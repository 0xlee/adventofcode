-- lua doesn't have a function/method for table size
function tableSize(t)
	local count = 0
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end

function solve(filename, distinctChars)
	file = io.open (filename, "r")
	line = file:read()

	for i = 1, #line do
		if i+distinctChars-1 > #line then
			break
		end
		local c = line:sub(i, i+distinctChars-1)

		local t = {}
		for j = 1, #c do
			local x = c:sub(j, j)
			t[x] = true
		end
		if tableSize(t) == distinctChars then
			print(i+distinctChars-1)
			break
		end
	end
end

solve("input-example-1", 4)
solve("input-example-2", 4)
solve("input-example-3", 4)
solve("input-example-4", 4)
solve("input", 4)
solve("input", 14)
