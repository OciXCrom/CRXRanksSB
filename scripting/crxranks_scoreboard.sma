#include <amxmodx>
#include <crxranks>
#include <cstrike>
#include <fun>

#define PLUGIN_VERSION "1.0"
#define UPDATE_DELAY 0.1

public plugin_init()
{
	register_plugin("CRXRanks: Scoreboard", PLUGIN_VERSION, "OciXCrom")
	register_cvar("CRXRanksSB", PLUGIN_VERSION, FCVAR_SERVER|FCVAR_SPONLY|FCVAR_UNLOGGED)
	register_event("ScoreInfo", "OnUpdateScoreboard", "a")
}

public OnUpdateScoreboard()
	RefreshScoreboard(read_data(1))
	
public RefreshScoreboard(id)
{
	if(is_user_connected(id))
	{
		set_user_frags(id, crxranks_get_user_xp(id))
		cs_set_user_deaths(id, crxranks_get_user_level(id))
	}
}

public crxranks_user_receive_xp(id, iXP, CRXRanks_XPSources:iSource)
{
	if(iSource != CRXRANKS_XPS_REWARD)
		set_task(UPDATE_DELAY, "RefreshScoreboard", id)
}