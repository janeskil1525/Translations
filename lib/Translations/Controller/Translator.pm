package Translations::Controller::Translator;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use Try::Tiny;
use Mojo::JSON qw{from_json to_json};
use Data::Dumper;
use Daje::Utils::Sentinelsender;


sub details_headers ($self) {

    my $body = $self->req->body;
    my $json_hash = from_json ($body);
    say Dumper($json_hash);
    my $module = $json_hash->{module};
    my $field_list = $json_hash->{field_list};
    my $data = $json_hash->{data};
    my $lan = $json_hash->{lan};

    my $translation_list = $self->get_translation_list($module, $field_list, $lan);
    my $length = scalar @{$translation_list};

    my $details;
    if($length){
        foreach my $field (@{$field_list}){

            $details->{$field->{setting_value}}->{value} = $data->{$field->{setting_value}};
            $details->{$field->{setting_value}}->{order} = $field->{setting_order};
            $details->{$field->{setting_value}}->{properties} = '';
            if(exists $field->{setting_properties} and $field->{setting_properties}){
                $details->{$field->{setting_value}}->{properties} = try {
                    from_json $field->{setting_properties};
                }catch{
                    Daje::Utils::Sentinelsender->new()->capture_message(
                        'Translations','Translations::Controller::Translator::details_headers',
                            (ref $self), (caller(0))[3], $_
                    );
                    say $_;
                    return '';
                };
            }
            my ($matching_hash) = grep {
                $_->{tag} eq $field->{setting_value}
            } @{$translation_list}
                if $length;

            if(ref($matching_hash) eq 'HASH' and exists $matching_hash->{tag}){
                $details->{$field->{setting_value}}->{label} = $matching_hash->{translation};
            }else{
                $details->{$field->{setting_value}}->{label} = $field->{setting_value};
            }
        }
    }

    #my $result = to_json($details);
    $self->render(json => {result => $details});
}

sub grid_header ($self) {

    my $json_hash = from_json ($self->req->body);
    my $module = $json_hash->{module};
    my $field_list = $json_hash->{field_list};
    my $lan = $json_hash->{lan};

    my $translation_list = $self->get_translation_list($module, $field_list, $lan);
    my $length = scalar @{$translation_list};

    my @header_list;
    foreach my $field (@{$field_list}){
        my $header;
        #my $matching_hash;
        $header->{order} = $field->{setting_order};
        $header->{field} = $field->{setting_value};
        $header->{properties} = '';
        if($field->{setting_properties}){
            $header->{properties} = try {
                from_json $field->{setting_properties};
            }catch{
                Daje::Utils::Sentinelsender->new()->capture_message(
                    'Translations','Translations::Controller::Translator::grid_header',
                        (ref $self), (caller(0))[3], $_
                );
                say $_;
                return '';
            };
        }

        my ($matching_hash) = grep {
            $_->{tag} eq $field->{setting_value}
        } @{$translation_list}
            if $length;

        if(ref($matching_hash) eq 'HASH' and exists $matching_hash->{tag}){
            $header->{headerName} = $matching_hash->{translation};
        }else{
            $header->{headerName} = $field->{setting_value};
        }
        push @header_list, $header;
    }

    #my $result = to_json(\@header_list);
    $self->render(json => {result => \@header_list});
}

sub get_translation_list ($self, $module, $field_list, $lan) {

    my $stmt = $self->get_query($module, $field_list, $lan);
say $stmt;
    my $translation_list = try{
        $self->app->pg->db->query($stmt)->hashes->to_array
    }catch{
        Daje::Utils::Sentinelsender->new()->capture_message(
            'Translations','Translations::Controller::Translator::get_translation_list',
                (ref $self), (caller(0))[3], $_
        );
        say $_;
    };

    return $translation_list;
}

sub get_query ($self, $module, $field_list, $lan) {

    my $incondition ;

    say "get_query " . Dumper($field_list);
    foreach (@{$field_list}){
        $incondition .= " '$_->{setting_value}',";
    }

    $incondition = substr ($incondition,0,-1);
    my $stmt = qq{
		SELECT tag, translation
			FROM languages JOIN translations
		ON 	languages_pkey = languages_fkey AND lan = '$lan'
			WHERE module = '$module'
		AND tag IN($incondition)
	};

    return $stmt;
}

1;
