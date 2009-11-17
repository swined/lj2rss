package ua;

use warnings;
use strict;
use LWP::UserAgent;
use LWP::Protocol::http::SocksChain;

our @ISA = qw/LWP::UserAgent/;

sub new {
	my ($class, %param) = @_;
	my $self = $class->SUPER::new(
		timeout => 30,
		cookie_jar => {},
	);
#	$self->agent('http://lj2rss.net.ru/; swined@gmail.com');
	return $self;
}

sub set_socks {
	my ($port) = @_;
	LWP::Protocol::implementor( http => 'LWP::Protocol::http::SocksChain' );
	@LWP::Protocol::http::SocksChain::EXTRA_SOCK_OPTS = (
		Chain_Len    => 1,
		Debug        => 0,
		Random_Chain => 1,
		Chain_File_Data => ['127.0.0.1:' . $port . ':::5'],
		Auto_Save    => 0,
		Restore_Type => 0,
	);
}

1;
