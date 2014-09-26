#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

use Data::Dumper;

use Net::Prober;
use Net::Prober::Probe::HTTP;

my $result = Net::Prober::probe_http({
    host    => 'operasoftware.pc.cdn.bitgravity.com',
    timeout => 10.0,
    url     => '/pub/opera/ping/ping.txt',
    match   => '1',
});

say Dumper($result);
