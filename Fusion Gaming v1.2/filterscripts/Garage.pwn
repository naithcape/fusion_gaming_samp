// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT
//1643.839843,-1514.819580,13.566620
// id 0 LS Garage

#include <a_samp>
#include <YSI\y_ini>
#include <ZCMD>
#include <sscanf2>

forward SaveGrage(id);

#define SCM SendClientMessage //Saves time
#define BPATH "/Garages/%i.ini" //Defines the path y_ini will use to find the .ini file we need.
#define DIALOG_GARAZA 3123
#define DIALOG_G_IME 3124
//The below colors do not have to be used, but you will need to edit the script if you choose not to use them.
#define NEWBIE_COLOR        0x7DAEFFFF
#define TCOLOR_WHITE        0xFFFFFF00
#define COLOR_GRAD1         0xB4B5B7FF
#define COLOR_GRAD2         0xBFC0C2FF
#define COLOR_GRAD3         0xCBCCCEFF
#define COLOR_GRAD4         0xD8D8D8FF
#define COLOR_GRAD5         0xE3E3E3FF
#define COLOR_GRAD6         0xF0F0F0FF
#define COLOR_FADE1         0xE6E6E6E6
#define COLOR_FADE2         0xC8C8C8C8
#define COLOR_FADE3         0xAAAAAAAA
#define COLOR_FADE4         0x8C8C8C8C
#define COLOR_FADE5         0x6E6E6E6E
#define COLOR_PURPLE        0xC2A2DAAA
#define COLOR_RED           0xAA3333AA
#define COLOR_GREY          0xAFAFAFAA
#define COLOR_GREEN         0x33AA33AA
#define COLOR_BLACK         0x000001FF
#define COLOR_BLUE          0x007BD0FF
#define COLOR_LIGHTORANGE   0xFFA100FF
#define COLOR_FLASH         0xFF000080
#define COLOR_LIGHTRED      0xFF6347AA
#define COLOR_LIGHTBLUE     0x01FCFFC8
#define COLOR_LIGHTGREEN    0x9ACD32AA
#define COLOR_YELLOW        0xFFFF00AA
#define COLOR_LIGHTYELLOW   0xFFFF91FF
#define COLOR_YELLOW2       0xF5DEB3AA
#define COLOR_WHITE         0xFFFFFFAA



enum gInfo {
    gOwned,
    gPrice,
    gOwner[MAX_PLAYER_NAME],
    gType,
    gLocked,
    gMoney,
    Float:gEntranceX,
    Float:gEntranceY,
    Float:gEntranceZ,
    Float:gEntranceA,
    Float:gExitX,
    Float:gExitY,
    Float:gExitZ,
    Float:gExitA,
    gInt,
    gWorld,
    gInsideInt,
    gInsideWorld,
    gInsideIcon,
    gOutsideIcon,
    gName[128]
}
new GarageInfo[200][gInfo];
new Text3D:GarageText[200];
new InsideGarage[MAX_PLAYERS];

stock SledecaGarazaID()
{
new
firma[64];
for(new f = 1; f<= 200; f++)
{
format(firma, sizeof(firma), "/Garages/%i.ini", f);
if(!fexist(firma)) return f;
}
return true;
}

