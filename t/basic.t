use Test::More 'no_plan';

use strict;
use warnings;
use utf8;

use Test::Mojo;

use FindBin;
$ENV{MOJO_HOME} = "$FindBin::Bin/..";
require "$ENV{MOJO_HOME}/atnd.pl";

my $t = Test::Mojo->new;
$t->get_ok('/get_lists/HTML5');
