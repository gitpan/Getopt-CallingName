use strict;
use warnings;

my @pm_files;

BEGIN {
	use File::Find::Rule;
	@pm_files = File::Find::Rule->file()->name('*.pm')->in('lib');
}

use Test::Pod tests => scalar @pm_files;

foreach my $file (@pm_files) {
	pod_file_ok($file);
}
