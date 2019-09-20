package li;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(li);

sub li {
    my $content = $_[0];
    $content =~ s/- (.*)/<li>$1<\/li>/g;
    return $content;
}
