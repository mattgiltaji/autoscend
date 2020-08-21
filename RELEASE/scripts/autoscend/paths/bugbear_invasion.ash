script "bugbear_invasion.ash"

boolean in_bugbear()
{
	return (auto_my_path() == "Bugbear Invasion");
}


void bugbear_initializeSettings()
{
	if(in_bugbear())
	{
		set_property("auto_getBeehive", false);
		set_property("auto_getStarKey", false);
		set_property("auto_holeinthesky", false);
		set_property("auto_getBoningKnife", false);
		set_property("auto_wandOfNagamar", false);
		
		//don't try to get any of the keys
		set_property("nsTowerDoorKeysUsed", "Boris's key,Jarlsberg's key,Sneaky Pete's key,Richard's star key,skeleton key,digital key");
	}
}

boolean LM_bugbear()
{
	if(!in_bugbear())
	{
		return false;
	}
	//we need a key o tron to unlock the mothership, build it as soon as we can
	if(item_amount($item[key-o-tron]) == 0 && item_amount($item[BURT]) >= 5)
	{
	/*
		coinmaster flash = $item[key-o-tron].seller;
		print("buying from " + flash);
		
		int coins = flash.available_tokens;
		int price = sell_price(flash, $item[Key-o-tron]);
		if(price > coins) {
			abort("You only have "+coins+" "+flash.token+", but it costs "+price+" "+flash.token);
		}
		*/
		
		use($item[BURT]);
		buy($coinmaster[Bugbear Token], 1, $item[key-o-tron]);
		//visit_url("inv_use.php?whichitem=5683&quantity=5&pwd", true);
		print("bought a key-o-tron to collect bugbear data!", "purple");
		
		if(item_amount($item[key-o-tron]) == 0)
		{
			abort("Please buy Key-o-tron manually by using a BURT from your inventory.");
		}
	}

	return false;
}

boolean LX_completeBugbearMothershipZone(string zoneName)
{
	
	return false;
}


boolean L13_bugbearMothership()
{
	if(!in_bugbear())
	{
		return false;
	}
	
	boolean [string] mothershipZones = $strings[Medbay,WasteProcessing,Sonar,ScienceLab,Morgue,SpecialOps,Engineering,Navigation,Galley];
	
	foreach zone in mothershipZones
	{
		string status = get_property("status"+zone);
		if (is_integer(status))
		{
			print("Please unlock "+zone+" by gathering more biodata.");
			return false;
		}
		
		if (status == "open")
		{
			LX_completeBugbearMothershipZone(zone);
			return false;
		}
		else if (status == "unlocked")
		{
			auto_log_warning("Trying to adventure in "+zone+" but the level isn't unlocked yet.", "red");
			return false;
		}
	}
	//we're all clear, fight the captain
	
	
	return false;
}