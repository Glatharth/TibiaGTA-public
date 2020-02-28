_config_GTA = {
	storage_muni = 49000,
	storage_exhaust = 49100,
	storage_moto = 10,
	storage_moto_check = 11,
	storage_first_outfit = 1,
	storage_cadeia_time = 20,
	cadeia_time = 15 * 60, -- minutos
	blood = 18,
	outfits = {
		renegada = {
			[1] = {looktype = 70, name = "Renegada"}
		},
		renegado = {
			[1] = {looktype = 63, name = "Renegado"}
		},
		justiceira = {
			[1] = {looktype = 71, name = "Justiceira"}
		},
		justiceiro = {
			[1] = {looktype = 23, name = "Justiceiro"}
		}
	}
}

_Storage = {
	["QG"] = 49200,
	["Action_Seeds"] = 49201
}

_Sistemas = {
	[1] = {
		name = "Clans",
		enable = 1,
		message_disable = "O sistema estï¿½ desativado.",
		view_account_type = ACCOUNT_TYPE_SENIORTUTOR,
		config = {
			["death_min"] = 100,
			["points_killer"] = 10, -- exemplo: player:getLevel() / 10
			["points_killer_bonus"] = 5, -- exemplo: (player:getLevel() - killer:getLevel()) / 5
			["enable_functions_leaders"] = 1,
			Atributos = {
				["Heal"] = {price = 1650000, min = 1, max = 20, global_storage_J = 51000, global_storage_R = 52000},
				["Damage"] = {price = 1650000, min = 1, max = 20, global_storage_J = 51010, global_storage_R = 52010}
			},
			Hunt = {
				["Expand"] = {price = 1000000, min = 1, max = 5, global_storage_J = 51100, global_storage_R = 52100},
				["Spawn"] = {price = 40000, min = 1, max = 25, global_storage_J = 51110, global_storage_R = 52110},
				["Monster"] = {price = 28500, min = 1, max = 10, global_storage_J = 51120, global_storage_R = 52120},
				Hunt_monsters = {
					[1] = {name = "Mutante", enable = 1, quest = {false, nil, nil}}, -- quest = {true, storage, value_storage(>=)}
					[2] = {name = "Morto Vivo", enable = 1, quest = {false, nil, nil}},
					[3] = {name = "Cowboy", enable = 1, quest = {false, nil, nil}},
					[4] = {name = "Exterminador", enable = 1, quest = {false, nil, nil}}
				}
			},
			Fazenda = {
				["Seeds"] = {},
				["Tiles"] = {
					[103] = {transform = {804}},
					[104] = {transform = {804}}
				}
			}
		}
	},
	[2] = {
		name = "NPC_Look",
		enable = 1,
		message_disable = "O sistema estï¿½ desativado.",
		storage = 100,
		view_account_type = ACCOUNT_TYPE_SENIORTUTOR
	},
	[3] = {
		name = "QG",
		enable = 1,
		message_disable = "O sistema estï¿½ desativado.",
		view_account_type = ACCOUNT_TYPE_SENIORTUTOR,
		monsters = {
			[1] = {name = "Mutante", enable = 1, quest = {false, nil, nil}}, -- quest = {true, storage, value_storage(>=)}
			[2] = {name = "Morto Vivo", enable = 1, quest = {false, nil, nil}},
			[3] = {name = "Masson", enable = 1, quest = {false, nil, nil}},
			[4] = {name = "Lobizomen", enable = 1, quest = {false, nil, nil}},
			[5] = {name = "Cowboy", enable = 1, quest = {false, nil, nil}},
			[6] = {name = "Robot", enable = 1, quest = {false, nil, nil}},
			[7] = {name = "Androide", enable = 1, quest = {false, nil, nil}},
			[8] = {name = "Asfark", enable = 1, quest = {false, nil, nil}},
			[9] = {name = "Exterminador", enable = 1, quest = {true, 15000, 2}}
		}
	},
	[4] = {
		name = "Hunted System",
		enable = 1,
		message_disable = "O sistema estï¿½ desativado.",
		view_account_type = ACCOUNT_TYPE_SENIORTUTOR,
		config = {
			["Level"] = 250,
			["Hunted_storage"] = 14352
		}
	}
}

