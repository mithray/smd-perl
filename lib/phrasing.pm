package phrasing;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(phrasing);

sub phrasing {

	my $text = shift;

	# <strong> must go first:
	$text =~ s{ (\*\*|__) (?=\S) (.+?[*_]*) (?<=\S) \1 }
		{<strong>$2</strong>}gsx;

	$text =~ s{ (\*|_) (?=\S) (.+?) (?<=\S) \1 }
		{<em>$2</em>}gsx;

	$text =~ s{ (\^) (?=\S) (.+?) (?<=\S) \1 }
		{<sup>$2</sup>}gsx;

	$text =~ s{ (~) (?=\S) (.+?) (?<=\S) \1 }
		{<sub>$2</sub>}gsx;

	$text =~ s{ (\{>) (?=\S) (.+?) (?<=\S) (<\}) }
		{<mark><em>$2</em></mark>}gsx;

	$text =~ s{ (\{\-) (?=\S) (.+?) (?<=\S) (\-\}) }
		{<del>$2</del>}gsx;

	$text =~ s{ (\{\+) (?=\S) (.+?) (?<=\S) (\+\}) }
		{<ins>$2</ins>}gsx;

	$text =~ s{ (\{\=) (?=\S) (.+?) (?<=\S) (\=\}) }
		{<mark>$2</mark>}gsx;

	return $text;
}
