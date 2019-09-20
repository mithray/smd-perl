package headings;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(headings);

sub headings {
    my $content = $_[0];
    $content =~ s/###### (.*)/<h6>$1<\/h6>/g;
    $content =~ s/##### (.*)/<h5>$1<\/h5>/g;
    $content =~ s/#### (.*)/<h4>$1<\/h4>/g;
    $content =~ s/### (.*)/<h3>$1<\/h3>/g;
    $content =~ s/## (.*)/<h2>$1<\/h2>/g;
    $content =~ s/# (.*)/<h1>$1<\/h1>/g;

    return $content;
}
