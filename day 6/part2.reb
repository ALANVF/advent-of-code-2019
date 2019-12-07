Rebol [
	Title:  "AOC day 6 part 2"
	Author: "theangryepicbanana"
	Date:   7-Dec-2019
	Tabs:   4
]

text:   read/string %input.txt
orbits: map []
you:    none
santa:  none
found:  none
alnum:  charset [#"a" - #"z" #"A" - #"Z" #"0" - #"9"]
ident:  [some alnum]
travel: func[from][either none? from [copy []][append travel orbits/:from reduce [from]]]

parse/all/case text [
	some [
		copy p ident
		")"
		copy c ident
		(
			if c = "YOU" [you:   p]
			if c = "SAN" [santa: p]
			orbits/(c): p
		)
		[newline | end]
	]
]

orbits/("COM"): none

ry: reverse copy y: travel you
s: travel santa

forall ry [
	unless none? found: find s first ry [
		found: found/1
		break
	]
]

print (length? union find y found find s found) - 1

; vim: ft=rebol
