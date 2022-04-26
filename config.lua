Config = {}
Config.ServerName = 'ImaTakyvServer'
Config.Locale = 'bg' -- Currently supported: nl, en, tr, fr, br, de, fa, pt, es. Your translation file is really appreciated. Send it to our Github repo or Discord server.
Config.ExcludeAccountsList = {'bank', 'money'} -- DO NOT TOUCH!

Config.IncludeCash = true -- Include cash in inventory? true or false.
Config.IncludeAccounts = true -- Include accounts (bank, black money, ...)? true or false.
Config.CameraAnimationPocket = false -- Set camera focus towards player if in inventory.
Config.CameraAnimationBag = false -- Set camera focus towards player if in inventory.
Config.CameraAnimationTrunk = false -- Set camera focus towards player if in inventory.
Config.CameraAnimationGlovebox = false -- Set camera focus towards player if in inventory.
Config.EverybodyCanRob = true -- Rob a dead or mugging or handcuffed person or allow jobs only?
Config.JobOnlyInventory = false -- Can jobs use /openinventory ID from anywere? If False only admins can do this.
Config.AllowModerators = false -- Can moderators use /openinventory ID from anywere?
Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk and glovebox. Only if this is on TRUE Config.AllowJOBNAME will work.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.
Config.AllowNightclub = false -- If true, nightclub will be able to search players' trunks.
Config.AllowMafia = false -- If true, mafia will be able to search players' trunks.
Config.IllegalshopOpen = false -- if true everybody can enter this shop. If false only Config.InventoryJob.Illegal can enter this shop.
Config.UseLicense = false -- You must have esx_license working on your server. 
Config.useAdvancedShop = false -- es_extended shop system. Not shared, sorry. Just set to false and use the in-build custom shop.
Config.disableVersionCheck = false
Config.DailyRentPrice = 450
Config.disableVersionMessage = false
Config.versionCheckDelay = 10 -- In minutes

Config.Command = {Steal = 'steal', CloseInv = 'closeinventory', Unequip = 'unequip'} -- NOT YET SUPPORTED, CHANGE IN /server/main.lua/.
Config.Attachments = {'flashlight', 'mag', 'drummag', 'suppressor', 'scope', 'grip', 'skin', 'skin1', 'skin2', 'skin3', 'skin4', 'skin5', 'skin6','skin7'} -- SUPPORTED.
Config.InventoryJob = {Police = 'police', Nightclub = 'nightclub', Mafia = 'mafia', Illegal = nil, Ambulance = 'ambulance'} -- This must be the name used in your database/jobs table.
Config.CloseUiItems = {'phone', 'weed_seed', 'tunerchip', 'fixkit', 'medikit', 'firstaid', 'vicodin', 'adrenaline', 'vuurwerk', 'vuurwerk2', 'vuurwerk3', 'vuurwerk4', 'armbrace', 'neckbrace', 'bodybandage', 'legbrace', 'bandage', 'billet'} -- List of item names that will close ui when used.
Config.License = {Weapon = 'weapon', Police = 'weapon', Nightclub = 'weapon'} -- What license is needed for this shop?

Config.OpenControl = 289 -- F2. player inventory, it is recommend to use the same as CloseControl.
Config.CloseControl = 289 -- F2. player inventory, it is recommend to use the same as OpenControl.
Config.BagControl = 288 -- F4. player bag inventory
Config.SearchBag = 249 -- N. Search a bag on the ground
Config.TakeBag = 38 -- E. Take bag on the ground
Config.OpenKeyGlovebox = 170 -- F3. glovebox inventory (in-car), it is recommend to use the same as OpenKeyTrunk.
Config.OpenKeyTrunk = 170 -- F3. trunk inventory (behind-car), it is recommend to use the same as OpenKeyGlovebox.
Config.RobKeyOne = 38 -- E
Config.RobKeyTwo = 60 -- CTRL

Config.ReloadTime = 2000 -- in miliseconds for reloading your ammunition.

Config.LicensePrice = 25000

Config.ShopMinimumGradePolice = 0 -- minimum grade to open the police shop
Config.ShopMinimumGradeNightclub = 0
Config.ShopMinimumGradeMafia = 0

