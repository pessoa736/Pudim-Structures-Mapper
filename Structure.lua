---@diagnostic disable: missing-fields

---@class SchemeItens 
---@field type string
---@field __type string
---@field name string
---@field labels string[]
---@field childrens SchemeItens[]

---@alias Scheme SchemeItens[]

---@class StructureLib:table
---@field __type string
---@field Create fun(Self: StructureLib, Scheme: Scheme): any
---@field InnerCreateCalda fun(name: string, type: string, labels: string[], childrens?: SchemeItens[]): SchemeItens
---@field IsCalda fun(data: table<any, any> ): boolean, string


---@type StructureLib
local StructureLib = {}


function StructureLib:Create(scheme)
    local Stru = {}
    
    for k, v in pairs(scheme) do 
        local Is, t = self.IsCalda(v)
        if Is then
            Stru[k] = v
        elseif t == "table" then
            Stru[k] = self:Create(v)
        else
            Stru[k] = nil
        end
    end

    return Stru
end

function StructureLib.InnerCreateCalda(name, type, labels, childrens)
    return {
        __type = "calda",
        name = name,
        type = type,
        labels = labels,
        childrens = childrens or {}
    }
end

function StructureLib.IsCalda(data)
    local td = type(data)
    if td == "table" then
        if data.__type == "calda" then
            return true, "calda"
        end
    end
    return false, td
end


return StructureLib