AuraSpyUtils = LibStub("AceAddon-3.0"):NewAddon("AuraSpyUtils")

function AuraSpyUtils:isInGroup()
    --print("isInGroup: " .. tostring(GetNumGroupMembers() > 0))
    return GetNumGroupMembers() > 0
end

function AuraSpyUtils:isOnline(unit)
    --print("isOnline ("..unit.."): ".. tostring(UnitIsConnected(unit)))
    return UnitIsConnected(unit)
end

function AuraSpyUtils:spyEnchants(player, slotId)
    local tip = CreateFrame("GameTooltip", "scanTip", nil, "GameTooltipTemplate")
    tip:SetOwner(WorldFrame,"ANCHOR_NONE")
    tip:ClearLines()

    tip:SetInventoryItem(player, slotId)

    local enchants = {};

    for i = 1, select("#", tip:GetRegions()) do
        local region = select(i, tip:GetRegions())
        if region and region:GetObjectType() == "FontString" then
            local text = region:GetText()
            if (text ~= nil) then
                for _, val in ipairs(AuraSpyConfig.watched.enchants) do
                    if (string.sub(text, 1, string.len(val)) == val) then
                        enchants[#enchants + 1] = val;
                    end
                end
            end
        end
    end

    return enchants;
end

function AuraSpyUtils:spyPlayer(player, class)
    local consumables = {}
    for b=1,40 do
        local name, _, _, _, _, _, _, _, _, spellId = UnitBuff(player, b)

        if (name == nil) then
            break
        end

        if (AuraSpyUtils:tableHasValue(AuraSpyConfig.watched.consumables, spellId)) then
            consumables[#consumables + 1] = spellId;
        end
    end

    local mainId = GetInventorySlotInfo("MAINHANDSLOT");
    local offId = GetInventorySlotInfo("SECONDARYHANDSLOT");

    local enchants = {
        MH = AuraSpyUtils:spyEnchants(player, mainId),
        OH = AuraSpyUtils:spyEnchants(player, offId)
    }

    return consumables, enchants;
end

function AuraSpyUtils:spy()
    if IsInRaid() then
        local raid = {}
        for i=1,MAX_RAID_MEMBERS do
            local name, _, _, _, _, class, zone, online, isDead, role, isML, combatRole =  GetRaidRosterInfo(i);

            if (name ~= nil) then
                raid[#raid + 1] = {
                    name = name,
                    cl = class,
                };

                if (not online) then
                    raid[i].status = 'OFFLINE';
                elseif(isDead) then
                    raid[i].status = 'DEAD';
                else
                    local consumables, enchants = AuraSpyUtils:spyPlayer(name, class)
                    raid[i].consumables = consumables;
                    raid[i].enchants = enchants;
                end
            end
        end
        return raid
    else
        print("You must be in raid to spy commrades")
        return nil
    end
end

function AuraSpyUtils:dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. AuraSpyUtils:dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function AuraSpyUtils:isEmptyString(val)
    return val == nil or val == ""
end

function AuraSpyUtils:tableHasValue(table, value)
    for _, val in ipairs(table) do
        if val == value then
            return true
        end
    end
    return false
end