-- BLIPS & MARKERS
Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.5}
Config.MarkerColor = {r = 0, g = 128, b = 255}
Config.Color = 2
Config.WeaponColor = 1

-- BLIPS
Config.ShowDrugMarketBlip = true
Config.DrugStoreBlipID = 140
Config.ShowRegularShopBlip = true
Config.ShopBlipID = 52
Config.ShowRobsLiquorBlip = true
Config.LiquorBlipID = 93
Config.ShowYouToolBlip = true
Config.YouToolBlipID = 402
Config.ShowBlackMarketBlip = true
Config.BlackMarketBlipID = 110
Config.ShowPoliceShopBlip = true
Config.PoliceShopBlipID = 110
Config.ShowNightclubShopBlip = true
Config.NightclubShopBlipID = 110
Config.ShowWeaponShopBlip = true
Config.WeaponShopBlipID = 110
Config.ShowIllegalShopBlip = true
Config.IllegalShopBlipID = 110
Config.ShowPrisonShopBlip = true
Config.PrisonShopBlipID = 52

Config.Weight = 169 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg).
Config.DefaultWeight = 1 -- Default weight for an item.
Config.MaxBagWeight = 20
Config.MaxBagItemCount = 50 
Config.MaxDifferentBagItems = 5

Config.localWeight = { -- Fill this with all your items. This is only for trunk and glovebox! Change your pocket inventory weights in your database! (items table)
	bread = 1,
	water = 1,
	WEAPON_SMG = 5,
	WEAPON_PISTOL = 5,
	WEAPON_APPISTOL = 5,
	WEAPON_PUMPSHOTGUN = 5,
	WEAPON_SNOWBALL = 1
}

Config.GloveboxSize = { -- Related to Config.localWeight.
	[0] = 30, --Compact
	[1] = 40, --Sedan
	[2] = 70, --SUV
	[3] = 25, --Coupes
	[4] = 30, --Muscle
	[5] = 10, --Sports Classics
	[6] = 5, --Sports
	[7] = 5, --Super
	[8] = 5, --Motorcycles
	[9] = 180, --Off-road
	[10] = 300, --Industrial
	[11] = 70, --Utility
	[12] = 100, --Vans
	[13] = 0, --Cycles
	[14] = 5, --Boats
	[15] = 20, --Helicopters
	[16] = 0, --Planes
	[17] = 40, --Service
	[18] = 40, --Emergency
	[19] = 0, --Military
	[20] = 300, --Commercial
	[21] = 0 --Trains
}

Config.TrunkSize = { -- Related to Config.localWeight.
	[0] = 300, --Compact
	[1] = 400, --Sedan
	[2] = 700, --SUV
	[3] = 250, --Coupes
	[4] = 300, --Muscle
	[5] = 100, --Sports Classics
	[6] = 50, --Sports
	[7] = 50, --Super
	[8] = 50, --Motorcycles
	[9] = 1800, --Off-road
	[10] = 3000, --Industrial
	[11] = 700, --Utility
	[12] = 1000, --Vans
	[13] = 0, --Cycles
	[14] = 50, --Boats
	[15] = 200, --Helicopters
	[16] = 0, --Planes
	[17] = 400, --Service
	[18] = 400, --Emergency
	[19] = 0, --Military
	[20] = 3000, --Commercial
	[21] = 0 --Trains
}

Config.VehiclePlate = {
	taxi = 'TAXI',
	cop = 'police',
	police = 'police',
	ambulance = 'ambulance',
	mecano = 'mechano',
	mechanic = 'mechanic',
	police = 'police',
	nightclub = 'nightclub',
	nightclub = 'nightclub',
	bahamas = 'bahamas',
	cardealer = 'dealer'
}

