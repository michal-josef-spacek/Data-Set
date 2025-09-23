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
