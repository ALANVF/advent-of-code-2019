set c 0
for {set i 271973} {$i <= 785961} {incr i} {
	if [regexp {(\d)\1} $i] {
		set r [regexp -all -inline {(\d)\1{2,}} $i]
		set d [regexp -all -inline {(\d)\1} $i]

		if {[llength $r] == 4} {continue}
		if {[llength $r] == 2} {
			set l 0
			foreach {_ v} $d {
				if {[lindex $r 1] == $v} {incr l}
			}
			if {$l*2 == [llength $d]} {continue}
		}

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
