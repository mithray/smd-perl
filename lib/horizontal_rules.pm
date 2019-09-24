package horizontal_rules;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(horizontal_rules);

use get_globals;

sub horizontal_rules {
    my $text = shift;
    my %globals = get_globals();
    my $g_empty_element_suffix = $globals{'g_empty_element_suffix'};
    $text =~ s{^[ ]{0,2}([ ]?\*[ ]?){3,}[ \t]*$}{\n<hr$g_empty_element_suffix\n}gmx;
    $text =~ s{^[ ]{0,2}([ ]? -[ ]?){3,}[ \t]*$}{\n<hr$g_empty_element_suffix\n}gmx;
    $text =~ s{^[ ]{0,2}([ ]? _[ ]?){3,}[ \t]*$}{\n<hr$g_empty_element_suffix\n}gmx;
    return $text;
}
