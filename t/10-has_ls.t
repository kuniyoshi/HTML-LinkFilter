use Test::More;
use HTML::LinkFilter;

my @cases = (
    [ [ q{<!doctype html>}, q{<html>} ], qq{<!doctype html>\n<html>} ],
);

plan tests => scalar @cases;

sub callback { }

my $filter = HTML::LinkFilter->new;

foreach my $case_ref ( @cases ) {
    my( $wish, $html ) = @{ $case_ref };

    $filter->change( $html, $callback_sub );
    is_deeply( $filter->tags, $wish );
}


