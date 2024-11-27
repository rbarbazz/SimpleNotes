local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "SimpleNotes" then
        if CharacterNotes == nil then
            CharacterNotes = ""
        end
    end
end)
