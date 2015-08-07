use utf8;
package AsterFaster::Schema::Result::VoicemailUser;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AsterFaster::Schema::Result::VoicemailUser

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<voicemail_users>

=cut

__PACKAGE__->table("voicemail_users");

=head1 ACCESSORS

=head2 uniqueid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 customer_id

  data_type: 'varchar'
  default_value: 0
  is_nullable: 0
  size: 11

=head2 context

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 50

=head2 mailbox

  data_type: 'varchar'
  default_value: 0
  is_nullable: 0
  size: 11

=head2 password

  data_type: 'varchar'
  default_value: 0
  is_nullable: 0
  size: 10

=head2 fullname

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 150

=head2 email

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 50

=head2 pager

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 50

=head2 tz

  data_type: 'varchar'
  default_value: 'central'
  is_nullable: 0
  size: 10

=head2 attach

  data_type: 'varchar'
  default_value: 'yes'
  is_nullable: 0
  size: 4

=head2 saycid

  data_type: 'varchar'
  default_value: 'yes'
  is_nullable: 0
  size: 4

=head2 dialout

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 10

=head2 callback

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 10

=head2 review

  data_type: 'varchar'
  default_value: 'no'
  is_nullable: 0
  size: 4

=head2 operator

  data_type: 'varchar'
  default_value: 'no'
  is_nullable: 0
  size: 4

=head2 envelope

  data_type: 'varchar'
  default_value: 'no'
  is_nullable: 0
  size: 4

=head2 sayduration

  data_type: 'varchar'
  default_value: 'no'
  is_nullable: 0
  size: 4

=head2 saydurationm

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 0

=head2 sendvoicemail

  data_type: 'varchar'
  default_value: 'no'
  is_nullable: 0
  size: 4

=head2 delete

  accessor: undef
  data_type: 'varchar'
  default_value: 'no'
  is_nullable: 0
  size: 4

=head2 nextaftercmd

  data_type: 'varchar'
  default_value: 'yes'
  is_nullable: 0
  size: 4

=head2 forcename

  data_type: 'varchar'
  default_value: 'no'
  is_nullable: 0
  size: 4

=head2 forcegreetings

  data_type: 'varchar'
  default_value: 'no'
  is_nullable: 0
  size: 4

=head2 hidefromdir

  data_type: 'varchar'
  default_value: 'yes'
  is_nullable: 0
  size: 4

=head2 stamp

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "uniqueid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "customer_id",
  { data_type => "varchar", default_value => 0, is_nullable => 0, size => 11 },
  "context",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 50 },
  "mailbox",
  { data_type => "varchar", default_value => 0, is_nullable => 0, size => 11 },
  "password",
  { data_type => "varchar", default_value => 0, is_nullable => 0, size => 10 },
  "fullname",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 150 },
  "email",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 50 },
  "pager",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 50 },
  "tz",
  {
    data_type => "varchar",
    default_value => "central",
    is_nullable => 0,
    size => 10,
  },
  "attach",
  { data_type => "varchar", default_value => "yes", is_nullable => 0, size => 4 },
  "saycid",
  { data_type => "varchar", default_value => "yes", is_nullable => 0, size => 4 },
  "dialout",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 10 },
  "callback",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 10 },
  "review",
  { data_type => "varchar", default_value => "no", is_nullable => 0, size => 4 },
  "operator",
  { data_type => "varchar", default_value => "no", is_nullable => 0, size => 4 },
  "envelope",
  { data_type => "varchar", default_value => "no", is_nullable => 0, size => 4 },
  "sayduration",
  { data_type => "varchar", default_value => "no", is_nullable => 0, size => 4 },
  "saydurationm",
  { data_type => "tinyint", default_value => 1, is_nullable => 0 },
  "sendvoicemail",
  { data_type => "varchar", default_value => "no", is_nullable => 0, size => 4 },
  "delete",
  {
    accessor => undef,
    data_type => "varchar",
    default_value => "no",
    is_nullable => 0,
    size => 4,
  },
  "nextaftercmd",
  { data_type => "varchar", default_value => "yes", is_nullable => 0, size => 4 },
  "forcename",
  { data_type => "varchar", default_value => "no", is_nullable => 0, size => 4 },
  "forcegreetings",
  { data_type => "varchar", default_value => "no", is_nullable => 0, size => 4 },
  "hidefromdir",
  { data_type => "varchar", default_value => "yes", is_nullable => 0, size => 4 },
  "stamp",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</uniqueid>

=back

=cut

__PACKAGE__->set_primary_key("uniqueid");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-05-06 00:58:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7UDDVZxQDc8Q40ipUz31Ag


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
