package get_globals;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(get_globals);
use Digest::MD5 qw(md5_hex);

sub get_globals {
    my $g_list_level = 0;
    my $g_tab_width = 4;
    my $g_urls = ();
    my %g_escape_table;
    foreach my $char (split //, '\\`*_{}[]()>#+-.!') {
	$g_escape_table{$char} = md5_hex($char);
    }
    my $g_titles = '';
    my $g_empty_element_suffix = " />";     # Change to ">" for HTML output
    my %globals = ( 
        'g_list_level' => $g_list_level, 
        'g_tab_width' => $g_tab_width, 
        'g_urls' => $g_urls, 
        'g_escape_table' => %g_escape_table, 
        'g_titles' => $g_titles, 
        'g_empty_element_suffix' => $g_empty_element_suffix
    );
    return %globals;
}
