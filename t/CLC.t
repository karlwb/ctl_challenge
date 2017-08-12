use Modern::Perl;
use Test::More;

my @PRINT_AT_END = ();

subtest imports => sub {
    foreach my $class (qw/Employee Department/) {
	require_ok $class;
	use_ok $class;
    }
};

subtest basic_tests => sub {
    # developer
    my $d = Employee->new(type=>'developer', name=>'Bob', allocation=>1000);
    is $d->name, 'Bob', 'developer name';
    is $d->type, 'developer', 'developer type';
    is $d->allocation, 1000, 'developer allocation';
    is_deeply $d->staff, [], 'developer staff';
    is $d->total_allocation, 1000, 'developer total_allocation';
    
    # manager with one developer
    my $m = Employee->new(type=>'manager', name=>'Tom', allocation=>300, staff=>[$d]);
    is $m->name, 'Tom', 'manager name';
    is $m->type, 'manager', 'manager type';
    is $m->allocation, 300, 'manager allocation';
    is_deeply $m->staff, [$d], 'manager staff';
    is $m->total_allocation, 1300, 'manager total_allocation';
    
    # department with one manager and one employee
    my $dept = Department->new(name=>'engineering', staff=>[$m]);
    is $dept->name, 'engineering', 'dept name';
    is_deeply $dept->staff, [$m], 'dept staff';
    is $dept->total_allocation, 1300, 'dept total_allocation';
};

# helper for tests below...skeleton for "app"
# note: managers need to be added before their employees in $staff_list
sub create_dept {
    my ($deptname, $alloc_by_type, $staff_list) = @_;
    my $dept = Department->new(name=>$deptname, staff=>[]);
    foreach my $s (@{$staff_list}) {
	my $manager = $dept->find_staff($s->{boss}) // $dept;
	my $emp = Employee->new(name=>$s->{name}, type=>$s->{type}, allocation=>$alloc_by_type->{$s->{type}});
	$manager->add_staff($emp);
    }
    return $dept;
}

subtest clc_example => sub {
    my $alloc = { developer => 1000,
		  tester => 500,
		  manager => 300,
    };
    my $staff = [
	{type=>'manager', name=>'Manager A'},
	{type=>'manager', name=>'Manager B', boss=>'Manager A'},
	{type=>'developer', name=>'Developer A', boss=>'Manager B'},
	{type=>'tester', name=>'QA Tester A', boss=>'Manager B'},
    ];
    my $dept = create_dept('CLC Sample', $alloc, $staff);
    is $dept->total_allocation, 2100, 'clc total_allocation';
    push @PRINT_AT_END, $dept;
};

subtest complex_example => sub {
    my $alloc = { developer => 1000,
		  tester => 500,
		  manager => 300,
    };
    my $staff = [
	{type=>'manager', name=>'Joe CTO'},
	{type=>'manager', name=>'Alan Director', boss=>'Joe CTO'},
	{type=>'manager', name=>'Bob Director',  boss=>'Joe CTO'},
	{type=>'manager', name=>'Arve Manager',  boss=>'Alan Director'},
	{type=>'manager', name=>'Bill Manager',  boss=>'Arve Manager'},
	{type=>'manager', name=>'Null Manager',  boss=>'Bob Director'},
	{type=>'manager', name=>'Nil Manager',  boss=>'Bob Director'},	
	{type=>'developer', name=>'Fungible A', boss=>'Bill Manager'},
	{type=>'developer', name=>'Fungible B', boss=>'Bill Manager'},
	{type=>'developer', name=>'Fungible C', boss=>'Bill Manager'},
	{type=>'developer', name=>'Fungible D', boss=>'Bill Manager'},
	{type=>'tester', name=>'Testy A', boss=>'Bill Manager'},
	{type=>'tester', name=>'Testy B', boss=>'Bill Manager'},
	{type=>'developer', name=>'Fungible E', boss=>'Arve Manager'},
	{type=>'developer', name=>'Fungible F', boss=>'Arve Manager'},
	{type=>'manager', name=>'Trainee Manager', boss=>'Bill Manager'},
	{type=>'developer', name=>'Cluebie A', boss=>'Trainee Manager'},
	{type=>'tester', name=>'Testy C', boss=>'Trainee Manager'},	
    ];
    my $dept = create_dept('Complex', $alloc, $staff);
    is $dept->total_allocation, 10900, 'complex total_allocation';
    push @PRINT_AT_END, $dept;
};

done_testing;


if ($ENV{VERBOSE}) {
    foreach my $dept (@PRINT_AT_END) {
	print $dept->as_string . "\n\n";
    }
}
