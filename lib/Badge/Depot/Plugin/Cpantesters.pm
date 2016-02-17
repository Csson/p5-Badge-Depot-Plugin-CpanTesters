use 5.10.0;
use strict;
use warnings;

package Badge::Depot::Plugin::Cpantesters;

# ABSTRACT: CPAN testers plugin for Badge::Depot
# AUTHORITY
our $VERSION = '0.0101';

use Moose;
use namespace::autoclean;
use MooseX::AttributeShortcuts;
use Types::Standard qw/Str HashRef/;
use Types::URI qw/Uri/;
use JSON::MaybeXS 'decode_json';
use Path::Tiny;
with 'Badge::Depot';

has dist => (
    is => 'ro',
    isa => Str,
    lazy => 1,
    default => sub {
        my $self = shift;
        if($self->has_meta) {
            return $self->_meta->{'dist'} if exists $self->_meta->{'dist'};
        }
    },
);
has version => (
    is => 'ro',
    isa => Str,
    lazy => 1,
    default => sub {
        my $self = shift;
        if($self->has_meta) {
            return $self->_meta->{'version'} if exists $self->_meta->{'version'};
        }
    },
);
has base_url => (
    is => 'ro',
    isa => Uri,
    coerce => 1,
    lazy => 1,
    default => 'https://badgedepot.code301.com',
);
has custom_image_url => (
    is => 'ro',
    isa => Uri,
    coerce => 1,
    lazy => 1,
    builder => 1,
);

sub _build_custom_image_url  {
    my $self = shift;
    return sprintf '%s/badge/cpantesters/%s/%s', $self->base_url, $self->dist, $self->version;
}
has _meta => (
    is => 'ro',
    isa => HashRef,
    predicate => 'has_meta',
    builder => '_build_meta',
);

sub _build_meta {
    my $self = shift;

    return {} if !path('META.json')->exists;

    my $json = path('META.json')->slurp_utf8;
    my $data = decode_json($json);

    return {} if !exists $data->{'name'} || !exists $data->{'version'};

    return {
        dist => $data->{'name'},
        version => $data->{'version'},
    };
}

sub BUILD {
    my $self = shift;
    $self->link_url(sprintf 'http://matrix.cpantesters.org/?dist=%s %s', $self->dist, $self->version eq 'latest' ? '' : $self->version);
    $self->image_url($self->custom_image_url);
    $self->image_alt('CPAN Testers result');
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=head1 SYNOPSIS

If used standalone:

    use Badge::Depot::Plugin::Cpantesters;

    my $badge = Badge::Depot::Plugin::Cpantesters->new(dist => 'The-Dist', version => '0.1002');

    print $badge->to_html;
    # prints:
    <a href="http://matrix.cpantesters.org/?dist=The-Dist%200.1002">
        <img src="https://badgedepot.code301.com/badge/cpantesters/The-Dist/0.1002" alt="CPAN Testers result" />
    </a>

If used with L<Pod::Weaver::Section::Badges>, in weaver.ini:

    [Badges]
    ; other settings
    badge = cpantesters

=head1 DESCRIPTION

Creates a L<CpanTesters|http://cpantesters.org> badge for a distribution.

This class consumes the L<Badge::Depot> role.

=head1 ATTRIBUTES

If there is a C<META.json> in the distribution root, then no attributes are necessary - this plugin uses the distribution name and version given in it.

=for :list

=head2 dist

Distribution name. With dashes, not colons.

=head2 version

Distribution version.

=head2 base_url

Default: C<https://badgedepot.code301.com>

Set this if you wish to use another instance of L<Badge::Depot::App>.

=head1 SEE ALSO

=for :list
* L<Badge::Depot>
* L<Task::Badge::Depot>

=cut
