-- Helper Functions
local function saveNotes(notes)
    CharacterNotes = notes
end

local function getNotes()
    return CharacterNotes or ""
end

local function printNotes()
    print(getNotes())
end


-- UI
local simpleNotesFrame = CreateFrame("Frame", "SimpleNotesFrame", UIParent, "BasicFrameTemplate")
simpleNotesFrame:SetSize(300, 200)
simpleNotesFrame:SetPoint("CENTER")
simpleNotesFrame:SetMovable(true)
simpleNotesFrame:EnableMouse(true)
simpleNotesFrame:RegisterForDrag("LeftButton")
simpleNotesFrame:Hide()

local function toggleFrame()
    if simpleNotesFrame:IsVisible() then
        simpleNotesFrame:Hide()
    else
        simpleNotesFrame:Show()
    end
end

-- Title
simpleNotesFrame.title = simpleNotesFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
simpleNotesFrame.title:SetPoint("LEFT", simpleNotesFrame.TitleBg, "LEFT", 5, 0)
simpleNotesFrame.title:SetText("Simple Notes")

-- Scroll Frame
local editBoxWidth = 282
simpleNotesFrame.scrollFrame = CreateFrame("ScrollFrame", "SimpleNotesScrollFrame", simpleNotesFrame,
    "InputScrollFrameTemplate")
simpleNotesFrame.scrollFrame:SetSize(editBoxWidth, 165)
simpleNotesFrame.scrollFrame:SetPoint("TOP", simpleNotesFrame, "TOP", -2, -28)
simpleNotesFrame.scrollFrame.CharCount:Hide()

-- Hide the scrollbar while allowing to scroll
simpleNotesFrame.scrollFrame.ScrollBar:SetAlpha(0)

-- Edit Box
simpleNotesFrame.notes = simpleNotesFrame.scrollFrame.EditBox
simpleNotesFrame.notes:SetMultiLine(true)
simpleNotesFrame.notes:SetAutoFocus(true)
simpleNotesFrame.notes:SetFontObject(ChatFontNormal)
simpleNotesFrame.notes:SetWidth(editBoxWidth)
simpleNotesFrame.notes:SetText(getNotes())


-- Slash Commands
SLASH_SIMPLENOTESSAVE1 = "/snsave"
SLASH_SIMPLENOTESPRINT1 = "/snprint"
SLASH_SIMPLENOTESTOGGLE1 = "/sn"

SlashCmdList["SIMPLENOTESSAVE"] = saveNotes
SlashCmdList["SIMPLENOTESPRINT"] = printNotes
SlashCmdList["SIMPLENOTESTOGGLE"] = toggleFrame


-- Event Handlers
local function handleAddonLoaded(addonName)
    if addonName ~= "SimpleNotes" then
        return
    end

    if CharacterNotes == nil then
        CharacterNotes = ""
    end

    simpleNotesFrame.notes:SetText(getNotes())
end

simpleNotesFrame:RegisterEvent("ADDON_LOADED")
simpleNotesFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        return handleAddonLoaded(arg1)
    end
end)

simpleNotesFrame:SetScript("OnDragStart", simpleNotesFrame.StartMoving)
simpleNotesFrame:SetScript("OnDragStop", simpleNotesFrame.StopMovingOrSizing)
simpleNotesFrame.notes:SetScript("OnUpdate", function()
    saveNotes(simpleNotesFrame.notes:GetText())
end)
