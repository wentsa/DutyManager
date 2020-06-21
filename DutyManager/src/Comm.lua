DMComm = LibStub("AceAddon-3.0"):NewAddon("DMComm", "AceComm-3.0")

local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")

local TYPES = {
    SET_DUTY="DM_Duty",
    SET_CONFIRMATION="DM_Confirmation"
}

DMComm.callbacks = {
    onDutySet=nil,
    onConfirmationSet=nil,
}

function DMComm:OnEnable()
    DMComm:RegisterComm(TYPES.SET_DUTY, "OnDutySet")
    DMComm:RegisterComm(TYPES.SET_CONFIRMATION, "OnConfirmationSet")
end

function DMComm:setCallback(name, cb)
    DMComm.callbacks[name] = cb;
end

function DMComm:OnDutySet(prefix, message, distribution, sender)
    -- print("comm onDutySet: " .. prefix .. ";" .. message .. ";" .. distribution .. ";" .. sender)
    local success, duty = LibAceSerializer:Deserialize(message)
    if (success and duty.manager == sender and DMUtils:isManager(sender)) then
        if (duty.assignee == DMUtils:playerName()) then
            if (DMComm.callbacks.onDutySet ~= nil) then
                DMComm.callbacks.onDutySet(duty)
            end
        end
    end
end

function DMComm:OnConfirmationSet(prefix, message, distribution, sender)
    local success, data = LibAceSerializer:Deserialize(message)
    if (success and DMComm.callbacks.onConfirmationSet ~= nil) then
        DMComm.callbacks.onConfirmationSet(data.id, data.confirmed)
    end
end

-- duty={id, manager, assignee, task, target, note, icon, taskIcon}
function DMComm:SetDuty(duty, onError)
    if (DMUtils:isInYourGroup(duty.assignee)) then
        if (DMUtils:isOnline(duty.assignee)) then
            local data = LibAceSerializer:Serialize(duty);
            DMComm:SendCommMessage(TYPES.SET_DUTY, data, "WHISPER", duty.assignee)
        elseif (onError ~= nil) then
            onError("offline")
        end
    elseif (onError ~= nil) then
        onError("invalid")
    end
end

function DMComm:SetConfirmation(duty, confirmed)
    local data = LibAceSerializer:Serialize({ id=duty.id, confirmed=confirmed });
    DMComm:SendCommMessage(TYPES.SET_CONFIRMATION, data, "WHISPER", duty.manager)
end
