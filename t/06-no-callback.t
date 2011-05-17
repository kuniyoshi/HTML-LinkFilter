use Test::More;
use HTML::LinkFilter;

my @cases = (
    [ [ q{<a href="foo/bar">} ], q{<a href="foo/bar">} ],
    [ [ q{<a href="foo/bar">}, q{</a>} ], q{<a href="foo/bar"></a>} ],
    [ [ "<p>", "foo", "</p>" ], q{<p>foo</p>} ],
    [ [ q{<link href="http://foo.forkn.jp/css/member.css" rel="stylesheet" type="text/css" media="screen" />} ], q{<link href="http://foo.forkn.jp/css/member.css" rel="stylesheet" type="text/css" media="screen" />} ],
    [ [ q{<p>}, q{<a href="/foo">}, "bar", q{</a>}, q{</p>} ], <<'HTML' ],
<p>
    <a href="/foo">bar</a>
</p>
HTML
);

plan tests => scalar @cases;

my $filter = HTML::LinkFilter->new;

foreach my $case_ref ( @cases ) {
    my( $wish, $html ) = @{ $case_ref };
    $filter->change( $html );
    is_deeply( $filter->tags, $wish );
}


