package headings;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(headings);

use span_gamut;

sub headings {
	my $text = shift;

	# Setext-style headers:
	#	  Header 1
	#	  ========
	#  
	#	  Header 2
	#	  --------
	#
	$text =~ s{ ^(.+)[ \t]*\n=+[ \t]*\n+ }{
		"<h1>"  .  span_gamut($1)  .  "</h1>\n\n";
	}egmx;

	$text =~ s{ ^(.+)[ \t]*\n-+[ \t]*\n+ }{
		"<h2>"  .  span_gamut($1)  .  "</h2>\n\n";
	}egmx;


	# atx-style headers:
	#	# Header 1
	#	## Header 2
	#	## Header 2 with closing hashes ##
	#	...
	#	###### Header 6
	#
	$text =~ s{
			^(\#{1,6})	# $1 = string of #'s
			[ \t]*
			(.+?)		# $2 = Header text
			[ \t]*
			\#*			# optional closing #'s (not counted)
			\n+
		}{
			my $h_level = length($1);
			"<h$h_level>"  .  span_gamut($2)  .  "</h$h_level>\n\n";
		}egmx;

	return $text;
}
