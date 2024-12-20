math.randomseed(os.time())
local u = arg[1]
local r = math.random(0, 10000)
local a = {}
for i = 1, 10000 do
	a[i] = 0
	for j = 1, 100000 do
		local rem = j / u
		rem = math.floor(rem)
		rem = j - rem
		a[i] = a[i] + rem
	end
	a[i] = a[i] + r
end
print(a[r])
