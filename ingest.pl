#!/usr/bin/env perl

use strict;

sub ingest {
	open SRT, $_[0];
	my $at_the_zone = "not";
	my %srt_as_hash;
	my @moment;
	while (<SRT>) {
		if ($_ =~ /^\d+$/) { @moment = (); }
		unless ($_ =~ /^\d+$/) {
			push @moment, $_;
		}
	}
}

my $subtitles = "soundMarkTompkinsAboutSigiKeil.srt" unless $ARGV[0];
$subtitles = $ARGV[0] unless not $ARGV[0];

&ingest($subtitles);
