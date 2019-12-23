sub fn(@d) {
	(^my $d = +@d).map: {
		flat(@d Z flat(0 xx $_, |(|([1, 0, -1, 0] »xx» $_+1).List xx $d-$_))[^$d]).map(&[*]).sum.comb.tail
	}
}

my $i = "input.txt".&slurp.ords>>.&(*-48);
$i .= &fn for ^100;
say $i[^8].join;
