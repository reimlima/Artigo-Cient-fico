#!/usr/bin/perl

use strict;
use warnings;

my %hashText;
my $tweetText;

foreach (<>){
	chomp;
	$tweetText = (split(/\t/,$_))[2];
	if(defined($tweetText)){
		if(exists($hashText{$tweetText})){
			$hashText{$tweetText}++;
		} else {
			$hashText{$tweetText} = 1;
		}
	}
}

foreach (keys(%hashText)){
	print "$_ $hashText{$_}\n";
}
