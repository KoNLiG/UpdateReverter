#include <sourcemod>
#include <CSWeaponsAPI>

#pragma semicolon 1
#pragma newdecls required

#define AWP_CLASSNAME "weapon_awp"
#define AWP_DEFAULT_MAG_SIZE 5
#define M4_CLASSNAME "weapon_m4a1_silencer"
#define M4_DEFAULT_RANGE_MOD 0.94

ConVar update_reverter_awp_mag_size;
ConVar update_reverter_m4_range_mod;

public Plugin myinfo =
{
	name = "[CS:GO] Update Reverter",
	author = "KoNLiG",
	description = "Reverts 11/18/2022 CS:GO update which nerfed AWP magazine size and M4A1-S range modifier.",
	version = "1.0.0",
	url = "https://github.com/KoNLiG/UpdateReverter"
};

public void OnPluginStart()
{
	update_reverter_awp_mag_size = CreateConVar("update_reverter_awp_mag_size", "10", "AWP magazine size. Old is 10, default is 5.");
	update_reverter_m4_range_mod = CreateConVar("update_reverter_m4_range_mod", "0.99", "M4A1-S range modifier. Old is 0.99, default is 0.94.");

	AutoExecConfig();
}

public void OnCSWeaponDataLoaded(CSWeaponData weapon_data)
{
	char classname[32];
	weapon_data.GetClassName(classname, sizeof(classname));

	if (StrEqual(classname, AWP_CLASSNAME) && update_reverter_awp_mag_size.IntValue != AWP_DEFAULT_MAG_SIZE)
	{
		weapon_data.MaxClip1 = update_reverter_awp_mag_size.IntValue;
	}
	else if (StrEqual(classname, M4_CLASSNAME) && update_reverter_m4_range_mod.FloatValue != M4_DEFAULT_RANGE_MOD)
	{
		weapon_data.RangeModifier = update_reverter_m4_range_mod.FloatValue;
	}
}

