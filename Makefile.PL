use ExtUtils::MakeMaker;
my $module = 'LexAlias.pm';
WriteMakefile(
              'NAME'         => 'Devel::LexAlias',
              'VERSION_FROM' => $module,
              'PREREQ_PM'    => { 'Test::More' => 0,
                                  'Devel::Caller' => 0.03 },
             );

sub MY::postamble {
    return <<EOF
README: $module
\tpod2text $module > README
EOF
}
