use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Test::More;
use Test::Trap;

BEGIN { use_ok("App::ClusterSSH::Host") }

my $host;

eval { $host = App::ClusterSSH::Host->new(); };
isa_ok($@, 'App::ClusterSSH::Exception', 'Caught exception object OK');
like(
    $@,
    qr/hostname is undefined/,
    'eval error - hostname is undefined (method)'
);

diag('Checking IPv4 type addresses') if ( $ENV{TEST_VERBOSE} );
$host = App::ClusterSSH::Host->new( hostname => 'hostname' );
is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'hostname set' );
is( $host->get_port,     q{},        'checking set works' );
is( $host->get_username, q{},        'username is unset' );
is( $host->get_realname, 'hostname', 'realname set' );

$host->set_port(2323);

is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     2323,       'checking set works' );
is( $host->get_username, q{},        'username is unset' );
is( $host->get_realname, 'hostname', 'realname set' );

$host->set_username('username');

is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     2323,       'checking set works' );
is( $host->get_username, 'username', 'username is unset' );
is( $host->get_realname, 'hostname', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->new( hostname => 'hostname' );
isa_ok( $host, "App::ClusterSSH::Host" );

is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'hostname set' );
is( $host->get_port,     q{},        'checking set works' );
is( $host->get_username, q{},        'username is unset' );
is( $host->get_realname, 'hostname', 'realname set' );

$host->set_port(2323);

is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     2323,       'checking set works' );
is( $host->get_username, q{},        'username is unset' );
is( $host->get_realname, 'hostname', 'realname set' );

$host->set_username('username');

is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     2323,       'checking set works' );
is( $host->get_username, 'username', 'username is unset' );
is( $host->get_realname, 'hostname', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->new(
    hostname => 'hostname',
    port     => 2323,
);
isa_ok( $host, "App::ClusterSSH::Host" );

is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'hostname set' );
is( $host->get_port,     2323,       'checking set works' );
is( $host->get_username, q{},        'username is unset' );
is( $host->get_realname, 'hostname', 'realname set' );

$host->set_username('username');

is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     2323,       'checking set works' );
is( $host->get_username, 'username', 'username is unset' );
is( $host->get_realname, 'hostname', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->new(
    hostname => 'hostname',
    username => 'username',
);
isa_ok( $host, "App::ClusterSSH::Host" );

is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'hostname set' );
is( $host->get_port,     q{},        'checking set works' );
is( $host->get_username, 'username', 'username is set' );
is( $host->get_realname, 'hostname', 'realname set' );

$host->set_port(2323);

is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     2323,       'checking set works' );
is( $host->get_username, 'username', 'username is set' );
is( $host->get_realname, 'hostname', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->new(
    hostname => 'hostname',
    username => 'username',
    port     => 2323,

);
isa_ok( $host, "App::ClusterSSH::Host" );

is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     2323,       'checking set works' );
is( $host->get_username, 'username', 'username is set' );
is( $host->get_realname, 'hostname', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

diag('Parsing IPv4 hostname') if ( $ENV{TEST_VERBOSE} );

$host = App::ClusterSSH::Host->parse_host_string('hostname');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     q{},        'checking set works' );
is( $host->get_username, q{},        'username is unset' );
is( $host->get_realname, 'hostname', 'realname set' );

$host = App::ClusterSSH::Host->parse_host_string('host%name');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               'host%name', 'stringify works' );
is( $host->get_hostname, 'host%name', 'checking set works' );
is( $host->get_port,     q{},         'checking set works' );
is( $host->get_username, q{},         'username is unset' );
is( $host->get_realname, 'host%name', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('hostname:2323');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     2323,       'checking set works' );
is( $host->get_username, q{},        'username is unset' );
is( $host->get_realname, 'hostname', 'realname set' );

$host = App::ClusterSSH::Host->parse_host_string('host%name:2323');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               'host%name', 'stringify works' );
is( $host->get_hostname, 'host%name', 'checking set works' );
is( $host->get_port,     2323,        'checking set works' );
is( $host->get_username, q{},         'username is unset' );
is( $host->get_realname, 'host%name', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('username@hostname:2323');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     2323,       'checking set works' );
is( $host->get_username, 'username', 'username is set' );
is( $host->get_realname, 'hostname', 'realname set' );

