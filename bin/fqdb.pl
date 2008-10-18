use strict;
use warnings;
use Finance::QuoteDB::Schema;

my $dsn = 'dbi:SQLite:example.db';
my $mySchema = Finance::QuoteDB::Schema->connect_and_deploy($dsn);
