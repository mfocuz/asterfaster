package AsterFaster::Controller::Contexts;

use Mojo::Base 'Mojolicious::Controller';
use Try::Tiny;
use JSON;
use strict;

# GET /context/list
# List of contexts
# return: HTML
sub context_list_get{
    my $self = shift;
    my $m = $self->model('contexts');
    
    $self->logg->debug("[Controller::Request::context_list_get]"."::session");
    my @columns = qw/context/;
    my $contextData = $m->context_list(\@columns);
        
    return $self->render(contexts => $contextData);
}

# GET /context/godmod
# return: html
sub context_create_god_mod_get {
    my $self = shift;
    
    $self->logg->debug("[Controller::Request::context_create_godmod_get]"."::session");
    
    my $contextModel = $self->model('contexts');
    
    return $self->render();
}

# POST /context/godmod
# return : json
# 0 - no error; -1 - queue already exists; -2 - queue contains prohibited chars; -3 - error while adding queue members
sub context_create_godmod_post {
    my $self = shift;
    
    my $contextName = $self->param('name');
    my $exten = $self->param('exten');
    my $steps = $self->every_param('steps[]');
    
    $self->logg->debug("[Controller::Request::queue_create_post]"."::session"
        ."::params["
            ."contextName=$contextName,exten=$exten,steps=".join(';',@$steps)
        ."]"
    );
    
    my $m = $self->model('contexts');
    
    my $contextHash = {
        name => $contextName,
        exten => $exten,
    };
    
    my $isContextCreated = $m->context_create($contextName,$contextHash,$steps);
    
    if($isContextCreated == 0 ) {
        
        $self->render(json => {"error"=>"0", "message"=>"Queue created successfuly"});
    
    } elsif ($isContextCreated == -1) {
        
        $self->logg->debug("[Controller::Response::context_create_post]"."::session"
            ."::ERROR/-1"
        );
        
        $self->render(json => {"error"=>"-1","message"=>"Queue already exists"});
    } elsif ($isContextCreated == -2) {
        
        $self->logg->debug("[Controller::Response::context_create_post]"."::session"
            ."::ERROR/-2"
        );
        
        $self->render(json => {"error"=>"-2","message"=>"Queue already exists"});
    } elsif ($isContextCreated == -3) {
        
        $self->logg->debug("[Controller::Response::context_create_post]"."::session"
            ."::ERROR/-3"
        );
        
        $self->render(json => {"error"=>"-3","message"=>"Queue already exists"});
    }
}

# GET /context
# return: html
sub context_create_get {
    my $self = shift;
    
    $self->logg->debug("[Controller::Request::context_create_get]"."::session");
    
    my $contextModel = $self->model('contexts');
    
    return $self->render();
}

# POST /context
# return : json
# 0 - no error; -1 - context already exists; -2 - Error while adding extension entry;
# -3 - internal error(Model); -4 - no extension selected
sub context_create_post {
    my $self = shift;
    
    my $input = $self->req->json;
    my $contextName = $input->{name};
    my $extensInput = $input->{extens};
    
    $self->logg->debug("[Controller::Request::queue_create_post]"."::session"
        ."::params["
            ."contextName=$contextName"
        ."]"
    );
    
    my $m = $self->model('contexts');
    my $cdrPath = $self->config->{cdr}->{path};
    
    my @extens;
    my $contextHash = {
        name => $contextName,
        extens => \@extens,
    };
    
    
    foreach (@$extensInput) {
        my $cdr = $_->{cdr};
        
        my @steps;
        my $exten = {
            exten => '',
            steps => \@steps,
        };
        
        $exten->{exten} = $_->{exten};
        next if ! $exten->{exten};
        
        # Fill in standard exntesion plan
        push @steps,'Dial(SIP/${EXTEN},600,tT)';
        if ($cdr) {
            push @steps,"Monitor(wav,$cdrPath".'/${CALLERID(num)}-${EXTEN}-${STRFTIME(${EPOCH},,%d%m%Y-%H:%M:%S)},mb)';
            push @steps,"StopMonitor()";
        }
        push @steps,'Hangup()';
        push @extens,$exten;
    }
    
    if (scalar @extens == 0) {
        $self->logg->debug("[Controller::Request::queue_create_post]"."::session"
            ."::params["
                ."contextName=$contextName"
            ."]"
        );
        
        $self->render(json => {"error"=>"-4","message"=>"No extensions selected, should be at least one"});
        return;
    }
    
    my $isContextCreated = $m->context_create($contextName,$contextHash);
    
    if($isContextCreated == 0 ) {
        
        $self->render(json => {"error"=>"0", "message"=>"Dialplan created successfuly"});
    
    } elsif ($isContextCreated == -1) {
        
        $self->logg->debug("[Controller::Response::context_create_post]"."::session"
            ."::ERROR/-1"
        );
        
        $self->render(json => {"error"=>"-1","message"=>"Dialplan already exists"});
    } elsif ($isContextCreated == -2) {
        
        $self->logg->debug("[Controller::Response::context_create_post]"."::session"
            ."::ERROR/-2"
        );
        
        $self->render(json => {"error"=>"-2","message"=>"Error while adding extension entry"});
    } elsif ($isContextCreated == -3) {
        
        $self->logg->debug("[Controller::Response::context_create_post]"."::session"
            ."::ERROR/-3"
        );
        
        $self->render(json => {"error"=>"-3","message"=>"Internal Error"});
    }
    
}

# DELETE /context
# return: json/http code
# json/0 - no error, http/409 - context is not deleted
sub context_delete {
    my $self = shift;
    
    my $context = $self->param('context');
    my $m = $self->model('contexts');
    
    $self->logg->debug("[Controller::Request::context_delete]"."::session"
        ."::params["
            ."name=$context"
        ."]"
    );
    
    my $isDeleted = $m->context_delete($context);
    
    if ($isDeleted == 0) {
        $self->logg->debug("[Controller::Response::context_delete]"."::session"
            ."::SUCCESS/0"
        );
        
        $self->render(json => {"error"=>"0", "message"=>"NOT_SET"});
    } else {
        $self->logg->debug("[Controller::Request::context_delete]"."::session"
            ."::FAIL/409"
        );
        $self->render(status => 409);
    }
}









1;