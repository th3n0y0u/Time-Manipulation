local tool = script.Parent
local player = game.Players:GetPlayerFromCharacter(tool.Parent) or tool.Parent.Parent
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")
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

loadedanimations = {
	animator:LoadAnimation(animations[1]),
	animator:LoadAnimation(animations[2]),
	animator:LoadAnimation(animations[3])
} 
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
					if v.Parent ~= char and v.Parent ~= tool then 
						v.Anchored = true
					end
			    end
					anchorchildren(v)
			    end
			end
			
			stoptimesound1()
			local timer = timestoptime.Value
			tool.Parent.HumanoidRootPart.Anchored = false
			tool.Handle.Anchored = false
			game.Lighting.Ambient = Color3.new(0, 0, 0.498039)
			game.Lighting.OutdoorAmbient = Color3.new(0, 0, 0.498039)
			
			while timer > 0 and wait() do
				for i, v in pairs(game.Players:GetChildren()) do
					if v ~= player and v then
						if (player.Character.UpperTorso.Position - v.Character.UpperTorso.Position).Magnitude < 50 then 
							local char = v.Character or v.CharacterAdded:Wait()
							local hum = char:WaitForChild("Humanoid")
							local health = hum.Health
							
							local clone = script.Reset:Clone()
							v.Character.Humanoid.WalkSpeed = 0
							v.Character.Humanoid.JumpPower = 0
							v.Character.Humanoid:UnequipTools()
							clone.Parent = v.PlayerGui
							clone.Disabled = false 			
							
							local function check(item)
								if item:IsA("Tool") then
									v.Character.Humanoid.Health -= 1
									item.Parent = game.Players:GetPlayerFromCharacter(item.Parent).Backpack 
								end
							end
							
							if timer <= 1 then
								v.Character.Humanoid.WalkSpeed = 16 
								v.Character.Humanoid.JumpPower = 50
								
								for i, v in pairs(v.Character:GetChildren()) do
									if v:IsA("MeshPart") then
										v.Anchored = false
									end
								end 
								break
							end 
							
							anchorchildren(v.Character) 
							char.ChildAdded:Connect(check)
						else
							timer -= 1
							wait(1)  
						end
					end
				end
			end
			 
			humanoid:UnequipTools()

			local function remove()
				for i, v in pairs(game.Players:GetChildren()) do
					if v and v ~= player then
						v.Character.Humanoid.WalkSpeed = 16
						v.Character.Humanoid.JumpPower = 50
						local reset = v.PlayerGui:WaitForChild("Reset")
						reset:Destroy()
					end
				end
			end

			local function unanchorchildren(object) 
				for _,v in pairs(object:GetChildren()) do
					if v:IsA("Part") then
						if v.Parent:IsA("Tool") or v.Parent:IsA("Model") then
							if v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid") then
								v.Anchored = false 
							end
						end
					end
					unanchorchildren(v)
				end
			end

			remove()
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
						
						local head = v.Character:WaitForChild("Head")
						local humanoidrootpart = v.Character:WaitForChild("HumanoidRootPart")
						local uppertorso = v.Character:WaitForChild("UpperTorso")
						local lowertorso = v.Character:WaitForChild("LowerTorso")
						local rightupperarm = v.Character:WaitForChild("RightUpperArm")
						local rightlowerarm = v.Character:WaitForChild("RightLowerArm")
						local righthand = v.Character:WaitForChild("RightHand")
						local leftupperarm = v.Character:WaitForChild("LeftUpperArm")
						local leftlowerarm = v.Character:WaitForChild("LeftLowerArm")
						local lefthand = v.Character:WaitForChild("LeftHand")
						local rightupperleg = v.Character:WaitForChild("RightUpperLeg")
						local rightlowerleg = v.Character:WaitForChild("RightLowerLeg")
						local rightfoot = v.Character:WaitForChild("RightFoot")
						local leftupperleg = v.Character:WaitForChild("LeftUpperLeg")
						local leftlowerleg = v.Character:WaitForChild("LeftLowerLeg")
						local leftfoot = v.Character:WaitForChild("LeftFoot") 
						
						local function check(item)
							if item:IsA("Tool") then
								item.Parent = game.Players:GetPlayerFromCharacter(item.Parent).Backpack
							end
						end
						
						local position = v.Character.HumanoidRootPart.Position
						
						local clone = game.ServerStorage.TimeErase:Clone()
						clone.HumanoidRootPart.CFrame = CFrame.new(position)
						clone.Head.Orientation = head.Orientation + Vector3.new(-head.Orientation.X, head.Orientation.Y, -head.Orientation.Z) 
						clone.HumanoidRootPart.Orientation = humanoidrootpart.Orientation + Vector3.new(-humanoidrootpart.Orientation.X, humanoidrootpart.Orientation.Y, -humanoidrootpart.Orientation.Z)
						clone.UpperTorso.Orientation = uppertorso.Orientation + Vector3.new(-uppertorso.Orientation.X, uppertorso.Orientation.Y, -uppertorso.Orientation.Z) 
						clone.LowerTorso.Orientation = lowertorso.Orientation + Vector3.new(-lowertorso.Orientation.X, lowertorso.Orientation.Y, -lowertorso.Orientation.Z) 
						clone.RightUpperArm.Orientation = rightupperarm.Orientation + Vector3.new(-rightupperarm.Orientation.X, rightupperarm.Orientation.Y, -rightupperarm.Orientation.Z) 
						clone.RightLowerArm.Orientation = rightlowerarm.Orientation + Vector3.new(-rightlowerarm.Orientation.X, rightlowerarm.Orientation.Y, -rightlowerarm.Orientation.Z) 
						clone.RightHand.Orientation = righthand.Orientation + Vector3.new(-righthand.Orientation.X, righthand.Orientation.Y, -righthand.Orientation.Z) 
						clone.LeftUpperArm.Orientation = leftupperarm.Orientation + Vector3.new(-leftupperarm.Orientation.X, leftupperarm.Orientation.Y, -leftupperarm.Orientation.Z) 
						clone.LeftLowerArm.Orientation = leftlowerarm.Orientation + Vector3.new(-leftlowerarm.Orientation.X, leftlowerarm.Orientation.Y, -leftlowerarm.Orientation.Z) 
						clone.LeftHand.Orientation = lefthand.Orientation + Vector3.new(-lefthand.Orientation.X, lefthand.Orientation.Y, -lefthand.Orientation.Z) 
						clone.RightUpperLeg.Orientation = rightupperleg.Orientation + Vector3.new(-rightupperleg.Orientation.X, rightupperleg.Orientation.Y, -rightupperleg.Orientation.Z) 
						clone.RightLowerLeg.Orientation = rightlowerleg.Orientation + Vector3.new(-rightlowerleg.Orientation.X, rightlowerleg.Orientation.Y, -rightlowerleg.Orientation.Z) 
						clone.RightFoot.Orientation = rightfoot.Orientation + Vector3.new(-rightfoot.Orientation.X, rightfoot.Orientation.Y, -rightfoot.Orientation.Z) 
						clone.LeftUpperLeg.Orientation = leftupperleg.Orientation + Vector3.new(-leftupperleg.Orientation.X, leftupperleg.Orientation.Y, -leftupperleg.Orientation.Z) 
						clone.LeftLowerLeg.Orientation = leftlowerleg.Orientation + Vector3.new(-leftlowerleg.Orientation.X, leftlowerleg.Orientation.Y, -leftlowerleg.Orientation.Z) 
						clone.LeftFoot.Orientation = leftfoot.Orientation + Vector3.new(-leftfoot.Orientation.X, leftfoot.Orientation.Y, -leftfoot.Orientation.Z)  
						 
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
		local function remove()
			for i, v in pairs(game.Players:GetChildren()) do
				if v and v ~= player then
					v.Character.Humanoid.WalkSpeed = 16
					v.Character.Humanoid.JumpPower = 50
					local reset = v.PlayerGui:WaitForChild("Reset")
					reset:Destroy()
				end
			end
		end

		local function unanchorchildren(object) 
			for _,v in pairs(object:GetChildren()) do
				if v:IsA("Part") then
					if v.Parent:IsA("Tool") or v.Parent:IsA("Model") then
						if v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid") then
							v.Anchored = false 
						end
					end
				end
				unanchorchildren(v)
			end
		end

		remove()
		unanchorchildren(game.Workspace) 
		game.Lighting.Ambient = Color3.new(0.27451, 0.27451, 0.27451)
		game.Lighting.OutdoorAmbient = Color3.new(0.27451, 0.27451, 0.27451)  
	end

	local function two()
		humanoid.WalkSpeed = 16
		game.Lighting.TimeOfDay = "14:30:00"
		for v = 1, 3 do
			local object

			if v == 1 then
				object = char.RightUpperArm
			elseif v == 2 then
				object = char.LeftUpperArm 
			else
				object = char.HumanoidRootPart
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
	end
end

local function unequip()
	if equipped == true then
		equipped = false
	end 
end 

TimeStop.OnServerEvent:Connect(stoptime)
TimeErase.OnServerEvent:Connect(erasetime)
TimeAcceleration.OnServerEvent:Connect(accerleratetime)
tool.Equipped:Connect(equip)
tool.Unequipped:Connect(unequip) 
humanoid.Died:Connect(death) 
