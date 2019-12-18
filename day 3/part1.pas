program aoc3_1;

{$m+}
{$mode objfpc}

uses
	Classes,
	Types,
	Math;

type
	Point = record
		x, y: integer;
	end;

var
	input: TFileStream;
	tp: Point;
	ts: string = '';
	p1, p2: array of Point;
	dir: char;
	len, i, j, minx, maxx, miny, maxy, x, y: integer;
	res: array of integer;

function splitLine(fs: TFileStream): TStringDynArray;
var
	a: TStringDynArray;
	c: char = #0;
	s: string = '';
begin
	setLength(a, 0);
	while (fs.position < fs.size) and (fs.read(c, 1) <> -1) and (c <> #10) do
		if (c = ',') or (c = #10) then begin
			setLength(a, length(a)+1);
			a[length(a)-1] := s;
			s := '';
		end else
			s := s + string(c);
	setLength(a, length(a)+1);
	a[length(a)-1] := s;
	exit(a);
end;

function moveBy(dir: char; len: integer; last: Point): Point;
var
	p: Point;
begin
	p.x := last.x;
	p.y := last.y;
	case dir of
		'L': p.x := p.x-len;
		'R': p.x := p.x+len;
		'U': p.y := p.y-len;
		'D': p.y := p.y+len;
	end;
	exit(p);
end;

begin
	input := TFileStream.Create('input.txt', fmOpenRead);
	
	setLength(p1, 0);
	setLength(p2, 0);
	
	tp := default(Point);
	for ts in splitLine(input) do begin
		readStr(ts, dir, len);
		tp := moveBy(dir, len, tp);
		setLength(p1, length(p1)+1);
		with p1[length(p1)-1] do begin
			x := tp.x;
			y := tp.y;
		end;
	end;
	tp := default(Point);
	for ts in splitLine(input) do begin
		readStr(ts, dir, len);
		tp := moveBy(dir, len, tp);
		setLength(p2, length(p2)+1);
		with p2[length(p2)-1] do begin
			x := tp.x;
			y := tp.y;
		end;
	end;

	setLength(res, 0);
	for i := 0 to length(p1)-2 do
		for j := 0 to length(p2)-2 do begin
			if (p1[i].x = p1[i+1].x) and (p2[j].x <> p2[j+1].x) then begin
				minx := min(p2[j].x, p2[j+1].x);
				maxx := max(p2[j].x, p2[j+1].x);
				miny := min(p1[i].y, p1[i+1].y);
				maxy := max(p1[i].y, p1[i+1].y);
				x := p1[i].x;
				y := p2[j].y;
			end else if (p1[i].y = p1[i+1].y) and (p2[j].y <> p2[j+1].y) then begin
				minx := min(p1[i].x, p1[i+1].x);
				maxx := max(p1[i].x, p1[i+1].x);
				miny := min(p2[j].y, p2[j+1].y);
				maxy := max(p2[j].y, p2[j+1].y);
				x := p2[j].x;
				y := p1[i].y;
			end;
			
			if (minx <= x) and (x <= maxx) and (miny <= y) and (y <= maxy) xor (x = 0) and (y = 0) then begin
				setLength(res, length(res)+1);
				res[length(res)-1] := abs(x) + abs(y);
			end;
		end;

	writeln(minValue(res));
end.
