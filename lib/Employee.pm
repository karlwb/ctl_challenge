package Employee;
use Modern::Perl;
use List::Util qw(sum0);
use Moo;

with ('Role::HasStaff');
has type => (is => 'ro', required => 1);
has allocation => (is => 'ro', required => 1);

sub total_allocation {
    my $self = shift;
    return $self->allocation + sum0(map{$_->total_allocation} @{$self->staff});
}

sub as_string {
    my $self = shift;
    return sprintf("%s - %s, \$%.2f", $self->type, $self->name, $self->total_allocation);
}

1;
