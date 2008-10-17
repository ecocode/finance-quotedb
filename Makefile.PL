use inc::Module::Install;

name     'Finance-QuoteDB';
all_from 'lib/Finance/QuoteDB.pm';
author   'Erik Colson <eco@ecocode.net>';

requires 'DBIx::Class';
requires 'DBIx::Class::Schema';
build_requires 'Test::More';

auto_install;

WriteAll;

