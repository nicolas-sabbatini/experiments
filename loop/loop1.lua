math.randomseed(os.time())
local u = arg[1]
local r = math.random(0, 10000)
local a = {}
for i = 0, 10000 - 1 do
	for j = 0, 100000 - 1 do
		local rem = j / u
		rem = math.floor(rem)
		rem = j - rem
		a[i] = (a[i] or 0) + rem
	end
	a[i] = a[i] + r
end
print(a[r])
