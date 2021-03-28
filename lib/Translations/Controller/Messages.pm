package Translations::Controller::Messages;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use Try::Tiny;
use Mojo::JSON qw{from_json to_json decode_json};
use Data::Dumper;
use Daje::Utils::Sentinelsender;

sub get_messages ($self) {

    if($self->req->headers->header('X-Token-Check') eq $self->config->{key}){

        my $body = $self->req->body;
        my $json_hash = decode_json ($body);
        my $module = $json_hash->{module};
        my $lan = $json_hash->{lan};

        my $result = $self->get_messages_list($module, $lan);
        $self->render(json => {result => $result});
    } else {
        $self->render(json => {result => 'Something went wrong'});
    }
}

sub get_messages_list ($self, $module, $lan) {

    my $stmt = $self->get_query($module, $lan);
    my $messages_list = try{
        $self->app->pg->db->query($stmt)->hashes->to_array
    }catch{
        Daje::Utils::Sentinelsender->new()->capture_message(
            'Translations','Translations::Controller::Messages::get_messages_list',
            (ref $self), (caller(0))[3], $_
        );
        say $_;
    };

    return $messages_list;
}

sub get_query ($self, $module, $lan) {

    my $stmt = qq{
		SELECT tag, translation
			FROM languages JOIN translations
		ON 	languages_pkey = languages_fkey AND lan = '$lan'
			WHERE module = '$module'
	};

    return $stmt;
}
1;