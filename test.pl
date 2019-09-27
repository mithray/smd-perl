
use Digest::MD5 qw(md5_hex);
my %g_escape_table;
foreach my $char (split //, '\\`*_{}[]()>#+-.!') {
    print $char;
    $g_escape_table{$char} = md5_hex($char);
}
