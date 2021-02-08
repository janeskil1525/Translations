package Translations::Model::Users;
use Mojo::Base 'Daje::Utils::Sentinelsender', -signatures;

use Translations::Model::User;

has 'pg';

sub login ($self, $user, $password) {

	return Translations::Model::User->new(pg => $self->pg)->login_light($user, $password);
}

sub save ($self, $user) {

	return $self->pg->db->query(qq{
		INSERT INTO users(
			userid, username, passwd)
			VALUES (?, ?, ?)
				ON CONFLICT (userid)
			DO UPDATE
				SET moddatetime = now(),
				editnum = users.editnum + 1,
				username = ?,
				passwd = ?;
	},(
		$user->{userid}, $user->{username}, $user->{passwd}, $user->{username}, $user->{passwd}
	)
	);
}

sub list_p ($self) {

	return $self->pg->db->select_p('users');
}


1;