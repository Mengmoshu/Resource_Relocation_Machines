local b = {}

local function b.initSet(name, interval)
    local temp = {}
    for i = 1, interval do
        table.insert( temp, {} )
    end
    if #temp == interval then
        global.Buckets[name] = temp -- Be aware this may not do the right thing.
    end
end

local function b.configure(intervalList,) --?

end

return b

global = {
    Buckets = {
        interval1 = {}
        interval2 = {}

    }
}
