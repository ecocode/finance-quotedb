package Finance::QuoteDB::Schema::Symbol;
use base qw/DBIx::Class/;

use strict;
use warnings;

use vars qw /$VERSION/;

$VERSION = '0.01';

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
                                      },
                           currency=> { data_type=>'varchar',
                                        size=>4,
                                        is_nullable=>1,
                                        is_auto_increment=>0,
                                        default_value=>''
                                      }
                         );

__PACKAGE__->set_primary_key('symbolID');
__PACKAGE__->has_many('quotes'=>'Finance::QuoteDB::Schema::Quote','symbolID');

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

1;
