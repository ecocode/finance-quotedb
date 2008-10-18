package Finance::QuoteDB::Schema;
use base qw/DBIx::Class::Schema/;

use strict;
use warnings;

__PACKAGE__->load_classes(qw/ Symbol Quote /);

sub connect_and_deploy {
  my ($class,$dsn) = @_;
  my $self=$class->connect($dsn);
  $self->deploy({ add_drop_tables => 1});
  return $self;
} ;

1;
