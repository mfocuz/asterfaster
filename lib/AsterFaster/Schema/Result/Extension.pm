use utf8;
package AsterFaster::Schema::Result::Extension;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AsterFaster::Schema::Result::Extension

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<extensions>

=cut

__PACKAGE__->table("extensions");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 context

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 20

=head2 exten

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 20

=head2 priority

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 app

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 20

=head2 appdata

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 128

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "context",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 20 },
  "exten",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 20 },
  "priority",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "app",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 20 },
  "appdata",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 128 },
);

=head1 PRIMARY KEY

=over 4

=item * L</context>

=item * L</exten>

=item * L</priority>

=back

=cut

__PACKAGE__->set_primary_key("context", "exten", "priority");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-05-06 00:57:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jRhP/TM4Rl4pin5GdoTlXg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
