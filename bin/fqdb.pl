use strict;
use warnings;
use Finance::QuoteDB;
use Finance::QuoteDB::Schema;
use Getopt::Long qw(:config);
use Config::IniFiles;
use Pod::Usage;

=head1 NAME

fqdb - Manage quote databases

=head1 SYNOPSIS

fqdb [options] command

=head1 DESCRIPTION

This script is the command-line interface to the Finance::QuoteDB
module.

=head1 COMMANDS

createdb        Creates a new database
updatedb        Updates a database
addstock        Add stocks to database

=head1 OPTIONS

  -h --help     Shows help
  --dsn         Which database to use. Defaults to 'dbi:SQLite:fqdb.db'
  --market      Market from which stocks should be treated
  --stocks      Stock list (comma separated)

=head1 EXAMPLES

=head2 fqdb createdb --dsn='dbi:SQLite:quotes.db'

Creates a new database in the current directory called quotes.db of
type SQLite.

=head2 fqdb updatedb --dsn='dbi:SQLite:quotes.db'

Updates the database quotes.db with new quotes if available.

=cut

my $dsn = 'dbi:SQLite:fqdb.db';
my $market = '';
my $stocks = '';

GetOptions(
  'dsn=s'    => \$dsn,
  'market=s' => \$market,
  'stocks=s' => \$stocks,
  'h|help'   => sub { pod2usage(1); }
) or pod2usage(2);

my $command = shift(@ARGV)||'';

SWITCH: {
  ($command eq 'createdb') && do { Finance::QuoteDB->createdb($dsn);
                                   last SWITCH;};
  ($command eq 'addstock') && do { Finance::QuoteDB->addstock($dsn,$market,$stocks);
                                   last SWITCH;};
  ($command eq 'updatedb') && do { Finance::QuoteDB->updatedb($dsn);
                                   last SWITCH;};
  print "Nothing to do: No command given\n";
};
