#!/usr/bin/perl

use strict;
use warnings;

my %hashAccount;
my $tweetAccount;

foreach (<>){
	chomp;
	$tweetAccount = (split(/\t/,$_))[1];
	if(defined($tweetAccount)){
		if(exists($hashAccount{$tweetAccount})){
			$hashAccount{$tweetAccount}++;
		} else {
			$hashAccount{$tweetAccount} = 1;
		}
	}
}

foreach (keys(%hashAccount)){
	print "$_ $hashAccount{$_}\n";
}
