package Finance::QuoteDB::Schema::Quote;
use base qw/DBIx::Class/;

use strict;
use warnings;

__PACKAGE__->load_components(qw/ PK::Auto Core /);
__PACKAGE__->table('quote');
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
                           previous_close=> { data_type=>'float',
                                              is_nullable=>1,
                                              is_auto_increment=>0,
                                              default_value=>0
                                            },
                           day_open=> { data_type=>'float',
                                        is_nullable=>1,
                                        is_auto_increment=>0,
                                        default_value=>0
                                      },
                           day_high=> { data_type=>'float',
                                        is_nullable=>1,
                                        is_auto_increment=>0,
                                        default_value=>0
                                      },
                           day_low=> { data_type=>'float',
                                       is_nullable=>1,
                                       is_auto_increment=>0,
                                       default_value=>0
                                     },
                           day_close=> { data_type=>'float',
                                         is_nullable=>1,
                                         is_auto_increment=>0,
                                         default_value=>0
                                       },
                           bid=> { data_type=>'integer',
                                   is_nullable=>1,
                                   is_auto_increment=>0,
                                   default_value=>0
                                 },
                           ask=> { data_type=>'integer',
                                   is_nullable=>1,
                                   is_auto_increment=>0,
                                   default_value=>0
                                 },
                           volume=> { data_type=>'integer',
                                      is_nullable=>1,
                                      is_auto_increment=>0,
                                      default_value=>0
                                    }
                         );

__PACKAGE__->set_primary_key(qw / symbolID date /);
__PACKAGE__->belongs_to('symbolID'=>'Finance::QuoteDB::Schema::Symbol');
1;
