package line_breaks;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(line_breaks);

use get_globals;
my %globals = get_globals();

sub line_breaks {
    my $text = shift;
    my %globals = get_globals();
    my $g_empty_element_suffix = $globals{'g_empty_element_suffix'};
    $text =~ s/ {2,}\n/ <br$g_empty_element_suffix\n/g;
    return $text;
}