Config.Shops = {
	RegularShop = {
		Locations = {
			{x = 373.875,   y = 325.896,  z = 102.566},
			{x = 2557.458,  y = 382.282,  z = 107.622},
			{x = -3038.939, y = 585.954,  z = 6.908},
			{x = -3241.927, y = 1001.462, z = 11.830},
			{x = 547.431,   y = 2671.710, z = 41.156},
			{x = 1961.464,  y = 3740.672, z = 31.343},
			{x = 2678.916,  y = 3280.671, z = 54.241},
            {x = 1729.216,  y = 6414.131, z = 34.037},
            {x = -48.519,   y = -1757.514, z = 28.421},
			{x = 1163.373,  y = -323.801,  z = 68.205},
			{x = -707.501,  y = -914.260,  z = 18.215},
			{x = -1820.523, y = 792.518,   z = 137.118},
            {x = 1698.388,  y = 4924.404,  z = 41.063},
            {x = 25.723,   y = -1346.966, z = 28.497}, 
            {x = 1135.808,  y = -982.281,  z = 45.415},
			{x = -1222.915, y = -906.983,  z = 11.326},
			{x = -1487.553, y = -379.107,  z = 39.163},
			{x = -2968.243, y = 390.910,   z = 14.043},
			{x = 1166.024,  y = 2708.930,  z = 37.157},
			{x = 1392.562,  y = 3604.684,  z = 33.980},
            {x = 1984.78, y = 3052.14,  z = 47.22},
		},
		Items = {
			{name = 'bread', price = 8}, --sandwich
			{name = 'water', price = 10},
			{name = 'donut', price = 5},
			{name = 'cocacola', price = 15},
			{name = 'burger', price = 15},
			{name = 'dice', price = 10},
			{name = 'chips', price = 10},
			{name = 'banana', price = 5},
		}
	},

	GroothandelSupermarkt = {
		Locations = {
		},
		Items = {
		}
	},

	Showroom = {
		Locations = {
			-- { x = 468.58, y = -3205.64, z = 9.79 }
		},
		Items = {
			{ name = 'contract', price = 500},
			{ name = 'licenseplate', price = 500}
		}
	},

	MechanicShop = {
		Locations = {
			-- { x = 468.58, y = -3205.64, z = 9.79 }
		},
		Items = {
			{ name = 'airqn', price = 5},
			{ name = 'bushmils', price = 5},
			{ name = 'cleaverenergy', price = 5},
			{ name = 'domrakia', price = 5},
			{ name = 'heiniken', price = 5},
			{ name = 'jackdaniels', price = 5},
			{ name = 'kamenica', price = 5},
			{ name = 'konqk', price = 5},
			{ name = 'margaritka', price = 5},
			{ name = 'martini', price = 5},
			{ name = 'mastika', price = 5},
			{ name = 'mastika1', price = 5},
			{ name = 'monster', price = 5},
			{ name = 'pirinsko', price = 5},
			{ name = 'rakiapraskova', price = 5},
			{ name = 'shottekila', price = 5},
			{ name = 'sinjon', price = 5},
			{ name = 'sprite', price = 5},
			{ name = 'star', price = 5},
			{ name = 'stardark', price = 5},
			{ name = 'zagorka', price = 5},
		}
	},

	RobsLiquor = {
		Locations = {
		 	-- { x = 1135.808, y = -982.281, z = 45.415 }
		},
		Items = {
			{name = 'beer', price = 1},
			{name = 'wine', price = 1},
			{name = 'vodka', price = 1},
			{name = 'tequila', price = 1},
			{name = 'whisky', price = 1},
			{name = 'grand_cru', price = 1}
		}
	},

		Cafe = {
		Locations = {
		--	{x = 373.875,   y = 325.896,  z = 102.566}
		},
		Items = {
			{name = 'coffee', price = 5}
		}
	},


		Sandvichi = {
		Locations = {
		--	{x = 373.875,   y = 325.896,  z = 102.566}
		},
		Items = {
			{name = 'chips', price = 10},
			{name = 'donut', price = 5}

		}
	},


		Napitki = {
		Locations = {
		--	{x = 373.875,   y = 325.896,  z = 102.566}
		},
		Items = {
			{name = 'energy', price = 20},
			{name = 'water', price = 3},		
			{name = 'cocacola', price = 5}
		}
	},

	YouTool = {
		Locations = {
			{x = 44.83894726143,  y = -1748.5364990234,  z = 29.549386978149},
			{x = 2749.2309570313,   y = 3472.3308105469,  z = 55.679393768311}
		},
		Items = {
			-- {name = 'rope', price = 100},
			{name = 'oxygen_mask', price = 2500},
			{name = 'WEAPON_PETROLCAN', price = 300},
			{name = 'radio', price = 200},
			{name = 'lockpick', price = 500},
			{name = 'phone', price = 250},
			{name = 'binoculars', price = 500},
			-- {name = 'fixkit', price = 300},
			-- {name = 'medikit', price = 100},
			-- {name = 'bandage', price = 50},
			{name = 'dhm-jerry', price = 10},
			{name = 'dhm-waterpack', price = 10}
		}
	},

	PrisonShop = {
		Locations = {
		 	-- { x = -1103.05, y = -823.72, z = 14.48 }
		},
		Items = {
			{name = 'bread', price = 1},
			{name = 'water', price = 1},
			{name = 'cigarette', price = 1},
			{name = 'lighter'}, price = 1,
			{name = 'sandwich', price = 1},
			{name = 'chips', price = 1}
		}
	},

	WeaponShop = {
		Locations = {
			{ x = 22.09, y = -1107.28, z = 28.80 }
		},
		Items = {
			--{name = "ammunition_pistol", price = 150},
			--{name = "ammunition_shotgun", price = 250},
			--{name = "ammunition_smg", price = 300},
			--{name = "ammunition_rifle", price = 400},
			--{name = "WEAPON_KNIFE", price = 500},
			-- {name = 'GADGET_PARACHUTE', price = 300},
			--{name = 'bulletproof', price = 1500}
			--{name = "scope",price = 1},
			--{name = "skin",price = 1},
			--{name = "supressor",price = 1}
		}
	},

	PoliceShop = { -- available for Config.InventoryJob.Police
		Locations = { -- 482.55, -995.17, 30.69
			-- { x = 482.55,  y = -995.17,  z = 29.69 }
		},
		Items = {
			{name = "WEAPON_FLASHLIGHT", price = 200},
			{name = "WEAPON_STUNGUN", price = 200},
			{name = "WEAPON_NIGHTSTICK", price = 200},
			{name = "WEAPON_GLOCK", price = 5500},
			{name = "bulletproof", price = 250},
			{name = 'binoculars', price = 50},
			{name = 'fixkit', price = 150},
			--{name = 'medikit', price = 100},
			{name = 'radio', price = 250},
			{name = "ammunition_pistol", price = 150},
			{name = "ammunition_shotgun", price = 250},
			{name = "ammunition_smg", price = 300},
			{name = "ammunition_rifle", price = 400}
		}
	},


	BlackMarket = { -- available for Config.InventoryJob.Mafia
		Locations = {
			-- { x = -1297.96, y = -392.60, z = 35.47 }
		},
		Items = {
			{name = 'WEAPON_PISTOL', price = 10000},
			{name = 'ammunition_pistol',price = 1000},
			{name = 'ammunition_pistol_large',price = 1000}
		}
	},

	LicenseShop = {
		Locations = {
	    	-- {x = 12.47, y = -1105.5, z = 29.8}
		}
	},

	ShopNightclub = { -- available for Config.InventoryJob.Nightclub
		Locations = {
	    	-- { x = -2677.92, y = 1334.81, z = 139.88 },
	    	-- { x = -1879.94, y = 2063.07, z = 134.92 }
		},
		Items = {
			{name = 'WEAPON_FLASHLIGHT', price = 1000},
			{name = 'WEAPON_KNIFE', price = 1000},
			{name = 'WEAPON_BAT', price = 1000},
			{name = 'WEAPON_PISTOL', price = 10000},
			{name = 'WEAPON_PUMPSHOTGUN',price = 10000},
			{name = 'WEAPON_SMOKEGRENADE',price = 1000},
			{name = 'WEAPON_FIREEXTINGUISHER',price = 1000},
			{name = 'WEAPON_CROWBAR',price = 1000},
			{name = 'WEAPON_BZGAS',price = 1000},
			{name = 'ammunition_pistol',price = 100},
			{name = 'ammunition_pistol_large',price = 200},
			{name = 'ammunition_shotgun',price = 100},
			{name = 'ammunition_shotgun_large',price = 200},
			{name = 'ammunition_smg',price = 100},
			{name = 'ammunition_smg_large',price = 200},
			{name = 'ammunition_rifle',price = 100},
			{name = 'ammunition_rifle_large',price = 200},
			{name = 'ammunition_snp',price = 100},
			{name = 'ammunition_snp_large',price = 200},
			{name = 'ammunition_fireextinguisher',price = 100},
			{name = 'bulletproof',price = 1000},
			--{name = 'binoculars',price = 50},
			{name = 'flashlight',price = 100}
		}
	},
}

