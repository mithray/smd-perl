package outdent;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(outdent);

use get_globals;

sub outdent {
#
# Remove one level of line-leading tabs or spaces
#
    my %globals = get_globals();
    my $g_tab_width = $globals{'g_tab_width'};
    my $text = shift;

    $text =~ s/^(\t|[ ]{1,$g_tab_width})//gm;
    return $text;
}
