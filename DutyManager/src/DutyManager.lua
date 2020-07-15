DutyManager = LibStub("AceAddon-3.0"):NewAddon("DutyManager", "AceEvent-3.0", "AceHook-3.0")
AceGUI = LibStub("AceGUI-3.0")

DutyManager.var = {
    shown=false,
    frame=nil,
    minimized=false,
}

function DutyManager:OnInitialize()
    if not DMSettings then DMSettings = {
        position = nil,
    } end;

    DMComm:setCallback(
            'onDutySet',
            function(duty)
                DutyManager:onDutySet(duty)
            end
    )

    DMComm:setCallback(
            'onCheck',
            function (from)
                DMComm:CheckBroadcast(from, {
                    version=DMConfig.version
                })
            end
    )

    DutyManager:consolidate(true)
end

function DutyManager:OnEnable()
    DutyManager:RegisterEvent("GROUP_ROSTER_UPDATE", "onRosterUpdate")
end

function DutyManager:OnDisable()
    DutyManager:UnregisterEvent("GROUP_ROSTER_UPDATE")
end

function DutyManager:onRosterUpdate()
    DutyManager:consolidate()
end

function DutyManager:consolidate(forceShow)
    if (not DMUtils:isInGroup()) then
        DutyManager:hide()
        MyDuties = nil
    elseif (MyDuties ~= nil) then
        for i=#MyDuties,1,-1 do
            if (not DMUtils:isInYourGroup(MyDuties[i].manager)) then
                table.remove(MyDuties, i)
            end
        end
        if (DutyManager.var.shown) then
            DutyManager:refresh(MyDuties)
        elseif (forceShow) then
            DutyManager:show(MyDuties)
        end
    end
end

-- {id, manager, assignee, task, target, note, icon, taskIcon}
function DutyManager:onDutySet(duty)
    local found, foundIdx = DMUtils:searchDutyById(duty.id, MyDuties)

    if (duty.task ~= nil and duty.task ~= "" and duty.task ~= "nil") then
        if (MyDuties == nil) then
            MyDuties = {}
        end

        local idx = #MyDuties + 1
        if (found) then
            idx = foundIdx
        end

        MyDuties[idx] = duty
    else -- remove duty
        if (found ~= nil) then
            table.remove (MyDuties, foundIdx)
        end
    end

    DutyManager:refresh(MyDuties)
end

function DutyManager:fillDuties(duties)
    DutyManager.var.frame:ReleaseChildren()

    if (not DutyManager.var.minimized) then
        for _, d in ipairs(duties) do
            local group = AceGUI:Create("SimpleGroup")
            group:SetRelativeWidth(1)
            group:SetLayout("Flow")

            local taskLabel = AceGUI:Create("InteractiveLabel")
            taskLabel:SetText(d.task)

            local taskIcon;
            if (d.taskIcon ~= nil) then
                taskIcon = AceGUI:Create("Icon")
                taskIcon:SetImage(d.taskIcon)
                taskIcon:SetImageSize(16, 16)
                taskIcon.frame:EnableMouse(false)
                taskIcon.image:SetPoint("TOP", 0, -2)
            end

            local targetLabel = AceGUI:Create("Label")
            targetLabel:SetText(d.target)

            local targetIcon;
            if (d.icon ~= nil) then
                targetIcon = AceGUI:Create("Icon")
                targetIcon:SetImage(d.icon)
                targetIcon:SetImageSize(16, 16)
                targetIcon.frame:EnableMouse(false)
                targetIcon.image:SetPoint("TOP", 0, -2)
            end

            local tooltip = GameTooltip;
            taskLabel:SetCallback("OnEnter", function(widget)
                if (tooltip ~= nil) then
                    tooltip:ClearLines();
                    tooltip:SetOwner(taskLabel.frame, "ANCHOR_NONE")
                    tooltip:ClearAllPoints()
                    tooltip:SetPoint("TOPLEFT", taskLabel.frame, "BOTTOMLEFT")
                    if (d.note ~= nil) then
                        tooltip:AddLine(d.note .. "\n")
                    end
                    tooltip:AddLine("by " .. d.manager)
                    tooltip:Show();
                end
            end);
            taskLabel:SetCallback("OnLeave", function()
                if (tooltip ~= nil) then
                    tooltip:Hide()
                end
            end);

            if (taskIcon ~= nil) then
                taskIcon:SetHeight(20)
                taskIcon:SetWidth(30)
                group:AddChild(taskIcon)
            end

            taskLabel:SetHeight(20)
            taskLabel:SetWidth(150)
            group:AddChild(taskLabel)

            if (targetIcon ~= nil) then
                targetIcon:SetHeight(20)
                targetIcon:SetWidth(30)
                group:AddChild(targetIcon)
            end

            targetLabel:SetHeight(20)
            targetLabel:SetWidth(120)
            group:AddChild(targetLabel)

            if (not d.confirmed) then
                local btnConfirm = AceGUI:Create("ConfirmButton")
                btnConfirm:SetCallback(
                        "OnClick",
                        function()
                            local duty, idx = DMUtils:searchDutyById(d.id, MyDuties)
                            if (duty ~= nil) then
                                MyDuties[idx].confirmed = true
                            end
                            DMComm:SetConfirmation(d, true)

                            DutyManager:refresh(MyDuties)
                        end
                )
                group:AddChild(btnConfirm)

                btnConfirm:ClearAllPoints();
                btnConfirm:SetPoint("RIGHT", group.frame, "RIGHT", 0, 0)
            end

            taskLabel:ClearAllPoints();
            if (taskIcon ~= nil) then
                taskLabel:SetPoint("LEFT", taskIcon.frame, "RIGHT")
            else
                taskLabel:SetPoint("LEFT", group.frame, "RIGHT")
            end

            targetLabel:ClearAllPoints();
            if (targetIcon ~= nil) then
                targetLabel:SetPoint("LEFT", targetIcon.frame, "RIGHT")
            end

            group:SetHeight(20)

            DutyManager.var.frame:AddChild(group)
        end
    end
