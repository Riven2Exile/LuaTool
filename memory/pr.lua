function go_pr(root)
	print("=====================start=======================")
	local all_tables = {}
	local f = io.open("D:/lua_memory_"..os.time()..".txt", "w");
	if type(root) == "table" then
		pr(root, f, 1, all_tables);
	end


	f:write("------------- over ------------\r\n");
	f:flush();
	f:close(f);
end

function pr(root, f, deep, all_tables)
	if deep >= 50 then
		f:write("层数高于"..deep)
		return 
	end
	for i, v in pairs(root) do
		if "table" == type(v) then

			--print(string.format("%s key:%s type:%s", string.rep("-",deep), tostring(i), type(v) ))
			f:write(string.format("%s key:%s type:%s\r\n", string.rep("-",deep), tostring(i), type(v)) )
			if all_tables[v] ~= nil then
				--print("已经存在这个表了!!");
			else
				all_tables[v] = 1;
				pr(v, f, deep+1, all_tables);
			end
			
		elseif "number" == type(v) or "string" == type(v) then
			--print(string.format("%s key:%s type:%s value:%s", string.rep("-",deep), tostring(i), type(v), tostring(v)))
			f:write(string.format("%s key:%s type:%s value:%s\r\n", string.rep("-",deep), tostring(i), type(v), tostring(v)) )
		elseif "function" == type(v) then
			--print(string.format("%s key:%s type:%s value:%s", string.rep("-",deep), tostring(i), type(v), tostring(v)))
			f:write(string.format("%s key:%s type:%s value:%s\r\n", string.rep("-",deep), tostring(i), type(v), tostring(v)) )

			local tt = debug.getinfo(v)
			if tt.nups > 0 then
				for index = 1, tt.nups do
					local strUpName, cUpValue = debug.getupvalue(v, index)
					local strUpValueType = type(cUpValue)

					if strUpValueType ~= nil and strUpName ~= nil then
					      
						if strUpValueType == "table" then
							--print(string.format("%s index:%s type:%s var_name:%s", string.rep("-",deep+1), tostring(index), strUpValueType, strUpName ))
							f:write(string.format("%s index:%s type:%s var_name:%s\r\n", string.rep("-",deep+1), tostring(index), strUpValueType, strUpName ))

							if all_tables[cUpValue] ~= nil then
								--已经存在
							else
								all_tables[cUpValue] = 1;
								pr(cUpValue, f, deep+1, all_tables);
							end

							
					    else
					    	--print(  string.format("%s index:%s type:%s var_name:%s value:%s", string.rep("-",deep+1), tostring(index), strUpValueType, strUpName, tostring(cUpValue)  ))
					    	f:write( string.format("%s index:%s type:%s var_name:%s value:%s\r\n", string.rep("-",deep+1), tostring(index), strUpValueType, strUpName, tostring(cUpValue)  ))
					    end
					end
					
				end
				
			end

		else
			--print(string.format("%s key:%s type:%s value:%s", string.rep("-",deep), tostring(i), type(v), tostring(v)))
			f:write(string.format("%s key:%s type:%s value:%s\r\n", string.rep("-",deep), tostring(i), type(v), tostring(v)) )
		end
	end
end





-- function test()
-- 	local upppppp = {}
-- 	local uuuuuuuuuuuu = {}
-- 	function te()
-- 		upppppp = 1;
-- 		uuuuuuuuuuuu[2] = "abc";
-- 		uuuuuuuuuuuu[1] = 1;
-- 		uuuuuuuuuuuu[3] = {"istable"};
-- 		local t = _G;
-- 		t = debug.getregistry()
-- 		go_pr(t) 
-- 	end

-- 	return te();
-- end


-- test()