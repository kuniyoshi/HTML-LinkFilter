use Test::More tests => 1;

my $module  = "HTML::LinkFilter";
eval "use $module";
my @methods = qw(
    new
    _start_h  _end_h
    change  tags
);

can_ok( $module, @methods );

