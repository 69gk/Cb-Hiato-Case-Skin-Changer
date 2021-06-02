wait (2)

local LocalPlayer = game:GetService("Players").LocalPlayer
local Client = getsenv(game.Players.LocalPlayer.PlayerGui.Client)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local allSkins = {
   {'SG_Control'},
   {'Deagle_Crystal'},
   {'Scout_Darkness'},
   {'USP_Survival'},
   {'Tec9_Seasoned'},
   {'M4A4_Darkness'},
   {'AUG_Soldier'},
   {'AK47_Neonline'},
   {'AWP_Oriental'},
   {'MP9_Control'},
   {'Nova_Defective'},
   {'Bayonet_Kimura'},
   {'Falchion Knife_Kimura'},
   {'Fingerless Glove_Kimura'},

local isUnlocked

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

local isUnlocked

mt.__namecall = newcclosure(function(self, ...)
   local args = {...}
   if getnamecallmethod() == "InvokeServer" and tostring(self) == "Hugh" then
       return
   end
   if getnamecallmethod() == "FireServer" then
       if args[1] == LocalPlayer.UserId then
           return
       end
       if string.len(tostring(self)) == 38 then
           if not isUnlocked then
               isUnlocked = true
               for i,v in pairs(allSkins) do
                   local doSkip
                   for i2,v2 in pairs(args[1]) do
                       if v[1] == v2[1] then
                           doSkip = true
                       end
                   end
                   if not doSkip then
                       table.insert(args[1], v)
                   end
               end
           end
           return
       end
       if tostring(self) == "DataEvent" and args[1][4] then
           local currentSkin = string.split(args[1][4][1], "_")[2]
           if args[1][2] == "Both" then
               LocalPlayer["SkinFolder"]["CTFolder"][args[1][3]].Value = currentSkin
               LocalPlayer["SkinFolder"]["TFolder"][args[1][3]].Value = currentSkin
           else
               LocalPlayer["SkinFolder"][args[1][2] .. "Folder"][args[1][3]].Value = currentSkin
           end
       end
   end
   return oldNamecall(self, ...)
end)
   
setreadonly(mt, true)

Client.CurrentInventory = allSkins

local TClone, CTClone = LocalPlayer.SkinFolder.TFolder:Clone(), game.Players.LocalPlayer.SkinFolder.CTFolder:Clone()
LocalPlayer.SkinFolder.TFolder:Destroy()
LocalPlayer.SkinFolder.CTFolder:Destroy()
TClone.Parent = LocalPlayer.SkinFolder
CTClone.Parent = LocalPlayer.SkinFolder