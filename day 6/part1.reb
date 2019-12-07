Rebol [
	Title:  "AOC day 6 part 1"
	Author: "theangryepicbanana"
	Date:   7-Dec-2019
	Tabs:   4
]

text:   read/string %input.txt
orbits: map []
total:  0
alnum:  charset [#"a" - #"z" #"A" - #"Z" #"0" - #"9"]
ident:  [some alnum]
path:   func [from][either none? from [0][1 + path orbits/:from]]

parse/all/case text [
	some [
		copy p ident
		")"
		copy c ident (orbits/(c): p)
		[newline | end]
	]
]

orbits/("COM"): none

foreach [name from] orbits [
	total: total + path from
]

print total

; vim: ft=rebol
