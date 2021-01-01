#include	<YSI_Coding\y_hooks>
#include 	<YSI_Coding\y_timers>

#define     MAX_MINING		    20
#define     MININGOBJECT       	867
#define     MININGTEXT          "Objective: {FFFFFF}�Թ\n������ {FFFF00}N {FFFFFF}���ͷغ�Թ!"
#define     MININGNAME          "���"
#define		MININGTIMER			10

enum MINING_DATA
{
    miningID,
    miningObject,
    Float: miningPos[3],
    Text3D: mining3D,
    mining3DMSG[80],
    miningOn
};
new const miningData[MAX_MINING][MINING_DATA] =
{
	{ 0, MININGOBJECT, { 670.500732, 926.557067, -41.475772 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 1, MININGOBJECT, { 678.838012, 925.259582, -41.473415 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 2, MININGOBJECT, { 673.852478, 922.303161, -41.548767 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 3, MININGOBJECT, { 679.489379, 917.357727, -41.276176 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 4, MININGOBJECT, { 673.862670, 914.984008, -41.207321 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 5, MININGOBJECT, { 666.973205, 921.626342, -41.613155 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 6, MININGOBJECT, { 686.447021, 913.041320, -40.560043 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 7, MININGOBJECT, { 679.475769, 910.190124, -41.048439 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 8, MININGOBJECT, { 689.223510, 906.631835, -40.269996 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 9, MININGOBJECT, { 683.865295, 905.557067, -40.672229 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 10, MININGOBJECT, { 685.984741, 899.446899, -40.296852 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 11, MININGOBJECT, { 694.975097, 902.076049, -39.668643 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 12, MININGOBJECT, { 692.622558, 896.177978, -39.817611 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 13, MININGOBJECT, { 697.621154, 891.354370, -39.355659 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 14, MININGOBJECT, { 687.311584, 891.855468, -40.107055 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 15, MININGOBJECT, { 692.106262, 887.992187, -39.684555 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 16, MININGOBJECT, { 690.451110, 879.733947, -40.143363 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 17, MININGOBJECT, { 696.097167, 882.666015, -39.491031 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 18, MININGOBJECT, { 694.623901, 872.130493, -41.227066 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 },
	{ 19, MININGOBJECT, { 693.549255, 862.414123, -43.129112 }, Text3D: INVALID_3DTEXT_ID, MININGTEXT, 0 }
};

hook OnGameModeInit()
{
	for(new i = 0; i < sizeof(miningData); i++)
	{
		miningData[i][miningID] = CreateDynamicObject(miningData[i][miningObject], miningData[i][miningPos][0], miningData[i][miningPos][1], miningData[i][miningPos][2], 0.0, 0.0, 0.0);
		miningData[i][mining3D] = CreateDynamic3DTextLabel(miningData[i][mining3DMSG], COLOR_GREEN, miningData[i][miningPos][0], miningData[i][miningPos][1], miningData[i][miningPos][2] + 1.5, 5.0);
	}
	CreateDynamicPickup(1239, 23, 1134.4004,-1461.1428,15.7969);
	CreateDynamic3DTextLabel("��ҹ���:{FFFFFF} ���\n������ {FFFF00}N{FFFFFF}\n㹡�â�����", COLOR_GREEN, 1134.4004,-1461.1428,15.7969, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
	{
        for(new i = 0; i < sizeof miningData; i++)
        {
            new Float:x, Float:y, Float:z;
            GetDynamicObjectPos(miningData[i][miningID], x, y, z);
            if(IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z))
            {
                if(IsValidDynamicObject(miningData[i][miningID]))
                {
                    if(miningData[i][miningOn] == 0)
                    {
	                    miningData[i][miningOn] = 1;
		                TogglePlayerControllable(playerid, false);
						SetPlayerAttachedObject(playerid, 3, 19631, 6, 0.048, 0.029, 0.103, -80.0, 80.0, 0.0);
						SetPlayerArmedWeapon(playerid, 0);
						ApplyAnimation(playerid, "BASEBALL", "Bat_1", 4.1, 1, 0, 0, 1, 0, 1);
		                defer PlayerMiningUnfreeze[MININGTIMER*1000](playerid, i);
	                	return 1;
	                }
	                else
	                {
	                    SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�դ����ѧ���������� / �س���ѧ����������!");
	                }
                }
            }
        }
        if (IsPlayerInRangeOfPoint(playerid, 2.5, 1134.4004,-1461.1428,15.7969))
        {
            Dialog_Show(playerid, DIALOG_SELLMINING, DIALOG_STYLE_TABLIST_HEADERS, "[��¡���Ѻ����]", "\
				������¡��\t�Ҥ�\n\
				�������䷵�\t{00FF00}$50\n\
				����Թ����\t{00FF00}$65\n\
				����ҹ�Թ\t{00FF00}$70\n\
				�����������\t{00FF00}$300", "���", "�͡");
        }
	}
	return 1;
}

Dialog:DIALOG_SELLMINING(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
			    new ammo = Inventory_Count(playerid, "�������䷵�");
			    new price = ammo*50;

			    if (ammo <= 0)
			        return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س������������䷵�����㹵�����");

		        GivePlayerMoneyEx(playerid, price);
		        SendClientMessageEx(playerid, COLOR_GREEN, "[��ҹ���] {FFFFFF}�س���Ѻ�Թ�ӹǹ {00FF00}%s {FFFFFF}�ҡ��â���������䷵� {00FF00}%d {FFFFFF}���", FormatMoney(price), ammo);
				Inventory_Remove(playerid, "�������䷵�", ammo);
		    }
	        case 1:
	        {
			    new ammo = Inventory_Count(playerid, "����Թ����");
			    new price = ammo*65;

			    if (ammo <= 0)
			        return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س���������Թ��������㹵�����");

		        GivePlayerMoneyEx(playerid, price);
		        SendClientMessageEx(playerid, COLOR_GREEN, "[��ҹ���] {FFFFFF}�س���Ѻ�Թ�ӹǹ {00FF00}%s {FFFFFF}�ҡ��â������Թ���� {00FF00}%d {FFFFFF}���", FormatMoney(price), ammo);
				Inventory_Remove(playerid, "����Թ����", ammo);
		    }
	        case 2:
	        {
			    new ammo = Inventory_Count(playerid, "����ҹ�Թ");
			    new price = ammo*70;

			    if (ammo <= 0)
			        return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س���������ҹ�Թ����㹵�����");

		        GivePlayerMoneyEx(playerid, price);
		        SendClientMessageEx(playerid, COLOR_GREEN, "[��ҹ���] {FFFFFF}�س���Ѻ�Թ�ӹǹ {00FF00}%s {FFFFFF}�ҡ��â������ҹ�Թ {00FF00}%d {FFFFFF}���", FormatMoney(price), ammo);
				Inventory_Remove(playerid, "����ҹ�Թ", ammo);
		    }
	        case 3:
	        {
			    new ammo = Inventory_Count(playerid, "�����������");
			    new price = ammo*300;

			    if (ammo <= 0)
			        return SendClientMessage(playerid, COLOR_RED, "[�к�] {FFFFFF}�س��������������������㹵�����");

		        GivePlayerMoneyEx(playerid, price);
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		        SendClientMessageEx(playerid, COLOR_GREEN, "[��ҹ���] {FFFFFF}�س���Ѻ�Թ�ӹǹ {00FF00}%s {FFFFFF}�ҡ��â������������� {00FF00}%d {FFFFFF}���", FormatMoney(price), ammo);
				Inventory_Remove(playerid, "�����������", ammo);
		    }
		}
	}
	return 1;
}

timer PlayerMiningUnfreeze[5000](playerid, number)
{
	new rand = randomEx(1, 200);
	new ore[24];
	switch(rand)
	{
	    case 1..100: ore = "�������䷵�";
	    case 101..102: ore = "�����������";
	    case 103..150: ore = "����Թ����";
	    case 151..200: ore = "����ҹ�Թ";
	}
    new ammo = Inventory_Count(playerid, ore)+1;

    if(ammo > playerData[playerid][pItemAmount])
    {
		TogglePlayerControllable(playerid, true);
		ClearAnimations(playerid);
		RemovePlayerAttachedObject(playerid, 3);

		DestroyDynamicObject(miningData[number][miningID]);
		DestroyDynamic3DTextLabel(miningData[number][mining3D]);
		miningData[number][miningOn] = 0;
		defer CreateMiningObject(number);
        SendClientMessageEx(playerid, COLOR_RED, "[�к�] {FFFFFF}�����آͧ {00FF00}%s {FFFFFF}㹡����Ҥس�������", ore);
        return 1;
	}

	TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);
	RemovePlayerAttachedObject(playerid, 3);

	DestroyDynamicObject(miningData[number][miningID]);
	DestroyDynamic3DTextLabel(miningData[number][mining3D]);
	miningData[number][miningOn] = 0;
	defer CreateMiningObject(number);
	
	new id = Inventory_Add(playerid, ore, 1);

	if (id == -1)
	{
	    SendClientMessageEx(playerid, COLOR_RED, "[�к�] {FFFFFF}�����آͧ�����������§�� (%d/%d)", Inventory_Items(playerid), playerData[playerid][pMaxItem]);
		return 1;
	}
	GivePlayerExp(playerid, 20);
	SendClientMessageEx(playerid, COLOR_WHITE, "�س���Ѻ {00FF00}%s +1", ore);
	return 1;
}

timer CreateMiningObject[20000](number)
{
	miningData[number][miningID] = CreateDynamicObject(miningData[number][miningObject], miningData[number][miningPos][0], miningData[number][miningPos][1], miningData[number][miningPos][2], 0.0, 0.0, 0.0);
	miningData[number][mining3D] = CreateDynamic3DTextLabel(miningData[number][mining3DMSG], COLOR_GREEN, miningData[number][miningPos][0], miningData[number][miningPos][1], miningData[number][miningPos][2] + 1.5, 5.0);
}
