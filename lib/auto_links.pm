package auto_links;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(auto_links);

use auto_links;
use get_globals;


sub auto_links {
	my $text = shift;

	$text =~ s{<((https?|ftp):[^'">\s]+)>}{<a href="$1">$1</a>}gi;

	# Email addresses: <address@domain.foo>
	$text =~ s{
		<
        (?:mailto:)?
		(
			[-.\w]+
			\@
			[-a-z0-9]+(\.[-a-z0-9]+)*\.[a-z]+
		)
		>
	}{
		_EncodeEmailAddress( _UnescapeSpecialChars($1) );
	}egix;

	return $text;
}
