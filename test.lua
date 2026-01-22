
---@param PSM PudimStructureMapperLib
---@return any|nil
return function (PSM)
	local Root = PSM.Structure:CreateRootStructure()
	-- AddRegion deve ser chamado no Root (instância), não na lib
	Root:AddRegion("public")


    print()
end