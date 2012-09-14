#!/usr/bin/perl -w

use strict;
use Time::Interval;
use Date::Parse ; 
use DateTime ;

my $filename = shift ;
my $conf_offset = "00:00:35" ;

my ($ss,$mm,$hh,$day,$month,$year,$zone) = strptime($conf_offset);

my $subtitle_time = DateTime->new( hour => $hh, minute => $mm, second => $ss, year => 2012, month => 1, day => 1, time_zone => 'CET', nanosecond => 0 ) ; 

print "offset = " . $subtitle_time->hms . "\n" ;

open( FILENAME, "<$filename" ) or die "ERROR: can't open file $filename\n" ;

my $subnr = 0 ;
my $delta ;
my $starttime ;
my $endtime ;

# read first line:
my $line = <FILENAME> ;
my( $pkt_num,$gps_time,$lat,$lon,$gps_alt,$gps_speed,$gps_course,$temp_int,$temp_ext,$batt_volt,$batt_current,$humidity,$pressure,$baro_alt,$num_sats ) = split ',', $line  ;

my $last_time = $gps_time ;

while( <FILENAME> ) {

	( $pkt_num,$gps_time,$lat,$lon,$gps_alt,$gps_speed,$gps_course,$temp_int,$temp_ext,$batt_volt,$batt_current,$humidity,$pressure,$baro_alt,$num_sats ) = split ',' ;

        $delta = getInterval( $last_time, $gps_time ) ;

	if( $delta->{'seconds'} == 0 ) {
		next ;
	}

	$subnr++ ;

	$starttime = $subtitle_time->hms ;

	$subtitle_time->add( seconds => $delta->{'seconds'} ) ;

	$endtime = $subtitle_time->hms ;

        print "$subnr\n" ;
        print "$starttime,000 --> $endtime,000\n" ;
	print "Time: $gps_time Alt: $gps_alt Temp_int: $temp_int Temp_ext: $temp_ext\n\n" ;

	$last_time = $gps_time ;
}
