DMAdmin = LibStub("AceAddon-3.0"):NewAddon("DMAdmin", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")
AceGUI = LibStub("AceGUI-3.0")

DMAdmin.var = {
    shown=false,
    frame=nil,
    group=nil,
}

function DMAdmin:OnInitialize()
    if not DMSettingsAdmin then DMSettingsAdmin = {
        position = nil,
    } end;

    DMComm:setCallback(
            'onConfirmationSet',
            function (id, confirmed) DMAdmin:onConfirmationSet(id, confirmed) end
    )

    DMComm:setCallback(
            'onCheckBroadcast',
            function (from, data) DMAdmin:onCheckBroadcast(from, data) end
    )

    if (AdminDuties ~= nil and #AdminDuties > 0) then
        DMAdmin:consolidate()
    end
end

function DMAdmin:OnEnable()
    DMAdmin:RegisterEvent("GROUP_ROSTER_UPDATE", "onRosterUpdate")
    DMAdmin:RegisterChatCommand("duty",
            function ()
                if (DMUtils:isManager("player")) then
                    DMAdmin:show(AdminDuties)
                else
                    print("Only leader and assistants can assign duties")
                end
            end,
            true
    )
end

function DMAdmin:OnDisable()
    DMAdmin:UnregisterEvent("GROUP_ROSTER_UPDATE")
    DMAdmin:UnregisterChatCommand("duty")
end

function DMAdmin:onRosterUpdate()
    DMAdmin:consolidate()
end

function DMAdmin:onCheckBroadcast(from, data)
    -- TODO
end

function DMAdmin:consolidate()
    if (not DMUtils:isInGroup()) then
        DMAdmin:hide()
        AdminDuties = nil
    elseif (AdminDuties ~= nil) then
        local refresh = false
        for i=#AdminDuties,1,-1 do
            if (not DMUtils:isInYourGroup(AdminDuties[i].assignee)) then
                table.remove(AdminDuties, i)
                refresh = true
            end
        end
        if (refresh and DMAdmin.var.shown) then
            DMAdmin:refresh(AdminDuties)
        end
    end
end

function DMAdmin:onConfirmationSet(id, confirmed)
    local duty, idx = DMUtils:searchDutyById(id, AdminDuties)
    if (duty ~= nil) then
        AdminDuties[idx].confirmed = confirmed
        DMAdmin:refresh(AdminDuties)
    end
end

function DMAdmin:getClassDutyList(raid, player)
    for i, v in ipairs(raid) do
        if (v.name == player) then
            local cls = v.class
            if (cls ~= nil) then
                local list = DMConfig.taskList[string.upper(cls)]
                if (list ~= nil) then
                    local dropdownList = {""}
                    for k, l in ipairs(list) do
                        dropdownList[#dropdownList + 1] = DMUtils:createTextureString(l.path)
                    end
                    return list, dropdownList
                end
            end
        end
    end

    return {}, {""}
end

function DMAdmin:createDutyRow(duty, raidList, iconList, raid)
    local group = AceGUI:Create("SimpleGroup")
    group:SetRelativeWidth(1)
    group:SetLayout("Flow")

    local task = AceGUI:Create("EditBox")
    task:SetLabel("Task")
    task:SetText(duty == nil and "" or duty.task)


    local defaultIconValue = 1
    if (duty ~= nil and duty.icon ~= nil) then
        for i, v in ipairs(iconList) do
            if (duty.icon == DMUtils:getPathFromTextureString(v)) then
                defaultIconValue = i
            end
        end
    end

    local targetIcon = AceGUI:Create("Dropdown")
    targetIcon:SetLabel("Mark")
    targetIcon:SetList(iconList)
    targetIcon:SetValue(defaultIconValue)

    local target = AceGUI:Create("EditBox")
    target:SetLabel("Target")
    target:SetText(duty == nil and "" or duty.target)

    local note = AceGUI:Create("EditBox")
    note:SetLabel("Note")
    note:SetText(duty == nil and "" or duty.note)

    local actualTaskIconListRaw = {}
    local actualTaskIconList = {""}
    local taskIcon = AceGUI:Create("Dropdown")
    taskIcon:SetLabel("Task icon")

    local assignee
    local assigneeText
    if (duty == nil) then
        assignee = AceGUI:Create("Dropdown")
        assignee:SetLabel("Assignee")
        assignee:SetList(raidList)
        assignee:SetCallback("OnValueChanged", function (key)
            assigneeText = DMUtils:getNameFromClassString(raidList[assignee:GetValue()])
            actualTaskIconListRaw, actualTaskIconList = DMAdmin:getClassDutyList(raid, assigneeText)
            taskIcon:SetList(actualTaskIconList)
            taskIcon:SetValue(1)
            task:SetText("")
            target:SetText("")
            targetIcon:SetValue(1)
        end)
    else
        assignee = AceGUI:Create("Label")
        assignee:SetText(duty.assignee)
        assigneeText = duty.assignee
    end

    local defaultTaskIconValue = 1
    actualTaskIconListRaw, actualTaskIconList = DMAdmin:getClassDutyList(raid, assigneeText)

    if (duty ~= nil and duty.taskIcon ~= nil) then
        for i, v in ipairs(actualTaskIconList) do
            if (duty.taskIcon == DMUtils:getPathFromTextureString(v)) then
                defaultTaskIconValue = i
            end
        end
    end

    taskIcon:SetList(actualTaskIconList)
    taskIcon:SetValue(defaultTaskIconValue)

    taskIcon:SetCallback("OnValueChanged", function (key)
        local value = DMUtils:getPathFromTextureString(actualTaskIconList[taskIcon:GetValue()])
        local taskText = ""
        for i, v in ipairs(actualTaskIconListRaw) do
            if (v.path == value) then
                taskText = v.name
            end
        end

        task:SetText(taskText)
    end)


    local btnSend = AceGUI:Create("Button")
    btnSend:SetText("Assign")
    btnSend:SetCallback(
            "OnClick",
            function ()
                local dutyId = duty == nil and DMUtils:uuid() or duty.id
                local iconValue = targetIcon:GetValue()
                local iconParsed = iconValue == 1 and nil or DMUtils:getPathFromTextureString(iconList[iconValue])

                local taskIconValue = taskIcon:GetValue()
                local taskIconParsed = taskIconValue == 1 and nil or DMUtils:getPathFromTextureString(actualTaskIconList[taskIconValue])

                local newDuty = {
                    id=dutyId,
                    manager=DMUtils:playerName(),
                    assignee=assigneeText,
                    taskIcon=taskIconParsed,
                    task=task:GetText(),
                    target=target:GetText(),
                    note=note:GetText(),
                    icon=iconParsed,
                    confirmed=false
                }

                DMAdmin:addNewAdminDuty(newDuty)

                DMComm:SetDuty(
                        newDuty,
                function (reason)
                    print("could not send duty: " .. reason)
                end)

                DMAdmin:refresh(AdminDuties)

            end
    )

    assignee:SetWidth(120)
    taskIcon:SetWidth(100)
    task:SetWidth(200)
    targetIcon:SetWidth(100)
    target:SetWidth(100)
    note:SetWidth(250)
    btnSend:SetWidth(100)

    group:AddChild(assignee)
    group:AddChild(taskIcon)
    group:AddChild(task)
    group:AddChild(targetIcon)
    group:AddChild(target)
    group:AddChild(note)
    group:AddChild(btnSend)

    if (duty ~= nil) then
        local btnDelete = AceGUI:Create("Button")
        btnDelete:SetText("Delete")
        btnDelete:SetCallback(
                "OnClick",
                function ()
                    DMAdmin:deleteAdminDuty(duty.id) -- TODO mozna delete az po success /confirm delete

                    DMComm:SetDuty(
                            {
                                id=duty.id,
                                manager=duty.manager,
                                assignee=duty.assignee,
                            },
                            function (reason)
                                print("could not send duty: " .. reason)
                            end)

                    DMAdmin:refresh(AdminDuties)

                end
        )

        local confirmedLabel = AceGUI:Create("Label")
        local confirmedLabelText = duty.confirmed and DMUtils:createTextureString("interface/achievementframe/ui-achievement-criteria-check.blp") or ""
        confirmedLabel:SetText(confirmedLabelText)

        btnDelete:SetWidth(100)
        confirmedLabel:SetWidth(50)

        group:AddChild(btnDelete)
        group:AddChild(confirmedLabel)
    end



    return group
end

function DMAdmin:addNewAdminDuty(duty)
    if (AdminDuties == nil) then
        AdminDuties = {}
    end

    local found, idx = DMUtils:searchDutyById(duty.id, AdminDuties)
    local newIdx = #AdminDuties + 1
    if (found) then
        newIdx = idx
    end

    AdminDuties[newIdx] = duty
end

function DMAdmin:deleteAdminDuty(id)
    local found, idx = DMUtils:searchDutyById(id, AdminDuties)
    if (found) then
        table.remove(AdminDuties, idx)
    end
end

-- duty={id, manager, assignee, task, target, note, icon, taskIcon}
function DMAdmin:fillAdminDuties(widget, duties)
    local raid = DMUtils:getGroupMembers()
    table.sort(raid, function (a, b)
        if (a.class == nil or b.class == nil or a.class == b.class) then
            return a.name < b.name
        end
        return a.class < b.class
    end)

    local raidList = {}
    for k in pairs(raid) do
        local color = DMUtils:getClassColor(raid[k].class)
        raidList[#raidList + 1] = DMUtils:createClassString(color, raid[k].name)
    end

    local iconList = {""}
    for k in pairs(DMConfig.raidTarget) do
        iconList[#iconList + 1] = DMUtils:createTextureString(DMConfig.raidTarget[k])
    end

    if (duties ~= nil) then
        for _, d in ipairs(duties) do
            local row = DMAdmin:createDutyRow(d, raidList, iconList, raid)
            widget:AddChild(row)
        end
    end

    local row = DMAdmin:createDutyRow(nil, raidList, iconList, raid)

    widget:AddChild(row)
end


function DMAdmin:show(duties)
    if (not DMAdmin.var.shown) then
        local frame = AceGUI:Create("Frame")
        frame:SetTitle("Duty Manager - Admin")
        frame:SetLayout("Flow");
        frame:SetCallback("OnClose", function() DMAdmin:hide() end)
        DMAdmin:RawHookScript(frame.frame, "OnHide",
                function(f)
                    local point, relativeTo, relativePoint, x, y = frame:GetPoint()
                    DMSettingsAdmin.position = {
                        point = point,
                        relativePoint = relativePoint,
                        x = x,
                        y = y,
                    };
                    DMSettingsAdmin.size = {
                        width=frame.frame:GetWidth(),
                        height=frame.frame:GetHeight()
                    }
                    self.hooks[f].OnHide(f)
                end
        )
        frame.frame:SetFrameStrata("DIALOG")


        DMAdmin.var.frame = frame

        local scrollcontainer = AceGUI:Create("SimpleGroup")
        scrollcontainer:SetFullWidth(true)
        scrollcontainer:SetFullHeight(true)
        scrollcontainer:SetLayout("Fill")

        local scroll = AceGUI:Create("ScrollFrame")
        scroll:SetLayout("Flow")
        scrollcontainer:AddChild(scroll)

        frame:AddChild(scrollcontainer)

        DMAdmin:fillAdminDuties(scroll, duties)

        DMAdmin:PositionFrame()
        frame:Show()

        DMAdmin.var.shown = true
    end
end

function DMAdmin:hide()
    if (DMAdmin.var.shown) then
        local widget = DMAdmin.var.frame
        if (widget ~= nil) then
            AceGUI:Release(widget)
            DMAdmin:Unhook(widget.frame, "OnHide")
            DMAdmin.var = {
                shown = false,
                frame = nil,
            };
        end
    end
end

function DMAdmin:refresh(duties)
    DMAdmin:hide()
    DMAdmin:show(duties)
end

function DMAdmin:PositionFrame()
    if (DMAdmin.var.frame ~= nil) then
        DMAdmin.var.frame:ClearAllPoints()

        if (DMSettingsAdmin.position ~= nil) then
            DMAdmin.var.frame:SetPoint(
                    DMSettingsAdmin.position.point,
                    "UIParent",
                    DMSettingsAdmin.position.relativePoint,
                    DMSettingsAdmin.position.x,
                    DMSettingsAdmin.position.y
            );
        else
            DMAdmin.var.frame:SetPoint("RIGHT", "UIParent", "RIGHT", 0, 0);
        end

        if (DMSettingsAdmin.size ~= nil) then
            DMAdmin.var.frame:SetWidth(DMSettingsAdmin.size.width)
            DMAdmin.var.frame:SetHeight(DMSettingsAdmin.size.height)
        else
            DMAdmin.var.frame:SetWidth(800)
            DMAdmin.var.frame:SetHeight(500)
        end
    end
end
