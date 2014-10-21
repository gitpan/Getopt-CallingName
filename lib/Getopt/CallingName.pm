=head1 NAME

Getopt::CallingName - Script duties delegation based upon calling name

=head1 SYNOPSIS

 use Getopt::CallingName;
 call_name(
           prefix => 'tv_',
           args   => \@my_array,
           );

=head1 DESCRIPTION

Sometimes  you  can  have a script   that  can run   in two or  more  'modes' of
operation. Apart  from an option  to specify the mode,  the command line options
are the same/very similar. Much of the code used by the various modes is common.

As an application user interface  decision, it may  be more useful/helpful to be
able to call the script by two or more names - i.e. one for each mode. This cuts
out the command line option for specifying the mode.

In some cases it might be appropriate just to move all the code, or at least all
the common  code, into  a  module and have separate   wrapper perl scripts.  The
problem with this approach is either you end up  duplicating command line option
handling in each of  the wrapper scripts or you  end up moving the  command line
option handling  into a module  also.   The former  case introduces  maintenance
burden  [or perhaps an excuse  to  use TT2 to   generate your wrappers ;-)]. The
latter case can feel like a distortion/displacement of the code.

Getopt::CallingName provides another  alternative.  The idea  is that you create
symbolic links to  your actual script (which you   might want to give  a generic
name). Each symbolic link corresponds  to the name/mode with  which you call the
script.  Within your script, after  any  common setup/options handling you  call
subroutine call_name to call the appropriate script subroutine for the mode.

=head1 PUBLIC INTERFACE

=cut



package Getopt::CallingName;



# pragmata
use 5.006;
use base qw(Exporter);
use strict;
use warnings;

# Standard Perl Library and CPAN modules
use Carp qw(croak);
use English;


our @EXPORT = qw(call_name);
our $VERSION = '1.01';

#
# PUBLIC CLASS METHODS
#



=head2 Public Class Methods

=head3 call_name

 call_name(prefix => $prefix, args => $ra_args)

call_name accepts two optional arguments:

 prefix - string to chop off the script name. Useful if all your modes have a
          common prefix (tv_record, tv_play ...)

 args   - reference to an array which should be passed to the called sub.

call_name returns whatever the called subroutine returns.

call_name checks the subroutine it is going to call to ensure it exists. If it
does not exist, call name throws an 'exception' using Carp::croak.


=cut

sub call_name {
	my(%args) = @_;
	my $name = _get_name(%args);
	my @args = ($args{args}) ? @{$args{args}} : ();

	croak "Unable to call subroutine corresponding to name, &main::$name does not exist" unless(defined &{"main::$name"});
	
	{
		package main;
		no strict 'refs';
		return $name->(@args);
	}

	1;
}


#
# PRIVATE CLASS METHODS
#



=head1 INTERNALS

=head2 Private Class Methods

=head3 _get_name

 _get_name(prefix => $prefix)

Returns the $PROGRAM_NAME after     removing any path, prefix  (optional)    and
extension.

=cut

sub _get_name {
	my(%args) = @_;

	my($name) =  $PROGRAM_NAME =~ m!^(?:(?:.*)/)?([^.]*)!;
	$name =~ s/^$args{prefix}// if(defined $args{prefix});

	return $name;
}

1;

=head1 INSTALLATION

To install this module type the following:

   perl Makefile.PL
   make
   make test
   make install

=head1 DEPENDENCIES

This  module works only  with  perl v5.6 and higher.  I   am more than happy  to
backport to an earlier perl 5.x if someone using an old  perl would like to make
use of  my module. Mail  me  and ask me to  do  the work  [or  even better do it
yourself and send in a patch! ;-)]

This module requires these other modules and libraries:

 Carp
 Test::More

The first is required for its operation. The second is for testing purposes

This module has these optional dependencies:

 File::Find::Rule
 Test::Pod (0.95 or higher)

These are both just requried for testing purposes.

=head1 POSSIBLE ENHANCEMENTS

=over 4

=item *

use Test::Distribution (get it/get someone to get it to work nice with latest Test::Pod first)

=item *

Add a method_suffix feature (rename prefix to name_prefix?, also have method_prefix?)

=back

=head1 BUGS

None known at time  of writing.  To report a  bug or request an enhancement  use
CPAN's excellent Request Tracker:

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Getopt-CallingName>

=head1 AUTHOR

Sagar R. Shah

=head1 COPYRIGHT

Copyright 2003, Sagar R. Shah, All rights reserved

You can use this module under the same terms as Perl itself.

=cut