end

function DutyManager:show(duties)
    if (not DutyManager.var.shown) then
        local frame = AceGUI:Create("DutyFrame")
        frame:SetWidth(410)
        frame:SetHeight(35)
        frame:SetLayout("Flow");
        frame:SetCallback("OnClose", function() DutyManager:hide() end)
        DutyManager:RawHookScript(frame.frame, "OnHide",
                function(f)
                    local point, relativeTo, relativePoint, x, y = frame:GetPoint()
                    DMSettings.position = {
                        point = point,
                        relativePoint = relativePoint,
                        x = x,
                        y = y,
                    };
                    self.hooks[f].OnHide(f)
                end
        )

        DutyManager:RawHookScript(frame.frame, "OnDragStop",
                function(f)
                    local point, relativeTo, relativePoint, x, y = frame:GetPoint()
                    DMSettings.position = {
                        point = point,
                        relativePoint = relativePoint,
                        x = x,
                        y = y,
                    };
                    self.hooks[f].OnDragStop(f)
                end
        )

        frame:SetCallback(
                "OnMinimizeClick",
                function()
                    DutyManager.var.minimized = not DutyManager.var.minimized
                    DutyManager:refresh(MyDuties)
                end
        )

        frame:SetMinimized(DutyManager.var.minimized)

        DutyManager.var.frame = frame

        DutyManager:fillDuties(duties)

        DutyManager:PositionFrame()
        frame:Show()

        DutyManager.var.shown = true
    end
end

function DutyManager:hide()
    if (DutyManager.var.shown) then
        local widget = DutyManager.var.frame
        if (widget ~= nil) then
            AceGUI:Release(widget)
            DutyManager:Unhook(widget.frame, "OnHide")
            DutyManager:Unhook(widget.frame, "OnDragStop")
            DutyManager.var = {
                shown = false,
                frame = nil,
                minimized = DutyManager.var.minimized
            };
        end
    end
end

function DutyManager:refresh(duties)
    DutyManager:hide()
    if (duties ~= nil and #duties > 0) then
        DutyManager:show(duties)
    end
end

function DutyManager:PositionFrame()
    if (DutyManager.var.frame ~= nil) then
        DutyManager.var.frame:ClearAllPoints()

        if (DMSettings.position ~= nil) then
            DutyManager.var.frame:SetPoint(
                    DMSettings.position.point,
                    "UIParent",
                    DMSettings.position.relativePoint,
                    DMSettings.position.x,
                    DMSettings.position.y
            );
        else
            DutyManager.var.frame:SetPoint("RIGHT", "UIParent", "RIGHT", 0, 0);
        end
    end
end