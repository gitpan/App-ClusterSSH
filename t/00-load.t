use FindBin;
use lib $FindBin::Bin.'/../lib';

use Test::More tests => 1;

BEGIN {
	use_ok( 'App::ClusterSSH' );
}

diag( "Testing App::ClusterSSH $App::ClusterSSH::VERSION, Perl $], $^X" );
