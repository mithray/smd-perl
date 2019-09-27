package span_gamut;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(span_gamut);

use get_globals;
my %globals = get_globals();

use code_spans;
use escape_special_characters;
use images;
use anchors;
use auto_links;
use amps_and_angles;
use phrasing;
use line_breaks;

sub span_gamut {
    my $text = shift;

#    $text = code_spans($text);
#    $text = escape_special_characters($text);
#    $text = images($text);
#    $text = anchors($text);
#    $text = auto_links();
#    $text = amps_and_angles($text);
    $text = phrasing($text);
#    $text = line_breaks($text);

    return $text;
}
