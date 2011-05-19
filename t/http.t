=pod

=head1 NAME

t/http.t - Net::Prober test suite

=head1 DESCRIPTION

Try to probe hosts via HTTP connections

=cut

use strict;
use warnings;

use LWP::Online ':skip_all';
use Test::More tests => 5;

use Net::Prober;

my $result = Net::Prober::probe_http({
    host => 'static.myopera.com',
    url  => '/ping.html',
    md5  => 'f5a3cf5f5891652a2b148d40fb400a84',
    timeout => 3.0,
});

ok($result && ref $result eq 'HASH', 'probe_http() returns a hashref');
ok(exists $result->{ok} && $result->{ok}, 'Page downloaded and MD5 verified');
ok(exists $result->{time}
    && $result->{time} > 0.0
    && $result->{time} <= 3.0,
    "Got an elapsed time too ($result->{time}s)",
);
ok(exists $result->{md5}
    && $result->{md5} eq 'f5a3cf5f5891652a2b148d40fb400a84',
    "Got the correct 'md5' value"
);

$result = Net::Prober::probe({
    proto   => 'http',
    host    => 'www.opera.com',
    url     => '/browser/',
    match   => 'Faster',
    timeout => 5.0,
});

ok($result->{ok});
