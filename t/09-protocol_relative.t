use Test::More;
use URI;
use HTML::LinkFilter;

my $host = "example.com";

my @cases = (
    [ [ qq{<a href="//$host/foo/bar">} ], q{<a href="/foo/bar">} ],
    [ [ qq{<a href="//$host/foo/bar">}, q{foo}, q{</a>} ], q{<a href="/foo/bar">foo</a>} ],
    [ [ qq{<link href="//$host/css/styles.css" media="screen" rel="stylesheet" type="text/css" />} ], q{<link href="/css/styles.css" rel="stylesheet" type="text/css" media="screen" />} ],
    [ [ qq{<link href="//$host/css/member.css" media="screen" rel="stylesheet" type="text/css" />} ], q{<link href="/css/member.css" rel="stylesheet" type="text/css" media="screen" />} ],
);

plan tests => scalar @cases;

my $callback_sub = sub {
    my( $tagname, $attr_ref, $value ) = @_;

    my $uri = URI->new;
    $uri->scheme( "http" );
    $uri->host( $host );
    $uri->path( $value );
    ( my $string = $uri ) =~ s{\A http[:] }{}msx;

    return $string;
};

my $filter = HTML::LinkFilter->new;

foreach my $case_ref ( @cases ) {
    my( $wish, $html ) = @{ $case_ref };

    $filter->change( $html, $callback_sub );
    is_deeply( $filter->tags, $wish );
}


