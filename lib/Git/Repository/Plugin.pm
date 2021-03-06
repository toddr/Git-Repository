package Git::Repository::Plugin;

use strict;
use warnings;

our $VERSION = '1.00';

sub install {
    my ( $class, @names ) = @_;
    no strict 'refs';
    @names = @{"$class\::KEYWORDS"} if !@names;
    *{"Git::Repository::$_"} = \&{"$class\::$_"} for @names;
}

1;

__END__

=head1 NAME

Git::Repository::Plugin - Base class for Git::Repository plugins

=head1 SYNOPSIS

    package Git::Repository::Plugin::Hello;

    use Git::Repository::Plugin;
    our @ISA      = qw( Git::Repository::Plugin );
    our @KEYWORDS = qw( hello hello_gitdir );

    sub hello        { return "Hello, git world!\n"; }
    sub hello_gitdir { return "Hello, " . $_[0]->git_dir . "!\n"; }

    1;

=head1 DESCRIPTION

C<Git::Repository::Plugin> allows one to define new methods for
C<Git::Repository>, that will be imported in the C<Git::Repository>
namespace.

The L<SYNOPSIS> provides a full example.

The documentation of L<Git::Repository> describes how to load plugins
with all the methods they provide, or only a selection of them.

=head1 METHODS

C<Git::Repository::Plugin> provides a single method:

=head2 install( @names )

Install all names provided in the C<Git::Repository> namespace.

=head1 AUTHOR

Philippe Bruhat (BooK), C<< <book at cpan.org> >>

=head1 ACKNOWLEDGEMENTS

Thanks to Todd Rinalo, who wanted to add more methods to
C<Git::Repository>, which made me look for a solution that would preserve
the minimalism of C<Git::Repository>.

After a not-so-good design using @ISA (so C<Git::Repository> would
I<inherit> the extra methods), further discussions with Aristotle
Pagaltzis and a quick peek at Dancer's plugin management helped me
come up with the current design. Thank you Aristotle and the Dancer
team.

=head1 COPYRIGHT

Copyright 2010 Philippe Bruhat (BooK).

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

