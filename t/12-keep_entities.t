use strict;
use warnings;
use HTML::Entities qw( decode_entities );
use HTML::LinkFilter;
use Test::More;

my @cases = (
    [ <<END_QUERY, <<END_WISH ],
<a href="foo?bar=baz&amp;qux=">foo</a>
END_QUERY
<a href="foo?bar=baz&amp;qux=">foo</a>
END_WISH
    [ <<END_QUERY, <<END_WISH ],
<a href="foo?b=b&amp;q=" title="f">foo</foo>
END_QUERY
<a href="foo?b=b&amp;q=" title="f">foo</foo>
END_WISH
);

my $filter = HTML::LinkFilter->new;
my $conv_sub = sub {
    my( $tabname, $attr, $value ) = @_;
    return "CHANGE" if $attr eq "title";
    return;
};

plan tests => scalar @cases;

for my $case_ref ( @cases ) {
    my( $query, $wish ) = @{ $case_ref };
    $filter->change( $query, $conv_sub );
    is( $filter->html, $wish );
}
