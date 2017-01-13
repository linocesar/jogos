#!/usr/bin/env perl

use Term::ANSIColor qw(:constants);
print RED, "Stop!\n", RESET;
print GREEN, "Go!\n", RESET;

my $num;
for (my $t = 0; $t < 10; $t++) {
  $num = $t % 3 + 1;
  print $num;
}
print "\n";
my $m = index("aads", "q") ;
print  $m . "\n";


my $nomea = "CASA";

if ($nomea eq "C#SA") {
  print "ok\n";
}
