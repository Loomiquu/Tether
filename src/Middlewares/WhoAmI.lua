local RunService = game:GetService("RunService")

return function(): "Client" | "Server" | "Undefined"
	return if RunService:IsClient() then "Client" elseif RunService:IsServer() then "Server" else "Undefined"
end