public SaveGrage(id)
{
    new file4[40];
    format(file4, sizeof(file4), BPATH, id);
    new INI:File = INI_Open(file4);
    INI_SetTag(File,"data");
    INI_WriteInt(File,"gOwned", GarageInfo[id][gOwned]);
    INI_WriteInt(File,"gPrice", GarageInfo[id][gPrice]);
    INI_WriteString(File,"gOwner", GarageInfo[id][gOwner]);
    INI_WriteInt(File,"gType", GarageInfo[id][gType]);
    INI_WriteInt(File,"gLocked", GarageInfo[id][gLocked]);
    INI_WriteInt(File,"gMoney", GarageInfo[id][gMoney]);
    INI_WriteFloat(File,"gEntranceX", GarageInfo[id][gEntranceX]);
    INI_WriteFloat(File,"gEntranceY", GarageInfo[id][gEntranceY]);
    INI_WriteFloat(File,"gEntranceZ", GarageInfo[id][gEntranceZ]);
    INI_WriteFloat(File,"gEntranceA", GarageInfo[id][gEntranceA]);
    INI_WriteFloat(File,"gExitX", GarageInfo[id][gExitX]);
    INI_WriteFloat(File,"gExitY", GarageInfo[id][gExitY]);
    INI_WriteFloat(File,"gExitZ", GarageInfo[id][gExitZ]);
    INI_WriteFloat(File,"gExitA", GarageInfo[id][gExitA]);
    INI_WriteInt(File,"gInt", GarageInfo[id][gInt]);
    INI_WriteInt(File,"gWorld", GarageInfo[id][gWorld]);
    INI_WriteInt(File,"gInsideInt", GarageInfo[id][gInsideInt]);
    INI_WriteInt(File,"gInsideWorld", GarageInfo[id][gInsideWorld]);
    INI_WriteString(File,"gName", GarageInfo[id][gName]);
    INI_Close(File);
    return 1;
}
forward loadgarage_data(idx, name[], value[]);
public loadgarage_data(idx, name[], value[])
{
    INI_Int("gOwned", GarageInfo[idx][gOwned]);
    INI_Int("gPrice", GarageInfo[idx][gPrice]);
    INI_String("gOwner", GarageInfo[idx][gOwner], 24);
    INI_Int("gType", GarageInfo[idx][gType]);
    INI_Int("gLocked", GarageInfo[idx][gLocked]);
    INI_Int("gMoney", GarageInfo[idx][gMoney]);
    INI_Float("gEntranceX", GarageInfo[idx][gEntranceX]);
    INI_Float("gEntranceY", GarageInfo[idx][gEntranceY]);
    INI_Float("gEntranceZ", GarageInfo[idx][gEntranceZ]);
    INI_Float("gEntranceA", GarageInfo[idx][gEntranceA]);
    INI_Float("gExitX", GarageInfo[idx][gExitX]);
    INI_Float("gExitY", GarageInfo[idx][gExitY]);
    INI_Float("gExitZ", GarageInfo[idx][gExitZ]);
    INI_Float("gExitA", GarageInfo[idx][gExitA]);
    INI_Int("gInt", GarageInfo[idx][gInt]);
    INI_Int("gWorld", GarageInfo[idx][gWorld]);
    INI_Int("gInsideInt", GarageInfo[idx][gInsideInt]);
    INI_Int("gInsideWorld", GarageInfo[idx][gInsideWorld]);
    INI_String("gName", GarageInfo[idx][gName], 128);
    return 1;
}


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	OnGameModeInit();
	return 1;
}

public OnFilterScriptExit()
{
    OnGameModeExit();
	return 1;
}



