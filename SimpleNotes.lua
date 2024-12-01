-- Event Handlers
local simpleNotesFrame = CreateFrame("Frame")
simpleNotesFrame:RegisterEvent("ADDON_LOADED")

local function handleAddonLoaded(addonName)
    if addonName ~= "SimpleNotes" then
        return
    end

    if CharacterNotes == nil then
        CharacterNotes = ""
    end
end

simpleNotesFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        return handleAddonLoaded(arg1)
    end
end)

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

-- Slash Commands
SLASH_SIMPLENOTESSAVE1 = "/sns"
SLASH_SIMPLENOTESPRINT1 = "/snp"

SlashCmdList["SIMPLENOTESSAVE"] = saveNotes
SlashCmdList["SIMPLENOTESPRINT"] = printNotes
