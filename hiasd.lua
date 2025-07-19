local whitelist = {
    ["Gamerchan8181"]
    ["aegisoverdrive2"] = true,
    ["Eneslemekekek"] = true,
    ["Andrea_TaMare"] = true,
    ["blackgoku1249493"] = true,
    ["FeelThePowerOfChaos"] = true,
    ["Haku_S3np4i"] = true,
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

local backgroundSans = Instance.new("Sound")
backgroundSans.Name = "SansBackgroundVoice"
backgroundSans.SoundId = "rbxassetid://5417004822"
backgroundSans.Looped = true
backgroundSans.Volume = 3
backgroundSans.Parent = SoundService

local kickedFlagFile = "whitelist_kick_flag.txt"

local function showDialogue(text, onFinished)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SansDialogueUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.6, 0, 0.2, 0)
    frame.Position = UDim2.new(0.2, 0, 0.75, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderColor3 = Color3.new(1, 1, 1)
    frame.BorderSizePixel = 5
    frame.Parent = screenGui

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -20, 1, -20)
    textLabel.Position = UDim2.new(0, 10, 0, 10)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.RichText = true
    textLabel.Text = ""
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    textLabel.Parent = frame

    local sansSound = Instance.new("Sound")
    sansSound.SoundId = "rbxassetid://911882310"
    sansSound.Volume = 3
    sansSound.Name = "SansTalk"
    sansSound.Parent = SoundService

    backgroundSans:Play()

    coroutine.wrap(function()
        for i = 1, #text do
            textLabel.Text = string.sub(text, 1, i)
            if text:sub(i, i) ~= " " then
                local s = sansSound:Clone()
                s.Parent = SoundService
                s:Play()
                game.Debris:AddItem(s, 2)
            end
            task.wait(0.03)
        end
        backgroundSans:Stop()
        task.wait(1.5)
        screenGui:Destroy()
        if onFinished then onFinished() end
    end)()
end

local function blastAndKick(msg)
    backgroundSans:Stop()

    local soundParent = LocalPlayer:FindFirstChild("PlayerGui") or game:GetService("CoreGui")

    local flashGui = Instance.new("ScreenGui")
    flashGui.Name = "BlackFlash"
    flashGui.IgnoreGuiInset = true
    flashGui.ResetOnSpawn = false
    flashGui.Parent = game:GetService("CoreGui")

    local flashFrame = Instance.new("Frame")
    flashFrame.Size = UDim2.new(1, 0, 1, 0)
    flashFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    flashFrame.BackgroundTransparency = 1
    flashFrame.Parent = flashGui

    local fadeIn = TweenService:Create(flashFrame, TweenInfo.new(0.1), { BackgroundTransparency = 0 })
    local fadeOut = TweenService:Create(flashFrame, TweenInfo.new(0.1), { BackgroundTransparency = 1 })

-- 🎵 Play Sans Encounter Sound at the same time as first fadeIn
local encounterSound = Instance.new("Sound")
encounterSound.SoundId = "rbxassetid://3263122823"
encounterSound.Volume = 5
encounterSound.Parent = soundParent
encounterSound:Play()

-- ⚫ Flash sequence
fadeIn:Play()
fadeIn.Completed:Wait()

fadeOut:Play()
fadeOut.Completed:Wait()

fadeIn:Play()
fadeIn.Completed:Wait()

fadeOut:Play()
fadeOut.Completed:Wait()

fadeIn:Play()
fadeIn.Completed:Wait()

fadeOut:Play()
fadeOut.Completed:Wait()

flashGui:Destroy()

	task.wait(0.5)

    local gasterBlaster = Instance.new("Sound")
    gasterBlaster.SoundId = "rbxassetid://345052019"
    gasterBlaster.Volume = 5
    gasterBlaster.Parent = soundParent
    gasterBlaster:Play()

    gasterBlaster.Ended:Connect(function()
        task.wait(0.5)
        local deathSound = Instance.new("Sound")
        deathSound.SoundId = "rbxassetid://18950593618"
        deathSound.Volume = 5
        deathSound.Parent = soundParent
        deathSound:Play()
        deathSound.Ended:Connect(function()
            LocalPlayer:Kick(msg)
        end)
    end)
end

local function runFinalDialogues(lines, finalKickMsg)
    local function nextLine(index)
        if index > #lines then
            blastAndKick(finalKickMsg)
            return
        end
        showDialogue(lines[index], function()
            nextLine(index + 1)
        end)
    end
    nextLine(1)
end

local function showFinalGUI()
    local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    screenGui.Name = "SansFinalChoice"

    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0.3, 0, 0.25, 0)
    frame.Position = UDim2.new(0.35, 0, 0.4, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderColor3 = Color3.new(1, 1, 1)
    frame.BorderSizePixel = 3

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 0.4, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Text = "Stop getting kicked?"
    label.TextScaled = true
    label.Font = Enum.Font.Arcade

    local function createButton(text, pos, onClick)
        local button = Instance.new("TextButton", frame)
        button.Size = UDim2.new(0.4, 0, 0.3, 0)
        button.Position = pos
        button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Text = text
        button.Font = Enum.Font.Arcade
        button.TextScaled = true
        button.MouseButton1Click:Connect(onClick)
    end

    createButton("Yes", UDim2.new(0.1, 0, 0.55, 0), function()
        runFinalDialogues({
            "you're finally quitting on executing the script?",
            "finally.",
            "i want you to know... i won't let it go to waste.",
            "c'mere, pal."
        },  "if you really stopped trying to execute... you wouldn't come back.")
    end)

    createButton("No", UDim2.new(0.5, 0, 0.55, 0), function()
        runFinalDialogues({
            "welp, it was worth a shot.",
            "guess you like doing things the hard way, huh?"
        }, "geeettttttt dunked on!!!")
    end)
end

if not whitelist[LocalPlayer.Name] and not whitelist[tostring(LocalPlayer.UserId)] then
    local kickCount = 0
    if isfile(kickedFlagFile) then
        kickCount = tonumber(readfile(kickedFlagFile)) or 0
    end

    kickCount += 1

    if kickCount >= 10 then
        kickCount = 0
    end

    writefile(kickedFlagFile, tostring(kickCount))

    local dialogueSets = {
        [1] = { "kid.", "you ain't on the list." },
        [2] = { "heya.", "you look frustrated about something.", "guess i'm pretty good at my job, huh?" },
        [3] = { "hmm. that expression...", "that's the expression of someone who got kicked twice in a row.", "suffice to say, you look really... unsatisfied.", "all right.", "how 'bout we make it a third?" },
        [4] = { "hmm. that expression...", "that's the expression of someone who got kicked thrice in a row.", "...", "hey, what comes after 'thrice,' anyway?", "wanna help me find out?" },
        [5] = { "hmm. that expression...", "that's the expression of someone who got kicked quice in a row.", "quice? frice?", "welp, won't have to use it again anyways." },
        [6] = { "let's just get to the point." },
        [7] = { "are you done, freak? you're not getting on the list." },
    }

    local currentDialogue = dialogueSets[kickCount]

    if kickCount >= 8 then
        showFinalGUI()
        return
    end

    local function runDialogues(index)
        if not currentDialogue or index > #currentDialogue then
            blastAndKick("sorry bud, but you're not on the list.")
            return
        end
        showDialogue(currentDialogue[index], function()
            runDialogues(index + 1)
        end)
    end	

    runDialogues(1)
    return
end

local success, result = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/GreckBlox/OKLASJFkasjflkasjf/refs/heads/main/UTTD"))()
end)

if not success then
    warn("Failed to load script.")
end
