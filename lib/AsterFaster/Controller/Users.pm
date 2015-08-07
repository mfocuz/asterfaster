package AsterFaster::Controller::Users;

use Mojo::Base 'Mojolicious::Controller';
use Mojo::Log;
use File::Slurp;
use strict;

# GET /user/ext
# return: html (user list)
sub user_get {
    my $self = shift;
    my $m_u = $self->model('users');
    
    $self->logg->debug("[Controller::Request::user_list_get]"."::session");
    my @userColumns = qw/name userrole useragent ipaddr regseconds context/;
    my $userData = $m_u->user_list(\@userColumns, {type => 'friend'});
    
    my $m_c = $self->model('contexts');
    my @columns = qw/context/;
    my $contextData = $m_c->context_list(\@columns);
    my @contexts;
    
    push @contexts,keys %$contextData if (keys %$contextData > 0);
    
    my %report;
    $report{users_total} = keys %$userData;
    $report{users_online} = grep {$userData->{$_}->{regseconds} > 0} keys %$userData;
    $report{users_never_reg} = grep {$userData->{$_}->{useragent} eq ''} keys %$userData;
    
    return $self->render(users => $userData, contexts => \@contexts, report => \%report);
}

# GET /user/ext/list
# return: json
sub user_list_get {
    my $self = shift;
    
    my $m_u = $self->model('users');
    $self->logg->debug("[Controller::Request::user_list_get]"."::session");

    $self->logg->debug("[Controller::Request::user_list_get]"."::session");
    my @userColumns = qw/name userrole useragent ipaddr regseconds context/;
    my $userData = $m_u->user_list(\@userColumns, {type => 'friend'});
    
    my %report;
    $report{users_total} = keys %$userData;
    $report{users_online} = grep {$userData->{$_}->{regseconds} > 0} keys %$userData;
    $report{users_never_reg} = grep {$userData->{$_}->{useragent} eq ''} keys %$userData;
    
    my $jsonResponse = {userData => $userData, report => \%report};
    
    return $self->render(json => $jsonResponse);
}

# POST /user
# return : json
# 0 - no error; -1 - user already exists; -2 user is not numberic value
sub user_create_post {
    my $self = shift;
    
    my $ext= $self->param('name');
    my $password = $self->param('password');
    my $userRole = $self->param('userrole');
    my $context = $self->param('context');
    #my $codecs = $self->param('codecs');
    #my $port = $self->param('port');
    
    $self->logg->debug("[Controller::Request::user_create_post]"."::session"
        ."::params["
            ."ext=$ext,context=$context"
        ."]"
    );
    
    # Transform userRole to INT
    $userRole = 1 if ($userRole eq 'User');
    $userRole = 0 if ($userRole eq 'Admin');
    
    my $m_u = $self->model('users');
    
    my $userHash = {
        name => $ext,
        defaultuser => '',
        host => 'dynamic',
        nat => 'force_rport,comedia',
        userrole => $userRole,
        type => 'friend',
        callerid => $ext,
        cancallforward => 'yes',
        canreinvite => 'no',
        context => $context,
        dtmfmode => 'rfc2833',
        mailbox => $ext.'@voicemail',
        qualify => 'yes',
        restrictcid => 'n',
        secret => $password,
        disallow => 'all',
        allow => 'g729;ilbc;gsm;ulaw;alaw',
        fullcontact => 'sip:'.$ext.'@'.$self->config->{ipaddress},
        username => $ext,
        ipaddr => '',
        lastms => '',
        port => '5069',
        regseconds => '',
    };
    
    my $response = $m_u->user_create($ext,$userHash);
    
    if($response == 0 ) {
        $self->logg->debug("[Controller::Response::user_create_post]"."::session"
            ."::SUCCESS/0"
        );
        $self->render(json => {"error"=>"0", "message"=>"User created successfuly"});
    } elsif ($response == -1) {
        $self->logg->debug("[Controller::Response::user_create_post]"."::session"
            ."FAIL/-1"
        );
        $self->render(json => {"error"=>"-1","message"=>"User already exists"});
    } elsif ($response == -2) {
        $self->logg->debug("[Controller::Response::user_create_post]"."::session"
            ."FAIL/-2"
        );
        $self->render(json => {"error"=>"-2","message"=>"User ext is not a number"});
    }
}

sub edit_user {
    
}

# DELETE /user
# return: json/http code
# json/0 - no error, http/409 - user is not deleted
sub user_delete {
    my $self = shift;
    
    my $ext = $self->param('name');
    my $m = $self->model('users');
    
    $self->logg->debug("[Controller::Request::user_delete]"."::session"
        ."::params["
            ."ext=$ext"
        ."]"
    );
    
    my $response = $m->user_delete($ext);
    
    if ($response == 0) {
        $self->logg->debug("[Controller::Response::user_delete]"."::session"
            ."::SUCCESS/0"
        );
        $self->render(json => {"error"=>"0", "message"=>"NOT_SET"});
    } else {
        $self->logg->debug("[Controller::Request::user_delete]"."::session"
            ."::FAIL/409"
        );
        $self->render(status => 409);
    }
}

# GET /user/provline/list
# return: html (user list)
sub provline_list_get {
    my $self = shift;
    my $m = $self->model('users');
    
    $self->logg->debug("[Controller::Request::provline_list_get]"."::session");
    
    my @columns = qw/name context fromdomain fromuser/;
    my $provlineData = $m->user_list(\@columns, {type => 'peer'});
    
    return $self->render(provlineData => $provlineData);
}

