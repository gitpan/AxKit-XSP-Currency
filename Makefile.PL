# $Id: Makefile.PL 452 2005-03-21 00:37:35Z claco $
use ExtUtils::MakeMaker;
use strict;
use warnings FATAL => 'all';

eval 'use Apache::Test 1.16';
if (!$@) {
    require Apache::TestMM;
    Apache::TestMM->import(qw(test clean));

    ## for whatever reason, use AxKit causes issues
    ## use-ing A::A::Exception doesn't
    eval 'use Apache::AxKit::Exception';
    if (!$@) {
        push(@ARGV, '-defines', 'AXKIT');
    };

    Apache::TestMM::filter_args();
    Apache::TestMM::generate_script('t/TEST');
    Apache::TestMM::generate_script('t/SMOKE');
};

WriteMakefile(
    NAME            =>  'AxKit::XSP::Currency',
    VERSION_FROM    =>  'lib/AxKit/XSP/Currency.pm',
    ABSTRACT        =>  'Currency formatting and conversion taglib',
    ($] >= 5.005 ?
        (AUTHOR     =>  'Christopher H. Laco <claco@chrislaco.com>') : ()),
    PREREQ_PM       =>  {
        'AxKit'                                   => undef,
        'Locale::Currency::Format'                => undef,
        'Finance::Currency::Convert::WebserviceX' => undef
    },
    (ExtUtils::MakeMaker->VERSION >= 6.11) ?
    (NO_META      => 1) : (),

    dist => {
        PREOP => 'pod2text lib/AxKit/XSP/Currency.pm > $(DISTVNAME)/README',
    },
    clean => { FILES => 'smoke-report-* t/TEST t/SMOKE t/logs' }
);
