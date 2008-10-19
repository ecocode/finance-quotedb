use strict;
use warnings;
use Finance::QuoteDB::Schema;
use Getopt::Long qw(:config);
use Config::IniFiles;
use Pod::Usage;

=head1 NAME

fqdb - Manage quote databases

=head1 SYNOPSIS

fqdb [options] command [command_arguments]

=head1 DESCRIPTION

This script is the command-line interface to the Finance::QuoteDB
module.

=head1 COMMANDS

createdb        Creates a new database
updatedb        Updates a database

=head1 OPTIONS

  -h --help     Shows help
  --dsn         Which database to use. Defaults to 'dbi:SQLite:fqdb.db'

=head1 EXAMPLES

=head2 fqdb createdb --dsn='dbi:SQLite:quotes.db'

Creates a new database in the current directory called quotes.db of
type SQLite.

=head2 fqdb updatedb --dsn='dbi:SQLite:quotes.db'

Updates the database quotes.db with new quotes if available.

=cut

my $dsn = 'dbi:SQLite:fqdb.db';

GetOptions(
  'dsn=s'    => \$dsn,
  'h|help'   => sub { pod2usage(1); }
) or pod2usage(2);

my $command = shift(@ARGV)||'';

SWITCH: {
  ($command eq 'createdb') && do { createdb($dsn);
                                   last SWITCH;};
  ($command eq 'updatedb') && do { updatedb($dsn);
                                   last SWITCH;};
  print "Nothing to do: No command given\n";
};

sub createdb {
  my $dsn = shift;
  print "COMMAND: Create database $dsn\n";
  my $schema = Finance::QuoteDB::Schema->connect_and_deploy($dsn); # creates the database
  return $schema;
}

sub updatedb {
  my $dsn = shift;
  print "COMMAND: Update database $dsn\n";
  if (my $schema = Finance::QuoteDB::Schema->connect($dsn)) {
    print "Connected to database $dsn\n";
  } else {
    print "ERROR: Could not connect to $dsn\n";
  }
}
