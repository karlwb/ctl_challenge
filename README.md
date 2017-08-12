To run tests:

```
prove -Ilib -v
```

To print sample output from tests:
```
VERBOSE=1 prove -Ilib -v
```

Example output:
```
(py36) karl@pepper ~/src/ctl_code_challenge $ VERBOSE=1 prove -Ilib -v
t/CLC.t .. 
# Subtest: imports
    ok 1 - require Employee;
    ok 2 - use Employee;
    ok 3 - require Department;
    ok 4 - use Department;
    1..4
ok 1 - imports
# Subtest: basic_tests
    ok 1 - developer name
    ok 2 - developer type
    ok 3 - developer allocation
    ok 4 - developer staff
    ok 5 - developer total_allocation
    ok 6 - manager name
    ok 7 - manager type
    ok 8 - manager allocation
    ok 9 - manager staff
    ok 10 - manager total_allocation
    ok 11 - dept name
    ok 12 - dept staff
    ok 13 - dept total_allocation
    1..13
ok 2 - basic_tests
# Subtest: clc_example
    ok 1 - clc total_allocation
    1..1
ok 3 - clc_example
# Subtest: complex_example
    ok 1 - complex total_allocation
    1..1
ok 4 - complex_example
1..4
CLC Sample - $2100.00
  manager - Manager A, $2100.00
    manager - Manager B, $1800.00
      developer - Developer A, $1000.00
      tester - QA Tester A, $500.00
Complex - $10900.00
  manager - Joe CTO, $10900.00
    manager - Alan Director, $9700.00
      manager - Arve Manager, $9400.00
        manager - Bill Manager, $7100.00
          developer - Fungible A, $1000.00
          developer - Fungible B, $1000.00
          developer - Fungible C, $1000.00
          developer - Fungible D, $1000.00
          tester - Testy A, $500.00
          tester - Testy B, $500.00
          manager - Trainee Manager, $1800.00
            developer - Cluebie A, $1000.00
            tester - Testy C, $500.00
        developer - Fungible E, $1000.00
        developer - Fungible F, $1000.00
    manager - Bob Director, $900.00
      manager - Null Manager, $300.00
      manager - Nil Manager, $300.00
ok
All tests successful.
Files=1, Tests=4,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.04 cusr  0.01 csys =  0.07 CPU)
Result: PASS
```