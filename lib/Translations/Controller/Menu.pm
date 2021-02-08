package Translations::Controller::Menu;
use Mojo::Base 'Mojolicious::Controller', -signatures;


sub showmenu ($self) {

	$self->render_later;
	$self->menu->list()->then(sub {
		my $result = shift;

		my $collection = $result->hashes;
		$self->render(
			template => 'menu/menu',
			menu => $collection
		);

	})->catch(sub {
		my $err = shift;

		say $err;
	})->wait;

}
1;