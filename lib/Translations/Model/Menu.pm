package Translations::Model::Menu;
use Mojo::Base 'Daje::Utils::Sentinelsender', -signatures;

has 'pg';

sub list ($self) {

	return $self->pg->db->select_p('menu',
		[
			'menu',
			'menu_path',
		],
		undef,
		{
			'order_by' => 'menu_order'
		}
	);
}
1;