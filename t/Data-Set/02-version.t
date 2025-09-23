use strict;
use warnings;

use Data::Set;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Data::Set::VERSION, 0.01, 'Version.');
