---@diagnostic disable: lowercase-global

log = log or require("loglua")

---@param PSM PudimStructureMapperLib
---@return any|nil
return function (PSM)
	local TESTLOG = log.inSection("Pudim Structures Mapper Tests")

	-- Helper para assertions
	local function assert_equal(actual, expected, msg)
		if actual ~= expected then
			error(string.format("%s: esperado '%s', recebido '%s'", msg or "Assertion falhou", tostring(expected), tostring(actual)))
		end
	end

	local function assert_true(condition, msg)
		if not condition then
			error(msg or "Assertion falhou: esperado true")
		end
	end




	-- Test 1: InnerCreateCalda
	TESTLOG("Test 1: InnerCreateCalda deve criar item calda válido")
	
	local calda = PSM.Structure.InnerCreateCalda("meuItem", "string", {"label1", "label2"})
	assert_equal(calda.__type, "calda", "Tipo deve ser 'calda'")
	assert_equal(calda.name, "meuItem", "Nome deve ser 'meuItem'")
	assert_equal(calda.type, "string", "Type deve ser 'string'")
	assert_equal(#calda.labels, 2, "Deve ter 2 labels")
	
	TESTLOG("✓ InnerCreateCalda funcionando corretamente")




	-- Test 2: IsCalda detecta caldas
	TESTLOG("Test 2: IsCalda deve detectar itens calda")
	
	local is_calda, tipo = PSM.Structure.IsCalda(calda)
	assert_true(is_calda, "Deve retornar true para item calda")
	assert_equal(tipo, "calda", "Tipo deve ser 'calda'")
	
	
	local not_calda, tipo2 = PSM.Structure.IsCalda({foo = "bar"})
	assert_true(not not_calda, "Deve retornar false para tabela comum")
	assert_equal(tipo2, "table", "Tipo deve ser 'table'")
	TESTLOG("✓ IsCalda funcionando corretamente")

	

	
	
	-- Test 3: Create com scheme simples
	TESTLOG("Test 3: Create deve processar scheme simples")
	
	local scheme1 = {
		item1 = PSM.Structure.InnerCreateCalda("campo1", "number", {}),
		item2 = PSM.Structure.InnerCreateCalda("campo2", "string", {"required"}),
	}
	local stru1 = PSM.Structure:Create(scheme1)
	assert_true(stru1.item1 ~= nil, "item1 deve existir")
	assert_equal(stru1.item1.__type, "calda", "item1 deve ser calda")
	assert_true(stru1.item2 ~= nil, "item2 deve existir")
	
	TESTLOG("✓ Create com scheme simples funcionando")

	
	
	
	
	-- Test 4: Create com scheme aninhado (recursão)
	TESTLOG("Test 4: Create deve processar scheme aninhado recursivamente")
	
	local scheme2 = {
		root = PSM.Structure.InnerCreateCalda("root", "object", {}),
		nested = {
			child1 = PSM.Structure.InnerCreateCalda("child1", "string", {}),
			child2 = PSM.Structure.InnerCreateCalda("child2", "number", {}),
		}
	}
	local stru2 = PSM.Structure:Create(scheme2)
	assert_true(stru2.root ~= nil, "root deve existir")
	assert_true(stru2.nested ~= nil, "nested deve existir")
	assert_true(type(stru2.nested) == "table", "nested deve ser table")
	assert_true(stru2.nested.child1 ~= nil, "child1 deve existir em nested")
	assert_equal(stru2.nested.child1.name, "child1", "child1 deve ter nome correto")

	TESTLOG("✓ Create com recursão funcionando")

	
	
	-- Test 5: Create ignora valores não-calda e não-table
	TESTLOG("Test 5: Create deve ignorar valores primitivos")
	
	local scheme3 = {
		valid = PSM.Structure.InnerCreateCalda("valid", "string", {}),
		invalid_string = "apenas string",
		invalid_number = 42,
	}
	local stru3 = PSM.Structure:Create(scheme3)
	assert_true(stru3.valid ~= nil, "valid deve existir")
	assert_true(stru3.invalid_string == nil, "invalid_string deve ser nil")
	assert_true(stru3.invalid_number == nil, "invalid_number deve ser nil")
	
	TESTLOG("✓ Create filtra valores inválidos corretamente")



	
	TESTLOG("\n✅ Todos os testes passaram com sucesso!")
end