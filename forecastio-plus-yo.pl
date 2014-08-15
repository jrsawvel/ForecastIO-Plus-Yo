#!/usr/bin/perl -wT

# Aug 11, 2014
# I'm using Yo to send alerts based upon ForecastIO's data.
# This example sends a Yo to users subscribed to HEAVYRAINTOLEDO
# when the ForecastIO's minutely data predicts at least a 50 percent
# chance of heavy rain.

use strict;

$|++;

use lib '/home/youraccount/ToledoWX/lib';

use Weather::ForecastIO;
use Weather::Yo;

my $api_key = "forecastio api key";

# Toledo, Ohio
my $latitude = "41.665556";
my $longitude = "-83.575278";

my $forecast = ForecastIO->new($api_key, $latitude, $longitude);

$forecast->fetch_data;


my $prob_hit      = 0; 
my $intensity_hit = 0;

my @minutely = $forecast->minutely;
if ( @minutely ) {
    foreach my $m ( @minutely ) {
        my $prob = $m->precipProbability;
        $prob = $prob * 100;
        my $inten = $m->precipIntensity;
        $inten = $inten * 1000;

        if ( $prob >= 50 ) {
            $prob_hit = 1;
        }

        if ( $inten >= 175 ) {
            $intensity_hit = 1;
        }
    }
}


# Sylvania, Ohio
$latitude  = "41.711389";
$longitude = "-83.70333";

$forecast = ForecastIO->new($api_key, $latitude, $longitude);

$forecast->fetch_data;

@minutely = $forecast->minutely;
if ( @minutely ) {
    foreach my $m ( @minutely ) {
        my $prob = $m->precipProbability;
        $prob = $prob * 100;
        my $inten = $m->precipIntensity;
        $inten = $inten * 1000;

        if ( $prob >= 50 ) {
            $prob_hit = 1;
        }

        if ( $inten >= 175 ) {
            $intensity_hit = 1;
        }
    }
}

my $yo_api_token = "yo api token";

if ( $prob_hit and $intensity_hit ) {
    my $yo = Yo->new($yo_api_token);
    $yo->all;
}




