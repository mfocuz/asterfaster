package AsterFaster::Model::Queues;

use Mojo::Base 'AsterFaster::Model::Base';
use Try::Tiny;
use strict;

sub queue_list {
    my $self = shift;
    
    my ($columns,$filter,$perPage) = @_;
    
    my @queueData = $self->connect->resultset($self->app->config->{'database_schema'}->{'queues'})
        ->search(undef, {
            columns => $columns,
            order_by => 'name',
        });
    
    my %queueData;
    foreach my $queue (@queueData) {
        my $data = {};
        foreach my $column (@$columns) {
            $data->{$column} = $queue->get_column($column);
        }
        $queueData{$queue->get_column('name')} = $data;
    }
    
    return \%queueData;
}

# queue_create:
# 0 - no errors
# -1 - queue already exists
# -2 - queue name contains prohibited chars
# -3 - queue members not added
sub queue_create {
    my $self = shift;
    
    my ($queueName,$queueHash,$queueMembers) = @_;
    
    # prohibit some chars " / \ '
    return -2 if ($queueName =~ m/\"|\\|\/\'/);
    
    my $fieldvars = {
        name => $queueHash->{name},
        timeout => $queueHash->{timeout},
        strategy => $queueHash->{strategy},
    };
    
    try {
        my $isExist = $self->connect->resultset($self->app->config->{'database_schema'}->{'queues'})
            ->find({name => $queueName});
        
        return -1 if ($isExist);
        
        my $isQueueCreated = $self->connect->resultset($self->app->config->{'database_schema'}->{'queues'})->create($fieldvars);
        
        if ($isQueueCreated and (scalar @$queueMembers) > 0) {
            
            my $isMembersAdded = $self->qmembers_add($queueMembers,$queueName);
        
            if ( (grep {$_!=0} @$isMembersAdded) == 0) {
                return 0
            } else {
                return -3;
            }
        } else {
            return 0;
        }
    }
    catch {
        
    }
}

# queue_delete:
# 0 - no errors
# -1 - exception while DELETE
sub queue_delete {
    my $self = shift;
    
    my $name = shift;
    
    try {
        # delete queue
        $self->connect->resultset($self->app->config->{'database_schema'}->{'queues'})
            ->find({name => $name})->delete();
        
        $self->connect->resultset($self->app->config->{'database_schema'}->{'queue_members'})
        ->search({queue_name => $name})->delete();

        return 0;
    }
    catch {
        return -1;
    }
}

# add queue member
# return array of created members according to input array of members,
# 0 - created
# -1 - already exists
# -2 - exception while DB insert
sub qmembers_add {
    my $self = shift;
    
    my $members = shift;
    my $queue = shift;
    
    my $return = [];
    my $i = 0;
    
    foreach my $name (@$members) {
        my $isMemberExist = $self->connect->resultset($self->app->config->{'database_schema'}->{'queue_members'})
            ->find({membername => $name,
                    queue_name => $queue});
        
        if ($isMemberExist) {
            $return->[$i] = -1;
        } else {
            my $fieldVars = {
                membername => $name,
                interface => 'Agent/'.$name,
                queue_name => $queue,
            };
            
            try {
                $self->connect->resultset($self->app->config->{'database_schema'}->{'queue_members'})
                    ->create($fieldVars);
                $return->[$i] = 0;
            }
            
            catch {
                $return->[$i] = -2;
            }
        }
        
        $i++;
    }
    
    return $return;
}

# remove queue member:
# 0 - no errors
# -1 - exception while DELETE
sub qmembers_remove{
    my $self = shift;
    
    my $queueName = shift;
    my $members = shift;
    
    try {
        foreach my $memberName (@$members) {
            $self->connect->resultset($self->app->config->{'database_schema'}->{'queue_members'})
                ->find({membername => $memberName},{queue_name => $queueName})->delete();
        }
        
        return 0;
    }
    catch {
        return -1;
    }
}

1;