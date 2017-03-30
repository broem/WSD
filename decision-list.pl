#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper qw(Dumper);

use strict;
use warnings;
use Data::Dumper qw(Dumper);

my $fh;

my @fileIn = ();
my $mysteryNum = 0;
my $sense;

my %hashPotato = ();
my %senseFreq = ();
my %featuresUnigram = ();


if(open($fh, "<", $ARGV[0])) {

	while(<$fh>) {
		foreach my $line(split/\n/)  {
			chomp;

			# get frequency count of each sense
			senseCount($line);
			getBoWFeatures($line);

			push(@fileIn, $line);
		}
	}
	close $fh;
}

sub senseCount { ## what? this is wrong shouldnt be counting the senseIds
	my $word = shift;
	if($word=~m/senseid="(.+)"/) {
		#print("found $1\n");
		$senseFreq{$1}++;
	}
}

# A frequency feature Bag-Of-Fun-Words
# Store all the words associated by being in the same sentence
# set a flag when we encounter the tagged sense and store words
# as feature until we see the other word. Basic.
sub getBoWFeatures {
	my $line = shift;

	if($line=~m/senseid="phone"/) {
		$mysteryNum = 1;
		$sense = "phone";
	}
	if($line=~m/senseid="product"/) {
		$mysteryNum = 2;
		$sense = "product";
	}
	foreach my $word(split/\s+/){
		# remove the tags, this is annoying
		$word=~s/\<.+\>//;
		$word=~s/\<.+|.+\>//;
		$word=~s/instance=".+$//;
		$word=~s/id="line.+$//;
		$word=~s/.+\:"$//;
		$word=~s/aphb//;
		# remove the floating punctuation
		$word=~s/\"|,|\.|\;|\(|\)|:|\$|\%|\&|\{|\}|\!|\///g;
		# numbers here are pretty irrelevant right? DESTROY
		$word=~s/[0-9]//g; # 1970s???
		# bizzare
		$word=~s/--//;

		# do i need to remove line/lines?
		$word=~s/^line$|^lines$//g;

		if($word ne ""){
			## do we need the frequencies of each word? or just the
			## fact they exist?
			$featuresUnigram{$sense}{$word}++;
		}
	}
sub getNgramFeatures {


}


}
print Dumper(\%featuresUnigram);