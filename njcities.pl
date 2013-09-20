#!/usr/bin/perl
#requires lynx

use strict;
use warnings;
use autodie;

#$|++; #autoflush disk buffer

my $testing = 0; #set to 1 to prevent actual downloading, 0 normally
my $inputfile = "input.txt";
my $linxdump = "dump.txt";
my $outputfile = "out.".time.".csv";
my %alias; 
$alias{"1923 Municipal Manager Law"} = "1923 Municipal Manager Law";
$alias{"Council-Manager"} = "Faulkner Act (Council-Manager)";
$alias{"Faulkner Act (Council-Manager)"} = "Faulkner Act (Council-Manager)";
$alias{"Faulkner Act Council-Manager"} = "Faulkner Act (Council-Manager)";
$alias{"Faulkner Act Mayor-Council"} = "Faulkner Act (Mayor-Council)";
$alias{"Faulkner Act"} = "Faulkner Act (Mayor-Council)"; #there is only one, and this is it
$alias{"Mayor-Council"} = "Faulkner Act (Mayor-Council)";
$alias{"Faulkner Act (Mayor-Council)"} = "Faulkner Act (Mayor-Council)";
$alias{"Faulkner Act (Mayor-Council-Administrator)"} = "Faulkner Act (Mayor-Council-Administrator)";
$alias{"Mayor-Council-Administrator"} = "Faulkner Act (Mayor-Council-Administrator)";
$alias{"Faulkner Act (Small Municipality)"} = "Faulkner Act (Small Municipality)";
$alias{"Special Charter"} = "Special Charter";
$alias{"Borough"} = "Borough";
$alias{"borough"} = "Borough";
$alias{"Borough (New Jersey)"} = "Borough";
$alias{"Borough type of government"} = "Borough";
$alias{"City"} = "City";
$alias{"Town"} = "Town";
$alias{"Township"} = "Township";
$alias{"Township Committee"} = "Township";
$alias{"Township (New Jersey)"} = "Township";
$alias{"Village"} = "Village";
$alias{"Walsh Act"} = "Walsh Act";
$alias{"Walsh Act^[3]"} = "Walsh Act";
$alias{"Walsh Act (New Jersey)"} = "Walsh Act";

my @urlarray;
my $temp;

open my $ifile, '<', $inputfile;
@urlarray = <$ifile>;
close $ifile;

open my $ofile, '>', $outputfile;

foreach  my $url (@urlarray)
{
	chomp($url);
	$linxdump = $url;
	$linxdump =~ s/.+\///;
	$linxdump = "wiki/$linxdump";
	$temp = "lynx -dump -width=9999 -nolist \"$url\" > $linxdump";
	print "$temp\n";
	if (!$testing  && ! -e $linxdump) {system($temp);} #download page when not testing
	if ($testing) {$linxdump = "dump.txt";} #if testing use saved page
	open $ifile, '<', $linxdump;
		local $/; #load whole file into string
		my $thisfile = <$ifile>;
		#            • Type          Walsh Act
		$thisfile =~ m/\s+•\sType\s+(.+)\n/;
		my $form = $1;
		$form =~ s/^\s+//;
		$form = $alias{$form};
		print $ofile "\n$url;$form";
		
	close $ifile;
	
	
}

close $ofile;



print "\nDone\n\n";