# GET /user/provline
# return: html
sub provline_create_get {
    my $self = shift;
    
    $self->logg->debug("[Controller::Request::provline_create_get]"."::session");
    
    my $m_c = $self->model('contexts');
    my @columns = qw/context/;
    my $contextData = $m_c->context_list(\@columns);
    my @contexts;
    
    if (keys %$contextData > 0) {
        foreach (keys %$contextData) {
            push @contexts,$_;
        }
    }

    return $self->render(contexts => \@contexts);
}

# POST /user/provline
# return : json
# 0 - no error; -1 - user already exists; -2 user is not numberic value
sub provline_create_post {
    my $self = shift;
    
    my $ext= $self->param('name');
    my $password = $self->param('password');
    my $context = $self->param('context');
    my $host = $self->param('host');
    my $fromdomain = $self->param('fromdomain');
    my $fromuser = $self->param('fromdomain');
    my $port = $self->param('port');
    
    $self->logg->debug("[Controller::Request::user_create_post]"."::session"
        ."::params["
            ."ext=$ext,context=$context,host=$host,fromdomain=$fromdomain,fromuser=$fromuser,port=$port"
        ."]"
    );
    
    my $m = $self->model('users');
    my $userHash = {
        name => $ext,
        defaultuser => '',
        host => $host,
        fromuser => $fromuser,
        fromdomain => $fromdomain,
        nat => 'yes',
        type => 'peer',
        callerid => $ext,
        cancallforward => 'yes',
        canreinvite => 'no',
        context => $context,
        dtmfmode => 'rfc2833',
        mailbox => $ext.'@voicemail',
        qualify => 'yes',
        restrictcid => 'n',
        secret => $password,
        disallow => 'all',
        allow => 'g729;ilbc;gsm;ulaw;alaw',
        fullcontact => 'sip:'.$ext.'@'.$self->config->{ipaddress},
        username => $ext,
        ipaddr => '',
        port => $port,
        insecure => 'port,invite',
        lastms => '',
        regseconds => '',
    };
    my $isProvlineCreated = $m->user_create($ext,$userHash);
    
    if($isProvlineCreated == 0 ) {
        
        # add register entry to sip.conf
        my $isRegUpdated = $self->update_sip_regs();
        
        if ($isRegUpdated) {
            $self->logg->debug("[Controller::Response::provline_create_post]"."::session"
                ."::SUCCESS/0"
            );
            
            $self->render(json => {"error"=>"0", "message"=>"Provline created successfuly"});
        } else {
            # Roll back
            $m->user_delete($ext);
            
            $self->logg->debug("[Controller::Response::provline_create_post]"."::session"
                ."::ERROR: Can not update registrations"
            );
        }

    } elsif ($isProvlineCreated == -1) {
        $self->logg->debug("[Controller::Response::provline_create_post]"."::session"
            ."FAIL/-1"
        );
        $self->render(json => {"error"=>"-1","message"=>"Provline already exists"});
    } elsif ($isProvlineCreated == -2) {
        $self->logg->debug("[Controller::Response::provline_create_post]"."::session"
            ."FAIL/-2"
        );
        $self->render(json => {"error"=>"-2","message"=>"Provline ext is not a number"});
    }
}

# DELETE /user/provline
# return: json/http code
# json/0 - no error, http/409 - user is not deleted
sub provline_delete {
    my $self = shift;
    
    my $name = $self->param('name');
    my $m = $self->model('users');
    
    $self->logg->debug("[Controller::Request::provline_delete]"."::session"
        ."::params["
            ."name=$name"
        ."]"
    );
    
    my $response = $m->user_delete($name);
    
    if ($response == 0) {
        $self->update_sip_regs();
        
        $self->logg->debug("[Controller::Response::provline_delete]"."::session"
            ."::SUCCESS/0"
        );
        
        $self->render(json => {"error"=>"0", "message"=>"NOT_SET"});
    } else {
        $self->logg->debug("[Controller::Request::provline_delete]"."::session"
            ."::FAIL/409"
        );
        $self->render(status => 409);
    }
}


# sip.conf updated for SIP registration
# return:
# -1 - can not open sip.conf
sub update_sip_regs {
    my $self = shift;
    
    my $m = $self->model('users');
    
    my @columns = qw/name fromdomain port secret/;
    my $userData = $m->user_list(\@columns, {type => 'peer'});
    
    my $sipConf = $self->app->config->{asterisk}->{path}."/sip.conf";
    
    my @lines = read_file($sipConf);
    
    my $isGeneralSection = 0;
    my $positionToInsert = 0;
    for(my $i = 0; $i <= $#lines; $i++) {
        
        if ($lines[$i] =~ m/^\[general\]$/) {
            $isGeneralSection = 1;
            $positionToInsert = $i+1;
            next;
        }
        
        next if $isGeneralSection == 0;
        
        if ($lines[$i] =~ m/^register \=\>/) {
            splice(@lines,$i,1);
            $i--;
            next;
        }
        
        last if ($lines[$i] =~ m/^\[\w+\].*/ && $isGeneralSection == 1);
    }
    
    foreach my $provline (keys %$userData) {
        my $name = $userData->{$provline}->{name};
        my $fromDomain = $userData->{$provline}->{fromdomain};
        my $port = $userData->{$provline}->{port};
        my $secret = $userData->{$provline}->{secret};
        
        my $register = "register => $name:$secret\@$fromDomain:$port/$name\n";
        splice(@lines,$positionToInsert,0,$register);
    }
    
    write_file($sipConf,@lines);
    
    my $amiresp = $self->ami_cmd('sip reload');
    my $taskd;
    
    # TODO: asterisk sip reload
}

1;
