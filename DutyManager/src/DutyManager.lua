DutyManager = LibStub("AceAddon-3.0"):NewAddon("DutyManager", "AceEvent-3.0", "AceHook-3.0")
AceGUI = LibStub("AceGUI-3.0")

DutyManager.var = {
    shown=false,
    frame=nil,
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

    DutyManager:consolidate()
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

function DutyManager:consolidate()
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

    for _, d in ipairs(duties) do
        local group = AceGUI:Create("SimpleGroup")
        group:SetRelativeWidth(1)
        group:SetLayout("Flow")

        local taskLabel = AceGUI:Create("InteractiveLabel")
        taskLabel:SetText(d.task)

        local targetLabel = AceGUI:Create("Label")
        targetLabel:SetText(d.target)
        if (d.icon ~= nil) then
            targetLabel:SetImage(d.icon)
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

        group:AddChild(taskLabel)
        group:AddChild(targetLabel)

        if (not d.confirmed) then
            local btnConfirm = AceGUI:Create("Button")
            btnConfirm:SetText("ok")
            btnConfirm:SetWidth(100)
            btnConfirm:SetHeight(30)
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
        end

        DutyManager.var.frame:AddChild(group)
    end
end

function DutyManager:show(duties)
    if (not DutyManager.var.shown) then
        local frame = AceGUI:Create("Frame")
        frame:SetTitle("duties")
        frame:SetWidth(600)
        frame:SetHeight(500)
        frame:SetLayout("Flow");
        frame:SetCallback("OnClose", function() DutyManager:hide() end)
        frame:EnableResize(false);
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
        frame.frame:SetFrameStrata("DIALOG")

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
            DutyManager.var = {
                shown = false,
                frame = nil,
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