use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $post_data->{template} = 'matoritstatistics';
$post_data->{lan} = 'swe';

my $t = Test::Mojo->new('Translations');
$t->post_ok('http://127.0.0.1:3022/api/v1/templates/mail/' =>
    {'X-Token-Check' => '58e51981-4c5d-46cd-8703-b02c94595a18'} =>
    json => $post_data
)->status_is(200)->content_like(qr/Mojolicious/i);

done_testing();

