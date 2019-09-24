package block_quotes;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(block_quotes);

use block_gamut;

sub block_quotes {
	my $text = shift;

	$text =~ s{
		  (								# Wrap whole match in $1
			(
			  ^[ \t]*>[ \t]?			# '>' at the start of a line
			    .+\n					# rest of the first line
			  (.+\n)*					# subsequent consecutive lines
			  \n*						# blanks
			)+
		  )
		}{
			my $bq = $1;
			$bq =~ s/^[ \t]*>[ \t]?//gm;	# trim one level of quoting
			$bq =~ s/^[ \t]+$//mg;			# trim whitespace-only lines
			$bq = block_gamut($bq);		# recurse

			$bq =~ s/^/  /g;
			# These leading spaces screw with <pre> content, so we need to fix that:
			$bq =~ s{
					(\s*<pre>.+?</pre>)
				}{
					my $pre = $1;
					$pre =~ s/^  //mg;
					$pre;
				}egsx;

			"<blockquote>\n$bq\n</blockquote>\n\n";
		}egmx;


	return $text;
}
