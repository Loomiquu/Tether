return function(Client: Player | "All" | { Player }, ...: any)
	if type(Client) == "string" then
		print("All Players, Package: ", ...)
		return
	elseif type(Client) == "table" then
		print(Client)
		print("Package: ", ...)
		return
	end

	print(`{Client.Name}, Package: `, ...)
end
