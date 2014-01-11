#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

use Data::Dumper;

use Net::Prober;
use Net::Prober::Probe::HTTP;

my $result = Net::Prober::probe_http({
    host    => '37.228.108.161',
    url     => '/',
    method  => 'POST',
    body    => q("ping"),
    headers => [
        "Content-Type" => "application/json",
        "Host" => "sd.opera.com",
    ],
});

say Dumper($result);
