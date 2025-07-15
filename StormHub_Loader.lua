
-- StormHub Loader - By Darllan (Estilo kedd063)

local games = {
    [15744162557] = "https://raw.githubusercontent.com/Darllan10/Stormhub/main/KDML_GUI_IGUAL_O_VIDEO_Seguro.lua", -- Roubei um Brainrot
    -- [outroPlaceId] = "https://raw.githubusercontent.com/Darllan10/Stormhub/main/outro_script.lua",
}

local placeId = game.PlaceId

if games[placeId] then
    local success, result = pcall(function()
        loadstring(game:HttpGet(games[placeId]))()
    end)

    if not success then
        warn("❌ StormHub falhou ao carregar o script para este jogo.")
        warn(result)
    end
else
    warn("⚠️ StormHub: Este jogo não é suportado no momento.")
end
