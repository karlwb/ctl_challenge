package Department;
use Modern::Perl;
use List::Util qw(sum0);
use Moo;

with ('Role::HasStaff');

sub total_allocation {
    my $self = shift;
    return sum0(map{ $_->total_allocation } @{$self->staff});
}

sub as_string {
    my $self = shift;
    my @parts = (sprintf("%s - \$%.2f", $self->name, $self->total_allocation) );
    foreach my $s (@{$self->staff}) {
	push @parts, $self->_recursive_staff_str(1, $s);
    }
    return join("\n", @parts);
}

sub _recursive_staff_str {
    my ($self, $depth, $employee) = @_;
    my @collection = (' ' x (2*$depth) . $employee->as_string);
    foreach my $s (@{$employee->staff}) {
	push @collection, $self->_recursive_staff_str($depth+1, $s);
    }
    return @collection;
}

1;
