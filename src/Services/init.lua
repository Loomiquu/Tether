local Types = require(script.Parent.Types)

local Service = {}
Service.__index = Service
Service.__tostring = function(self)
	return self.ClassName
end

local function MiddlewareRunner(Middlewares: { Types.Middleware }, DisposedItem: any)
	for _, Middleware in Middlewares do
		Middleware(DisposedItem)
	end
end

function Service:Dispose(...: Types.Middleware)
	local Middlewares = { ... }

	self._BindableEvent:Fire()

	for _, Hook in self._Hooks do
		Hook:_Dispose()
	end

	for Key, Value in self do
		if typeof(Value) == "Instance" then
			Value:Destroy()
		end

		if next(Middlewares) ~= nil then
			MiddlewareRunner(Middlewares, Value)
		end

		self[Key] = nil
	end
end

function Service:CreateHook(Name: string, ...: Types.Middleware)
	return require(script.Parent.Hooks)(self, Name, ...)
end

return function<T>(Name: string): Types.Service<T>
	local self = setmetatable({}, Service)
	self.ClassName = `Service<{Name}>`
	self.Name = Name

	self._Hooks = {}

	self._BindableEvent = Instance.new("BindableEvent")
	self.OnDisposed = self._BindableEvent.Event

	return self
end