public OnGameModeInit()
{


new str[128];
for(new idx = 1; idx < sizeof(GarageInfo); idx++)
{
format(str, sizeof(str), BPATH, idx);
INI_ParseFile(str, "loadgarage_%s", .bExtra = true, .extra = idx );
if(GarageInfo[idx][gOwned] == 0)
{

format(str, sizeof(str), "{00CED1}Garaza %s\nVlasnik: Drzava\nCena: %d\n/kupigarazu", GarageInfo[idx][gName], GarageInfo[idx][gPrice]);
GarageText[idx] = Create3DTextLabel(str, 0x008080FF, GarageInfo[idx][gEntranceX], GarageInfo[idx][gEntranceY], GarageInfo[idx][gEntranceZ], 40.0, 0, 0);
}
if(GarageInfo[idx][gOwned] == 1)
{


format(str, sizeof(str), "{00FF22}Garaza %s\nVlasnik: %s\nSpace za ulazak", GarageInfo[idx][gName], GarageInfo[idx][gOwner]);
GarageText[idx] = Create3DTextLabel(str, 0x008080FF, GarageInfo[idx][gEntranceX], GarageInfo[idx][gEntranceY], GarageInfo[idx][gEntranceZ], 40.0, 0, 0);
}

}
return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{

	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
if(newkeys == KEY_SPRINT)
{

if(!IsPlayerInAnyVehicle(playerid))
{
for(new b = 1; b < sizeof(GarageInfo); b++)//Loops through all the businesses.
{
if(IsPlayerInRangeOfPoint(playerid, 1.0, GarageInfo[b][gEntranceX], GarageInfo[b][gEntranceY], GarageInfo[b][gEntranceZ]))//Checks if player is near the entrance.
{
if(GarageInfo[b][gLocked] == 1) return SendClientMessage(playerid, COLOR_GREY, "Ova garaza je zakljucana");//Checks it it is locked/
SetPlayerPos(playerid, GarageInfo[b][gExitX], GarageInfo[b][gExitY], GarageInfo[b][gExitZ]);
SetPlayerFacingAngle(playerid, GarageInfo[b][gExitA]);
SetPlayerVirtualWorld(playerid, GarageInfo[b][gInsideWorld]);
InsideGarage[playerid] = b;
return 1;
}
if(IsPlayerInRangeOfPoint(playerid, 2.0, GarageInfo[b][gExitX], GarageInfo[b][gExitY], GarageInfo[b][gExitZ]) && GetPlayerVirtualWorld(playerid) == GarageInfo[b][gInsideWorld])//Checks if player is in near the exit.
{
SetPlayerPos(playerid, GarageInfo[b][gEntranceX], GarageInfo[b][gEntranceY], GarageInfo[b][gEntranceZ]);
SetPlayerFacingAngle(playerid, GarageInfo[b][gEntranceA]);

SetPlayerVirtualWorld(playerid, GarageInfo[b][gWorld]);
InsideGarage[playerid] = 0;
return 1;
}
}
}

if(IsPlayerInAnyVehicle(playerid))
{
for(new b = 1; b < sizeof(GarageInfo); b++)//Loops through all the businesses.
{
if(IsPlayerInRangeOfPoint(playerid, 1.0, GarageInfo[b][gEntranceX], GarageInfo[b][gEntranceY], GarageInfo[b][gEntranceZ]))//Checks if player is near the entrance.
{
if(GarageInfo[b][gLocked] == 1) return SendClientMessage(playerid, COLOR_GREY, "Ova garaza je zakljucana");//Checks it it is locked/
SetVehiclePos(GetPlayerVehicleID(playerid), GarageInfo[b][gExitX], GarageInfo[b][gExitY], GarageInfo[b][gExitZ]);
SetVehicleZAngle(GetPlayerVehicleID(playerid), GarageInfo[b][gExitA]);
SetPlayerVirtualWorld(playerid, GarageInfo[b][gInsideWorld]);
SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GarageInfo[b][gInsideWorld]);
InsideGarage[playerid] = b;
return 1;
}
if(IsPlayerInRangeOfPoint(playerid, 2.0, GarageInfo[b][gExitX], GarageInfo[b][gExitY], GarageInfo[b][gExitZ]) && GetPlayerVirtualWorld(playerid) == GarageInfo[b][gInsideWorld])//Checks if player is in near the exit.
{
SetVehiclePos(GetPlayerVehicleID(playerid), GarageInfo[b][gEntranceX], GarageInfo[b][gEntranceY], GarageInfo[b][gEntranceZ]);
SetVehicleZAngle(GetPlayerVehicleID(playerid), GarageInfo[b][gEntranceA]);
SetPlayerVirtualWorld(playerid, GarageInfo[b][gWorld]);
SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GarageInfo[b][gWorld]);
InsideGarage[playerid] = 0;
return 1;
}
}
}



}

return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
switch(dialogid)
{
case DIALOG_G_IME:
{
if(response)
{
new imeu[128];
if(sscanf(inputtext, "s[128]", imeu)) return ShowPlayerDialog(playerid, DIALOG_G_IME, DIALOG_STYLE_INPUT, "Garaza", "Promeni novo ime", "Promeni", "Odustani");
for(new id = 1;id <= sizeof(GarageInfo); id++)
{
new ime[MAX_PLAYER_NAME];
GetPlayerName(playerid, ime, 24);
if(strcmp(GarageInfo[id][gOwner],ime, false ) == 0)
{
strmid(GarageInfo[id][gName], imeu, 0, strlen(imeu), 255);
new str[128];
format(str, sizeof(str), "{00FF22}Garaza %s\nVlasnik: %s\nSpace za ulazak", GarageInfo[id][gName], GarageInfo[id][gOwner]);
Update3DTextLabelText(GarageText[id],-1,str);
}
}

}
}
}

