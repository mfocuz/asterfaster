package AsterFaster;

use Mojo::Base 'Mojolicious';
use Mojolicious::Plugin::Config;
use Mojolicious::Plugin::AccessLog;
use Mojolicious::Plugin::Authentication;
use Mojo::Log;
use AsterFaster::Model;
use AsterFaster::Schema;
use Asterisk::AMI;
use strict;

# This method will run once at server start
sub startup {
    my $self = shift;
  
    $self->setup_plugins;
    $self->setup_routing;
    $self->setup_logging;
    
    # setup sessions
    $self->sessions->default_expiration(3600*24*7); 

}

sub setup_routing {
    my $self = shift;

    my $r = $self->routes;
    $r->namespaces(['AsterFaster::Controller']);
    
    # Users
    $r->get('/user/ext/list')->to('users#user_list_get');
    $r->get('/user/ext')->to('users#user_get');
    $r->post('/user/ext')->to('users#user_create_post');
    $r->delete('/user/ext')->to('users#user_delete');
    
    # Provider lines
    $r->get('/user/provline/list')->to('users#provline_list_get');
    $r->get('/user/provline')->to('users#provline_create_get');
    $r->post('/user/provline')->to('users#provline_create_post');
    $r->delete('/user/provline')->to('users#provline_delete');
    
    # Queues
    $r->get('/queue/list')->to('queues#queue_list_get');
    $r->get('/queue')->to('queues#queue_create_get');
    $r->post('/queue')->to('queues#queue_create_post');
    $r->delete('/queue')->to('queues#queue_delete');
    
    # Contexts
    $r->get('/context/list')->to('contexts#context_list_get');
    $r->get('/context')->to('contexts#context_create_get');
    $r->get('/context/godmod')->to('contexts#context_create_godmod_get');
    $r->post('/context')->to('contexts#context_create_post');
    $r->delete('/context')->to('contexts#context_delete');
}

sub setup_plugins {
    my $self = shift;
    
    # Setup Config plugin
    $self->plugin(Config => {file => 'asterfaster.conf' });
    
    # Init the model
    $self->setup_model;
    
    # Setup auth plugin
    $self->plugin('authentication' => {
        'autoload_user' => 1,
        'session_key' => 'sessionid',
        'load_user' => sub {},
        'validate_user' => sub {},
        'current_user_fn' => 'user', # compatibility with old code
    });
    
    # Setup Asterisk AMI plugin
    $self->asterisk_ami;
}

sub setup_model {
    my $self = shift;
    my $config = $self->config('database');
    my $model = AsterFaster::Model->new(
        app => $self,
        dsn         => $config->{dsn},
        user        => $config->{username},
        password    => $config->{password},
    );
    $self->helper(model => sub { $model->model($_[1]) });
    # TODO this should disappear once only models talk to schemas
    $self->helper(schema => sub { $model->schema($_[1]) });
}

sub setup_logging {
    my $self= shift;
    
    # setup Application level logging
    my $logfile = $self->app->config->{'logging'}->{'filename'};
    # for now only debug level is implemented
    my $level = $self->app->config->{'logging'}->{'loglevel'};
    my $log = Mojo::Log->new(path => $logfile, level => $level);
        
    $self->helper( logg => sub {
        my $self = shift;
        return $log;
    });
    
    # setup AccessLog plugin
    $self->plugin(AccessLog => {log => $self->app->config->{'logging'}->{'access_log'}});
}

sub asterisk_ami {
    my $self = shift;
    my $amiConfig = $self->config->{asterisk}->{ami};
    
    my $astami = Asterisk::AMI->new($amiConfig);
    $self->helper(ami_cmd => sub {
        my $cmd = shift;
        return $astami->(
            Action => 'Command',
            Command => $cmd,
        );
    });
    $self->helper(ami => sub {return $astami});
}

sub setup_hooks {
    
}

1;
