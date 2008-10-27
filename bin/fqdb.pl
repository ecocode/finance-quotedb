use strict;
use warnings;
use Finance::QuoteDB;
use Finance::QuoteDB::Schema;
use Getopt::Long qw(:config);
use Config::IniFiles;
use Pod::Usage;
use Log::Log4perl qw(:easy);

=head1 NAME

fqdb - Manage quote databases

=head1 SYNOPSIS

fqdb [options] command

=head1 DESCRIPTION

This script is the command-line interface to the Finance::QuoteDB
module.

=head1 COMMANDS

createdb        Creates a new database
addstock        Add stocks to database
updatedb        Updates a database

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

# enable debug logging to a file
Log::Log4perl->easy_init( { level   => $DEBUG,
#                            file    => ">>fqdb.log"
                          });

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
  INFO ("Nothing to do: No command given\n");
};

=head1 COPYRIGHT & LICENSE

Copyright 2008 Erik Colson, all rights reserved.

This file is part of Finance::QuoteDB.

Finance::QuoteDB is free software: you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

Finance::QuoteDB is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with Finance::QuoteDB.  If not, see
<http://www.gnu.org/licenses/>.

=cut
