
loadstring(game:HttpGet("https://raw.githubusercontent.com/mainstreamed/amongus-hook/refs/heads/main/drawingfix.lua", true))();

if not (game:IsLoaded() and getgenv().drawingLoaded) then
    repeat
        task.wait()
    until (game:IsLoaded() and getgenv().drawingLoaded)
end

do
    if getgenv().loaded then
        return
    end

 


   do 
    local base_url = "https://github.com/buhayhayahay332-lang/SkinChanger/main/Operation%20One" 

    local includes = {
        "sdk/memory.lua",
        "sdk/misc.lua",
        "core/attachment_editor.lua",
    }

    local inits = {}

    for _, file in next, includes do
        local url = base_url .. file
        print("[Includes] Fetching:", url)

        local ok, response = pcall(function()
            return game:HttpGet(url, true)
        end)

        if not ok or not response or response == "" then
            warn("[Includes] Failed to fetch:", file, "-", response or "nil / empty response")
            continue
        end

        local first8 = tostring(response):sub(1, 8)
        if first8:match("^%s*<") or response:find("404") or response:find("Not Found") then
            warn("[Includes] Bad response (probably HTML). Check URL or repo visibility:", url)
            warn("[Includes] response snippet:", tostring(response):sub(1, 200))
            continue
        end

        local chunk, loadErr = loadstring(response)
        if not chunk then
            warn("[Includes] Failed to compile:", file, "-", loadErr)
            continue
        end

        local success, result = pcall(chunk)
        if not success then
            warn("[Includes] Runtime error when executing:", file, "-", result)
            continue
        end

        if type(result) ~= "table" then
            warn("[Includes] Module did not return a table:", file)
            continue
        end

        for i, v in next, result do
            if i == "init" and type(v) == "function" then
                table.insert(inits, v)
            else
                rawset(getfenv(1), i, v)
            end
        end
    end

    for _, init in next, inits do
        local ok2, err2 = pcall(init)
        if not ok2 then
            warn("[Includes] init() error:", err2)
        end
    end
end

end

    do --// ui stuff
        local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
        local theme_manager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua"))()
        local save_manager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua"))()
        local window = library:CreateWindow({Title = "Test By NIGGA | Pid: " .. game.PlaceVersion, Center = true, AutoShow = true, TabPadding = 8, MenuFadeTime = 0.2});
        
        local _local = window:AddTab("Local") do
            local attachment_editor_groupbox = _local:AddLeftGroupbox("Attachment Editor") do

                attachment_editor_groupbox:AddDropdown('attachment_editor_skin', {Values = {"Default", "Golden", "Diamond", "Red", "Green", "Blue", "Halloween", "Yellow", "White", "SnowCamo", "Kalash", "Skulls", "OilSpill", "HazardSkin", "ForestCamo", "ClassicStuds", "DeepRed", "FrenchSticker", "Steyr", "DesertCamo", "Ghillie", "CarbonFiber", "Space"} , Default = 1, Multi = false, Text = 'Skin', Callback = function(Value)
                    attachment_editor_settings.skin = Value;
                end});
                attachment_editor_groupbox:AddDropdown('attachment_editor_scope', {Values = {"Default", "PSO", "PMII", "ACOG", "Specter", "TA44", "Kobra", "Micro", "XPS", "DeltaPoint", "Primer"} , Default = 1, Multi = false, Text = 'Scope', Callback = function(Value)
                    attachment_editor_settings.scope = Value;
                end});

                attachment_editor_groupbox:AddDropdown('attachment_editor_barrel', {Values = {"Default", "Compensator", "FlashHider", "MuzzleBrake", "Silencer"} , Default = 1, Multi = false, Text = 'Barrel', Callback = function(Value)
                    attachment_editor_settings.barrel = Value;
                end});

                attachment_editor_groupbox:AddDropdown('attachment_editor_charm', {Values = {"Default", "AceCard", "BlueBall", "BulletCharm", "ColorfulSquares", "DiamondCharm", "LoveHeart", "LuckyCharm"} , Default = 1, Multi = false, Text = 'Charm', Callback = function(Value)
                    attachment_editor_settings.charm = Value;
                end});

                attachment_editor_groupbox:AddDropdown('attachment_editor_mag', {Values = {"Default", "DrumAA12", "DrumSkorpion", "ExtendedMP7", "ExtendedSkorpion"} , Default = 1, Multi = false, Text = 'Mag', Callback = function(Value)
                    attachment_editor_settings.mag = Value;
                end});

                attachment_editor_groupbox:AddDropdown('attachment_editor_stock', {Values = {"Default", "SwitchGlock"} , Default = 1, Multi = false, Text = 'Stock', Callback = function(Value)
                    attachment_editor_settings.stock = Value;
                end});

                attachment_editor_groupbox:AddDropdown('attachment_editor_grip', {Values = {"Default", "AngledGrip", "Bipod", "BrazilianShield", "LaserPointer", "TacticalFlashlight", "ThumbGrip", "VerticalGrip"} , Default = 1, Multi = false, Text = 'Grip', Callback = function(Value)
                    attachment_editor_settings.grip = Value;
                end});

                attachment_editor_groupbox:AddButton({Text = 'Apply', DoubleClick = false, Func = function()
                    local function safe_apply(label, fn)
                        if type(fn) ~= "function" then
                            warn("[Attachment Editor] Missing function:", label);
                            return;
                        end;

                        local ok, err = pcall(fn);
                        if not ok then
                            warn("[Attachment Editor] Failed:", label, err);
                        end;
                    end

                    safe_apply("skin", set_skin);
                    safe_apply("scope", set_scope);
                    safe_apply("grip", set_grip);
                    safe_apply("stock", set_stock);
                    safe_apply("mag", set_mag);
                    safe_apply("charm", set_charm);
                    safe_apply("barrel", set_barrel);
                end});
            end;
        end;

        local ui_settings = window:AddTab("UI Settings") do
            theme_manager:SetLibrary(library);
            save_manager:SetLibrary(library);
            save_manager:IgnoreThemeSettings();
            theme_manager:SetFolder("KLUB");
            save_manager:SetFolder("KLUB/Operation One");
            save_manager:BuildConfigSection(ui_settings);
            theme_manager:ApplyToTab(ui_settings);
            save_manager:LoadAutoloadConfig();
            --replicated_storage:FindFirstChild("RemoteEvent"):FireServer('z', 5); --// anti admin
        end;
    end;

    getgenv().loaded = true;
end
