local dkjson = require "dkjson"

local directory = {}
local addonLocation = "."

function basename(path)
    return path:match("^.+/(.+)$")
end

print("> Addons found:")

-- Loops over all addons JSON files and adds them to the directory.
local files = io.popen(string.format("ls %s/*.json", addonLocation))
for file in files:lines() do
    local filename = basename(file)
    if not filename:match("_directory.json") then

        local f = io.open(file, "r")
        local content = f:read("*all")
        f:close()

        local addon = dkjson.decode(content)
        table.insert(directory, addon)
        
        print("", addon.name, "v" .. addon.gameVersionCompatibility[1], file)
    end
end

-- Writes the directory to a JSON file `_directory.json`.
local jsonString = dkjson.encode(directory, { indent = true })
local file = io.open("./_directory.json", "w")
file:write(jsonString)
file:close()

print("> Writing to `_directory.json` finished.")
