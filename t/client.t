#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Mojo::Pg;

use Translations::Helper::Client;;

sub details_headers {

    my $pg = Mojo::Pg->new->dsn("dbi:Pg:dbname=Translations;host=192.168.1.100;port=15432;user=postgres;password=PV58nova64");

    my @field_list = (
        {
            setting_value => 'companies_pkey',
            setting_order => 0
        },{
        setting_value => 'editnum',
        setting_order => 0
    },{
        setting_value => 'insdatetime',
        setting_order => 0
    },{
        setting_value => 'modby',
        setting_order => 0
    },{
        setting_value => 'moddatetime',
        setting_order => 0
    },{
        setting_value => 'company',
        setting_order => 0
    },{
        setting_value => 'name',
        setting_order => 0
    },{
        setting_value => 'registrationnumber',
        setting_order => 0
    },{
        setting_value => 'homepage',
        setting_order => 0
    },{
        setting_value => 'phone',
        setting_order => 0
    },{
        setting_value => 'menu_group',
        setting_order => 0
    });

    my $data;

    $data->{companies_pkey} = 100;
    $data->{editnum} = 1;
    $data->{insby} ='System';
    $data->{insdatetime} = '2021-02-08 23:10:11';
    $data->{modby} = 'System';
    $data->{moddatetime} = '2021-02-08 23:10:11';
    $data->{company} = 'YT';
    $data->{name} = 'Testbolaget';
    $data->{registrationnumber} = '1234567-1234';
    $data->{homepage} = 'www';
    $data->{phone} = '123456 678';
    $data->{menu_group} = 1,

   my $result =  Translations::Helper::Client->new(
       pg               => $pg,
       endpoint_address => 'http://127.0.0.1:3022',
       key              => '58e51981-4c5d-46cd-8703-b02c94595a18'
   )->details_headers ('companies', \@field_list, $data, 'swe');

    return 1;
}

sub grid_header {

    my $pg = Mojo::Pg->new->dsn("dbi:Pg:dbname=Translations;host=192.168.1.100;port=15432;user=postgres;password=PV58nova64");

    my @field_list = (
        {
            setting_value      => 'companies_pkey',
            setting_order      => 0,
            setting_properties => '',
        },{
        setting_value => 'editnum',
        setting_order => 0,
            setting_properties => '',
    },{
        setting_value => 'insdatetime',
        setting_order => 0,
            setting_properties => '',
    },{
        setting_value => 'modby',
        setting_order => 0,
            setting_properties => '',
    },{
        setting_value => 'moddatetime',
        setting_order => 0,
            setting_properties => '',
    },{
        setting_value => 'company',
        setting_order => 0,
            setting_properties => '',
    },{
        setting_value => 'name',
        setting_order => 0,
            setting_properties => '',
    },{
        setting_value => 'registrationnumber',
        setting_order => 0,
            setting_properties => '',
    },{
        setting_value => 'homepage',
        setting_order => 0,
            setting_properties => '',
    },{
        setting_value => 'phone',
        setting_order => 0,
            setting_properties => '',
    },{
        setting_value => 'menu_group',
        setting_order => 0,
            setting_properties => '',
    });

    my $result =  Translations::Helper::Client->new(
        pg               => $pg,
        endpoint_address => 'http://127.0.0.1:3022',
        key              => '58e51981-4c5d-46cd-8703-b02c94595a18'
    )->grid_header ('Companies_grid_fields', \@field_list, 'swe');

    return 1;
}

ok(grid_header() == 1);
#ok(details_headers() == 1);
done_testing();

