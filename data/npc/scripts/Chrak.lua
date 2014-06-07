local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	local Questlinestorage = 1015 --Questlinestorage
	local player = Player(cid)
	if not npcHandler:isFocused(cid) then
		return false
	elseif msgcontains(msg, "battle") then
		if player:getStorageValue(Questlinestorage) == 24 then
			npcHandler:say({"Zo you want to enter ze arena, you know ze rulez and zat zere will be no ozer option zan deaz or victory?",
							"My mazter wantz to zurprize hiz opponentz by an unexpected move. He will uze warriorz from ze outzide, zomeone zat no one can azzezz. ... ",
							"One of ziz warriorz could be you. Or you could ztay here and rot in ze dungeon. Are you interezted in ziz deal? "}, cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "mission") then
		if player:getStorageValue(Questlinestorage) == 26 then
			npcHandler:say({"You have done ze impozzible and beaten ze champion. Your mazter will be pleazed. Hereby I cleanze ze poizon from your body. You are now allowed to leave. ...",
							"For now ze mazter will zee zat you and your alliez are zpared of ze wraz of ze dragon emperor az you are unimportant for hiz goalz. ...",
							"You may crawl back to your alliez and warn zem of ze gloriouz might of ze dragon emperor and hiz minionz."}, cid)
			player:setStorageValue(Questlinestorage, 27)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Asss you wishzz.", cid)
			player:setStorageValue(Questlinestorage, 25)
			player:setStorageValue(12138, 2) --Questlog, The New Frontier Quest "Mission 08: An Offer You Can't Refuse"
			player:setStorageValue(12139, 1) --Questlog, The New Frontier Quest "Mission 09: Mortal Combat"
			npcHandler.topic[cid] = 0
		end
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
