program aoc16_2;

{$mode objfpc}
{$m+}

uses
	Classes,
	Types,
	Math;

var
	fs: TextFile;
	inStr: ansiString = '';
	res: TIntegerDynArray;
	i: integer;

function fn(arr: TIntegerDynArray): TIntegerDynArray;
var
	al, i, j, k, l: integer;
	output, freqs: TIntegerDynArray;
begin
	al := length(arr);
	setLength(output, al);
	setLength(freqs, al);
	
	for i := 0 to high(arr) do begin
		for j := 0 to i do freqs[j] := 0;
		
		j := i;
		k := 3;
		
		while j <= high(freqs) do begin
			l := 0;
			while (j <= high(freqs)) and (l <= i) do begin
				output[i] := output[i] + (2 - k mod 4) mod 2 * arr[j];
				j := j + 1;
				l := l + 1;
			end;
			k := k + 1;
		end;

		output[i] := abs(output[i]) mod 10;
	end;

	exit(output);
end;

begin
	assign(fs, 'input.txt');
	reset(fs);
	readln(fs, inStr);
	close(fs);

	setLength(res, length(inStr));
	for i := 1 to length(inStr) do
		res[i-1] := integer(inStr[i]) - 48;
	
	for i := 1 to 100 do
		res := fn(res);
	
	setLength(res, 8);
	for i in res do
		write(i);
	writeln;
end.
