return function(StrictTable: any)
	local Metatable = {}

	setmetatable(StrictTable, Metatable)

	function Metatable:__index()
		error(`{self.Name} is readonly`)
	end

	function Metatable:__tostring()
		return self.ClassName
	end

	return StrictTable
end
