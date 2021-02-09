package Translations::Helper::Client;
use Mojo::Base 'Daje::Utils::Sentinelsender', -signatures;

use Mojo::UserAgent;
use Mojo::JSON qw {to_json decode_json};
use Data::Dumper;

has 'endpoint_address';
has 'key';

sub details_headers ($self, $module, $field_list, $data, $lan) {

    my $ua = Mojo::UserAgent->new();
    my $post_data;
    $post_data->{module} = $module;
    $post_data->{field_list} = $field_list;
    $post_data->{data} = $data;
    $post_data->{lan} = $lan;

    my $res = $ua->post(
        $self->endpoint_address() . '/details_headers' =>
            {'X-Token-Check' => $self->key()} =>
        json => $post_data
    )->result;

    my $body;
    if($res->is_error){
        $self->capture_message(
            'Translations', 'Translations::Helper::Client::details_headers', 'Translations::Helper::Client',
            (caller(0))[3], $res->message
        );
        say $res->message;
    } else {
        $body = $res->body;
    }

    my $result = decode_json($body);
    return $result->{result};
}

sub grid_header ($self, $module, $field_list, $lan) {

    my $ua = Mojo::UserAgent->new();
    my $post_data;
    $post_data->{module} = $module;
    $post_data->{field_list} = $field_list;
    $post_data->{lan} = $lan;

    my $res = $ua->post(
        $self->endpoint_address() . '/grid_header' =>
            {'X-Token-Check' => $self->key()} =>
            json => $post_data
    )->result;

    my $body;
    if($res->is_error){
        $self->capture_message(
            'Translations', 'Translations::Helper::Client::grid_header', 'Translations::Helper::Client',
            (caller(0))[3], $res->message
        );
        say $res->message;
    } else {
        $body = $res->body;
    }
    my $result = decode_json($body);
    return $result->{result};
}

sub get_translation_list ($self, $module, $field_list, $lan) {

    my $ua = Mojo::UserAgent->new();
    my $post_data;
    $post_data->{module} = $module;
    $post_data->{field_list} = $field_list;
    $post_data->{lan} = $lan;

    my $json = encode_json($post_data);
    my $res = $ua->post(
        $self->endpoint_address() . '/get_translation_list' =>
            {'X-Token-Check' => $self->key()} =>
            json => $json
    )->result;

    if($res->is_error){
        $self->capture_message(
            'Translations', 'Translations::Helper::Client::grid_header', 'Translations::Helper::Client',
            (caller(0))[3], $res->message
        );
        say $res->message;
    }
}
1;


__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::Translations - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('Translations');

  # Mojolicious::Lite
  plugin 'Translations';

=head1 DESCRIPTION

L<Mojolicious::Plugin::Translations> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::Translations> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicious.org>.

=cut


1;