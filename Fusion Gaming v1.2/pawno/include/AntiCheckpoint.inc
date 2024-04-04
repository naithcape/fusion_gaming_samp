new Float: TampanDanBerani[MAX_PLAYERS][3];

public OnPlayerConnect(playerid)
{
	for(new x = 0; x < 3; x++) TampanDanBerani[playerid][x] = 0;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new Float: Vx, Float: Vy, Float: Vz;
		GetVehiclePos(GetPlayerVehicleID(playerid), Vx, Vy, Vz);
	        if(GetDistance(Vx, Vy, Vz, TampanDanBerani[playerid][0], TampanDanBerani[playerid][1],         TampanDanBerani[playerid][2]) > 20) return Kick(playerid);
	}
	else
	{
		if(!IsPlayerInRangeOfPoint(playerid, 10.0, TampanDanBerani[playerid][0], TampanDanBerani[playerid][1], TampanDanBerani[playerid][2])) return Kick(playerid);
	}
return 1;
}

stock DSetPlayerCheckpoint(playerid, Float: x, Float: y, Float: z, Float: size)
{
	TampanDanBerani[playerid][0] = x;
	TampanDanBerani[playerid][1] = y;
	TampanDanBerani[playerid][2] = z;
	return SetPlayerCheckpoint(playerid, x, y, z, size);
}

Float:GetDistance( Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2 )
{
	new Float:d;
	d += floatpower(x1-x2, 2.0 );
	d += floatpower(y1-y2, 2.0 );
	d += floatpower(z1-z2, 2.0 );
	d = floatsqroot(d);
	return d;
}