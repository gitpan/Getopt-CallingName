use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new(
		   license             => 'perl',
		   module_name         => 'Getopt::CallingName',
		   requires            => {
				   'Test::More' => 0,
				  },
		   create_readme       => 1,
		   sign                => 1,
		   create_makefile_pl  => 'passthrough',
       add_to_cleanup      => [ 'Getopt-CallingName-*' ],
		  )->create_build_script;
