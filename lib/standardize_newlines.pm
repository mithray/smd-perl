package standardize_newlines;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(standardize_newlines);

sub standardize_newlines {
    my $md = $_[0];
    $md =~ s{\r\n}{\n}g;
    $md =~ s{\r}{\n}g; 	
    return $md;
}
