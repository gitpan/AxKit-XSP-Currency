#!perl
# $Id: SMOKE.PL 296 2005-03-05 01:08:13Z claco $
use strict;
use warnings FATAL => 'all';
use lib qw(lib);

use Apache::TestSmoke ();

Apache::TestSmoke->new(@ARGV)->run;
