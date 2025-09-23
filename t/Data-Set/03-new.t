use strict;
use warnings;

use Data::Set;
use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $obj = Data::Set->new;
isa_ok($obj, 'Data::Set');

# Test.
eval {
	Data::Set->new(
		'output_struct' => 'bad',
	);
};
is($EVAL_ERROR, "Parameter 'output_struct' isn't hash reference.\n",
	"Parameter 'output_struct' isn't hash reference (bad).");
clean();
