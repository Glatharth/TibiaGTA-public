-- Combat settings
-- NOTE: valid values for worldType are: "pvp", "no-pvp" and "pvp-enforced"
worldType = "pvp"
hotkeyAimbotEnabled = true
protectionLevel = 50
killsToRedSkull = 15
killsToBlackSkull = 25
pzLocked = 60000
removeChargesFromRunes = true
timeToDecreaseFrags = 2 * 60 * 60 * 1000
whiteSkullTime = 15 * 60 * 1000
stairJumpExhaustion = 4000
experienceByKillingPlayers = false
expFromPlayersLevelRange = 75

-- Connection Config
-- NOTE: maxPlayers set to 0 means no limit
ip = "127.0.0.1"
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
maxPlayers = 0
motd = "Bem Vindo ao TibiaGTA"
onePlayerOnlinePerAccount = false
allowClones = false
serverName = "TibiaGTA"
statusTimeout = 5000
replaceKickOnLogin = true
maxPacketsPerSecond = 100

-- Deaths
-- NOTE: Leave deathLosePercent as -1 if you want to use the default
-- death penalty formula. For the old formula, set it to 10. For
-- no skill/experience loss, set it to 0.
deathLosePercent = -1

-- Houses
-- NOTE: set housePriceEachSQM to -1 to disable the ingame buy house functionality
housePriceEachSQM = 15000
houseRentPeriod = "weekly"

-- Item Usage
timeBetweenActions = 100
timeBetweenExActions = 100

-- Map
-- NOTE: set mapName WITHOUT .otbm at the end
mapName = ""
mapAuthor = ""

-- Market
marketOfferDuration = 30 * 24 * 60 * 60
premiumToCreateMarketOffer = true
checkExpiredMarketOffersEachMinutes = 60
maxMarketOffersAtATimePerPlayer = 100

-- MySQL
mysqlHost = ""
mysqlUser = "root"
mysqlPass = ""
mysqlDatabase = ""
mysqlPort = 3306
mysqlSock = ""

-- Misc.
-- NOTE: classicAttackSpeed set to true makes players constantly attack at regular
-- intervals regardless of other actions such as item (potion) use. This setting
-- may cause high CPU usage with many players and potentially affect performance!
allowChangeOutfit = true
freePremium = false
kickIdlePlayerAfterMinutes = 15
maxMessageBuffer = 4
emoteSpells = true
classicEquipmentSlots = false
classicAttackSpeed = false
showScriptsLogInConsole = true

-- Server Save
-- NOTE: serverSaveNotifyDuration in minutes
serverSaveNotifyMessage = true
serverSaveNotifyDuration = 5
serverSaveCleanMap = false
serverSaveClose = false
serverSaveShutdown = true

-- Rates
-- NOTE: rateExp is not used if you have enabled stages in data/XML/stages.xml
rateExp = 1
rateSkill = 1
rateLoot = 1
rateMagic = 1
rateSpawn = 1

-- Monsters
deSpawnRange = 2
deSpawnRadius = 50

-- Stamina
staminaSystem = true

-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true

-- Startup
-- NOTE: defaultPriority only works on Windows and sets process
-- priority, valid values are: "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = false

-- Status server information
ownerName = "Glatharth"
ownerEmail = "phlinho10@gmail.com" 
url = ""
location = "Brazil"

--  - Contato -
-- https://www.linkedin.com/in/paulo-henrique-8462b8173/
-- https://www.facebook.com/RoyalPaladin
-- Discord: RoyalPaladino#0989
-- phlinho10@gmail.com / paulohl10@hotmail.com