#!/usr/bin/perl

use DBIx::Class::Schema::Loader qw/ make_schema_at /;
make_schema_at(
    'AsterFaster::Schema',
    { debug => 1,
      dump_directory => './lib',
    },
    [ 'dbi:mysql:database=asterfaster;host=127.0.0.1;port=3306', 'root', '',
    ],
);
