use Test::More;
use HTML::LinkFilter;

my @cases = (
    [ [ q{<a href="foo/bar">} ], q{<a href="foo/bar">} ],
);

plan tests => scalar @cases;

my $filter = HTML::LinkFilter->new;

foreach my $case_ref ( @cases ) {
    my( $wish, $html ) = @{ $case_ref };

    $filter->change( $html );
    is_deeply( $filter->tags, $wish );
}


