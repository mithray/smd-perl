#!/usr/bin/perl
use strict;
use warnings;
binmode STDOUT, ":encoding(UTF-8)";
use feature 'unicode_strings';
use utf8;

use FindBin;                  
use lib "$FindBin::Bin/lib";
#FindBin::again();

# Inside Block
use phrasing;
use codespans;
use escape_special_characters;

=insideblock
use images;
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

sub prepare_base_html {
    my $base_html = get_file('templates/base.html');
    my $base_css = get_file('templates/base.css');
    my $html_title = "MD Conversion with Perl";
    $base_html =~ s/<!-- css -->/$base_css/;
    $base_html =~ s/<!-- title -->/$html_title/;
    return $base_html;
}

=span
sub inside_block {
	my $text = shift;
	$text = _DoCodeSpans($text);
	$text = _EscapeSpecialChars($text);
	$text = _DoImages($text);
	$text = _DoAnchors($text);
	$text = _DoAutoLinks($text);
	$text = _EncodeAmpsAndAngles($text);
	$text = _DoItalicsAndBold($text);
	$text =~ s/ {2,}\n/ <br$g_empty_element_suffix\n/g;
	return $text;
}
=cut

sub convert_to_html {
    my $text = $_[0];
    $text = headings($text);
    $text = lists($text);
    $text = codespans($text);
    $text = escape_special_characters($text);
    $text = phrasing($text);
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
my $html = prepare_base_html();
$html =~ s/<article>/<article>$text/;


print "$html"

