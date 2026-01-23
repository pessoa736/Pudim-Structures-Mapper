


---@param PSM PudimStructureMapperLib
---@return any|nil
return function (PSM)
	local TESTLOG = log.inSection("(PSM) Tests In Dev Sandbox").debug

	TESTLOG("Creation test Struture")

	local PSM_S = PSM.Structure

	local function Folder(name, labels, childrens) return PSM_S.InnerCreateCalda(name, "folder", labels, childrens) end
	local function File(name, labels) return PSM_S.InnerCreateCalda(name, "file", labels) end

	local Root = PSM_S:Create{
		Folder("photos", 
			{"photos", "pictures", "images"},
			{
				File(
					"foto minha", 
					{"eu"}
				)
			}
		),
		File("Random File.Js", {"Js"})
	}


end