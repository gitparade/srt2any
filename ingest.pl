#!/usr/bin/env perl

use strict;
use Data::Dumper;

sub ingest {
	open SRT, $_[0];
	my %srt_as_hash;
	my $key;
	while (<SRT>) {
		chomp;
		if ($_ =~ /^\d+$/) {
			push my @moment, $_;
			$srt_as_hash{$_} = \@moment;
			$key = $_;
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

print Dumper %srt;
