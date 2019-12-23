Rebol [
	Title:  "AOC day 22 part 1"
	Author: "theangryepicbanana"
	Date:   22-Dec-2019
	Tabs:   4
]

data: load read %input.txt
cards: 10007
deck: []
repeat i cards [append deck i - 1]

parse data [
	any [
		end

		| 'deal 'with 'increment set incr integer! (
			pos: 1
			table: make vector! cards
			
			foreach i deck [
				table/(i + 1): pos
				loop incr [
					either pos = cards [pos: 1][pos: pos + 1]
				]
			]

			i: 0
			foreach v table [
				deck/(v): i
				i: i + 1
			]
		)
		
		| 'deal 'into 'new 'stack (
			reverse deck
		)

		| 'cut set len integer! (
			either positive? len [
				move/part deck length? deck len
			][
				deck: append take/part/last deck negate len deck
			]
		)
	]
]

print (index? find deck 2019) - 1
