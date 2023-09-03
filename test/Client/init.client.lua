local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MoneyService = require(ReplicatedStorage:WaitForChild("Module"))

MoneyService.MoneySignal:FireServer(12)
