#!/usr/bin/perl
use strict;
use warnings;
binmode STDOUT, ":encoding(UTF-8)";
use feature 'unicode_strings';
use utf8;

use FindBin;                  
use lib "$FindBin::Bin/lib";
use headings;
use phrasing;
use ul;
use li;

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
    return $base_html
}

sub convert_to_html {
    my $html = $_[0];
    $html = headings($html);
    $html = phrasing($html);
    $html = ul($html);
    $html = li($html);
    return $html
}

my $md = get_file('README.md');
my $html= convert_to_html($md);
$html =~ s/<article>/<article>$html/;



print "$html"
