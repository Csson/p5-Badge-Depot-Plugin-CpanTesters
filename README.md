# NAME

Badge::Depot::Plugin::Cpantesters - CPAN testers plugin for Badge::Depot

# VERSION

Version 0.0100, released 2016-02-17.

# SYNOPSIS

If used standalone:

    use Badge::Depot::Plugin::Cpantesters;

    my $badge = Badge::Depot::Plugin::Cpantesters->new(dist => 'The-Dist', version => '0.1002');

    print $badge->to_html;
    # prints:
    <a href="http://matrix.cpantesters.org/?dist=The-Dist%200.1002">
        <img src="https://badgedepot.code301.com/badge/cpantesters/The-Dist/0.1002" alt="CPAN Testers result" />
    </a>

If used with [Pod::Weaver::Section::Badges](https://metacpan.org/pod/Pod::Weaver::Section::Badges), in weaver.ini:

    [Badges]
    ; other settings
    badge = cpantesters

# DESCRIPTION

Creates a [CpanTesters](http://cpantesters.org) badge for a distribution.

This class consumes the [Badge::Depot](https://metacpan.org/pod/Badge::Depot) role.

# ATTRIBUTES

If there is a `META.json` in the distribution root, then no attributes are necessary - this plugin uses the distribution name and version given in it.

## dist

Distribution name. With dashes, not colons.

## version

Distribution version.

## base\_url

Default: `https://badgedepot.code301.com`

Set this if you wish to use another instance of [Badge::Depot::App](https://metacpan.org/pod/Badge::Depot::App).

# SEE ALSO

- [Badge::Depot](https://metacpan.org/pod/Badge::Depot)
- [Task::Badge::Depot](https://metacpan.org/pod/Task::Badge::Depot)

# SOURCE

[https://github.com/Csson/p5-Badge-Depot-Plugin-CpanTesters](https://github.com/Csson/p5-Badge-Depot-Plugin-CpanTesters)

# HOMEPAGE

[https://metacpan.org/release/Badge-Depot-Plugin-Cpantesters](https://metacpan.org/release/Badge-Depot-Plugin-Cpantesters)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
