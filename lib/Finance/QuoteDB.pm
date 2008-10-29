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

Version 0.00_51 pre-alpha

=cut

@EXPORT = ();
@EXPORT_OK = qw /createdb updatedb addstock/ ;
@EXPORT_TAGS = ( all => [@EXPORT_OK] );
$VERSION = '0.00_51';

=head1 SYNOPSIS

Please take a look at script/fqdb which is the command-line frontend
to Finance::QuoteDB.

=head1 METHODS

=head2 new

new({dsn=>$dsn})

=cut

sub new {
  my $self = shift;
  my $class = ref($self) || $self;

  my $this = {};
  bless $this, $class;

  my $config = shift ;

  foreach (keys %$config) {
    $this->{$_} = $$config{$_};
  }
  if (my $dsn = $this->{dsn}) {
    INFO ("CREATED FQDB object based on $dsn\n");
  } else {
    ERROR ("No dsn specified\n") ;
    die;
  }

  return $this;
}

=head2 createdb

createdb()

=cut

sub createdb {
  my $self = shift;

  my $dsn = $self->{dsn};

  INFO ("COMMAND: Create database $dsn\n");
  my $schema = Finance::QuoteDB::Schema->connect_and_deploy($dsn); # creates the database
  return $schema;
}

=head2 updatedb

updatedb()

=cut

sub updatedb {
  my $self = shift ;

  my $dsn = $self->{dsn};

  INFO ("COMMAND: Update database $dsn\n");
  my $schema = $self->schema();
  my @stocks = $schema -> resultset('Symbol')->
    search(undef, { order_by => "fqmarket,symbolID",
                    columns => [qw / fqmarket symbolID /] });
  my %stocks ;
  foreach my $stock (@stocks) {
    my $fqmarket = $stock->fqmarket() ;
    my $symbolID = $stock->symbolID() ;
    if (!$stocks{$fqmarket}) {
      $stocks{$fqmarket} = () ;
    };
    push @{$stocks{$fqmarket}}, $symbolID ;
    INFO ("SCANNING : $fqmarket - $symbolID\n");
  };
  foreach my $market (keys %stocks) {
    DEBUG "$market -->" .join(",",@{$stocks{$market}})."\n" ;
    $self->updatedbMarketStock($market,\@{$stocks{$market}}) ;
  }
}

=head2 updatedbMarketStock

updatedbMarketStock($market,\@stocks)

=cut

sub updatedbMarketStock {
  my ($self,$market,$stockArray) = @_ ;
  my $schema = $self->schema();
  DEBUG "UPDATEDBMARKETSTOCK: $market -->" .join(",",@$stockArray)."\n" ;
  my $q = Finance::Quote->new();
  my %quotes = $q->fetch($market,@$stockArray);
  foreach my $stock (@$stockArray) {
    if ($quotes{$stock,"success"}) { # This quote was retrieved
      INFO ("Updating stock $stock --> $quotes{$stock,'last'}\n");
      my $quoters = $schema->resultset('Quote')->update_or_create(
        { symbolID => $stock,
          date => $quotes{$stock,'date'},
          previous_close => $quotes{$stock,'close'},
          day_open => $quotes{$stock,'open'},
          day_high => $quotes{$stock,'high'},
          day_low => $quotes{$stock,'low'},
          day_close => $quotes{$stock,'last'},
          bid => $quotes{$stock,'bid'},
          ask => $quotes{$stock,'ask'},
          volume => $quotes{$stock,'volume'}
        });
    } else {
      INFO ("Could not retrieve $stock\n");
    }
  }
};

=head2 delstock

delstock($stocks)

=cut

sub delstock {
  my ($self,$stocks) = @_ ;

  if (my @stocks = split(",",$stocks)) {
    my $schema = $self->schema();
    foreach my $stock (@stocks) {
      INFO ("Deleting stock $stock\n");
      my $rs = $schema -> resultset('Symbol')->
        search({'symbolID' => $stock});
      $rs->delete_all();
    }
  } else {
    INFO ("No stocks specified\n") ;
  }
};

=head2 addstock

addstock($market,$stocks)

=cut

sub addstock {
  my ($self,$market,$stocks) = @_ ;

  my $dsn = $self->{dsn};

  if (!$market) {
    INFO ("No market specified\n") ;
    return
  } else {
    INFO ("Getting stocks from $market\n") ;
  }
  if (my @stocks = split(",",$stocks)) {
    my $q = Finance::Quote->new();
    my %quotes = $q->fetch($market,@stocks);
    foreach my $stock (@stocks) {
      INFO ("Checking stock $stock\n");
      if ($quotes{$stock,"success"}) { # This quote was retrieved
        INFO (" --> $quotes{$stock,'name'}\n") ;
        my $schema = $self->schema();
        $schema->populate('Symbol',
                          [[qw /symbolID name fqmarket isin failover currency/],
                           [$stock, $quotes{$stock,'name'}, $market, '', 0, $quotes{$stock,'currency'} ]]);
      } else {
        INFO ("Could not retrieve $stock\n");
      }
    }
  } else {
    INFO ("No stocks specified\n") ;
  }
};

=head2 schema

schema()

If necessary, creates a DBIx::Class::Schema and returns a reference to that DBIx::Class::Schema.

=cut

sub schema {
  my $self = shift ;
  my $dsn = $self->{dsn};
  if (!$self->{schema}) {
    if (my $schema = Finance::QuoteDB::Schema->connect($dsn)) {
      INFO ("Connected to database $dsn\n");
      $self->{schema} = $schema ;
    } else {
      ERROR ("Could not connect to database $dsn\n") ;
      die ;
    }
  }
  return $self->{schema}
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
