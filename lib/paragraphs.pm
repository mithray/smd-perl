package paragraphs;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(paragraphs);

use get_globals;
use span_gamut;
my %globals = get_globals();

sub paragraphs {
#
#	Params:
#		$text - string to process with html <p> tags
#
        my %globals = get_globals();
        my %g_html_blocks; #= $globals{'g_html_blocks'};

	my $text = shift;

	# Strip leading and trailing lines:
	$text =~ s/\A\n+//;
	$text =~ s/\n+\z//;

	my @grafs = split(/\n{2,}/, $text);

	#
	# Wrap <p> tags.
	#
	foreach (@grafs) {
		unless (defined( $g_html_blocks{$_} )) {
			$_ = span_gamut($_);
			s/^([ \t]*)/<p>/;
			$_ .= "</p>";
		}
	}

	#
	# Unhashify HTML blocks
	#
	foreach (@grafs) {
		if (defined( $g_html_blocks{$_} )) {
			$_ = $g_html_blocks{$_};
		}
	}

	return join "\n\n", @grafs;
}
