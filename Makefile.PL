use strict;
use warnings;

use ExtUtils::MakeMaker;
use File::ShareDir::Install qw{install_share};

install_share  'share';

WriteMakefile(
	VERSION       => '1.0.2',
	NAME          => 'Translations',
	PREREQ_PM     => {
		'Mojolicious'                                 => '8.35',
	},
	test          => { TESTS => 't/*.t' },
	AUTHOR        => 'Jan Eskilsson <janeskil1525@cpan.org>',
	EXE_FILES     => [ qw{
		script/translations
	} ],

);

package MY;
use File::ShareDir::Install qw(postamble);
