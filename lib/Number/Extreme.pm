package Number::Extreme;

use strict;
use 5.008_001;
our $VERSION = '0.01';

sub new {
    my ($class, %args) = @_;
    bless \%args, __PACKAGE__;
}

sub max {
    my $class     = shift;
    my $extractor = shift;

    return $class->new(
        cmp           => sub { $_[1] > $_[0] },
        extractor     => $extractor,
        current_value => undef,
        current       => undef,
    );
}

sub min {
    my $class     = shift;
    my $extractor = shift;

    return $class->new(
        cmp           => sub { $_[1] < $_[0] },
        extractor     => $extractor,
        current_value => undef,
        current       => undef,
        @_,
    );
}

sub test {
    my ($self, $object) = @_;
    local $_ = $object;
    my $value = $self->{extractor} ? $self->{extractor}->() : $_;

    if (!defined $self->{current_value} ||
        $self->{cmp}->($self->{current_value}, $value)) {
        $self->{current} = $_;
        $self->{current_value} = $value;
        return 1;
    }
}

sub current_value { $_[0]->{current_value} }
sub current       { $_[0]->{current} }

1;
__END__

=encoding utf-8

=for stopwords

=head1 NAME

Number::Extreme -

=head1 SYNOPSIS

  use Number::Extreme;

=head1 DESCRIPTION

Number::Extreme is

=head1 AUTHOR

Chia-liang Kao E<lt>clkao@clkao.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
