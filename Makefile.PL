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
requires 'Log::Log4perl';

test_requires 'Test::More';

install_script 'fqdb';
no_index directory => 'examples';

auto_install;

WriteAll;

