use utf8;
package AsterFaster::Schema::Result::Cdr;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AsterFaster::Schema::Result::Cdr

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<cdr>

=cut

__PACKAGE__->table("cdr");

=head1 ACCESSORS

=head2 calldate

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 clid

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 src

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 dst

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 dcontext

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 channel

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 dstchannel

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 lastapp

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 lastdata

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 duration

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 billsec

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 disposition

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 45

=head2 amaflags

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 accountcode

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 20

=head2 uniqueid

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 32

=head2 userfield

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "calldate",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "clid",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "src",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "dst",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "dcontext",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "channel",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "dstchannel",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "lastapp",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "lastdata",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "duration",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "billsec",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "disposition",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 45 },
  "amaflags",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "accountcode",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 20 },
  "uniqueid",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 32 },
  "userfield",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-05-06 00:57:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bO9ocfWsyiaDdREUJfPT8g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
