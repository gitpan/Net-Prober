
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Probes network hosts for downtime, latency, etc...",
  "AUTHOR" => "Cosimo Streppone <cosimo\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Net-Prober",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Net::Prober",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Data::Dumper" => 0,
    "Digest::MD5" => 0,
    "IO::Socket::INET" => 0,
    "IO::Socket::SSL" => 0,
    "IO::Socket::UNIX" => 0,
    "LWPx::ParanoidAgent" => 0,
    "Net::Ping" => "2.34",
    "Sys::Syslog" => 0
  },
  "TEST_REQUIRES" => {
    "LWP::Online" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.14",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Data::Dumper" => 0,
  "Digest::MD5" => 0,
  "IO::Socket::INET" => 0,
  "IO::Socket::SSL" => 0,
  "IO::Socket::UNIX" => 0,
  "LWP::Online" => 0,
  "LWPx::ParanoidAgent" => 0,
  "Net::Ping" => "2.34",
  "Sys::Syslog" => 0,
  "Test::More" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