Config.Throwables = { -- WEAPON NAME & WEAPON HASH
	WEAPON_MOLOTOV = 615608432,
	WEAPON_GRENADE = -1813897027,
	WEAPON_STICKYBOMB = 741814745,
	WEAPON_PROXMINE = -1420407917,
	WEAPON_SMOKEGRENADE = -37975472,
	WEAPON_PIPEBOMB = -1169823560,
	WEAPON_FLARE = 1233104067,
	WEAPON_SNOWBALL = 126349499,
	WEAPON_BZGAZ = 0xA0973D5E
}

Config.FuelCan = 883325847

Config.PropList = { -- Here you can change the prop when using the item.
	cash = {['model'] = 'prop_cash_pile_02', ['bone'] = 28422, ['x'] = 0.02, ['y'] = 0.02, ['z'] = -0.08, ['xR'] = 270.0, ['yR'] = 180.0, ['zR'] = 0.0}
}

Config.EnableInventoryHUD = true

Config.Ammo = {
	{
		name = 'ammunition_pistol',
		weapons = {
			'WEAPON_PISTOL',
			"WEAPON_GLOCK",
			'WEAPON_APPISTOL',
			'WEAPON_SNSPISTOL',
			'WEAPON_COMBATPISTOL',
			'WEAPON_HEAVYPISTOL',
			'WEAPON_MACHINEPISTOL',
			'WEAPON_MARKSMANPISTOL',
			'WEAPON_PISTOL50',
			'WEAPON_VINTAGEPISTOL'
		},
		count = 30
	},
	{
		name = 'ammunition_shotgun',
		weapons = {
			'WEAPON_ASSAULTSHOTGUN',
			'WEAPON_AUTOSHOTGUN',
			'WEAPON_BULLPUPSHOTGUN',
			'WEAPON_DBSHOTGUN',
			'WEAPON_HEAVYSHOTGUN',
			'WEAPON_PUMPSHOTGUN',
			'WEAPON_SAWNOFFSHOTGUN'
		},
		count = 12
	},
	{
		name = 'ammunition_smg',
		weapons = {
			'WEAPON_ASSAULTSMG',
			'WEAPON_MICROSMG',
			'WEAPON_MICROSMG2',
			'WEAPON_MICROSMG3',
			'WEAPON_MINISMG',
			'WEAPON_SMG'
		},
		count = 45
	},
	{
		name = 'ammunition_rifle',
		weapons = {
			'WEAPON_ADVANCEDRIFLE',
			'WEAPON_ASSAULTRIFLE',
			'WEAPON_BULLPUPRIFLE',
			'WEAPON_CARBINERIFLE',
			'WEAPON_SPECIALCARBINE',
			'WEAPON_COMPACTRIFLE',
			'WEAPON_M4'
		},
		count = 45
	},
	{
		name = 'ammunition_snp',
		weapons = {
			'WEAPON_SNIPERRIFLE',
			'WEAPON_SNIPERRIFLE2',
			'WEAPON_HEAVYSNIPER',
			'WEAPON_MARKSMANRIFLE'
		},
		count = 10
	},
	{
		name = 'ammunition_fireextinguisher',
		weapons = {
			'WEAPON_FIREEXTINGUISHER'
		},
		count = 15
	}
}

Config.VaultBox = 'p_v_43_safe_s'
Config.Vault = {
	-- police = {
	-- 	coords = vector3(463.74, -985.14, 29.69),
    --     --coords = vector3(452.99, -973.48, 29.69),
	-- 	heading = 270.00,
	-- 	needItemLicense = false,
	-- },
	-- ambulance = {
	-- 	coords = vector3(340.54, -592.45, 42.28),
	-- 	heading = 244.94,
	-- 	needItemLicense = false,
	-- },
	--[[mechanic = {
		coords = vector3(-1417.78, -453.97, 35.91),
		heading = 212.71,
		needItemLicense = false,
	},]]
}
