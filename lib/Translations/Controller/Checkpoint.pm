package Translations::Controller::Checkpoint;
use Mojo::Base 'Mojolicious::Controller', -signatures;


sub ping {
    my $self = shift;

    my $result = 'Failed';

    if($self->req->headers->header('X-Token-Check') eq $self->config->{sentinel}->{key}){
        $result = 'Success';
    }

    $self->render(json => {result => $result});;
}

1;