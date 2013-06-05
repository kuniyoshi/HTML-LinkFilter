use Test::More;
use HTML::LinkFilter;

my @cases = (
    [ <<'WISH', <<'HTML' ],
<a title="github" href="//github.com/">github.com</a>
WISH
<a title="github" href="//github.com/">github.com</a>
HTML
);

plan tests => scalar @cases;

sub callback { }

my $filter = HTML::LinkFilter->new;

foreach my $case_ref ( @cases ) {
    my( $wish, $html ) = @{ $case_ref };

    $filter->change( $html, \&callback );
    is( $filter->html, $wish );
}


