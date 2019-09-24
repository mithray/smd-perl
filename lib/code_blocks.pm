package code_blocks;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(code_blocks);

use get_globals;
use encode_code;
use detab;
use outdent;

sub code_blocks {
#
#	Process Markdown `<pre><code>` blocks.
#	

	my $text = shift;

    my %globals = get_globals();
    my $g_tab_width = $globals{'g_tab_width'};



	$text =~ s{
			(?:\n\n|\A)
			(	            # $1 = the code block -- one or more lines, starting with a space/tab
			  (?:
			    (?:[ ]{$g_tab_width} | \t)  # Lines must start with a tab or a tab-width of spaces
			    .*\n+
			  )+
			)
			((?=^[ ]{0,$g_tab_width}\S)|\Z)	# Lookahead for non-space at line-start, or end of doc
		}{
			my $codeblock = $1;
			my $result; # return value

			$codeblock = encode_code(outdent($codeblock));
			$codeblock = detab($codeblock);
			$codeblock =~ s/\A\n+//; # trim leading newlines
			$codeblock =~ s/\s+\z//; # trim trailing whitespace

			$result = "\n\n<pre><code>" . $codeblock . "\n</code></pre>\n\n";

			$result;
		}egmx;

	return $text;
}
