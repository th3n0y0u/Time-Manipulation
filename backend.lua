local tool = script.Parent
local char
local humanoid
local animator
local runservice = game:GetService("RunService")
local events = tool:WaitForChild("Events")
local values = tool:WaitForChild("Settings")
local animation = tool:WaitForChild("Animations")
local lightning = game:GetService("Lighting")
local timestoptime = values:WaitForChild("Timestop")
local timeerasetime = values:WaitForChild("Timeerase")
local timeaccerlerationtime = values:WaitForChild("Timeaccerleration")
local TimeErase = events:WaitForChild("Timeerase")
local TimeStop = events:WaitForChild("Timestop")
local TimeAcceleration = events:WaitForChild("Timeacceleration")

local animations = {
	animation.TimeAcceleration,
	animation.TimeErase,
	animation.TimeStop
}

local loadedanimations
local equipped = false

local function stoptime(player) 
	
	if equipped == true then
		if game.ReplicatedStorage.TimeStop.Value == false then
			game.ReplicatedStorage.TimeStop.Value = true 
			local function stoptimesound1()
				local sound = Instance.new("Sound", tool)
				sound.SoundId = "rbxassetid://5535518052"
				sound.Volume = 1
				sound.PlaybackSpeed = 1
				sound:Play()
				coroutine.resume(coroutine.create(function()
					wait(sound.TimeLength) 
					sound:Destroy()
				end))
			end
			
			local function stoptimesound2()
				local sound = Instance.new("Sound", tool)
				sound.SoundId = "rbxassetid://6945516179"
				sound.Volume = 1
				sound.PlaybackSpeed = 1
				sound:Play()
				coroutine.resume(coroutine.create(function()
					wait(sound.TimeLength)
					sound:Destroy()
				end))
			end 
		 
			local function anchorchildren(object) 
				for _,v in pairs(object:GetChildren()) do
				if v:IsA("Part") then
					if v.Parent ~= tool.Parent or v.Parent ~= tool then 
						v.Anchored = true
					end
			    end
					anchorchildren(v)
			    end
			end
			
			anchorchildren(game.Workspace) 
			stoptimesound1()
			tool.Parent.HumanoidRootPart.Anchored = false
			tool.Handle.Anchored = false
			game.Lighting.Ambient = Color3.new(0, 0, 0.498039)
			game.Lighting.OutdoorAmbient = Color3.new(0, 0, 0.498039)
			
			for i, v in pairs(game.Players:GetChildren()) do
				if v ~= player then
					local health = v.Character.Humanoid.Health
					local damagetakenduringtimestop = 0
					local timer = timestoptime.Value
					
					local clone = script.Reset:Clone()
					v.Character.Humanoid.WalkSpeed = 0
					v.Character.Humanoid.JumpPower = 0
					v.Character.Humanoid:UnequipTools()
					clone.Parent = v.PlayerGui
					clone.Disabled = false 			
					
					while timer > 0 do 
						
						local function check(item)
							if item:IsA("Tool") then
								v.Character.Humanoid.Health -= 1
								item.Parent = game.Players:GetPlayerFromCharacter(item.Parent).Backpack 
							end
						end
						
						local function change(value)
							damagetakenduringtimestop += health - v.Character.Humanoid.Health
							v.Character.Humanoid.Health = health
							clone:Destroy()
						end 
						
						if timer <= 0 then
							v.Character.Humanoid.WalkSpeed = 16 
							v.Character.Humanoid:TakeDamage(damagetakenduringtimestop / 4)  
							
							for i, v in pairs(v.Character:GetChildren()) do
								if v:IsA("MeshPart") then
									v.Anchored = false
								end
							end 
							
						end 
						
						v.Character.ChildAdded:Connect(check)
						v.Character.Humanoid.Health.Changed:Connect(change)
						timer -= 1
						wait(1)
						
					end
				end
			end
			
			tool.Parent.Humanoid:UnequipTools()
			local function unanchorchildren(object) 
				for _,v in pairs(object:GetChildren()) do
					if v:IsA("Part") then
						if v.Parent.Parent ~= game.Workspace.WeaponLineUp or v.Parent:IsA("Tool") then
							if v ~= game.Workspace.SpawnLocation then
								if v:IsA("Model") then
									v.Anchored = false 
								end
							end
						end
					end
					unanchorchildren(v)
				end
			end
			unanchorchildren(game.Workspace) 
			stoptimesound2() 
			game.Lighting.Ambient = Color3.new(0.27451, 0.27451, 0.27451)
			game.Lighting.OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451) 
			wait(timestoptime.Value + 20)
			game.ReplicatedStorage.TimeStop.Value = false
		end
	end
