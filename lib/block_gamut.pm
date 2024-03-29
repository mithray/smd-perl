package block_gamut;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(block_gamut);

use headings;
use lists;
use horizontal_rules;
use code_blocks;
use echarts;
use block_quotes;
use hash_html_blocks;
use paragraphs;
use mermaid;

sub block_gamut {
    my $text = shift;

    $text = headings($text);
    $text = lists($text);
#    $text = horizontal_rules($text);
    $text = echarts($text);
    $text = code_blocks($text);
    $text = mermaid($text);
#    $text = block_quotes($text);
    $text = hash_html_blocks($text);
#    $text = paragraphs($text);

    return $text;
}
