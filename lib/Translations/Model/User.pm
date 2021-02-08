package Translations::Model::User;
use Mojo::Base 'Daje::Utils::Sentinelsender', -signatures;

use Try::Tiny;
use Data::UUID;
use Data::Dumper;
use Digest::SHA qw{sha512_base64};

has 'pg';

sub save_user ($self, $user) {

    my $stmt;
    my $result;
    delete $user->{password} unless $user->{password};

    say Dumper($user);
    if (exists $user->{password}){
        $user->{passwd} = sha512_base64($user->{password});
        $stmt = qq{INSERT INTO users (username, userid, active, passwd, menu_group) VALUES (?,?,?,?,?)
                    ON CONFLICT (userid) DO UPDATE SET username = ?,
                    passwd = ?, moddatetime = now(), active = ?
                        RETURNING users_pkey};

        $result = try {
            $self->pg->db->query($stmt,(
                $user->{username},
                $user->{userid},
                $user->{active},
                $user->{passwd},
                $user->{menu_groupid},
                $user->{username},
                $user->{passwd},
                $user->{active}
            ));
        }catch{
            $self->capture_message("[Daje::Model::User::save_user with password] " . $_);
        };
    }else{
        $stmt = qq{UPDATE users SET username = ?,
                        moddatetime = now(), active = ? WHERE userid = ?
                    RETURNING users_pkey};

        $result = try{
            $self->pg->db->query($stmt,(
                $user->{username},
                $user->{active},
                $user->{userid},
            ));
        }catch{
            $self->capture_message("[Daje::Model::User::save_user with no password] " . $_);
        }
    }

    return $result;
}

sub save_user_p ($self, $user) {

    my $stmt;
    my $result;
    delete $user->{password} unless $user->{password};

    if (exists $user->{password}){
        $user->{passwd} = sha512_base64($user->{password});
        $stmt = qq{INSERT INTO users (username, userid, active, passwd, menu_group) VALUES (?,?,?,?,?)
                    ON CONFLICT (userid) DO UPDATE SET username = ?,
                    passwd = ?, moddatetime = now(), active = ?
                        RETURNING users_pkey};

        $result = $self->pg->db->query_p($stmt,(
            $user->{username},
            $user->{userid},
            $user->{active},
            $user->{passwd},
            $user->{menu_groupid},
            $user->{username},
            $user->{passwd},
            $user->{active}
        ));
    }else{
        $stmt = qq{
            INSERT INTO users (username, userid, active, menu_group) VALUES (?,?,?,?)
                ON CONFLICT (userid) DO UPDATE SET username = ?,
                    moddatetime = now(), active = ?
                RETURNING users_pkey
        };

        $result = $self->pg->db->query_p($stmt,(
            $user->{username},
            $user->{userid},
            $user->{active},
            $user->{menu_groupid},
            $user->{username},
            $user->{active}
        ));
    }
    say "before insert";

    return $result;
}

sub login ($self, $user, $password) {

    my $user_obj;
    $password = '' unless $password;

    my $passwd = sha512_base64($password);
    my $result = $self->pg->db->query("select * from users where userid = ? and passwd= ?",($user,$passwd));
    if($result->rows() > 0){
        $user_obj = $result->hash;
        my $ug = Data::UUID->new;
        my $token = $ug->create();
        $token = $ug->to_string($token);

        my $users_pkey = $user_obj->{users_pkey};

        $result = $self->pg->db->query(qq{INSERT INTO users_token (users_fkey, token) VALUES (?,?)
                                    ON CONFLICT (users_fkey) DO UPDATE SET token = ?,
                                        moddatetime = now()},
            ($users_pkey, $token, $token));
        $user_obj->{token} = $token;
    }else{
        $user_obj->{token} = '';
        $user_obj->{error} = 'Username or password is incorrect';
    }

    return $user_obj ;
}

# Just check if user and password matches with some user in the databas
#
# Return number of hits, more than 0 and user is matched
#
sub login_light ($self, $user, $password) { #scalar (userid, password)

    $password = '' unless $password;
    my $passwd = sha512_base64($password);
    my $result = $self->pg->db->query("select * from users where userid = ? and passwd= ?",($user,$passwd));
    return $result->rows() > 0;
}

1;