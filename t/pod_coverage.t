#!perl -wT
# $Id: pod_coverage.t 296 2005-03-05 01:08:13Z claco $
use strict;
use warnings;
use Test::More;

eval 'use Test::Pod::Coverage 1.04';
plan skip_all => 'Test::Pod::Coverage 1.04' if $@;

eval 'use Pod::Coverage 0.14';
plan skip_all => 'Pod::Coverage 0.14 not installed' if $@;

my $trustme = {
    trustme =>
    [qr/^(format|parse_(start|end|char)|start_document)$/]
};

all_pod_coverage_ok($trustme);
