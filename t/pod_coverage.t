#!perl -wT
# $Id: pod_coverage.t 385 2005-03-11 01:04:35Z claco $
use strict;
use warnings;
use Test::More;

eval 'use Test::Pod::Coverage 1.04';
plan skip_all => 'Test::Pod::Coverage 1.04' if $@;

eval 'use Pod::Coverage 0.14';
plan skip_all => 'Pod::Coverage 0.14 not installed' if $@;

my $trustme = {
    trustme =>
    [qr/^(format|convert|symbol|parse_(start|end|char)|start_document)$/]
};

all_pod_coverage_ok($trustme);