end

local function erasetime(player)
	if equipped == true then
		if game.ReplicatedStorage.TimeErase.Value == false then
			game.ReplicatedStorage.TimeErase.Value = true
			local function erasetimesound1()
				local sound = Instance.new("Sound", tool)
				sound.SoundId = "rbxassetid://5779100644"
				sound.Volume = 1
				sound.PlaybackSpeed = 1
				sound:Play()
				coroutine.resume(coroutine.create(function()
					wait(sound.TimeLength) 
					sound:Destroy()
				end))
			end
			
			local function erasetimesound2()
				local sound = Instance.new("Sound", tool)
				sound.SoundId = "rbxassetid://3373991228" 
				sound.Volume = 1
				sound.PlaybackSpeed = 1
				sound:Play()
				coroutine.resume(coroutine.create(function()
					wait(sound.TimeLength) 
					sound:Destroy()
				end))
			end
			
			erasetimesound1() 
			game.Lighting.Ambient = Color3.new(1, 0, 0)
			game.Lighting.OutdoorAmbient = Color3.new(1, 0, 0)   
			local timer = timeerasetime.Value	
			local forcefield = Instance.new("ForceField")
			forcefield.Parent = player.Character.HumanoidRootPart
			
			for i, v in pairs(tool.Parent:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency = 1
					for i, decal in pairs(v:GetChildren()) do
						if decal:IsA("Decal") then
							decal.Transparency = 1
						end
					end
				elseif v:IsA("Accessory") then
					local value = Instance.new("ObjectValue")
					value.Name = "PlayerWhoOwns"
					value.Parent = v
					v.Parent = game.ServerStorage
					value.Value = player.Character
				end
			end
			
			for i, v in pairs(game.Players:GetChildren()) do
				if v ~= player then
					local secondsposition = v.Character.HumanoidRootPart.Position
					repeat
						
						local function check(item)
							if item:IsA("Tool") then
								item.Parent = game.Players:GetPlayerFromCharacter(item.Parent).Backpack
							end
						end
						
						local position = v.Character.HumanoidRootPart.Position
						
						local clone = game.ServerStorage.TimeErase:Clone()
						clone.HumanoidRootPart.CFrame = CFrame.new(position)
						clone.Parent = game.Workspace
						
						v.Character.ChildAdded:Connect(check)
						timer -= 1 
						wait(1)
					until timer <= 0 
					
					v.Character.HumanoidRootPart.CFrame = CFrame.new(secondsposition)
					forcefield:Destroy()
					for i, v in pairs(game.Workspace:GetChildren()) do
						if v.Name == "TimeErase" then
							v:Destroy()
						end
					end
				end
				
				game.Lighting.Ambient = Color3.new(0.27451, 0.27451, 0.27451)
				game.Lighting.OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451)  
			end
			
			for i, v in pairs(tool.Parent:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency = 0
					tool.Parent.HumanoidRootPart.Transparency = 1
					for i, decal in pairs(v:GetChildren()) do
						if decal:IsA("Decal") then
							decal.Transparency = 0
						end
					end
				end
			end
			
			for i, v in pairs(game.ServerStorage:GetChildren()) do
				if v:FindFirstChild("PlayerWhoOwns") then
					v.Parent = v.PlayerWhoOwns.Value
				end
			end
			wait(timeerasetime.Value + 20)
			game.ReplicatedStorage.TimeErase.Value = false 
		end 
	end
end

local function accerleratetime(player)
	if equipped == true then
		if game.ReplicatedStorage.TimeAcceleration.Value == false then
			game.ReplicatedStorage.TimeAcceleration.Value = true 
			local timer = 0
			
			local function timeaccelerationsound1()
				local sound = Instance.new("Sound", tool)
				sound.SoundId = "rbxassetid://5054637240" 
				sound.Volume = 1
				sound.PlaybackSpeed = 1
				sound:Play()
				coroutine.resume(coroutine.create(function()
					wait(sound.TimeLength) 
					sound:Destroy()
				end))
			end
			
			timeaccelerationsound1()
			for v = 1, 3 do
				local object
				
				if v == 1 then
					object = player.Character.RightUpperArm
				elseif v == 2 then
					object = player.Character.LeftUpperArm
				else
					object = player.Character.HumanoidRootPart
				end
				 
				local attachment1 = Instance.new("Attachment")
				local attachment2 = Instance.new("Attachment")
				local trail = Instance.new("Trail") 
				attachment1.Parent = object
				attachment2.Parent = object
				trail.Parent = object
				trail.Attachment0 = attachment1
				trail.Attachment1 = attachment2
				attachment1.Position = Vector3.new(0, 2, 0)
				attachment2.Position = Vector3.new(0, -2, 0)
			end
			
			repeat 
				local timeofday = tostring(timer)..":".."00"..":".."00"
				player.Character.Humanoid.WalkSpeed = 16 + timer
				game.Lighting.TimeOfDay = timeofday
				timer += 1
				wait(1 / 5)
			until timer >= timeaccerlerationtime.Value * 5
			
			player.Character.Humanoid.WalkSpeed = 16
			game.Lighting.TimeOfDay = "14:30:00"
			for v = 1, 3 do
				local object
				
				if v == 1 then
					object = player.Character.RightUpperArm
				elseif v == 2 then
					object = player.Character.LeftUpperArm
				else
					object = player.Character.HumanoidRootPart
				end
				
				for i, v in pairs(object:GetChildren()) do
					if v:IsA("Attachment") or v:IsA("Trail") then
						v:Destroy()
					end
				end
			end
			
			wait(timeaccerlerationtime.Value + 20)
			game.ReplicatedStorage.TimeAcceleration.Value = false
		end
	end
end

local function death()
	local function one()
		tool.Parent.Humanoid:UnequipTools()
		local function unanchorchildren(object) 
			for _,v in pairs(object:GetChildren()) do
				if v:IsA("Part") then
					if (v.Parent:IsA("Model") and v.Parent.Parent ~= game.Workspace.WeaponLineUp) or v.Parent:IsA("Tool") then
						if v ~= game.Workspace.SpawnLocation then
							v.Anchored = false 
						end
					end
				end
				unanchorchildren(v)
			end
		end
		unanchorchildren(game.Workspace) 
		game.Lighting.Ambient = Color3.new(0.27451, 0.27451, 0.27451)
		game.Lighting.OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451)  
		game.ReplicatedStorage.TimeStop.Value = false
	end

	local function two()
		tool.Parent.Humanoid.WalkSpeed = 16
		game.Lighting.TimeOfDay = "14:30:00"
		for v = 1, 3 do
			local object

			if v == 1 then
				object = tool.Parent.RightUpperArm
			elseif v == 2 then
				object = tool.Parent.LeftUpperArm
			else
				object = tool.Parent.HumanoidRootPart
			end

			for i, v in pairs(object:GetChildren()) do
				if v:IsA("Attachment") or v:IsA("Trail") then
					v:Destroy()
				end
			end
		end
		game.ReplicatedStorage.TimeAcceleration.Value = false
	end

	local function three()
		for i, v in pairs(tool.Parent:GetChildren()) do
			if v:IsA("BasePart") then
				v.Transparency = 0
				tool.Parent.HumanoidRootPart.Transparency = 1
				for i, decal in pairs(v:GetChildren()) do
					if decal:IsA("Decal") then
						decal.Transparency = 0
					end
				end
			end
		end

		for i, v in pairs(game.ServerStorage:GetChildren()) do
			if v:FindFirstChild("PlayerWhoOwns") then
				v.Parent = v.PlayerWhoOwns.Value
			end
		end 
		game.ReplicatedStorage.TimeErase.Value = false   
	end

	one()
	two()
	three() 
end

local function equip()
	if equipped == false then
		equipped = true
		char = tool.Parent
	end
end

local function unequip()
	if equipped == true then
		equipped = false
		char = tool.Parent.Parent.Character
	end 
end 

TimeStop.OnServerEvent:Connect(stoptime)
TimeErase.OnServerEvent:Connect(erasetime)
TimeAcceleration.OnServerEvent:Connect(accerleratetime)
tool.Equipped:Connect(equip)
tool.Unequipped:Connect(unequip)
if char then
	char.Humanoid.Died:Connect(death)
	humanoid = char.Humanoid
	animator = humanoid.Animator
	loadedanimations = {
		animator:LoadAnimation(animations[1]),
		animator:LoadAnimation(animations[2]),
		animator:LoadAnimation(animations[3])
	}
end
