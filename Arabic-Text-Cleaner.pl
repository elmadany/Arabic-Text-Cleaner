###################################################
# Arabic Text Cleaner
# written by AbdelRahim Elmadany
# April,6 2017
# Usage: perl Arabic-Text-Cleaner.pl inputFile outpitFile
####################################################
open my $in,  '<:encoding(UTF-8)',  $ARGV[0] or die $!;
open my $out, '>:encoding(UTF-8)', $ARGV[1]  or die $!;
$line=0;
while(<$in>)
{
  $line++;
  print "$line lines.\r";
  $_=" ".$_." "; #add space in start/end of the line to cache all URLs
  s/(&(.*?);)+/ /g; #remove web programming qoutes e.g  &quot; &#9733;
  s/\p{Z}+/ /g; #remove multi-any kind of whitespace or invisible separator.
  s/\s+http(.*?)\s+/ /g; # remove UTLs 

  #if( $_ !~ m/\p{L}/) # check if the line have word/leter for any langauge
  if( $_ =~ m/[دجحخهعغفقثصضشسيبلاتنمكطظوةىﻻرؤءئإأآ]+/) # check if the line have Arabic word/leter
  {
     #if the line have stretching letters more than 2 times remove the repetition e.g. مشكوووووووووووووور
     if ($_ =~ m/([دجحخهعغفقثصضشسيبلاتن?؟!.مكطظوةىﻻرؤءئإأآ]+)\1{2}/ ) 
     {
	for($i=0; $i<10; $i++) {$_ =~ s/([دجحخهعغفقثصضشسيبلاتن?؟!.مكطظوةىﻻرؤءئإأآ]+)\1{2}/\1/g;}
     }
     print $out $_; #print cleaned Arabic line
  }

}


