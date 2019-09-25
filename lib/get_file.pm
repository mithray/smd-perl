package get_file;

use strict;
use warnings;
use Exporter 'import';
our $VERSION = '1.00';
our @EXPORT  = qw(get_file);

sub get_file{
    if (open (  my $fh, "<:encoding(UTF-8)", "$_[0]")){
        my $data = '';
        while (my $row = <$fh>){
            $data = "$data$row";
        }
        return $data;
    }
}
