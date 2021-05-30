package Translations::Controller::Mailtemplates;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use Mojo::JSON qw{from_json};

sub load_template ($self) {

    $self->render_later;

    my $json_hash = from_json ($self->req->body);

    $self->mailtemplates->load_template(
        $json_hash->{template}, $json_hash->{lan}
    )->then(sub ($result) {
        $self->render(json => {template => $result, result => 'Success'});
    })->catch(sub ($err) {
        $self->render(json => {result => $err});
    })->wait;
}
1;