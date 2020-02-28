-- Creditos: -- Paulo Henrique
local _config = {
	item = {8844, 1},
	money = 5000,
	mensagem = "Você comprou um galão de gasolina"
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:removeMoney(_config.money) then
		player:addItem(_config.item[1], _config.item[2])
		player.sendCancelMessage(player, _config.mensagem)
		return true
	end
	player.sendCancelMessage(player, "Você não tem dinheiro!")
	return true
end