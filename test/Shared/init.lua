local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tether = require(ReplicatedStorage:WaitForChild("Tether"))

local MoneyService = Tether.CreateService("MoneyService")
MoneyService.MoneySignal = MoneyService:CreateHook("CashChangeEvent")
MoneyService.MoneyHash = {}

return MoneyService
