#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

use Data::Dumper;

use Net::Prober;
use Net::Prober::Probe::HTTP;

my $result = Net::Prober::probe_http({
    host    => '185.26.182.72',
    timeout => 6.0,
    port    => 80,
    url     => '/pub/opera/',
    match   => 'Index of /',
});

say Dumper($result);
