-- thanks for orion (theo_theobenzo) for I guess, 'helping'?
local cloneref = cloneref or function(obj) return obj end
repeat task.wait() until game:IsLoaded()
local playersService = cloneref(game:GetService('Players'))
local chatService = cloneref(game:GetService('TextChatService'))
local runService = cloneref(game:GetService('RunService'))
local coreGui = cloneref(game:GetService('CoreGui'))
local starterGui = cloneref(game:GetService('StarterGui'))
local lplr = playersService.LocalPlayer
for _, tool in ipairs(lplr.Backpack:GetChildren()) do
    if tool:IsA('Tool') then
        tool:Destroy()
    end
end
for _, tool in ipairs(lplr.Character:GetChildren()) do
    if tool:IsA('Tool') then
        tool:Destroy()
    end
end
workspace.Camera.CameraSubject = lplr.Character.Humanoid
local function selfdestruct()
    while task.wait() do end
end
local allowMessages = true
local accessoryId = '6660331473'
local success, chatWindow = pcall(function()
    return coreGui.ExperienceChat.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.RCTScrollContentView
end)
if success then
    chatWindow.ChildAdded:Connect(function(chatMessage)
        if not allowMessages then
            chatMessage.Visible = false
        end
    end)
end

chatService.BubbleChatConfiguration.MaxBubbles = 0
local function sendMessage(message)
    if message == '' then return end
    allowMessages = false
    task.wait(0.05)
    chatService:FindFirstChild('TextChannels').RBXGeneral:SendAsync(tostring(message))
    task.delay(0.05, function()
        allowMessages = true
    end)
end
if accessoryId == '' then selfdestruct() end
sendMessage('-rs')
task.wait(2)
if lplr.Character:FindFirstChildWhichIsA('Accessory') then
    sendMessage('-ch')
    task.wait(2)
end
if lplr.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
    sendMessage('-r6')
    task.wait(2)
end
sendMessage('-gh ' .. accessoryId)
task.wait(0.3)
sendMessage('-net')
task.wait(2)
chatService.BubbleChatConfiguration.MaxBubbles = 3
local accessory = lplr.Character:FindFirstChildWhichIsA('Accessory') or workspace:FindFirstChildWhichIsA('Accessory')
task.spawn(function()
    repeat task.wait() until accessory and accessory:FindFirstChild('Handle') and accessory.Handle:FindFirstChildWhichIsA('TouchTransmitter')
    accessory.Handle:FindFirstChildWhichIsA('TouchTransmitter'):Destroy()
end)

if not accessory or not accessory:FindFirstChild('Handle') then selfdestruct() end
local handle = accessory.Handle
repeat
    local weld = handle:FindFirstChildWhichIsA('Weld')
    if weld then weld:Destroy() end
    task.wait()
until not handle:FindFirstChildWhichIsA('Weld')
local safePart = Instance.new('Part')
safePart.Anchored = true
safePart.Size = Vector3.new(500, 0.5, 500)

local angle = 0
local handlePos = lplr.Character['Right Leg'].Position + Vector3.new(0, -0.5, 0)
local cam = Instance.new('Part')
cam.Size = Vector3.new(0.5, 0.5, 0.5)
cam.CanCollide = false
cam.Anchored = true
cam.Transparency = 1
workspace.Camera.CameraSubject = cam
--task.spawn(function()
--    while task.wait() do
--        lplr.Character.Head.CFrame = handle.CFrame
--    end
--end)
runService.Heartbeat:Connect(function(delta)
    handle.Position = handlePos
    cam.Position = handlePos + Vector3.new(0, 2, 0)
end)
--lplr.Character:BreakJoints()

local function moveRight()
    handlePos = handlePos + Vector3.new(-0.2, 0, 0)
    handle.Rotation = Vector3.new(0, 90, 0)
end
local function moveLeft()
    handlePos = handlePos + Vector3.new(0.2, 0, 0)
    handle.Rotation = Vector3.new(0, -90, 0)
end
local function moveForward()
    handlePos = handlePos + Vector3.new(0, 0, -0.2)
    handle.Rotation = Vector3.new(0, 0, 0)
end
local function moveBackward()
    handlePos = handlePos + Vector3.new(0, 0, 0.2)
    handle.Rotation = Vector3.new(0, -180, 0)
end
local function moveLeft()
    handlePos = handlePos + Vector3.new(0.2, 0, 0)
    handle.Rotation = Vector3.new(0, -90, 0)
end

task.spawn(function()
    while task.wait(5) do
            handlePos = handlePos + Vector3.new(0.05, 0, 0)
    end
end)

local tools = {
    ['Forward'] = function()
        for _ = 1, 30 do
            moveForward()
            task.wait()
        end
    end,
    ['Backward'] = function()
        for _ = 1, 30 do
            moveBackward()
            task.wait()
        end
    end,
    ['Right'] = function()
        for _ = 1, 30 do
            moveLeft()
            task.wait()
        end
    end,
    ['Left'] = function()
        for _ = 1, 30 do
            moveRight()
            task.wait()
        end
    end,
}

for name, func in pairs(tools) do
    local tool = Instance.new('Tool')
    tool.Parent = lplr.Backpack
    tool.Name = name
    tool.RequiresHandle = true
    local handle = Instance.new('Part')
    handle.Name = 'Handle'
    handle.Size = Vector3.new(0.5,0.5,0.5)
    handle.Parent = tool
    tool.Activated:Connect(func)
end


if table.find({'Kingjad088899V2'}, game.Players.LocalPlayer.Name) then
   sendMessage('i like feminine men')
end
