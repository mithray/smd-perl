#!/usr/bin/perl
use strict;
use warnings;
binmode STDOUT, ":encoding(UTF-8)";
use feature 'unicode_strings';
use utf8;

use FindBin;                  
use lib "$FindBin::Bin/lib";

# Inside Block
use phrasing;
use codespans;
use escape_special_characters;
use images;

=insideblock
use anchors;
use autolinks;
use encode_amps_and_angles;
use phrasing; #italics, bold, critic
use lines;
=cut

# Block
use headings;
use lists;

# Helpers
use detab;

my $g_list_level = 0;
my $g_tab_width = 4;

sub get_file{
    if (open (  my $fh, "<:encoding(UTF-8)", "$_[0]")){
        my $data = '';
        while (my $row = <$fh>){
            $data = "$data$row";
        }
        return $data;
    }
}

sub get_html_skeleton {
    my $base_html = get_file('templates/base.html');
    my $base_css = get_file('templates/base.css');
    my $html_title = "MD Conversion with Perl";
    $base_html =~ s/<!-- css -->/$base_css/;
    $base_html =~ s/<!-- title -->/$html_title/;
    return $base_html;
}

sub span_gamut {
    my $text = shift;

    $text = code_spans($text);
    $text = escape_special_characters($text);
    $text = images($text);
    $text = anchors($text);
    $text = auto_links();
    $text = amps_angles($text);
    $text = phrasing($text);
    $text = line_breaks($text);

    return $text;
}

sub block_gamut {
    my $text = shift;

    $text = headings($text);
    $text = lists($text);
    $text = horizontal_rules($text);
    $text = code_blocks($text);
    $text = blockquotes($text);
    $text = hash_html($text);
    $text = paragraphs($text);

    return $text;
}

sub convert_to_html {
    my $text = shift;
    $text = block_gamut($text)
    $text = span_gamut($text)
    return $text
}

sub standardize_newlines {
    my $md = $_[0];
    $md =~ s{\r\n}{\n}g;
    $md =~ s{\r}{\n}g; 	
    return $md;
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

