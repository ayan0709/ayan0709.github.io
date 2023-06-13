repeat  task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
else
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
    repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end


function autoload()
    pcall(function()
        local exec = tostring(identifyexecutor())
        if exec == "Synapse X" and Settings.AutoLoadScript then
            syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ayan0709/ayan0709.github.io/master/auto.lua'))()")
        elseif exec ~= "Synapse X" and Settings.AutoLoadScript then
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ayan0709/ayan0709.github.io/master/auto.lua'))()")
        end
    end)
end
if Settings.AutoLoadScript then
    autoload()
end
function autoload2()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ayan0709/ayan0709.github.io/master/auto.lua'))()
end
if Settings.refarmc then
    autoload2() end
if Settings.setfarm1 then
    autoload2() end
if Settings.setfarm2 then
    autoload2() end
if Settings.setfarmIC then
    autoload2() end



getgenv().settings = {
   Tiers = {
    ['5'] = {'double_cost'}, -- ignore challenge for specific tier ex. {'tank_enemies', 'shield_enemies', 'double_cost', 'fast_enemies', 'short_range'}
   },
   Wait_Time = 2 -- higher = more chance of not failing to join portal
}


function p(id)
   local reg = getreg()
   local portals = {}
   for i,v in next, reg do
      if type(v) == 'function' then
         if getfenv(v).script then
            for _, v in pairs(debug.getupvalues(v)) do
               if type(v) == 'table' then
                  if v["session"] then
                     for _, item in pairs(v["session"]["inventory"]['inventory_profile_data']['unique_items']) do
                        if item["item_id"]:match(id) then
                           table.insert(portals, item)
                        end
                     end
                     return portals
                  end
               end
            end
         end
      end
   end
end

for i,v in pairs(p('portal_item__madoka')) do
   for b,x in pairs(settings.Tiers) do
      if v['_unique_item_data']['_unique_portal_data']['portal_depth'] == tonumber(b) and not table.find(x, v['_unique_item_data']['_unique_portal_data']['challenge']) then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(v["uuid"], {["friends_only"] = true})
            task.wait(1.5)
            for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
               if v.Name == "Owner" and tostring(v.value) == game.Players.LocalPlayer.Name then
                  game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(tostring(v.Parent.Name))
                  break;
               end
            end
            return
         end
    end
 end
