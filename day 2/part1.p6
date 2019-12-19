my @v = slurp("input.txt").split(",")>>.Int;
@v[1, 2] = 12, 2;
loop {
	state $i = 0;
	last if $i >= +@v;

	given @v[$i] {
		when 1 {
			@v[@v[$i+3]] = [+] @v[|@v[$i+1, $i+2]];
			$i+=4;
		}
		when 2 {
			@v[@v[$i+3]] = [*] @v[|@v[$i+1, $i+2]];
			$i+=4;
		}
		when 99 {last}
	}
}
say @v[0]