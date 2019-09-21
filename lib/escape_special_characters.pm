package escape_special_characters;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(escape_special_characters);

use Digest::MD5 qw(md5_hex);
use tokenize_html;
use encode_backslash_escapes;

sub escape_special_characters {
    my %g_escape_table;
    foreach my $char (split //, '\\`*_{}[]()>#+-.!') {
    	$g_escape_table{$char} = md5_hex($char);
    }
	my $text = shift;
	my $tokens ||= tokenize_html($text);

	$text = '';   # rebuild $text from the tokens
# 	my $in_pre = 0;	 # Keep track of when we're inside <pre> or <code> tags.
# 	my $tags_to_skip = qr!<(/?)(?:pre|code|kbd|script|math)[\s>]!;

	foreach my $cur_token (@$tokens) {
		if ($cur_token->[0] eq "tag") {
			# Within tags, encode * and _ so they don't conflict
			# with their use in Markdown for italics and strong.
			# We're replacing each such character with its
			# corresponding MD5 checksum value; this is likely
			# overkill, but it should prevent us from colliding
			# with the escape values by accident.
			$cur_token->[1] =~  s! \* !$g_escape_table{'*'}!gx;
			$cur_token->[1] =~  s! _  !$g_escape_table{'_'}!gx;
			$text .= $cur_token->[1];
		} else {
			my $t = $cur_token->[1];
			$t = encode_backslash_escapes($t);
			$text .= $t;
		}
	}
	return $text;
}
