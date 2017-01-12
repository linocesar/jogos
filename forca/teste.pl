#!/usr/bin/env perl

use Term::ANSIColor qw(:constants);
print RED, "Stop!\n", RESET;
print GREEN, "Go!\n", RESET;


my $t = <STDIN>;
chomp($t);

if ($t == '[a-zA-Z]') {
  print "ok\n";
}
