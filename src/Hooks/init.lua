local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Middlewares = require(script.Parent.Middlewares)

local Hooks = {}
Hooks.__index = Hooks
Hooks.__tostring = function(self)
	return self.ClassName
end

-- * Request Handlers

local function MiddlewareRunner(MiddlewareArray, ...)
	for _, Middleware in MiddlewareArray do
		Middleware(...)
	end
end

function Hooks:_HandleRequests()
	local EventName = `On{Middlewares.WhoAmI()}Event`

	self._Signal[EventName]:Connect(function(...)
		MiddlewareRunner(self._Middlewares, ...)

		for _, Function in self._BindedFunctions do
			Function(...)
		end
	end)
end

-- * Disposing Method

function Hooks:_Dispose()
	if self._Signal ~= nil then
		self._Signal.Parent:Destroy()
	end

	self = nil
end

-- * Function Binding methods

function Hooks:BindEvent(Name, Callback)
	self._BindedFunctions[Name] = Callback
end

function Hooks:UnbindEvent(Name)
	self:BindFunction(Name, nil)
end

-- * Hook Signal Methods

function Hooks:FireServer(...)
	if Middlewares.WhoAmI() == "Server" then
		error("Client sided functions cannot run on the server")
	end

	self._Signal:FireServer(...)
end

function Hooks:FireClients(Clients: Player | "All" | { Player }, ...)
	if Middlewares.WhoAmI() == "Client" then
		error("Server sided functions cannot run on the client")
	end

	if Clients == "All" then
		self._Signal:FireAllClients(...)
		return
	end

	if type(Clients) ~= "table" then
		self._Signal:FireClient(Clients, ...)
		return
	end

	for _, Client in Clients do
		self._Signal:FireClient(Client, ...)
	end
end

function Hooks:FireClientsExcept(Client: Player, ...)
	local Clients = Players:GetPlayers()

	for _, Player in Clients do
		if Player == Client then
			continue
		end

		self._Signal:FireClient(Player, ...)
	end
end

-- * Constructor

return function(Service, Name, ...)
	if Middlewares.WhoAmI() == "Server" then
		require(script.Server)(Service, Name)
	end

	local self = setmetatable({}, Hooks)
	self._Signal = ReplicatedStorage:WaitForChild(`TetherStorage<{Service.Name}>`)[Name]
	self._Middlewares = { ... }
	self._BindedFunctions = {}

	self.ClassName = "Hook"
	self.Name = Name

	self:_HandleRequests()

	Service._Hooks[`{Service.Name}|{Name}`] = self
	return self
end
