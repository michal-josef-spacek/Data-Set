#!/usr/bin/env perl

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