if(dialogid == DIALOG_GARAZA)
{
if(response)
{
if(listitem == 0)
{
ShowPlayerDialog(playerid, DIALOG_G_IME, DIALOG_STYLE_INPUT, "Garaza", "Promeni novo ime", "Promeni", "Odustani");
}
if(listitem == 1)
{
for(new id = 1;id <= sizeof(GarageInfo); id++)
{
new ime[MAX_PLAYER_NAME];
GetPlayerName(playerid, ime, 24);
if(strcmp(GarageInfo[id][gOwner],ime, false ) == 0)
{
GarageInfo[id][gOwned] = 0;
strmid(GarageInfo[id][gOwner], "Niko", 0, strlen("Niko"), 255);
//\n/kupigarazu
new str[128];
format(str, sizeof(str), "{00CED1}Garaza %s\nVlasnik: Drzava\nCena: %d\n/kupigarazu", GarageInfo[id][gName], GarageInfo[id][gPrice]);
Update3DTextLabelText(GarageText[id],-1,str);
GivePlayerMoney(playerid, GarageInfo[id][gPrice]);
SCM(playerid, -1, "Prodali ste garazu");
if(GarageInfo[id][gPrice] == 0) break;
SaveGrage(id);
}
}
}

if(listitem == 2)
{
for(new id = 1;id <= sizeof(GarageInfo); id++)
{
new ime[MAX_PLAYER_NAME];
GetPlayerName(playerid, ime, 24);
if(strcmp(GarageInfo[id][gOwner],ime, false ) == 0)
{
GarageInfo[id][gLocked] = 1;
SCM(playerid, -1, "Zakljuco si garazu");

if(GarageInfo[id][gPrice] == 0) break;
SaveGrage(id);
}
}
}
if(listitem == 3)
{
for(new id = 1;id <= sizeof(GarageInfo); id++)
{
new ime[MAX_PLAYER_NAME];
GetPlayerName(playerid, ime, 24);
if(strcmp(GarageInfo[id][gOwner],ime, false ) == 0)
{
GarageInfo[id][gLocked] = 0;
SCM(playerid, -1, "Otkljuco si garazu");

if(GarageInfo[id][gPrice] == 0) break;
SaveGrage(id);
}
}
}


}
}


