use Test::Pod;
use File::Find::Rule;
use Test::More qw(no_plan);

my @pm_files = File::Find::Rule->file()->name('*.pm')->in('lib');

foreach my $file (@pm_files) {
	pod_file_ok($file);
}
