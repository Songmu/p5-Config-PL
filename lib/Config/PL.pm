package Config::PL;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Carp ();
use Cwd ();
use File::Basename ();

use parent 'Exporter';
our @EXPORT = qw/config_do/;

sub config_do($) {
    my $config_file = shift;
    my (undef, $file,) = caller;
    local @INC = (Cwd::getcwd, File::Basename::dirname($file));

    my $config = do $config_file;
    Carp::croak $@ if $@;
    Carp::croak $! unless defined $config;
    unless (ref $config eq 'HASH') {
        Carp::croak "$config_file does not return HashRef.";
    }

    $config;
}

1;
__END__

=encoding utf-8

=head1 NAME

Config::PL - It's new $module

=head1 SYNOPSIS

    use Config::PL;

=head1 DESCRIPTION

Config::PL is ...

=head1 LICENSE

Copyright (C) Masayuki Matsuki.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Masayuki Matsuki E<lt>y.songmu@gmail.comE<gt>

=cut

