#!C:\Strawberry\perl\bin -w

use strict;
use warnings;
use Data::Dumper qw(Dumper);

my $fh;

my @fileIn = ();

my %hashPotato = ();
my %senseFreq = ();


if(open($fh, "<", $ARGV[0])) {

	while(<$fh>) {
		foreach my $line(split/\n/)  {
			chomp;

			# get frequency count of each sense
			senseCount($line);

			push(@fileIn, $line);
		}
	}
	close $fh;
}

sub senseCount {
	my $word = shift;
	if($word=~m/senseid="(.+)"/) {
		#print("found $1\n");
		$senseFreq{$1}++;
	}
}
print Dumper(\%senseFreq);