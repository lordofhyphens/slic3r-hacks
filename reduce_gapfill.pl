#!/usr/bin/perl -i~
# This is a REALLY DIRTY DIRTY perl script to reduce extrusion rate 
# for gapfill. It is not guaranteed to do anything except call M221.
# Set your gap fill speed to 12mm/s or change $gapspeed.
# Written by Joseph Lenox
use strict;
use warnings;

my $gapfill_flowrate = 80; # Syntax is M221 S# where # is a number between 0 and 100
my $original_flowrate = 100; # if using m221 for other purposes, replace this with that value
my $gapspeed = 720;
my $flag = 0;
while (<>) {
  if (/^G1.*? F([0-9.]+)/) {
    if ($1 == $gapspeed) {
      print "M221 S" . $gapfill_flowrate . "; Set reduced flowrate for gapfill\n";
      $flag = 1;
    } elsif ($flag) {
      print "M221 S" . $original_flowrate. "; Reset flow rate\n";
      $flag = 0;
    }
    
  }
  print;
}

