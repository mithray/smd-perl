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
sub process_markdown{
    my $text = shift;
    $text = detab($text);
    $text = trim_empty_line_space($text);
    $text= convert_to_html($text);
    return $text
}

		my %cli_opts;
                my $VERSION = "0.0.1";
		use Getopt::Long;
		Getopt::Long::Configure('pass_through');
		GetOptions(\%cli_opts,
			'version',
                        'shortversion',
			'wrap',
			'style',
		);
		if ($cli_opts{'version'}) {		# Version info
			print "\nThis is Markdown, version $VERSION.\n";
			print "Copyright 2004 John Gruber\n";
			print "http://daringfireball.net/projects/markdown/\n\n";
			exit 0;
		}
		if ($cli_opts{'shortversion'}) {		# Just the version number string.
			print $VERSION;
			exit 0;
		}
		if ($cli_opts{'style'}) {			# Use HTML tag style instead of XHTML
                }

# Slurp whole File
my $text;
{
    local $/;               
    $text= <>;
}

$text = process_markdown($text);

if ($cli_opts{'wrap'}) {			# Use HTML tag style instead of XHTML
    my $wrapper= get_html_skeleton();
    my $wrapped = $wrapper;
    $wrapped =~ s/<!-- content -->/$text/;
    $text = $wrapped;
}
print $text;
#$text = standardize_newlines($text);
#$text = end_with_newlines($text);


#print "$html";
#

