export type TBA = nil --! Never use this type in production code

export type Service<T> = {
	Name: string,

	OnDispose: RBXScriptSignal,
	Dispose: (self: Service<T>, ...Middleware) -> nil,
	CreateHook: (self: Service<T>, Name: string, ...Middleware) -> Hook,

	__tostring: (self: Service<T>) -> string,
} & T

export type Hook = {
	Name: string,
	ClassName: string,

	BindEvent: (Name: string, Callback: (...any) -> nil) -> nil,
	UnbindEvent: (Name: string) -> nil,

	FireServer: (self: Hook, ...any) -> nil,
	FireClients: (self: Hook, Clients: Player | { Player } | "All", ...any) -> nil,
	FireClientsExcept: (self: Hook, Client: Player, ...any) -> nil,

	__tostring: (self: Hook) -> string,
}

export type Middleware = (...any?) -> nil
export type Middlewares = {
	WhoAmI: Middleware,
	HookLogger: Middleware,
}

export type Tether = {
	Name: string,
	ClassName: string,

	Middlewares: Middlewares,
	CreateService: <T>(ServiceName: string) -> Service<T>,

	__tostring: (self: Tether) -> string,
}

return {}
