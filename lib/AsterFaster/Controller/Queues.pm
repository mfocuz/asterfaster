package AsterFaster::Controller::Queues;

use Mojo::Base 'Mojolicious::Controller';
use Try::Tiny;
use strict;

# GET /queue/list
# return: json (queue list)
sub queue_list_get {
    my $self = shift;
    my $m = $self->model('queues');
    
    $self->logg->debug("[Controller::Request::queue_list_get]"."::session");
    my @columns = qw/name timeout strategy/;
    
    my $queueData = $m->queue_list(\@columns);
    
    return $self->render(queues => $queueData);
}

# GET /queue
# return: html
sub queue_create_get {
    my $self = shift;
    
    $self->logg->debug("[Controller::Request::queue_create_get]"."::session");
    
    my $userModel = $self->model('users');
    
    my $userData = $userModel->user_list();
    
    my @userNumbers = keys %$userData;
    
    return $self->render(userNumbers => \@userNumbers);
}

# POST /queue
# return : json
# 0 - no error; -1 - queue already exists; -2 - queue contains prohibited chars; -3 - error while adding queue members
sub queue_create_post {
    my $self = shift;
    
    my $queueName = $self->param('name');
    my $timeout = $self->param('timeout');
    my $strategy = $self->param('strategy');
    my $queueMembers = $self->every_param('members[]');
    
    $self->logg->debug("[Controller::Request::queue_create_post]"."::session"
        ."::params["
            ."queueName=$queueName,timeout=$timeout,strategy=$strategy,members=".join(',',@$queueMembers)
        ."]"
    );
     
    my $m = $self->model('queues');
    my $queueHash = {
        name => $queueName,
        timeout => $timeout,
        strategy => $strategy,
    };
    
    my $isQueueCreated = $m->queue_create($queueName,$queueHash,$queueMembers);
    
    if($isQueueCreated == 0 ) {
        
        $self->render(json => {"error"=>"0", "message"=>"Queue created successfuly"});
    
    } elsif ($isQueueCreated == -1) {
        
        $self->logg->debug("[Controller::Response::queue_create_post]"."::session"
            ."::ERROR/-1"
        );
        
        $self->render(json => {"error"=>"-1","message"=>"Queue already exists"});
    } elsif ($isQueueCreated == -2) {
        
        $self->logg->debug("[Controller::Response::queue_create_post]"."::session"
            ."::ERROR/-2"
        );
        
        $self->render(json => {"error"=>"-2","message"=>"Queue contains prohibited chars"});
    } elsif ($isQueueCreated == -3) {
        
        $self->logg->debug("[Controller::Response::queue_create_post]"."::session"
            ."::ERROR/-2"
        );
        
        $self->render(json => {"error"=>"-2","message"=>"Queue members not added"});
    }
}

sub edit_queue {
    my $self = shift;
    
}

# DELETE /queue
# return: json/http code
# json/0 - no error, http/409 - queue is not deleted
sub queue_delete {
    my $self = shift;
    
    my $queueName = $self->param('name');
    my $m = $self->model('queues');
    
    my $isQueueDeleted = $m->queue_delete($queueName);
    
    if ($isQueueDeleted == 0) {
        $self->render(json => {"error"=>"0", "queue_str"=>"NOT_SET"});
    } else {
        $self->logg->debug("[Controller::Response::queue_delete]"."::session"
            ."::ERROR/409"
            ."::Can not delete queue"
        );
        
        $self->render(status => 409);
    }
}

1;