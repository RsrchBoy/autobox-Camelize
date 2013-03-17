package autobox::Camelize;

# ABSTRACT: autobox methods for (de)camelcasing

use strict;
use warnings;

use parent 'autobox';

sub import {
    my $class = shift @_;

    return $class->SUPER::import(
        STRING => 'autobox::Camelize::STRING',
        @_,
    );
}

{
    package autobox::Camelize::STRING;

    use strict;
    use warnings;

    sub decamelize {
        my $string = lcfirst shift @_;

        $string =~ s/::(.)/__\l$1/g;
        $string =~ s/([A-Z])/_\l$1/g;

        return $string;
    }

    sub camelize {
        my $string = ucfirst shift @_;

        $string =~ s/__(.)/::\u$1/g;
        $string =~ s/_(.)/\u$1/g;

        return $string;
    }
}

!!42;
__END__

=for :stopwords camelize decamelize Camelize Decamelize Camelizing Decamelizing camelization lowercased

=head1 SYNOPSIS

    use autobox::Camelize;

    # $foo is 'this_is__my__name'
    my $foo = 'ThisIs::My::Name'->decamelize;

    # $bar is 'ThisIs::NotMy::Name'
    my $bar = 'this_is__not_my__name'->camelize;

=head1 DESCRIPTION

This is a simple set of autobox methods that work on strings, and
camelize/decamelize them according to how the author thinks camelization
should work:

Camelizing replaces '__[a-z]' with '::[A-Z]', and '_[a-z]' with '[A-Z]'.
The first character is capitalized.

Decamelizing replaces '::[A-Z]' with '__[a-z]', and '[A-Z]' with '_[a-z]'.
The first character is lowercased.

=head1 STRING METHODS

=head2 camelize

Camelize a string.

=head2 decamelize

Decamelize a string.

=head1 SEE ALSO

L<autobox>

L<autobox::Core> has a fairly comprehensive collection of autobox methods.

=cut
