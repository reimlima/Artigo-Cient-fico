#!/usr/bin/perl

use strict;
use warnings;

my %wordHash;
my $auxWord;
my $tweetText;
my @wordArray;

foreach (<>){
	chomp;
	$tweetText = (split(/\t/,$_))[2];
	if(defined($tweetText)){
		@wordArray = split(/\s/, $tweetText);
		foreach $auxWord (@wordArray){
			if(defined($wordHash{$auxWord})){
				$wordHash{$auxWord}++;
			}else{
				$wordHash{$auxWord} = 1;
			} 
		}
	}
}

foreach (keys(%wordHash)){
	print "$_ $wordHash{$_}\n";
}
