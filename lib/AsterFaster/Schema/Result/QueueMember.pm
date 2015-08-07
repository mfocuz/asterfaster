use utf8;
package AsterFaster::Schema::Result::QueueMember;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AsterFaster::Schema::Result::QueueMember

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<queue_members>

=cut

__PACKAGE__->table("queue_members");

=head1 ACCESSORS

=head2 uniqueid

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 membername

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 queue_name

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 interface

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 penalty

  data_type: 'integer'
  is_nullable: 1

=head2 paused

  data_type: 'varchar'
  is_nullable: 1
  size: 4

=cut

__PACKAGE__->add_columns(
  "uniqueid",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "membername",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "queue_name",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "interface",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "penalty",
  { data_type => "integer", is_nullable => 1 },
  "paused",
  { data_type => "varchar", is_nullable => 1, size => 4 },
);

=head1 PRIMARY KEY

=over 4

=item * L</uniqueid>

=back

=cut

__PACKAGE__->set_primary_key("uniqueid");

=head1 UNIQUE CONSTRAINTS

=head2 C<queue_interface>

=over 4

=item * L</queue_name>

=item * L</interface>

=back

=cut

__PACKAGE__->add_unique_constraint("queue_interface", ["queue_name", "interface"]);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-05-06 00:57:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZFYoDDcob/qHlg0DI0AwCw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
