package AsterFaster::Model::Contexts;

use Mojo::Base 'AsterFaster::Model::Base';
use Try::Tiny;
use strict;

# get context list:
sub context_list {
    my $self = shift;
    
    my ($columns,$filter,$perPage) = @_;
    
    my @contextData = $self->connect->resultset($self->app->config->{'database_schema'}->{'extensions'})
        ->search($filter, {
            columns => $columns,
            order_by => 'context',
            distinct => 1,
        });
    
    my %contextData;
    foreach my $context (@contextData) {
        my $data = {};
        foreach my $column (@$columns) {
            $data->{$column} = $context->get_column($column);
        }
        $contextData{$context->get_column('context')} = $data;
    }
    
    return \%contextData;
}

# context_create:
# 0 - no errors
# -1 - context already exists
# -2 - error while adding extension entry
# -3 - exception
sub context_create {
    my $self = shift;
    
    my ($contextName, $contextHash) = @_;
    
    try {
        my @isExist = $self->connect->resultset($self->app->config->{'database_schema'}->{'extensions'})
            ->search({context => $contextName});
        
        return -1 if (scalar @isExist > 0);
        
        my $extens = $contextHash->{extens};

        foreach (@$extens) {
            my $exten = $_->{exten};
            my $steps = $_->{steps};
            my $priority = 1;
            foreach my $step (@$steps) {
                my ($app,$appData) = $step =~ m/(\w+)\((.*)\)/;
            
                my $fieldvars = {
                    context => $contextName,
                    exten => $exten,
                    priority => $priority,
                    app => $app,
                    appdata => $appData,
                };
                
                my $isContextCreated = $self->connect->resultset($self->app->config->{'database_schema'}->{'extensions'})->create($fieldvars);
                
                return -2 if (!$isContextCreated);
                
                $priority++;
            }
        }
        
        return 0;
    }
    
    catch {
        return -3;
    }
}

# delete context
# 0 - success
# -1 - error occured
sub context_delete {
    my $self = shift;
    
    my $context = shift;
    
    try {
        $self->connect->resultset($self->app->config->{'database_schema'}->{'extensions'})
            ->search({context => $context})->delete();
        
        return 0;
    }
    
    catch {
        return -1;
    }
}

1;