say slurp("input.txt").words>>.Int.map({my$v=$_;[+] gather while $v>5 {take $v=$v div 3-2}}).sum
