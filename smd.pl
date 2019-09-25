#!/usr/bin/perl
use strict;
use warnings;
binmode STDOUT, ":encoding(UTF-8)";
use feature 'unicode_strings';
use utf8;

use FindBin;                  
use lib "$FindBin::Bin/lib";

# Span Gamut
use block_gamut;
use span_gamut;

# Helpers
use detab;
use standardize_newlines;
use get_html_skeleton;
use get_file;

# Globals
use get_globals;



sub convert_to_html {
    my $text = shift;
    $text = block_gamut($text);
    $text = span_gamut($text);
    return $text;
}

sub end_with_newlines {
    my $text = $_[0];
    $text .= "\n\n";
    return $text
}



# Slurp whole File
my $text;
{
    local $/;               
    $text= <>;
}

$text = standardize_newlines($text);
#$text = end_with_newlines($text);
$text = detab($text);
$text =~ s/^[ \t]+$//mg; #Delete lines of only Spaces and tabs
$text= convert_to_html($text);
my $html = get_html_skeleton();
$html =~ s/<article>/<article>$text/;


print "$html"
