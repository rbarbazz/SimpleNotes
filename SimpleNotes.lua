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