$host = App::ClusterSSH::Host->parse_host_string('username@host%name:2323');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               'host%name', 'stringify works' );
is( $host->get_hostname, 'host%name', 'checking set works' );
is( $host->get_port,     2323,        'checking set works' );
is( $host->get_username, 'username',  'username is set' );
is( $host->get_realname, 'host%name', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('username@hostname');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               'hostname', 'stringify works' );
is( $host->get_hostname, 'hostname', 'checking set works' );
is( $host->get_port,     q{},        'checking set works' );
is( $host->get_username, 'username', 'username is set' );
is( $host->get_realname, 'hostname', 'realname set' );

$host = App::ClusterSSH::Host->parse_host_string('username@host%name');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               'host%name', 'stringify works' );
is( $host->get_hostname, 'host%name', 'checking set works' );
is( $host->get_port,     q{},         'checking set works' );
is( $host->get_username, 'username',  'username is set' );
is( $host->get_realname, 'host%name', 'realname set' );

diag('Parsing IPv4 IP address') if ( $ENV{TEST_VERBOSE} );

$host = App::ClusterSSH::Host->parse_host_string('127.0.0.1');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               '127.0.0.1', 'stringify works' );
is( $host->get_hostname, '127.0.0.1', 'checking set works' );
is( $host->get_port,     q{},         'checking set works' );
is( $host->get_username, q{},         'username is unset' );
is( $host->get_realname, '127.0.0.1', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('127.0.0.1:2323');
isa_ok( $host, "App::ClusterSSH::Host" );

is( $host,               '127.0.0.1', 'stringify works' );
is( $host->get_hostname, '127.0.0.1', 'checking set works' );
is( $host->get_port,     2323,        'checking set works' );
is( $host->get_username, q{},         'username is unset' );
is( $host->get_realname, '127.0.0.1', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('username@127.0.0.1:2323');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               '127.0.0.1', 'stringify works' );
is( $host->get_hostname, '127.0.0.1', 'checking set works' );
is( $host->get_port,     2323,        'checking set works' );
is( $host->get_username, 'username',  'username is set' );
is( $host->get_realname, '127.0.0.1', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('username@127.0.0.1');
isa_ok( $host, "App::ClusterSSH::Host" );

is( $host,               '127.0.0.1', 'stringify works' );
is( $host->get_hostname, '127.0.0.1', 'checking set works' );
is( $host->get_port,     q{},         'checking set works' );
is( $host->get_username, 'username',  'username is set' );
is( $host->get_realname, '127.0.0.1', 'realname set' );

diag('Checking IPv6 type addresses') if ( $ENV{TEST_VERBOSE} );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('::1');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               '::1', 'stringify works' );
is( $host->get_hostname, '::1', 'checking set works' );
is( $host->get_port,     q{},   'port is unset' );
is( $host->get_username, q{},   'username is unset' );
is( $host->get_realname, '::1', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('username@::1');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               '::1',      'stringify works' );
is( $host->get_hostname, '::1',      'checking set works' );
is( $host->get_port,     q{},        'port is unset' );
is( $host->get_username, 'username', 'username is set' );
is( $host->get_realname, '::1',      'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('[::1]');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               '::1', 'stringify works' );
is( $host->get_hostname, '::1', 'checking set works' );
is( $host->get_port,     q{},   'port is unset' );
is( $host->get_username, q{},   'username is unset' );
is( $host->get_realname, '::1', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('username@[::1]');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               '::1',      'stringify works' );
is( $host->get_hostname, '::1',      'checking set works' );
is( $host->get_port,     q{},        'port is unset' );
is( $host->get_username, 'username', 'username is set' );
is( $host->get_realname, '::1',      'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('[::1]:22');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               '::1', 'stringify works' );
is( $host->get_hostname, '::1', 'checking set works' );
is( $host->get_port,     22,    'checking port set' );
is( $host->get_username, q{},   'username is unset' );
is( $host->get_realname, '::1', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string('username@[::1]:22');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host,               '::1',      'stringify works' );
is( $host->get_hostname, '::1',      'checking set works' );
is( $host->get_port,     22,         'checking port set' );
is( $host->get_username, 'username', 'username is set' );
is( $host->get_realname, '::1',      'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

$host = App::ClusterSSH::Host->parse_host_string(
    '2001:0db8:85a3:0000:0000:8a2e:0370:7334');
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host, '2001:0db8:85a3:0000:0000:8a2e:0370:7334', 'stringify works' );
is( $host->get_hostname,
    '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
    'checking set works'
);
is( $host->get_port,     q{}, 'port is unset' );
is( $host->get_username, q{}, 'username is unset' );
is( $host->get_realname, '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
    'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

trap {
    $host = App::ClusterSSH::Host->parse_host_string(
        '2001:0db8:85a3::8a2e:0370:7334');
};
is( $trap->leaveby, 'return', 'returned ok' );
is( $trap->die,     undef,    'returned ok' );
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host, '2001:0db8:85a3::8a2e:0370:7334', 'stringify works' );

is( $trap->stdout, q{}, 'Expecting no STDOUT' );
is( $trap->stderr =~ tr/\n//, 2, 'got correct number of print lines' );
like(
    $trap->stderr,
    qr/^Ambiguous host string: "2001:0db8:85a3::8a2e:0370:7334/,
    'checking warning output'
);
like(
    $trap->stderr,
    qr/Assuming you meant "\[2001:0db8:85a3::8a2e:0370:7334\]"?/,
    'checking warning output'
);

is( $host->get_hostname,
    '2001:0db8:85a3::8a2e:0370:7334',
    'checking set works'
);
is( $host->get_port,     q{}, 'port is unset' );
is( $host->get_username, q{}, 'username is unset' );
is( $host->get_realname, '2001:0db8:85a3::8a2e:0370:7334', 'realname set' );

$host = undef;
is( $host, undef, 'starting afresh' );

trap {
    $host = App::ClusterSSH::Host->new(
        hostname   => 'ssh_test',
        ssh_config => $Bin . '/10host_ssh_config',
    );
};
is( $trap->leaveby, 'return', 'returned ok' );
is( $trap->die,     undef,    'returned ok' );
isa_ok( $host, "App::ClusterSSH::Host" );
is( $host, 'ssh_test', 'stringify works' );
is( $host->check_ssh_hostname, 0, 'check_ssh_hostname ok for ssh_test', );

for my $hostname (
    'server1',  'server2',
    'server3',  'server4',
    'server-5', 'server5.domain.name',
    'server-6.domain.name'
    )
{

    $host = undef;
    is( $host, undef, 'starting afresh for ssh hostname checks' );

    trap {
        $host = App::ClusterSSH::Host->new(
            hostname   => $hostname,
            ssh_config => $Bin . '/10host_ssh_config',
        );
    };
    is( $trap->leaveby, 'return', 'returned ok' );
    is( $trap->die,     undef,    'returned ok' );
    isa_ok( $host, "App::ClusterSSH::Host" );
    is( $host, $hostname, 'stringify works' );
    is( $host->check_ssh_hostname, 1,
        'check_ssh_hostname ok for ' . $hostname );
    is( $host->get_realname, $hostname, 'realname set' );

}

#$host = undef;
#is( $host, undef, ' starting afresh for ssh hostname checks ' );
#
#trap {
#    $host = App::ClusterSSH::Host->new( hostname => ' ssh_text ', ssh_config => $Bin . ' / 10 host_ssh_config ' );
#};
#is( $trap->leaveby, ' return ', ' returned ok ' );
#is( $trap->die,     undef,    ' returned ok ' );
#isa_ok( $host, "App::ClusterSSH::Host" );
#is( $host, ' ssh_text ', ' stringify works ' );
#is( $host->check_ssh_hostname, 0, ' check_ssh_hostname ok ');
#
#$host = undef;
#is( $host, undef, ' starting afresh for ssh hostname checks ' );
#
#trap {
#    $host = App::ClusterSSH::Host->new( hostname => ' ssh_text ', ssh_config => $Bin . ' / 10 host_ssh_config ' );
#};
#is( $trap->leaveby, ' return ', ' returned ok ' );
#is( $trap->die,     undef,    ' returned ok ' );
#isa_ok( $host, "App::ClusterSSH::Host" );
#is( $host, ' ssh_text ', ' stringify works ' );
#is( $host->check_ssh_hostname, 0, ' check_ssh_hostname ok ');

done_testing();
