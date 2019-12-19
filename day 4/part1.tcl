set c 0
for {set i 271973} {$i <= 785961} {incr i} {
	if [regexp {(\d)\1} $i] {
		incr c
		foreach j {0 1 2 3 4} {
			if {[string index $i $j] > [string index $i $j+1]} {
				incr c -1
				break
			}
		}
	}
}
puts $c
