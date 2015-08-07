package AsterFaster::Model;
use Mojo::Base -base;
use Mojo::Loader qw(find_modules load_class);

use DBIx::Connector;
use Carp qw/ croak /;

has modules => sub { {} };
has 'root_schema';

sub new {
    my $class = shift;
    my %args = @_;
    
    my $self = $class->SUPER::new(@_);
    my @packages = grep { $_ ne 'AsterFaster::Model::Base' } find_modules('AsterFaster::Model');
    foreach my $pm (@packages) {
        my $e = load_class($pm);
        croak "Loading `$pm' failed: $e" if ref $e;
        my ($basename) = $pm =~ /.*::(.*)/;
        $self->modules->{lc $basename} = $pm->new(%args);
    }
    
    return $self;
}

sub model {
    my ($self, $model) = @_;
    return $self->{modules}{$model} || croak "Unknown model `$model'";
}

sub models { return grep { $_ ne '' } keys %{$_[0]->{modules}} }

sub checkuser{
    my $self = shift;
    my ($userlogin,$userpass)=@_;
    my $user = $self->connect->resultset('User')->single({userlogin=>$userlogin,userpass=>$userpass});
    return $user;
}

1;
