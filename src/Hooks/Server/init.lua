local ReplicatedStorage = game:GetService("ReplicatedStorage")

return function(Service, Name)
	local SignalFolder = ReplicatedStorage:FindFirstChild(`TetherSignal<{Service.Name}>`)

	if SignalFolder == nil then
		SignalFolder = Instance.new("Folder")
		SignalFolder.Parent = ReplicatedStorage
		SignalFolder.Name = `TetherStorage<{Service.Name}>`
	end

	if SignalFolder:FindFirstChild(Name) ~= nil then
		error("Hooks cannot have the same name")
	end

	local Signal = Instance.new("RemoteEvent")
	Signal.Name = Name
	Signal.Parent = SignalFolder
end
