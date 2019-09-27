package code_spans;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(code_spans);

sub code_spans {
    my $text = shift;
    $text =~ s{`(.*?)`}{<code>$1<\/code>};
    return $text;
}
