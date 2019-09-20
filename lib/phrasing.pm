package phrasing;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(phrasing);

sub phrasing {
    my $content = $_[0];
    $content =~ s/__(.*?)__/<strong>$1<\/strong>/g;
    $content =~ s/_(.*?)_/<em>$1<\/em>/g;
    $content =~ s/\*\*(.*?)\*\*/<strong>$1<\/strong>/g;
    $content =~ s/\*(.*?)\*/<em>$1<\/em>/g;
    return $content;
}
