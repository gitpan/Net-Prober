package Net::Prober::http;
{
  $Net::Prober::http::VERSION = '0.12';
}

use strict;
use warnings;
use base 'Net::Prober::Probe::HTTP';

1;

=pod

=encoding UTF-8

=head1 NAME

Net::Prober::http

=head1 VERSION

version 0.12

=head1 AUTHOR

Cosimo Streppone <cosimo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Cosimo Streppone.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__END__

sub probe_http {
    my ($probe) = @_;

    my ($host, $port, $timeout, $proto, $url, $expected_md5, $content_match) =
        @{$probe}{qw(host port timeout proto url md5 match)};

    my $ua = LWPx::ParanoidAgent->new();
    $ua->agent("Net::Prober/$Net::Prober::VERSION");
    $ua->max_redirect(0);
    $ua->timeout($timeout);

    $proto = 'http' if not defined $proto;

    if ($proto eq 'http') {
        $port ||= 80;
    }
    elsif ($proto eq 'https') {
        $port ||= 443;
    }

    $url = '/' unless defined $url;
    $url =~ s{^/+}{};

    my $scheme = $port == 443 ? "https" : "http";
    my $probe_url = "$scheme://$host:$port/$url";

    my $t0 = [ Time::HiRes::gettimeofday() ];
    my $resp = $ua->get($probe_url);
    my $elapsed = Time::HiRes::tv_interval($t0);
    my $content = $resp->content();

    my $good = $resp->is_redirect() || $resp->is_success();

    if ($good and defined $expected_md5) {
        my $md5 = Digest::MD5::md5_hex($content);
        if ($md5 ne $expected_md5) {
            $good = 0;
        }
    }

    if ($good and defined $content_match) {
        my $match_re;
        eval {
            $match_re = qr{$content_match}ms;
        } or do {
            Carp::croak("Invalid regex for http content match '$content_match'\n");
        };
        if ($content !~ $match_re) {
            $good = 0;
        }
    }

    return {
        ok      => $good ? 1 : 0,
        status  => $resp->status_line,
        time    => $elapsed,
        content => $content,
        md5     => $content ? Digest::MD5::md5_hex($content) : undef,
    };

}


