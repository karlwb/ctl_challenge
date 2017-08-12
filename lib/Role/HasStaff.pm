package Role::HasStaff;
use Modern::Perl;
use Moo::Role;

has staff => (is => 'rwp', required => 0, default => sub { [] } );
has name => (is => 'ro', required => 1);

sub add_staff {
    my ($self, $add) = @_;
    my $staff = $self->staff;
    push @{$staff}, $add;
    $self->_set_staff($staff);
}

sub find_staff {
    my ($self, $name) = @_;
    return undef unless $name;
    return $self if $self->name eq $name;
    foreach my $s (@{$self->staff}) {
	my $found = $s->find_staff($name);
	return $found if $found;
    }
    return undef;
}

1;
