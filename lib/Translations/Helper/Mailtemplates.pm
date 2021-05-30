package Translations::Helper::Mailtemplates;
use Mojo::Base 'Daje::Utils::Sentinelsender', -signatures, -async_await;

has 'pg';

async sub load_template($self, $template, $lan) {

    my $stmt = qq {
        SELECT header_value, body_value, footer_value FROM
            languages JOIN default_mail_templates
        ON languages_fkey = languages_pkey AND lan = ?
            JOIN mail_templates
        ON mail_templates_fkey = mail_templates_pkey AND mailtemplate = ?
    };

    $template = $self->pg->db->query(
        $stmt, ($lan, $template)
    );

    my $hash;
    $hash = $template->hash if $template and $template->rows()    ;
    return $hash;
}
1;