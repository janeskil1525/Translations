package Translations::Controller::Login;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use Data::Dumper;
use Data::GUID;

sub showlogin ($self) {

	$self->render(template => 'logon/logon');
}

sub login ($self) {

	if($self->authenticate->login_check($self->param('email'), $self->param('pass'), 'Basket')) {

		$self->session({ auth => 1 });
		return $self->redirect_to('/app/menu/show');
	}
	$self->flash('error' => 'Wrong login/password');
	$self->redirect_to($self->config->{webserver});

}

1;
