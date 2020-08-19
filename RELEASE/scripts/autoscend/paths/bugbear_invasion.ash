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

//maybe function for making BURT stuff?


boolean LM_bugbear()
{
	if(!in_bugbear())
	{
		return false;
	}
	//we need a key o tron to unlock the mothership, build it as soon as we can
	if(item_amount($item[key-o-tron]) == 0 && item_amount($item[BURT]) >= 5)
	{
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
