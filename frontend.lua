local userinputservice = game:GetService("UserInputService")
local debounce = false
local equipped = false
local tool = script.Parent
local events = tool:WaitForChild("Events")
local values = tool:WaitForChild("Settings") 
local timestoptime = values:WaitForChild("Timestop")
local timeerasetime = values:WaitForChild("Timeerase")
local timeaccerlerationtime = values:WaitForChild("Timeaccerleration")
local TimeErase = events:WaitForChild("Timeerase")
local TimeAcceleration = events:WaitForChild("Timeacceleration")
local TimeStop = events:WaitForChild("Timestop")
local gui1 = tool:WaitForChild("TimeacclerationGUI")
local gui2 = tool:WaitForChild("TimestopGUI")

userinputservice.InputBegan:Connect(function(input, gameprocessed)
	if input then
		if equipped == true then
			if debounce == false then
				if input.KeyCode == Enum.KeyCode.E then
					debounce = true
					TimeStop:FireServer()
					
					for i, v in pairs(game.Players:GetPlayers()) do
						if v then
							local clone = gui2:Clone()
							local timer = timestoptime.Value
							clone.Parent = v.PlayerGui
							
							repeat wait(1)
								clone.Bar.Size = UDim2.new(0, timer * 103 , 0, 20)
								timer -= 1
							until timer <= 0
							
							clone:Destroy()
						end
					end
					
					wait(timestoptime.Value + 40)
					debounce = false
				elseif input.KeyCode == Enum.KeyCode.R then
					debounce = true
					TimeAcceleration:FireServer()
					
					for i, v in pairs(game.Players:GetPlayers()) do
						if v then
							local clone = gui1:Clone()
							local timer = timeaccerlerationtime.Value
							clone.Parent = v.PlayerGui

							repeat wait(1)
								clone.Bar.Size = UDim2.new(0, timer * 15.5, 0, 20) 
								timer -= 1
							until timer <= 0
							
							clone:Destroy()
						end
					end
				
					wait(timeaccerlerationtime.Value + 40)
					debounce = false
				elseif input.KeyCode == Enum.KeyCode.T then 
					if game.ReplicatedStorage.TimeErase.Value == false then
						debounce = true
						TimeErase:FireServer()
						wait(timeerasetime.Value + 40)
						debounce = false
					end
				end
			end
		end
	end
end)

tool.Equipped:Connect(function()
	if equipped == false then
		equipped = true
	end
end)

tool.Unequipped:Connect(function()
	if equipped == true then
		equipped = false
	end
end)
