NB. Linux = LF, Windows = CRLF, MacOS = CR (I think)
'line1 line2' =: > LF cut fread 'input.txt'

moveBy =: dyad define
	NB. x   : complex (previous point)
	NB. y   : string  (offset)
	NB. ret : complex (new point)
	
	dir =. {. y
	len =. ". }. y
	
	select. dir
	case. 'L' do.
		x - len j. 0
	case. 'R' do.
		x + len j. 0
	case. 'U' do.
		x - j. len
	case. 'D' do.
		x + j. len
	end.
)

main =: monad define
	minmax =. (<./&]) , (>./&])
	gx =. {.&+.
	gy =. }.&+.
	xs =. gx"0
	ys =. gy"0
	offsets1 =. > ',' cut line1
	offsets2 =. > ',' cut line2
	points1 =. >a:
	points2 =. >a:
	ut =. i. @ -&1
	res =. >a:
	'fx fy' =. 0 0
	'minx maxx miny maxy x y' =. 0 0 0 0 0 0

	point =. 0j0
	for_offset. offsets1 do.
		points1 =. points1 , point =. point moveBy offset
	end.
	
	point =. 0j0
	for_offset. offsets2 do.
		points2 =. points2 , point =. point moveBy offset
	end.
	
	for_ipair. , (ut #points1) j./ (ut #points2) do.
		'i1 i2' =. +. ipair
		'p1x p1y n1x n1y' =. , +. (0 1 + i1) { points1
		'p2x p2y n2x n2y' =. , +. (0 1 + i2) { points2

		if. (p1x = n1x) *. (p2x ~: n2x) do.
			'minx maxx' =. /:~ p2x,n2x
			'miny maxy' =. /:~ p1y,n1y
			fx =. p1x
			fy =. p2y
		elseif. (p1y = n1y) *. (p2y ~: n2y) do.
			'minx maxx' =. /:~ p1x,n1x
			'miny maxy' =. /:~ p2y,n2y
			fx =. p2x
			fy =. p1y
		end.
		
		if. (*./ (minx,fx,miny,fy) <: (fx,maxx,fy,maxy)) ~: ((fx = 0) *. (fy = 0)) do.
			res =. res , +/ | fx,fy
		end.
	end.

	echo <./ res

	0
)

exit main 0