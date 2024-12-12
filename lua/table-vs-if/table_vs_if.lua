math.randomseed(os.time())

print("Start test")

local function pull_random()
	local rand = math.random(1, 60)
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

local testing_str = {}
for _ = 1, 100000000 do
	local rand_str = pull_random()
	table.insert(testing_str, rand_str)
end

local how_mamy_test = 15

print("Testing the table acsess")
local acsess_table = {
	NOP = function()
		math.random()
	end,
	POP = function()
		math.random()
	end,
	PUSH = function()
		math.random()
	end,
	ADD = function()
		math.random()
	end,
	SUB = function()
		math.random()
	end,
}
local table_time = 0
for i = 1, how_mamy_test do
	local before = os.clock()
	for _, str in pairs(testing_str) do
		acsess_table[str]()
	end
	local after = os.clock()
	table_time = table_time + (after - before)
	print(string.format("Loop took %0.6f seconds to run", after - before) .. " attempt: " .. i)
end
print("Total time: " .. table_time)
print("Average time: " .. table_time / how_mamy_test)
print("\n")

print("Testing the IF statement")
local if_time = 0
for i = 1, how_mamy_test do
	local before = os.clock()
	for _, str in pairs(testing_str) do
		if str == "NOP" then
			math.random()
		elseif str == "POP" then
			math.random()
		elseif str == "PUSH" then
			math.random()
		elseif str == "ADD" then
			math.random()
		elseif str == "SUB" then
			math.random()
		end
	end
	local after = os.clock()
	if_time = if_time + (after - before)
	print(string.format("Loop took %0.6f seconds to run", after - before) .. " attempt: " .. i)
end
print("Total time: " .. if_time)
print("Average time: " .. if_time / how_mamy_test)

print("\n")
print("Table -> Total: ", table_time, "Average: ", table_time / how_mamy_test)
print("If -> Total: ", if_time, "Average: ", if_time / how_mamy_test)
if table_time / how_mamy_test < if_time / how_mamy_test then
	print("Table is faster")
else
	print("If is faster")
end
