use Test::More;
use HTML::LinkFilter;

my @cases = (
    [ [ qq{<a href="/foo/bar">} ], q{<a href="/foo/bar">} ],
    [ [ qq{<a href="/foo/bar">}, q{foo}, q{</a>} ], q{<a href="/foo/bar">foo</a>} ],
);

plan tests => scalar @cases;

my $callback_sub = sub { };

my $filter = HTML::LinkFilter->new;

foreach my $case_ref ( @cases ) {
    my( $wish, $html ) = @{ $case_ref };

    $filter->change( $html, $callback_sub );
    is_deeply( $filter->tags, $wish );
}


