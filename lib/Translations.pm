package Translations;
use Mojo::Base 'Mojolicious', -signatures;

use Mojo::Pg;

use File::Share;
use Mojo::File;
use Translations::Model::Menu;
use Translations::Model::Users;
use Translations::Helper::Mailtemplates;

use Authenticate::Helper::Client;
use Mojo::JSON qw {from_json};


$ENV{TRANSLATIONS_HOME} = '/home/jan/Project/Translations/'
    unless $ENV{TRANSLATIONS_HOME};

has dist_dir => sub {
  return Mojo::File->new(
      File::Share::dist_dir('Translations')
  );
};

has home => sub {
  Mojo::Home->new($ENV{TRANSLATIONS_HOME});
};

# This method will run once at server start
sub startup ($self) {

    # Load configuration from config file
    my $config = $self->plugin('Config');

    $self->helper(pg => sub {state $pg = Mojo::Pg->new->dsn(shift->config('pg'))});
    $self->log->path($self->home() . $self->config('log'));

    $self->pg->migrations->name('translations')->from_file(
        $self->dist_dir->child('migrations/translations.sql')
    )->migrate(33);

    $self->renderer->paths([
      $self->dist_dir->child('templates'),
    ]);
    $self->static->paths([
      $self->dist_dir->child('public'),
    ]);

    $self->helper(menu => sub { state $menu = Translations::Model::Menu->new(pg => shift->pg)});
    $self->helper(users => sub { state $users = Translations::Model::Users->new(pg => shift->pg)});
    $self->helper(authenticate => sub {
        state $authenticate = Authenticate::Helper::Client->new(pg => shift->pg)}
    );
    $self->authenticate->endpoint_address($self->config->{authenticate}->{endpoint_address});
    $self->authenticate->key($self->config->{authenticate}->{key});

    $self->helper(mailtemplates => sub {
        state $mailtemplates = Translations::Helper::Mailtemplates->new(pg => shift->pg)}
    );

    # Configure the application
    $self->secrets($config->{secrets});

    my $schema = from_json(Mojo::File->new(
        $self->dist_dir->child('schema/translations.json')
    )->slurp) ;

    my $api_route = $self->routes->under('/api' => sub {
        my $c = shift;
        #say "authentichate " . $c->req->headers->header('X-Token-Check');
        # Authenticated
        return 1 if $c->req->headers->header('X-Token-Check') eq $c->config->{key} ;
        return 1 if $c->authenticate->authenticate(
            $c->req->headers->header('X-User-Check'), $c->req->headers->header('X-Token-Check')
        );
        # Not authenticated
        $c->render(json => '{"error":"unknown error"}');
        return undef;
    });

    my $auth_yancy = $self->routes->under( '/yancy', sub {
        my ( $c ) = @_;

        return 1 if ($c->session('auth') // '') eq '1';
        $c->redirect_to('/');
        return undef;
    } );

    my $auth_route = $self->routes->under( '/app', sub {
    my ( $c ) = @_;

        return 1 if ($c->session('auth') // '') eq '1';
        $c->redirect_to('/');
        return undef;
    } );

    # $self->plugin(
    #     'Yancy' => {
    #         route       => $auth_yancy,
    #         backend     => {Pg => $self->pg},
    #         schema      => $schema,
    #         read_schema => 0,
    #         'editor.return_to'   => '/app/menu/show/',
    #         'editor.require_user' => undef,
    #         file => {
    #
    #         }
    #     }
    # );
    # Router
    my $r = $self->routes;


    # Normal route to controller
    $r->get('/')->to('login#showlogin');
    $r->post('/login')->to('login#login');
    $r->post('/details_headers')->to('translator#details_headers');
    $r->post('/grid_header')->to('translator#grid_header');
    $r->post('/get_messages')->to('messages#get_messages');
    $r->get('/checkpoint/ping/')->to('checkpoint#ping');

    $api_route->post('/v1/templates/mail/')->to('mailtemplates#load_template');

    $auth_route->get('/menu/show')->to('menu#showmenu');
    $auth_route->get('/users/list/')->to('users#list');
    $auth_route->get('/menu/show')->to('menu#showmenu');

}

1;