Municao = {
	[1] = {
		name = "Chumbinho",
		id = 12702,
		distance = 16,
		min = 30,
		max = 65,
		combat = COMBAT_ICEDAMAGE
	},
	[2] = {
		name = "Bullet",
		id = 12700,
		distance = 2,
		min = 180,
		max = 230,
		combat = COMBAT_ICEDAMAGE
	},
	[3] = {
		name = "Red Bullet",
		id = 12701,
		distance = 7,
		min = 250,
		max = 300,
		combat = COMBAT_HOLYDAMAGE
	}
}

Arma = {
	["Pistol Free"] = {
		municoes = {Municao[1]},
		amount = 1,
		min = 15,
		max = 30
	},
	["Taurus"] = {
		municoes = {Municao[1]},
		amount = 1,
		min = 45,
		max = 65
	},
	["Magnum"] = {
		municoes = {Municao[2]},
		amount = 1,
		min = 80,
		max = 110
	},
	["Shotgun"] = {
		municoes = {Municao[2]},
		amount = 6,
		min = 550,
		max = 800
	},
	["Ak-47"] = {
		municoes = {Municao[2]},
		amount = 1,
		min = 60,
		max = 100
	},
	["Navy"] = {
		municoes = {Municao[2]},
		amount = 1,
		min = 50,
		max = 85
	},
	["Ak-47 Gold"] = {
		municoes = {Municao[1], Municao[2]},
		amount = 1,
		min = 150,
		max = 220
	},
	["Ak-47 Black"] = {
		municoes = {Municao[1], Municao[2], Municao[3]},
		amount = 1,
		min = 170,
		max = 240
	}
}

Capacete = {
	["Moto"] = {id = 12713, looktype_J = 258, looktype_R = 101, attack = true, speed = 500, chamas_gasolina = 0},
	["Hornet"] = {id = 12820, looktype_J = 123, looktype_R = 123, attack = true, speed = 700, chamas_gasolina = 0},
	["Bicicleta"] = {id = 12712, looktype_J = 41, looktype_R = 41, attack = false, speed = 250},
	["Skate"] = {id = 12715, looktype_J = 66, looktype_R = 66, attack = true, speed = 350}
}

EnterCloseServer = {
	-- Esse sistema serve para filtrar quem pode entrar no servidor ou nï¿½o
	["enable"] = true,
	["names"] = {"Vulgo Ze Droguinha", "Aspiraboo", "Skank", "Leoblaack"}, -- Nomes para nï¿½o serem bloqueados
	["IP"] = {}, -- IPS para nï¿½o serem filtrados
	["staff"] = {ACCOUNT_TYPE_TUTOR} -- Quais ranks de staff nï¿½o serï¿½o bloqueados (Admin nï¿½o ï¿½ bloqueado)
}

NPC_config = {
	['Riara'] = {
		quest = {
			[1] = {
				secretQuest = false,
				requirementQuest = {{5555, 1}, {6666, 1}},
				initStorage = {{58285, 0, 100}, {69396, 0, 100}},
				finalStorage = {{58286, 0}, {69397, 0}},
				initMessage = "Olá",
				finalMessage = "Tchau",
				rewards = {{2160, 2}, {2160, 2}},
				takeItem = {{2160, 1}, {2160, 1}}
			},
			[2] = {
				secretQuest = false,
				requirementQuest = {},
				initStorage = {{58285, 0, 100}, {69396, 0, 100}},
				finalStorage = {{58286, 0}, {69397, 0}},
				initMessage = "Olá",
				finalMessage = "Tchau",
				rewards = {{2160, 2}, {2160, 2}},
				takeItem = {{2160, 1}, {2160, 1}}
			}
		}
	}
}