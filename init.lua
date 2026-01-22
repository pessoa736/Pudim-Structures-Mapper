---@diagnostic disable: missing-fields, undefined-field

if not _G.log then _G.log = require("loglua") end 
local u = require("utils")




u.loadEnvFile()

---@type boolean
TESTS = TESTS or false
DEBUG = DEBUG or false


---@class PudimStructureMapperLib: table
---@field Structure StructureLib
---@field Scaner any
---@field Transform any
---@field Return any
---@field Cache any

---@type PudimStructureMapperLib
local PSM = {}

PSM.Structure = require("Structure") or {}
PSM.Scaner = require("Scaner") or {}
PSM.Transform = require("Transform") or {}
PSM.Return = require("Return") or {}
PSM.Cache = require("Cache") or {}


if TESTS then
    require("test")(PSM)
    log.show()
end

return PSM