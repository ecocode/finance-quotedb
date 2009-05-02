package Finance::QuoteDB::Geniustrader;

use strict;
use warnings;

use Exporter ();
use vars qw/@EXPORT @EXPORT_OK @EXPORT_TAGS/;

use Log::Log4perl qw(:easy);

=head1 NAME

Finance::QuoteDB::Interface::Geniustrader - Interfaces to external program Geniustrader

=cut

@EXPORT = ();
@EXPORT_OK = qw // ;
@EXPORT_TAGS = ( all => [@EXPORT_OK] );

=head1 SYNOPSIS

Please take a look at script/fqdb which is the command-line frontend
to Finance::QuoteDB.

=head1 METHODS

=head2 writeConfig

writeConfig ( $fqdb-obj, $file )

This function will create a Geniustrader config file for the $fqdb object.

=cut

sub writeConfig {
}
