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

my @urlarray;
my $temp;

open my $ifile, '<', $inputfile;
@urlarray = <$ifile>;
close $ifile;

open my $ofile, '>', $outputfile;

foreach  my $url (@urlarray)
{
	chomp($url);
	$temp = "lynx -dump -width=9999 -nolist \"$url\" > $linxdump";
	print "$temp\n";
	if (!$testing) {system($temp);} #download page when not testing
	if ($testing) {$linxdump = "dump.txt";} #if testing use saved page
	open my $ifile, '<', $linxdump;
		local $/; #load whole file into string
		my $thisfile = <$ifile>;
		#print $thisfile;
		if ($thisfile =~ m/Council-Manager/i)
		{
			print $ofile "\n$url; Council-Manager";
		}
		if ($thisfile =~ m/Small Municipality Plan/i)
		{
			print $ofile "\n$url; Small Municipality Plan";
		}
		if ($thisfile =~ m/Mayor-Council/i)
		{
			print $ofile "\n$url; Mayor-Council";
		}
		if ($thisfile =~ m/Mayor-Council-Administrator/i)
		{
			print $ofile "\n$url; Mayor-Council-Administrator";
		}
		if ($thisfile =~ m/1923 Municipal Manager Law/i)
		{
			print $ofile "\n$url; 1923 Municipal Manager Law";
		}
		if ($thisfile =~ m/special charter/i)
		{
			print $ofile "\n$url; special charter";
		}
		if ($thisfile =~ m/Walsh Act/i)
		{
			print $ofile "\n$url; Walsh Act";
		}
		if ($thisfile =~ m/Town form/i)
		{
			print $ofile "\n$url; Town form";
		}
		if ($thisfile =~ m/Borough form/i)
		{
			print $ofile "\n$url; Borough form";
		}
		if ($thisfile =~ m/Township form/i)
		{
			print $ofile "\n$url; Township form";
		}
		if ($thisfile =~ m/City form/i)
		{
			print $ofile "\n$url; City form";
		}
		if ($thisfile =~ m/Village form/i)
		{
			print $ofile "\n$url; Village form";
		}
		
		
		
		
		
		
		
	close $ifile;
	
	
	
	
	
	
}

close $ofile;


#Faulkner Act form of Government under the Small Municipality Plan
#Faulkner Act (Council-Manager)

#Mayor-Council-Administrator

#Faulkner Act (Mayor-Council) Plan E form of municipal government
#Faulkner Act (Mayor-Council) Plan C as the form of local government
#governed under the Mayor-Council system of municipal government under the Faulkner Act
#mayor-council form of government under the Faulkner Act

#governed under the 1923 Municipal Manager Law
#special charter
#Walsh Act form of government

#Town form of New Jersey municipal government
#Township form of government
#Borough form of New Jersey municipal government
#City form of government
#City form of New Jersey municipal government












print "\nDone\n\n";
