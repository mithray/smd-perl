package encode_code;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(encode_code);
use Digest::MD5 qw(md5_hex);

use get_globals;

sub encode_code {
#
# Encode/escape certain characters inside Markdown code runs.
# The point is that in code, these characters are literals,
# and lose their special Markdown meanings.
#
    my %globals = get_globals();
    my %g_escape_table = $globals{'g_escape_table'};

#my %g_escape_table;
#foreach my $char (split //, '\\`*_{}[]()>#+-.!') {
#	$g_escape_table{$char} = md5_hex($char);
#}

    local $_ = shift;

	# Encode all ampersands; HTML entities are not
	# entities within a Markdown code span.
	s/&/&amp;/g;

	# Encode $'s, but only if we're running under Blosxom.
	# (Blosxom interpolates Perl variables in article bodies.)
	{
		no warnings 'once';
    	if (defined($blosxom::version)) {
    		s/\$/&#036;/g;	
    	}
    }


	# Do the angle bracket song and dance:
	s! <  !&lt;!gx;
	s! >  !&gt;!gx;

	# Now, escape characters that are magic in Markdown:
	s! \* !$g_escape_table{'*'}!gx;
	s! _  !$g_escape_table{'_'}!gx;
	s! {  !$g_escape_table{'{'}!gx;
	s! }  !$g_escape_table{'}'}!gx;
	s! \[ !$g_escape_table{'['}!gx;
	s! \] !$g_escape_table{']'}!gx;
	s! \\ !$g_escape_table{'\\'}!gx;

	return $_;
}
