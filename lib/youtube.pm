package youtube;

use warnings;
use strict;
use LWP::Simple;

sub replace {
	my ($text) = @_;
	while ($text =~ m|<iframe src="(http://lj-toys.com/[^""]*)"[^>]*></iframe>|si) {
		my ($before, $after, $url) = ($`, $', $1);
		$url =~ s/&amp;/&/gsi;
		my $embed = get $url;
		next unless $embed =~ m|<param name="movie" value="http://www.youtube.com/v/([^&]+?)(?:&[^""]+?)">|si;
		$text = sprintf 
			'%s<div><a href="http://www.youtube.com/?v=%s">youtube:<br/><img src="http://i1.ytimg.com/vi/%s/hqdefault.jpg" alt="youtube"/></a></div>%s', 
			$before, 
			$1, 
			$1,
			$after;
	}
	return $text;
}

1;