return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
CMD:napravigarazu(playerid, params[])
{
if(!IsPlayerAdmin(playerid)) return SCM(playerid, COLOR_GREY, "Niste ovlasteni");
new cena;
if(sscanf(params, "i", cena)) return SCM(playerid, COLOR_WHITE, "/napravigarazu [Cena]");
new Float:Pos[3];
new world;
GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
world = GetPlayerVirtualWorld(playerid);
new Float: A;
GetPlayerFacingAngle(playerid, A);
new int = GetPlayerInterior(playerid);
new id = SledecaGarazaID();
GarageInfo[id][gInsideInt] = 0;
GarageInfo[id][gExitX] = 1643.839843;
GarageInfo[id][gExitY] = -1514.819580;
GarageInfo[id][gExitZ] = 13.566620;



GarageInfo[id][gOwned] = 0;
GarageInfo[id][gPrice] = cena;
GarageInfo[id][gType] = 4;
GarageInfo[id][gEntranceX] = Pos[0];
GarageInfo[id][gEntranceY] = Pos[1];
GarageInfo[id][gEntranceZ] = Pos[2];
GarageInfo[id][gEntranceA] = 180;
GarageInfo[id][gLocked] = 1;

GarageInfo[id][gInt] = int;
GarageInfo[id][gWorld] =world;
GarageInfo[id][gInsideWorld] = id;

new string[30];
format(string, sizeof(string), "None");
strmid(GarageInfo[id][gName], string, 0, strlen(string), 255);

new str1[30];
format(str1, sizeof(str1), "Niko");
strmid(GarageInfo[id][gOwner], str1, 0, strlen(str1), 255);

new str[128];
format(str, sizeof(str), "{00CED1}Garaza %s\nVlasnik: Drzava\nCena: %d\n/kupigarazu", GarageInfo[id][gName], GarageInfo[id][gPrice]);
GarageText[id] = Create3DTextLabel(str, 0x008080FF, GarageInfo[id][gEntranceX], GarageInfo[id][gEntranceY], GarageInfo[id][gEntranceZ], 40.0, 0, 0);

new file4[40];
format(file4, sizeof(file4), BPATH, id);
new INI:File = INI_Open(file4);
INI_SetTag(File,"data");
INI_WriteInt(File,"gOwned", GarageInfo[id][gOwned]);
INI_WriteInt(File,"gPrice", GarageInfo[id][gPrice]);
INI_WriteString(File,"gOwner", GarageInfo[id][gOwner]);
INI_WriteInt(File,"gType", GarageInfo[id][gType]);
INI_WriteInt(File,"gLocked", GarageInfo[id][gLocked]);
INI_WriteInt(File,"gMoney", GarageInfo[id][gMoney]);
INI_WriteFloat(File,"gEntranceX", GarageInfo[id][gEntranceX]);
INI_WriteFloat(File,"gEntranceY", GarageInfo[id][gEntranceY]);
INI_WriteFloat(File,"gEntranceZ", GarageInfo[id][gEntranceZ]);
INI_WriteFloat(File,"gEntranceA", GarageInfo[id][gEntranceA]);
INI_WriteFloat(File,"gExitX", GarageInfo[id][gExitX]);
INI_WriteFloat(File,"gExitY", GarageInfo[id][gExitY]);
INI_WriteFloat(File,"gExitZ", GarageInfo[id][gExitZ]);
INI_WriteFloat(File,"gExitA", GarageInfo[id][gExitA]);
INI_WriteInt(File,"gInt", GarageInfo[id][gInt]);
INI_WriteInt(File,"gWorld", GarageInfo[id][gWorld]);
INI_WriteInt(File,"gInsideInt", GarageInfo[id][gInsideInt]);
INI_WriteInt(File,"gInsideWorld", GarageInfo[id][gInsideWorld]);
INI_WriteString(File,"gName", GarageInfo[id][gName]);
INI_Close(File);



return 1;
}
CMD:kupigarazu(playerid, params[])
{
for(new id=1;id <= sizeof(GarageInfo);id++)
{
new ime[MAX_PLAYER_NAME];
GetPlayerName(playerid, ime, 24);
if(strcmp(GarageInfo[id][gOwner],ime, true ) == 0) return 0;
if(IsPlayerInRangeOfPoint(playerid, 3.0, GarageInfo[id][gEntranceX], GarageInfo[id][gEntranceY], GarageInfo[id][gEntranceZ]))
{
if(GetPlayerMoney(playerid) < GarageInfo[id][gPrice]) return SCM(playerid, -1, "Nemate dovoljno novca");
GivePlayerMoney(playerid, -GarageInfo[id][gPrice]);
strmid(GarageInfo[id][gOwner], ime, 0, strlen(ime), 255);
GarageInfo[id][gOwned] = 1;
SCM(playerid, -1, "Kupili ste garazu, koristite /garaza za ostalu pomoc");
new str[128];
format(str, sizeof(str), "{00FF22}Garaza %s\nVlasnik: %s\nSpace za ulazak", GarageInfo[id][gName], GarageInfo[id][gOwner]);
Update3DTextLabelText(GarageText[id],-1,str);
}
}
return 1;
}
CMD:garaza(playerid, params[])
{
for(new id = 1;id <= sizeof(GarageInfo); id++)
{
if(IsPlayerInRangeOfPoint(playerid, 30.0, GarageInfo[id][gEntranceX], GarageInfo[id][gEntranceY], GarageInfo[id][gEntranceZ]))
{
new ime[MAX_PLAYER_NAME];
GetPlayerName(playerid, ime, 24);
if(strcmp(GarageInfo[id][gOwner],ime, false ) == 0)
{
ShowPlayerDialog(playerid, DIALOG_GARAZA, DIALOG_STYLE_LIST, "Garaza", "Ime\nProdaj drzavi\nZakljucaj\nOtkljucaj", "Odaberi", "Odustani");
}
}
}
return 1;
}

