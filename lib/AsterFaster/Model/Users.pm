package AsterFaster::Model::Users;

use Mojo::Base 'AsterFaster::Model::Base';
use strict;


# get user list:
# returns HASH like
# user => {userdata}
sub user_list {
    my $self = shift;
    
    my ($columns,$filter,$perPage) = @_;
    
    my @userData = $self->connect->resultset($self->app->config->{'database_schema'}->{'sip_users'})
        ->search($filter, {
            columns => $columns,
            order_by => 'name',
        });
    
    my %userData;
    foreach my $user (@userData) {
        my $data = {};
        foreach my $column (@$columns) {
            $data->{$column} = $user->get_column($column);
        }
        $userData{$user->get_column('name')} = $data;
    }
    
    return \%userData;
}

# create_user:
# 0 - no errors
# -1 - user already exists
# -2 - user name(ext) is not a number
sub user_create{
    my $self = shift;
    my ($ext,$userHash) = @_;

    return -2 if !($ext =~ m/\d+/);
    
    my $fieldvars = {
        name=> $userHash->{name},
        host => $userHash->{host},
        nat => $userHash->{nat},
        userrole => $userHash->{userrole},
        type => $userHash->{type},
        accountcode => $userHash->{accountflags},
        amaflags => $userHash->{amaflags},
        'call-limit' => $userHash->{callLimit},
        callgroup => $userHash->{callgroup},
        callerid => $userHash->{callerid},
        callbackextension => $userHash->{callbackextension},
        cancallforward => $userHash->{cancallforward},
        canreinvite  => $userHash->{canreinvite},
        context => $userHash->{context},
        defaultip => $userHash->{defaultip},
        dtmfmode => $userHash->{dtmfmode},
        fromuser => $userHash->{fromuser},
        fromdomain => $userHash->{fromdomain},
        insecure => $userHash->{insecure},
        language => $userHash->{language},
        mailbox => $userHash->{language},
        md5secret => $userHash->{md5secret},
        deny => $userHash->{md5secret},
        permit => $userHash->{permit},
        mask => $userHash->{mask},
        musiconhold => $userHash->{musiconhold},
        pickupgroup => $userHash->{pickupgroup},
        qualify => $userHash->{qualify},
        regexten => $userHash->{regexten},
        restrictcid => $userHash->{restrictcid},
        rtptimeout => $userHash->{rtptimeout},
        rtpholdtimeout => $userHash->{rtpholdtimeout},
        secret => $userHash->{secret},
        setvar => $userHash->{setvar},
        disallow => $userHash->{disallow},
        allow => $userHash->{allow},
        fullcontact => $userHash->{fullcontact},
        ipaddr => $userHash->{ipaddr},
        port => $userHash->{port},
        regserver => $userHash->{regserver},
        regseconds => $userHash->{regseconds},
        lastms => $userHash->{lastms},
        defaultuser => $userHash->{defaultuser},
        subscribecontext => $userHash->{subscribecontext},
        useragent => $userHash->{useragent},
    };
    
    my $isExist = $self->connect->resultset($self->app->config->{'database_schema'}->{'sip_users'})
            ->find({name => $ext},{key => 'name'});
    if ($isExist) {
        return -1;
    }
    else {
        $self->connect->resultset($self->app->config->{'database_schema'}->{'sip_users'})->create($fieldvars);
        return 0;
    }
}

# delete extension
# 0 - success
# -1 - error occured
sub user_delete {
    my $self = shift;
    
    my $ext = shift;
    
    $self->connect->resultset($self->app->config->{'database_schema'}->{'sip_users'})
        ->find({name => $ext},{key => 'name'})->delete();
    
    return 0;
}

sub edit_user {
    
}



1;

