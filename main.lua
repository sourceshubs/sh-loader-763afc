--[[
    Sources Hub - Steal An Egg
    Discord: https://discord.gg/sourceshubs
]]

local url = "https://raw.githubusercontent.com/sourceshubs/sh-loader-763afc/main/source.lua"

local function notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = tostring(title or "Sources Hub"),
            Text = tostring(text or ""),
            Duration = 5,
        })
    end)
end

local ok, result = pcall(function()
    return game:HttpGet(url)
end)

if not ok or type(result) ~= "string" or #result < 100 then
    notify("Sources Hub", "Failed to download script. Check your executor / internet.")
    return
end

local loadOk, loadErr = pcall(function()
    local fn, err = loadstring(result)
    if not fn then
        error(err or "loadstring failed")
    end
    return fn()
end)

if not loadOk then
    notify("Sources Hub", "Script error: " .. tostring(loadErr))
    warn("[Sources Hub] " .. tostring(loadErr))
end
