#!/usr/bin/perl
foreach(<>){
	chomp;
	($tweetDate,$tweetAccount,$tweetText) = (split(/\|/,$_))[0,1,2];
	$tweetDate =~ s/date = //;
	$tweetAccount =~ s/user = //; 
	$tweetText =~s/text = //;
	print "$tweetDate\t$tweetAccount\t$tweetText\n";
}
