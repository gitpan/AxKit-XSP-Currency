# $Id: Currency.pm 323 2005-03-05 18:19:16Z claco $
package AxKit::XSP::Currency;
use strict;
use warnings;
use vars qw($VERSION $NS @EXPORT_TAGLIB);
use base 'Apache::AxKit::Language::XSP::TaglibHelper';
use Locale::Currency::Format;

$VERSION = '0.04';
$NS  = 'http://today.icantfocus.com/CPAN/AxKit/XSP/Currency';

@EXPORT_TAGLIB = (
    'format($price;$code,$options)'
);

sub format {
    my ($price, $code, $options) = @_;

    $code    ||= 'USD';
    $options ||= 'FMT_HTML';

    eval '$options = ' . $options;

    return currency_format($code, $price, $options);
};

1;
__END__


=head1 NAME

AxKit::XSP::Currency - Currency formatting and conversion taglib

=head1 VERSION

    $Id: Currency.pm 323 2005-03-05 18:19:16Z claco $

=head1 SYNOPSIS

Add this taglib to AxKit in your http.conf or .htaccess:

    AxAddXSPTaglib AxKit::XSP::Currency

Add the namespace to your XSP file and use the tags:

    <xsp:page
         language="Perl"
         xmlns:xsp="http://apache.org/xsp/core/v1"
         xmlns:currency="http://today.icantfocus.com/CPAN/AxKit/XSP/Currency"
    >

    <currency:format code="USD" options="FMT_STANDARD">19.5</currency:format>

    <currency:format>
        <currency:code>USD</currency:code>
        <currenct:options>FMT_HTML</currency:options>
        <currency:price>10.95</currenct:price>
    </currency:format>

=head1 DESCRIPTION

This tag library provides an interface to format and convert currency within
XSP pages.

This initial version currently only supports currency formatting. Currency
conversion is planned for future releases.

=head1 TAG HIERARCHY

    <currency:format code="USD|CAD|..." options="FMT_STANDARD|FMT_COMMON|...">
        <currency:code></currency:code>
        <currency:options></currency:options>
        <currency:price></currency:price>
    </currency:format>

=head1 TAG REFERENCE

=head2 <currency:format>

Given a price, usually in decimal form, format returns a formatted price using
the various options in C<Locale::Currency::Format>.

    <currency:format>
        <currency:price>10.9</currency:price>
    </currency:format>  # prints &amp;#x0024;10.50

The C<format> tag has three available attributes to control the output:

=over

=item code

This is the 3 letter currency code used to specify the currency in use.
The C<code> attribute can also be specified using a child tag instead:

    <currency:format>
        <currency:code>USD</currency:code>
    </currency:format>

C<USD> is used as the default if no currency code is specified.
See L<Locale::Currency::Format> for all of the available currency codes.

=item options

This is a string containing the formatting options to be used to specify
the desired output format. The C<options> attribute can also be specified
using a child tag instead:

    <currency:format>
        <currency:options>FMT_STANDARD | FMT_NOZEROS</currency:options>
    </currency:format>

C<FMT_HTML> is used as the default if no options are specified.
See L<Locale::Currency::Format> for all of the available format options.

=item price

This is the price to be formatted. While it can be passed as an attribute,
the more common usage will be as a child tag:

    <currency:format>
        <currency:price>19.95</currency:price>
    </currency:format>

=back

=head1 SEE ALSO

L<Locale::Currency::Format>

=head1 AUTHOR

    Christopher H. Laco
    CPAN ID: CLACO
    cpan@chrislaco.com
    http://today.icantfocus.com/blog/
