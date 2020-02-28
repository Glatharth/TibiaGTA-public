-- Nome da Quest --
-- Creditos: -- 
local _config = {
	storage = 12443,
	item = {{2160, 5}, {2160, 5}, {2160, 10}, {2160, 12}},
	mensagem = "Voce ganhou muito dinheiro!"

}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(_config.storage) < 1 then
		for i, c in ipairs(_config.item) do
			player:addItem(_config.item[i][1], _config.item[i][2])
		end
		player.sendCancelMessage(player, _config.mensagem)
		player:setStorageValue(_config.storage, 1)
		return true
	end
	player.sendCancelMessage(player, "Voce ja abriu.")
	return true
end