package AsterFaster::Model::Base;

use Mojo::Base -base;
use Mojo::Exception;
use Carp qw/ croak /;
use Digest::MD5;

has [qw/ app root_schema /];

sub connect{
    my $self = shift;
    my $schema = AsterFaster::Schema->connect(
        $self->{dsn},
        $self->{user},
        $self->{password},
        {
          quote_names => 1, 
          mysql_enable_utf8 => 1,
        }
    );
    return $schema;
}

sub dblog { shift->app->db_log(@_) }

1;