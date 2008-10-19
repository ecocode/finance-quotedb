package Finance::QuoteDB::Schema::Symbol;
use base qw/DBIx::Class/;

use strict;
use warnings;

__PACKAGE__->load_components(qw/ PK::Auto Core /);
__PACKAGE__->table('symbol');
__PACKAGE__->add_columns ( symbolID=> { data_type=>'varchar',
                                        size=>10,
                                        is_nullable=>0,
                                        is_auto_increment=>0,
                                        default_value=>''
                                      },
                           name=> { data_type=>'varchar',
                                    size=>40,
                                    is_nullable=>1,
                                    is_auto_increment=>0,
                                    default_value=>''
                                  },
                           fqmarket=> { data_type=>'varchar',
                                        size=>20,
                                        is_nullable=>1,
                                        is_auto_increment=>0,
                                        default_value=>''
                                      },
                           isin=> { data_type=>'varchar',
                                    size=>12,
                                    is_nullable=>1,
                                    is_auto_increment=>0,
                                    default_value=>''
                                  },
                           failover=> { data_type=>'boolean',
                                        default_value=>'FALSE'
                                      }
                         );

__PACKAGE__->set_primary_key('symbolID');
__PACKAGE__->has_many('quotes'=>'Finance::QuoteDB::Schema::Quote','symbolID');

1;
