package Finance::QuoteDB::Schema::Symbols;
use base qw/DBIx::Class/;

use strict;
use warnings;

__PACKAGE__->load_components(qw/ PK::Auto Core /);
__PACKAGE__->table('symbols');
__PACKAGE__->add_columns ( symbolID=> { data_type=>'varchar',
                                        size=>12,
                                        is_nullable=>0,
                                        is_auto_increment=>0,
                                        default_value=>''
                                      },
                           name=> { data_type=>'varchar',
                                    size=>40,
                                    is_nullable=>1,
                                    is_auto_increment=>0,
                                    default_value=>''
                                  });
__PACKAGE__->set_primary_key('symbolID');
__PACKAGE__->has_many('quotes','Finance::QuoteDB::Schema::Quotes');

1;
