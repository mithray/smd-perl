package echarts;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(echarts);

use get_globals;
use encode_code;
use detab;
use outdent;
use Digest::MD5 qw(md5_hex);

sub echarts {
    my $text = shift;
    $text =~ s {\@\@\@echarts([^\n]*)\n((([^\n]*)\n)*?)\@\@\@}{
        my $title = $1;
        my $content = $2;
        my $id = "chart" . md5_hex($content);
        $title = $id;
        my $height = "30em";
        my $width = "100%";
        my $block = '<div id="' . $title . '" style="width: ' . $width . ';height: ' . $height . ';"></div>';
        my $script = "
            <script type='text/javascript'>
                let options = $content 
                let $title = echarts.init(document.getElementById(\"$title\"))
                $title.setOption(options)
            </script>
        ";
        my $result = $block . $script;
        $result;
    }egmxs;

    return $text;
}
