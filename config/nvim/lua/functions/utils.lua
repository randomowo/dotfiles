local export = {}

local function mergeTables(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == 'table' then
            if type(t1[k] or false) == 'table' then
                t1[k] = mergeTables(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end

    return t1
end

local function split(s, delimiter)
    local result = {};
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end

    return result
end

local function tlength(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end

    return count
end

function export.sortByKey(key)
    return function(a, b)
        return a[key] < b[key]
    end
end

function export.getFromListByKV(t, key, value)
    for k in pairs(t) do
        if type(t[k]) == 'table' then
            for kk, v in pairs(t[k]) do
                if kk == key and v == value then
                    return { k, t[k] }
                end
            end
        end
    end

    return nil
end

function export.mergeListsByKey(l1, l2, key)
    local result = {}
    local visited = {}
    for k, v in pairs(l1) do
        if type(v) == 'table' then
            local res = export.getFromListByKV(l2, key, v[key])
            if res ~= nil then
                result[k] = res[2]
                table.insert(visited, res[2])
            else
                result[k] = v
            end
        else
            result[k] = v
        end
    end

    table.sort(visited, function(a, b) return a < b end)

    for _, v in pairs(l2) do
        local have = false
        for _, vv in pairs(visited) do
            if v == vv then
                have = true
                break
            end
        end
        if not have then
            table.insert(result, v)
        end
    end

    return result
end

-- function to require local modules with custom_{module} module if exists
function export.import(module)
    local m = require(module)

    local module_parts = split(module, '/')
    module_parts[tlength(module_parts)] = 'custom_' .. module_parts[tlength(module_parts)]

    local custom_module = table.concat(module_parts, '/')

    if pcall(require, custom_module) then
        m = mergeTables(m or {}, require(custom_module) or {})
    end

    return m
end

return export
