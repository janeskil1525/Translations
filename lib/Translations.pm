package Translations;
use Mojo::Base 'Mojolicious', -signatures;

use Mojo::Pg;

use File::Share;
use Mojo::File;
use Translations::Model::Menu;
use Translations::Model::Users;

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

  $self->renderer->paths([
      $self->dist_dir->child('templates'),
  ]);
  $self->static->paths([
      $self->dist_dir->child('public'),
  ]);

  # Configure the application
  $self->secrets($config->{secrets});


  $self->pg->migrations->name('translations')->from_file(
      $self->dist_dir->child('migrations/translations.sql')
  )->migrate(25);

  my $auth_route = $self->routes->under( '/app', sub {
    my ( $c ) = @_;

    return 1 if ($c->session('auth') // '') eq '1';
    $c->redirect_to('/');
    return undef;
  } );

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('login#showlogin');
  $r->post('/login')->to('login#login');
  $r->get('/details_headers')->to('translator#details_headers');
  $r->get('/grid_header')->to('translator#grid_header');
  $auth_route->get('/menu/show')->to('menu#showmenu');
  $auth_route->get('/users/list/')->to('users#list');


}

1;
