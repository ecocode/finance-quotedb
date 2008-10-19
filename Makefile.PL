use inc::Module::Install;

name     'Finance-QuoteDB';
all_from 'lib/Finance/QuoteDB.pm';
author   'Erik Colson <eco@ecocode.net>';
license  'gpl';

requires 'DBIx::Class';
requires 'DBIx::Class::Schema';
requires 'SQL::Translator';
requires 'Pod::Usage';
requires 'Config::IniFiles';
requires 'Finance::Quote';

build_requires 'Test::More';

auto_install;

WriteAll;

