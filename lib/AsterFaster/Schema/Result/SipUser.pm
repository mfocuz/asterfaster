use utf8;
package AsterFaster::Schema::Result::SipUser;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AsterFaster::Schema::Result::SipUser

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<sip_users>

=cut

__PACKAGE__->table("sip_users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 host

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 31

=head2 nat

  data_type: 'varchar'
  default_value: 'no'
  is_nullable: 0
  size: 5

=head2 userrole

  data_type: 'integer'
  default_value: 1
  is_nullable: 0

=head2 type

  data_type: 'enum'
  default_value: 'friend'
  extra: {list => ["user","peer","friend"]}
  is_nullable: 0

=head2 accountcode

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 amaflags

  data_type: 'varchar'
  is_nullable: 1
  size: 13

=head2 call-limit

  accessor: 'call_limit'
  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 callgroup

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 callerid

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 callbackextension

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 cancallforward

  data_type: 'char'
  default_value: 'yes'
  is_nullable: 1
  size: 3

=head2 canreinvite

  data_type: 'char'
  default_value: 'yes'
  is_nullable: 1
  size: 3

=head2 context

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 defaultip

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=head2 dtmfmode

  data_type: 'varchar'
  is_nullable: 1
  size: 7

=head2 fromuser

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 fromdomain

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 insecure

  data_type: 'varchar'
  is_nullable: 1
  size: 4

=head2 language

  data_type: 'char'
  is_nullable: 1
  size: 2

=head2 mailbox

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 md5secret

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 deny

  data_type: 'varchar'
  is_nullable: 1
  size: 95

=head2 permit

  data_type: 'varchar'
  is_nullable: 1
  size: 95

=head2 mask

  data_type: 'varchar'
  is_nullable: 1
  size: 95

=head2 musiconhold

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 pickupgroup

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 qualify

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 regexten

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 restrictcid

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 rtptimeout

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 rtpholdtimeout

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 secret

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 setvar

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 disallow

  data_type: 'varchar'
  default_value: 'all'
  is_nullable: 1
  size: 100

=head2 allow

  data_type: 'varchar'
  default_value: 'g729;ilbc;gsm;ulaw;alaw'
  is_nullable: 1
  size: 100

=head2 fullcontact

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 ipaddr

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 45

=head2 port

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 regserver

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 regseconds

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 lastms

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 defaultuser

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 80

=head2 subscribecontext

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 useragent

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "host",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 31 },
  "nat",
  { data_type => "varchar", default_value => "no", is_nullable => 0, size => 5 },
  "userrole",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
  "type",
  {
    data_type => "enum",
    default_value => "friend",
    extra => { list => ["user", "peer", "friend"] },
    is_nullable => 0,
  },
  "accountcode",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "amaflags",
  { data_type => "varchar", is_nullable => 1, size => 13 },
  "call-limit",
  {
    accessor    => "call_limit",
    data_type   => "smallint",
    extra       => { unsigned => 1 },
    is_nullable => 1,
  },
  "callgroup",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "callerid",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "callbackextension",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "cancallforward",
  { data_type => "char", default_value => "yes", is_nullable => 1, size => 3 },
  "canreinvite",
  { data_type => "char", default_value => "yes", is_nullable => 1, size => 3 },
  "context",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "defaultip",
  { data_type => "varchar", is_nullable => 1, size => 15 },
  "dtmfmode",
  { data_type => "varchar", is_nullable => 1, size => 7 },
  "fromuser",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "fromdomain",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "insecure",
  { data_type => "varchar", is_nullable => 1, size => 4 },
  "language",
  { data_type => "char", is_nullable => 1, size => 2 },
  "mailbox",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "md5secret",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "deny",
  { data_type => "varchar", is_nullable => 1, size => 95 },
  "permit",
  { data_type => "varchar", is_nullable => 1, size => 95 },
  "mask",
  { data_type => "varchar", is_nullable => 1, size => 95 },
  "musiconhold",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "pickupgroup",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "qualify",
  { data_type => "char", is_nullable => 1, size => 3 },
  "regexten",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "restrictcid",
  { data_type => "char", is_nullable => 1, size => 3 },
  "rtptimeout",
  { data_type => "char", is_nullable => 1, size => 3 },
  "rtpholdtimeout",
  { data_type => "char", is_nullable => 1, size => 3 },
  "secret",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "setvar",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "disallow",
  {
    data_type => "varchar",
    default_value => "all",
    is_nullable => 1,
    size => 100,
  },
  "allow",
  {
    data_type => "varchar",
    default_value => "g729;ilbc;gsm;ulaw;alaw",
    is_nullable => 1,
    size => 100,
  },
  "fullcontact",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "ipaddr",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 45 },
  "port",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "regserver",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "regseconds",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "lastms",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "defaultuser",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 80 },
  "subscribecontext",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "useragent",
  { data_type => "varchar", is_nullable => 1, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-08-01 12:30:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:a4MH9OHXw0RgYDlotm01fg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
