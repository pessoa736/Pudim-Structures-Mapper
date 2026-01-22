---@diagnostic disable: missing-fields

---@class RootStructure: table
---@field __type string
---@field Path string
---@field childrens table
---@field __index StructureLib


---@alias labels string[]


---@class Components:table
---@field __type string
---@field __index RootStructure
---@field name string
---@field labels labels


---@class Regions: table
---@field __type string
---@field __index RootStructure
---@field name string
---@field path string
---@field labels labels
---@field childrens table<any, Regions|Components|nil>



---@class StructureLib:table
---@field __type string
---@field CreateRootStructure fun(Self: StructureLib, Path?: string): RootStructure
---@field AddRegion fun(Self: StructureLib, name?: string, label?: labels)



---@type StructureLib
local Stru = {}

function Stru:CreateRootStructure(Path)
    ---@type RootStructure
    local Root = {
        __type = "Root",
        Path = Path or debug.getinfo(1, "S").source:match("@(.*/)") or "./",
        childrens = {},
        __index = Stru,
    }

    return setmetatable(Root, Root)
end




---@cast Stru RootStructure|StructureLib
function Stru:AddRegion(name, labels)
    
    if self.__type == "lib" or self.__type == "Component" then 
        error("expected add a Region on RootStructure or other Region")
    end
    
    ---@type Regions
    local region = {
        name = name or #self.childrens .. "Region",
        labels = labels or {},
        path = "/"..name,
        __index = Stru,
        __type = "Region"
    }
    
    if self.__type == "Root" or self.__type == "Region" then
        self.childrens[name] = setmetatable(region, region)
    else 
        error("type not expected")
    end
end


return Stru