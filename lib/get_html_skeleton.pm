package get_html_skeleton;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(get_html_skeleton);

use get_file;

sub get_html_skeleton {
    my $base_html = get_file('../templates/base.html');
    my $base_css = get_file('../templates/base.css');
    my $html_title = "MD Conversion with Perl";
    $base_html =~ s/<!-- css -->/$base_css/;
    $base_html =~ s/<!-- title -->/$html_title/;
    return $base_html;
}

