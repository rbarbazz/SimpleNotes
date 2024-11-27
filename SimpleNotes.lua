local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event, addon_name)
    if event == "ADDON_LOADED" and addon_name == "SimpleNotes" then
        if CharacterNotes == nil then
            CharacterNotes = ""
        end
    end
end)
