input = File.read "input.txt"
vals = input.split(",").map &.to_i

(0..99).to_a.each_repeated_permutation 2 do |(a, b)|
	v = vals.clone
	v[1], v[2] = a, b

	i = 0
	loop do
		break if i >= vals.size
		
		case v[i]
			when 1 then v[v[i+3]] = v[v[i+1]] + v[v[i+2]]; i+=4
			when 2 then v[v[i+3]] = v[v[i+1]] * v[v[i+2]]; i+=4
			when 99 then break
			else
		end
	end

	if v[0] == 19690720
		puts 100 * a + b
		exit
	end
end