use strict;
use warnings;
use utf8;
use Test::More;

subtest 'not valid funtion' => sub {
    local $@;
    eval 'use Config::PL qw/hoge/';
    like $@, qr/'hoge' is not exportable function/;

};

subtest 'empty args' => sub {
    package Blah;
    use Test::More;
    eval 'use Config::PL ()';

    ok(!Blah->can('config_do'));
    ok Config::PL->can('config_do');
};

subtest ':path' => sub {
    package BlahBlah;
    use Test::More;
    eval 'use Config::PL qw/config_do/';
    ok !$@;

    my %config = config_do('config/ok.pl');
    is $config{ok}, 1;
};

subtest ':path' => sub {
    package BlahBlahBlah;
    use Test::More;
    eval 'use Config::PL qw!:path t/dummy!';
    ok !$@;

    my %config = config_do('config/ok2.pl');
    is $config{ok}, 2;
};

done_testing;
