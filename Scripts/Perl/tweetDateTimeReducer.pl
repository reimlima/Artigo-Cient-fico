#!/usr/bin/perl

use strict;
use warnings;

my %hashDateTime;
my $tweetTime;
my $tweetDateTime;
my $tweetDateTimeFormated;
my %mon2num = ('Jan' => '01', 'Feb' => '02', 'Mar' => '03', 'Apr' => '04', 'May' => '05', 'Jun' => '06', 'Jul' => '07', 'Aug' => '08', 'Sep' => '09', 'Oct' => '10', 'Nov' => '11', 'Dec' => '12');

foreach (<>){
        chomp;
        $tweetDateTime = (split(/\t/,$_))[0];
        if ($tweetDateTime =~ /(.*)\s(.*)\s(.*)\s(.*)\s(.*)\s(.*)/){
                $tweetDateTimeFormated = "$3/$mon2num{$2}/$6";
                $tweetTime = $4;
                $tweetTime =~ s/([0-9]{2}):([0-9]{2}):([0-9]{2})/$1:$2/;
                $tweetDateTimeFormated = "$tweetDateTimeFormated $tweetTime";
        }
        if(defined($tweetDateTimeFormated)){
                if(exists($hashDateTime{$tweetDateTimeFormated})){
                        $hashDateTime{$tweetDateTimeFormated}++;
                } else {
                        $hashDateTime{$tweetDateTimeFormated} = 1;
                }
        }
}

foreach (keys(%hashDateTime)){
        print "$_ $hashDateTime{$_}\n";
}
