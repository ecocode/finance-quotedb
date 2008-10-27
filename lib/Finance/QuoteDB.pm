package Finance::QuoteDB;

use warnings;
use strict;

use Exporter ();
use vars qw/@EXPORT @EXPORT_OK @EXPORT_TAGS $VERSION/;
use Finance::Quote;
use Log::Log4perl qw(:easy);

=head1 NAME

Finance::QuoteDB - User database tools based on Finance::Quote

=head1 VERSION

Version 0.01 pre-alpha

=cut

@EXPORT = ();
@EXPORT_OK = qw /createdb updatedb addstock/ ;
@EXPORT_TAGS = ( all => [@EXPORT_OK] );
$VERSION = '0.01';

=head1 SYNOPSIS

Please take a look at bin/fqdb.pl which is the command-line frontend
to Finance::QuoteDB.

=head1 METHODS

=head2 createdb

=cut

sub createdb {
  my ($self,$dsn) = @_ ;

  INFO ("COMMAND: Create database $dsn\n");
  my $schema = Finance::QuoteDB::Schema->connect_and_deploy($dsn); # creates the database
  return $schema;
}

=head2 updatedb

=cut

sub updatedb {
  my ($self,$dsn) = @_ ;

  INFO ("COMMAND: Update database $dsn\n");
  if (my $schema = Finance::QuoteDB::Schema->connect($dsn)) {
    INFO ("Connected to database $dsn\n");
    my $stocks_rs = $schema -> resultset('Symbol')->
      search(undef, { order_by => "fqmarket,symbolID",
                      columns => [qw / fqmarket symbolID /] });
    while (my $symbol = $stocks_rs->next ) {
      my $fqmarket = $symbol->fqmarket() ;
      my $symbolID = $symbol->symbolID() ;
      INFO ("SCANNING : $fqmarket - $symbolID\n");
    }
  } else {
    INFO ("ERROR: Could not connect to $dsn\n");
  }
}

=head2 addstock

=cut

sub addstock {
  my ($self,$dsn,$market,$stocks) = @_ ;
  if ($market) {
    INFO ("Getting stocks from $market\n") ;
    if (my @stocks = split(",",$stocks)) {
      my $q = Finance::Quote->new();
      my %quotes = $q->fetch($market,@stocks);
      foreach my $stock (@stocks) {
        INFO ("Checking stock $stock\n");
        INFO (" --> $quotes{$stock,'name'}\n") ;
        if (my $schema = Finance::QuoteDB::Schema->connect($dsn)) {
          INFO ("Connected to database $dsn\n");
          $schema->populate('Symbol',
                            [[qw /symbolID name fqmarket isin failover/],
                            [$stock, $quotes{$stock,'name'}, $market, '', 0 ]]);
        } else {
          INFO ("ERROR: Could not connect to $dsn\n");
        }
      }
    } else {
      INFO ("No stocks specified\n") ;
    }
  } else {
    INFO ("No market specified\n") ;
  }
}

=head1 AUTHOR

Erik Colson, C<< <eco at ecocode.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-finance-quotedb at rt.cpan.org>,
or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Finance-QuoteDB>.  I
will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Finance::QuoteDB


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Finance-QuoteDB>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Finance-QuoteDB>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Finance-QuoteDB>

=item * Search CPAN

L<http://search.cpan.org/dist/Finance-QuoteDB>

=back


=head1 ACKNOWLEDGEMENTS


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

1; # End of Finance::QuoteDB
