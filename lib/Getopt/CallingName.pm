=head1 NAME

Getopt::CallingName - Script duties delegation based upon calling name

=head1 SYNOPSIS

 use Getopt::CallingName;  #exports the delegate symbol by default
 #exact interface to be decided

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
script delegate to call the appropriate script function for the mode.

The  exact features of  Getopt::CallingName still  have to  be decided. The most
basic feature  would   be to accept   a  hash of regex   =>  subrefs, evaluating
$PROGRAM_NAME against the regexs.  Failure could be handled either via a default
function, or perhaps a fatal error, or perhaps  throwing an Exception (Error.pm)
for the script to deal with. The delegate  method itself would return the return
value of    the subroutine that     it delegated  to.   Slightly  more  advanced
functionality could  include inspecting the stash for  a method corresponding to
the $PROGRAM_NAME (perhaps also allow  the script author  to specify a prefix so
that scripts tv_play  and tv_record could  be implemented by methods  play() and
record()).

=head1 PUBLIC INTERFACE

=cut



package Getopt::CallingName;



# pragmata
use base qw(Exporter);
use strict;
use warnings;

# Standard Perl Library and CPAN modules
use English;

# CORE modules


our @EXPORT = qw(delegate);
our $VERSION = 0.01;

#
# PUBLIC CLASS METHODS
#



=head2 Public Class Methods

=head3 delegate

 delegate(%args)

blah

=cut

sub delegate {
	my($class, %args) = @_;

	die("Not implemeted yet!!\n");

	my($self);

	$self = {};
	bless $self, $class;
	$self;
}


#
# PRIVATE CLASS METHODS
#



# =head1 INTERNALS

# =head2 Private Class Methods

# =head3 select

#  bar()

# blah

# =cut

# sub bar {
# 	my($self) = @_;

# 	$self;
# }

1;



=head1 AUTHOR

Sagar R. Shah

=cut
