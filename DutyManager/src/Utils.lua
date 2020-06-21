DMUtils = LibStub("AceAddon-3.0"):NewAddon("DMUtils")

function DMUtils:isInGroup()
    --print("isInGroup: " .. tostring(GetNumGroupMembers() > 0))
    return GetNumGroupMembers() > 0
end

function DMUtils:isManager(unit)
    return true
    --unit = unit or "player"
    --print("isManager (" .. unit .. "): " .. tostring(UnitIsGroupAssistant(unit) or UnitIsGroupLeader(unit)))
    --return UnitIsGroupAssistant(unit) or UnitIsGroupLeader(unit)
end

function DMUtils:isInYourGroup(unit)
    local raid = DMUtils:getGroupMembers()
    for  _, v in ipairs(raid) do
        if (v.name == unit) then
            --print("isInYourGroup (" .. unit .. "): true")
            return true
        end
    end

    --print("isInYourGroup (" .. unit .. "): false")
    return false
end

function DMUtils:playerName()
    return UnitName("player")
end

function DMUtils:isOnline(unit)
    return UnitIsConnected(unit)
end

function DMUtils:searchDutyById(id, duties)
    if (duties == nil or id == nil) then
        return nil
    end

    for index, value in ipairs(duties) do
        if (value.id == id) then
            return value, index
        end
    end

    return nil
end

function DMUtils:getGroupMembers()
    local raid = {}
    if (DMUtils:isInGroup()) then
        for i = 1, MAX_RAID_MEMBERS do
            local name, _, _, _, class = GetRaidRosterInfo(i)
            if (name ~= nil) then
                raid[i] = {
                    name=name,
                    class=class
                }
            end
        end
    else
        -- TODO debug only
        raid[1] = {
            name=DMUtils:playerName(),
            class=UnitClass("player"),
        }
    end
    return raid
end

function DMUtils:getClassColor(class)
    if (class ~= nil) then
        local color = DMConfig.classColors[string.upper(class)]
        if (color ~= nil) then
            return color
        end
    end

    return 1, 1, 1
end

function DMUtils:createTextureString(path)
    return "|T" .. path .. ":0|t"
end

function DMUtils:getPathFromTextureString(str)
    return string.sub(str, 3, string.len(str) - 4)
end

function DMUtils:createClassString(color, text)
    return "|cFF" .. color .. text .. "|r"
end

function DMUtils:getNameFromClassString(str)
    return string.sub(str, 11, string.len(str) - 2)
end

local random = math.random
function DMUtils:uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

function DMUtils:dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. DMUtils:dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end