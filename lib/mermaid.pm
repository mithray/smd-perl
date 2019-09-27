package mermaid;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(mermaid);

use get_globals;
use encode_code;
use detab;
use outdent;

sub mermaid {

    my $text = shift;
    #$text =~ s {\@\@\@mermaid\s*([^\n]*)\n}{
    $text =~ s {\@\@\@mermaid([^\n]*)\n(([^\n]*\n)*)\@\@\@}{
        my $title = $1;
        my $content = $2;
        my $result= '<div class="mermaid">' . $content . '</div>';
        $result;
    }egxs;

    return $text;
}
