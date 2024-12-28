local function pull_random()
	local rand = math.random(1, 50)
	if rand <= 10 then
		return "NOP"
	elseif rand <= 20 then
		return "POP"
	elseif rand <= 30 then
		return "PUSH"
	elseif rand <= 40 then
		return "ADD"
	elseif rand <= 50 then
		return "SUB"
	end
end

print("return {")
for _ = 1, 9999999 do
	local rand_str = pull_random()
	print('"' .. rand_str .. '",')
end
print("}")
