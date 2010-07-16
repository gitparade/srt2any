#!/usr/bin/env perl
use strict;
use Data::Dumper;

use CGI qw/:standard :html4/;
use utf8;

sub ingest {
	open SRT, $_[0];
	my %srt_as_hash;
	my $key;
	while (<SRT>) {
		chomp;
		if ($_ =~ /^\d+$/) {
			$key = sprintf("%04s", $_);
			push my @moment, $key;
			$srt_as_hash{$key} = \@moment;
#			$key = sprintf("%09s", $_);
		}
		unless ($_ =~ /^\d+$/) {
			unless ($_ eq "") {
				push @{$srt_as_hash{$key}}, $_;
			}
		}
	}
	%srt_as_hash;
}

my $subtitles = "soundMarkTompkinsAboutSigiKeil.srt" unless $ARGV[0];
$subtitles = $ARGV[0] unless not $ARGV[0];

my %srt = &ingest($subtitles);

my $css_file = "http://localhost/srt2html.css";

print
	header(-charset=>'utf-8'),
	start_html(-title => $subtitles,
				-style => {"src"=>$css_file});

my @keys = sort keys %srt;
my @frame;
my $frame_length;
foreach (@keys) {
	@frame = @{$srt{$_}};
	$frame_length = $#frame;
	foreach (0..$frame_length) {
		if ($_ == 0) {
			next;
		}
		elsif ($_ == 1) {
			printf "<div class=\"time\">%s</div>", $frame[$_];
		}
		else {
			printf "<div class=\"text\">%s</div>", $frame[$_];
		}
	}
	print "<br/>";
}




print end_html;
