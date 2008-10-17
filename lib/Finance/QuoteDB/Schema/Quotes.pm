package Finance::QuoteDB::Schema::Quotes;
use base qw/DBIx::Class/;

use strict;
use warnings;

__PACKAGE__->load_components(qw/ PK::Auto Core /);
__PACKAGE__->table('quotes');
__PACKAGE__->add_columns ( symbolID=> { data_type=>'varchar',
                                        size=>12,
                                        is_nullable=>0,
                                        is_auto_increment=>0,
                                        default_value=>''
                                      },
                           date=> { data_type=>'date',
                                    is_nullable=>0,
                                    is_auto_increment=>0,
                                    default_value=>''
                                  },
                           quote=> { data_type=>'float(10,4)',
                                     is_nullable=>1,
                                     is_auto_increment=>0,
                                     default_value=>0
                                   } );

__PACKAGE__->set_primary_key(qw / symbolID date /);
__PACKAGE__->belongs_to('symbols','Finance::QuoteDB::Schema::Symbols');

1;
