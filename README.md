# NAME

Finance::QuoteDB - User database tools based on Finance::Quote

# SYNOPSIS

Please take a look at script/fqdb which is the command-line frontend
to Finance::QuoteDB. Type following command at your command prompt for
more information:

    fqdb --help

# METHODS

## new

new({dsn=>$dsn})

## createdb

createdb()

## updatedb

updatedb()

## updatedbMarketStock

updatedbMarketStock($market,\\%symbolIDs)

## backpopulate

backpopulate($start\_date, $end\_date, $overwrite, $stocks)

## delstock

delstock($stocks)

## addstock

addstock($market,$stocks)

$stocks is in the format FQsymbol\[USERsymbol\],...
If USERsymbol is ommitted then USERsymbol will be set to FQsymbol

## getquotes

getquotes( $USERsymbols, $date\_start \[,$date\_end\] )

This function returns quotes between $date\_start and $date\_end for the specified
user symbols (comma separated list).  Range will be one day if $date\_end is
omitted.

## dumpquotes

dumpquotes ( $USERsymbols, $date\_start \[,$date\_end\] )

This function dumps quotes between $date\_start and $date\_end for the specified
user symbols (comma separated list).  Range will be one day if $date\_end is
omitted.

## dumpstocks

dumpstocks ()

This function dumps the symbols of the stocks in the database.

## add\_yahoo\_stocks

add\_yahoo\_stocks( $exchanges , \[ $refsearchlist \] )

retrieves yahoo tickers for specified exchanges and stores them in your database
NOTE: $exchanges being the ID as coming from yahoo.
      NYQ for Nyse, PAR for Paris
$refsearchlist is an optional reference to a list of search patterns. defaults to \[\*\*AA .. \*\*ZZ\]

## schema

schema()

If necessary, creates a DBIx::Class::Schema and returns a reference to that DBIx::Class::Schema.

## today

today()

returns current date in isodate format

# AUTHOR

Erik Colson, `<eco at ecocode.net>`

# BUGS

Please report any bugs or feature requests to `bug-finance-quotedb at
rt.cpan.org`, or through the web interface at
[http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Finance-QuoteDB](http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Finance-QuoteDB).  I will be
notified, and you'll automatically be notified of progress on your bug as I make
changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Finance::QuoteDB

You can also look for information at:

- RT: CPAN's request tracker

    [http://rt.cpan.org/NoAuth/Bugs.html?Dist=Finance-QuoteDB](http://rt.cpan.org/NoAuth/Bugs.html?Dist=Finance-QuoteDB)

- AnnoCPAN: Annotated CPAN documentation

    [http://annocpan.org/dist/Finance-QuoteDB](http://annocpan.org/dist/Finance-QuoteDB)

- CPAN Ratings

    [http://cpanratings.perl.org/d/Finance-QuoteDB](http://cpanratings.perl.org/d/Finance-QuoteDB)

- Search CPAN

    [http://search.cpan.org/dist/Finance-QuoteDB](http://search.cpan.org/dist/Finance-QuoteDB)

- Mailing list

    You can subscribe to the mailing list by sending an email to
    fqdb@lists.tuxfamily.org with subject : subscribe

# ACKNOWLEDGEMENTS

# COPYRIGHT & LICENSE

Copyright 2008-2015 Erik Colson, all rights reserved.

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
&lt;http://www.gnu.org/licenses/>.
