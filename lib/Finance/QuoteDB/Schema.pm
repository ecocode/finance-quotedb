package Finance::QuoteDB::Schema;
use base qw/DBIx::Class::Schema/;

use strict;
use warnings;

__PACKAGE__->load_classes(qw/ Symbols Quotes /);

1;
