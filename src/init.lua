--!strict
--!native
local Types = require(script.Types)

export type Service<T> = Types.Service<T>
export type Hook = Types.Hook
export type Middleware = Types.Middleware
export type Middlewares = Types.Middlewares
export type Tether = Types.Tether

return require(script.Strict)({
	Name = "Tether",
	ClassName = "Tether",

	Middlewares = require(script.Middlewares),
	CreateService = require(script.Services),
}) :: Tether
