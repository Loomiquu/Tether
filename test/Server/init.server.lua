local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MoneyService = require(ReplicatedStorage.Module)

MoneyService.MoneySignal:BindEvent("Added", function(Client, Money)
	MoneyService.MoneyHash[Client] = (MoneyService.MoneyHash[Client] or 0) + Money

	print(MoneyService.MoneyHash[Client])
end)
