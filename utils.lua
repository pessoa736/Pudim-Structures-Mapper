---@diagnostic disable: missing-fields, undefined-field, need-check-nil


if not _G.log then _G.log = require("loglua") end 
require "lua-string"


local u = {}


---@type fun(path: string): string?, boolean, string
function u.readFile(path)
    local file <const> = io.open(path, "r+")
    local content

    if file then 
        content = file:read("*a")
        file:close()
        return content, true, "success load"
    end
    return nil, false, "fail load"
end



function u.loadEnvFile()
    local env, ok, msg = u.readFile(".env")
    local LLE = log.inSection("load env")

    if ok  then
        env = env:trim("\n"):trim("\r") ---@diagnostic disable-line: param-type-mismatch
        for k, v in string.gmatch(env, "%s*(%w+)%s*=%s*(%w+)%s*") do
            _G[k] = v
        end
    end

    LLE.debug(msg, ".env")
end



return u