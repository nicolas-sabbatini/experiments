local input = require("input")
local acsess_table = {
	NOP = math.random,
	POP = math.random,
	PUSH = math.random,
	ADD = math.random,
	SUB = math.random,
}
for _, str in pairs(input) do
	acsess_table[str]()
end
