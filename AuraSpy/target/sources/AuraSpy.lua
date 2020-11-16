AuraSpy = LibStub("AceAddon-3.0"):NewAddon("AuraSpy", "AceEvent-3.0", "AceHook-3.0", "AceConsole-3.0")
AceGUI = LibStub("AceGUI-3.0")

function AuraSpy:OnInitialize()
    if not AuraReports then AuraReports = {} end;
    if not AuraSpy.var then AuraSpy.var = {} end;

    print("AuraSpy initialized")
end

function AuraSpy:OnEnable()
    AuraSpy:RegisterChatCommand("kgb", "OnCommand")

    AuraSpy:CreateCopyFrame()
    --AuraSpy:RegisterEvent("GROUP_ROSTER_UPDATE", "onRosterUpdate")
end

function AuraSpy:OnDisable()
    AuraSpy:UnregisterChatCommand("kgb")
    --AuraSpy:UnregisterEvent("GROUP_ROSTER_UPDATE")
end

function mysplit (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function AuraSpy:OnCommand(params)
    local p = mysplit(params, " ")

    if (p[1] == "spy") then
        local players = AuraSpyUtils:spy()
        if (players ~= nil) then
            players.name = p[2]
            AuraReports[#AuraReports + 1] = players
            print("Spied " .. #players .. " commrades")
        end
    elseif (p[1] == "clear") then
        AuraReports = {}
        print("cleared")
    elseif (p[1] == "export") then
        local json = AuraSpyJson.stringify(AuraReports[1], false)
        AuraSpy:OpenEditor(json)
    else
        local consumables, enchants = AuraSpyUtils:spyPlayer(p[1], UnitClass(p[1]))
        print(AuraSpyUtils:dump(consumables));
        print(AuraSpyUtils:dump(enchants));
    end
end

function AuraSpy:OpenEditor(text)
    print("opening")
    if (AuraSpy.var and AuraSpy.var.editBox) then
        print("ok")
        AuraSpy.var.editBox:Insert(text)
        AuraSpy.var.editFrame:Show()
        AuraSpy.var.editBox:HighlightText()
        AuraSpy.var.editBox:SetFocus()
        print("done")
    end
end

function AuraSpy:CloseEditor()
    if (AuraSpy.var and AuraSpy.var.editBox) then
        AuraSpy.var.editBox:SetText("")
        AuraSpy.var.editBox:ClearFocus()
        AuraSpy.var.editFrame:Hide()
    end
end

function AuraSpy:CreateCopyFrame()
    AuraSpy.var.editFrame = CreateFrame("ScrollFrame", "CopyContent", UIParent, "InputScrollFrameTemplate")
    AuraSpy.var.editBox = AuraSpy.var.editFrame.EditBox
    AuraSpy.var.btnClose = CreateFrame("Button", "ChatCopy", AuraSpy.var.editFrame, "UIPanelButtonTemplate")

    -- setup edit box
    AuraSpy.var.editFrame:SetPoint("CENTER")
    AuraSpy.var.editFrame:SetSize(500, 300)
    AuraSpy.var.editFrame.CharCount:Hide()
    --editBox:SetFontObject("ChatFontNormal")
    AuraSpy.var.editBox:SetFont("Fonts\\ARIALN.ttf", 13)
    AuraSpy.var.editBox:SetWidth(AuraSpy.var.editFrame:GetWidth()) -- multiline editboxes need a width declared!!
    AuraSpy.var.editBox:SetScript("OnEscapePressed", function(self)
        AuraSpy:CloseEditor()
    end)
    AuraSpy.var.editBox:SetAllPoints()
    AuraSpy.var.editFrame:Hide()

    -- setup edit box closing button
    AuraSpy.var.btnClose:SetPoint("TOPRIGHT")
    AuraSpy.var.btnClose:SetSize(15, 15)
    AuraSpy.var.btnClose:SetText("x")
    AuraSpy.var.btnClose:SetFrameStrata("FULLSCREEN")
    AuraSpy.var.btnClose:SetScript("OnClick", function(self)
        AuraSpy:CloseEditor()
    end)
end