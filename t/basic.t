#!perl -wT
# $Id: basic.t 296 2005-03-05 01:08:13Z claco $
use strict;
use warnings;
use Test::More tests => 1;

SKIP: {
    eval 'use Apache::AxKit::Language::XSP';
    skip 'AxKit not installed', 1 if $@;

    {
        ## squelch AxKit strict/warnings
        no strict;
        no warnings;
        use_ok('AxKit::XSP::Currency');
    };
};
