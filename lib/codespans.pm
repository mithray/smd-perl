package codespans;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(codespans);

sub codespans {

	my $text = shift;
        $text =~ s{`(.*?)`}{<code>$1<\/code>};
	return $text;
}
