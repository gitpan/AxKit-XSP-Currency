#!perl -wT
# $Id: pod_syntax.t 296 2005-03-05 01:08:13Z claco $
use strict;
use warnings;
use Test::More;

eval 'use Test::Pod 1.00';
plan skip_all => 'Test::Pod 1.00 not installed' if $@;

all_pod_files_ok();
