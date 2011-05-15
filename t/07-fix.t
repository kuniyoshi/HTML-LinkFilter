use Test::More;
use HTML::LinkFilter;

my @cases = (
    [ [ q{<a href="baz">} ], q{<a href="foo/bar">} ],
);

plan tests => scalar @cases;

my $callback_sub = sub {
    return "baz";
};

my $filter = HTML::LinkFilter->new;

foreach my $case_ref ( @cases ) {
    my( $wish, $html ) = @{ $case_ref };

    $filter->change( $html, $callback_sub );
    is_deeply( $filter->tags, $wish );
}


