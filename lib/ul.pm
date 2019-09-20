package ul;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(ul);

sub ul {
    my $content = $_[0];
    $content =~ s/- (.*?)^[^-]/<ul>$1<\/ul>/sgm;
    return $content;
}

