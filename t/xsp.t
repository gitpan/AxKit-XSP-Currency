#!perl -wT
# $Id: xsp.t 296 2005-03-05 01:08:13Z claco $
use strict;
use warnings;
require Test::More;
use lib 't/lib';
use TestHelper qw(comp_to_file);

eval 'use Apache::Test 1.16';
Test::More::plan(skip_all =>
    'Apache::Test 1.16 not installed') if $@;

## test new/add first so we can use them to test everything else
my @tests = (
    'format.xsp',
    'format_code.xsp',
    'format_options.xsp',
    'format_code_options.xsp',
    'format_children.xsp',
    'format_children_precedence.xsp',
);

use Apache::TestUtil;
Apache::TestRequest->import(qw(GET));
Apache::Test::plan(tests => (scalar @tests * 2),
    need('AxKit', 'mod_perl', need_apache(1), need_lwp())
);

my $docroot = Apache::Test::vars('documentroot');

foreach (@tests) {
    my $r = GET("/axkit/$_");

    ok($r->code == 200);

    my ($ok, $response, $file) = comp_to_file($r->content, "$docroot/axkit/out/$_.out");

    t_debug($_);
    t_debug("HTTP Status: " . $r->code);
    t_debug("Expected:\n", $file);
    t_debug("Received:\n", $response);

    ok($ok);
};