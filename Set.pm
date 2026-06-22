package Data::Set;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Error::Pure qw(err);
use Mo::utils::Hash qw(check_hash);
use Mo::utils::Language qw(check_language_639_2);
use Scalar::Util qw(blessed);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Language.
	$self->{'lang'} = 'eng';

	# Output structure.
	$self->{'output_struct'} = {};

	# Texts.
	$self->{'texts'} = {};

	# Process parameters.
	set_params($self, @params);

	# Check 'lang'.
	check_language_639_2($self, 'lang');

	# Check 'output_struct'.
	check_hash($self, 'output_struct');

	# Check 'texts'.
	check_hash($self, 'texts');

	return $self;
}

sub data {
	my $self = shift;

	err "Need to be implemented.";
}

sub add_object_to_output_array {
	my ($self, $key, $object) = @_;

	if (exists $self->{'output_struct'}->{$key}) {
		if (ref $self->{'output_struct'}->{$key} ne 'ARRAY') {
			err "Bad output structure defined in constructor.";
		}
	} else {
		$self->{'output_struct'}->{$key} = [];
	}

	if (blessed($object)) {
		push @{$self->{'output_struct'}->{$key}}, $object;
	} elsif (ref $object eq 'ARRAY') {
		push @{$self->{'output_struct'}->{$key}}, @{$object};
	} else {
		err 'Bad object.';
	}

	return;
}

1;

__END__

=encoding utf8

=head1 NAME

Data::Set - Data set abstract class.

=head1 SYNOPSIS

 use Data::Set;

 my $obj = Data::Set->new(%params);
 my $data_hr = $obj->data;
 $obj->add_object_to_output_array($key, $object);

=head1 DESCRIPTION

Abstract class for dataset implementations with common constructor checks and
helpers for output structure manipulation.

=head1 METHODS

=head2 C<new>

 my $obj = Data::Set->new(%params);

Constructor.

Returns C<Data::Set> instance.

Supported parameters:

=over

=item * C<lang>

Language in ISO 639-2 format. Default value is C<eng>.

=item * C<output_struct>

Hash reference with output data structure. Default value is empty hash
reference.

=item * C<texts>

Hash reference with texts. Default value is empty hash reference.

=back

=head2 C<data>

 my $data_hr = $obj->data;

Abstract method for fetching dataset data. Return value is
C<$self->{'output_struct'}> structure.

Returns reference to hash.

=head2 C<add_object_to_output_array>

 $obj->add_object_to_output_array($key, $object);

Add object or objects under C<$key> in the output structure array.

Parameter C<$object> must be blessed instance or reference to array with
instances.

Returns undef.

=head1 ERRORS

 new():
         From Class::Utils::set_params():
                 Unknown parameter '%s'.
         From Mo::utils::Language::check_language_639_2():
                 Parameter 'lang' doesn't contain valid ISO 639-2 code.
         From Mo::utils::Hash::check_hash():
                 Parameter 'output_struct' isn't hash reference.
                 Parameter 'texts' isn't hash reference.

 data():
         Need to be implemented.

 add_object_to_output_array():
         Bad output structure defined in constructor.
         Bad object.

=head1 EXAMPLES

=head2 EXAMPLE

=for comment filename=example_app_dataset.pl

 use strict;
 use warnings;

 package Foo;

 use parent 'Data::Set';

 use Data::Const::HashType;

 sub data {
         my $self = shift;

         my $hash_type = Data::Const::HashType->new->data;

         # Add hash type to output structure.
         $self->add_object_to_output_array('hash_types', $hash_type);

         # Explicit value.
         $self->{'output_struct'}->{'foo'} = 'Example';

         return $self->{'output_struct'};
 }

 package main;

 use Data::Printer;

 # Object.
 my $obj = Foo->new;

 # Get data.
 my $data_hr = $obj->data;

 # Dump out.
 p $data_hr;

 # Output like:
 # {
 #     foo          "Example",
 #     hash_types   [
 #         [0] Data::HashType  {
 #                 parents: Mo::Object
 #                 public methods (6):
 #                     BUILD
 #                     Error::Pure:
 #                         err
 #                     Mo::utils:
 #                         check_isa, check_length, check_required
 #                     Mo::utils::Number:
 #                         check_positive_natural
 #                 private methods (0)
 #                 internals: {
 #                     id           1,
 #                     name         "SHA-512",
 #                     valid_from   \d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d (DateTime)
 #                 }
 #             }
 #     ]
 # }

=head1 DEPENDENCIES

L<Class::Utils>,
L<Error::Pure>,
L<Mo::utils::Hash>,
L<Mo::utils::Language>,
L<Scalar::Util>.

=head1 SEE ALSO

=over

=item L<Data::Const>

Abstract class for constant data objects.

=back

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Data-Set>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2025 Michal Josef Špaček

BSD 2-Clause License

=head1 VERSION

0.01

=cut
