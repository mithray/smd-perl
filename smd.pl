#!/usr/bin/perl
use strict;
use warnings;
binmode STDOUT, ":encoding(UTF-8)";
use feature 'unicode_strings';
use utf8;

use FindBin;                  
use lib "$FindBin::Bin/lib";

# Sections
use block_gamut;
use span_gamut;

# Helpers
use detab;
use standardize_newlines;
use get_html_skeleton;
use get_file;
use get_globals;


sub convert_to_html {
    my $text = shift;
    $text = block_gamut($text);
#    $text = span_gamut($text);
    return $text;
}

sub end_with_newlines {
    my $text = $_[0];
    $text .= "\n\n";
    return $text
}

sub trim_empty_line_space {

    my $text = shift;
    $text =~ s/^[ \t]*$//mg; #Delete lines of only spaces and tabs
    return $text;
}

# Slurp whole File
my $text;
{
    local $/;               
    $text= <>;
}

#$text = standardize_newlines($text);
#$text = end_with_newlines($text);
$text = detab($text);
$text = trim_empty_line_space($text);
$text= convert_to_html($text);
#my $html = get_html_skeleton();
#$html =~ s/<article>/<article>$text/;


#print "$html";
#

print $text;
