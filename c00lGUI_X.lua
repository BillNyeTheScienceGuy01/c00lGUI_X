-- ⚡ COOLGUI_X: GREG EDITION ⚡
-- ⛔ Anti-Kick | 👻 Cloak | 💬 Spammer | 🔊 Soundbombs | 🕵️‍♂️ Disguise | 🪄 Identity Warp

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local SayMessageRequest = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local Debris = game:GetService("Debris")

-- GUI Base
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "CoolGUI_X_GregEdition"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "🔥 COOLGUI_X - GREG EDITION 🔥"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true

-- Function toggles
local function createButton(yPos, text, callback)
	local btn = Instance.new("TextButton", Frame)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.Size = UDim2.new(1, -20, 0, 30)
	btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	btn.Text = text
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- 🔐 Anti-Kick
createButton(50, "🛡️ Enable Anti-Kick", function()
	local mt = getrawmetatable(game)
	setreadonly(mt, false)
	local old = mt.__namecall
	mt.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		if method == "Kick" or method == "kick" then
			warn("[GREG] Kick blocked.")
			return
		end
		return old(self, ...)
	end)
	warn("[GREG] Anti-Kick active.")
end)

-- 👻 Remove From Report Menu
createButton(90, "👻 Cloak from Report Menu", function()
	for _, gui in pairs(game:GetDescendants()) do
		if gui:IsA("TextLabel") or gui:IsA("TextButton") then
			if gui.Text == LocalPlayer.DisplayName or gui.Text == LocalPlayer.Name then
				gui:Destroy()
			end
		end
	end
	game.DescendantAdded:Connect(function(obj)
		if obj:IsA("TextLabel") or obj:IsA("TextButton") then
			if obj.Text == LocalPlayer.DisplayName or obj.Text == LocalPlayer.Name then
				obj:Destroy()
			end
		end
	end)
	warn("[GREG] Report menu cloak active.")
end)

-- 🕵️‍♂️ Identity Scrambler
createButton(130, "🕵️ Fake DisplayName (loop)", function()
	spawn(function()
		while true do
			LocalPlayer.DisplayName = "Guest_" .. math.random(1000, 9999)
			wait(3)
		end
	end)
	warn("[GREG] Display name spoof loop started.")
end)

-- 💬 Server Chat Spammer
local spamOn = false
local messages = {
	"<font color=\"rgb(255,0,0)\">🔥 GREG HAS ENTERED 🔥</font>",
	"<font color=\"rgb(0,255,255)\">💬 YOU CAN’T REPORT ME 💬</font>",
	"<font color=\"rgb(255,255,0)\">⚡ SYSTEM OVERRIDE ENABLED ⚡</font>"
}
local soundIds = {
	"rbxassetid://183763515",
	"rbxassetid://142295308",
	"rbxassetid://184352425"
}

createButton(170, "💬 Toggle Server Spam", function()
	spamOn = not spamOn
	if spamOn then
		warn("[GREG] Chat spammer started.")
	else
		warn("[GREG] Chat spammer stopped.")
	end
end)

spawn(function()
	local index = 1
	while true do
		if spamOn then
			SayMessageRequest:FireServer(messages[index], "All")
			local sound = Instance.new("Sound")
			sound.SoundId = soundIds[index]
			sound.Volume = 1
			sound.Looped = false
			sound.Parent = workspace
			sound:Play()
			Debris:AddItem(sound, 5)
			index = index + 1
			if index > #messages then index = 1 end
		end
		wait(3)
	end
end)

-- 🖚 Close GUI
createButton(250, "❌ Close GUI", function()
	ScreenGui:Destroy()
end)

-- GUI LOADED
SayMessageRequest:FireServer("<font color=\"rgb(255,100,100)\">[GREG GUI] Loaded. You are now untouchable.</font>", "All")
