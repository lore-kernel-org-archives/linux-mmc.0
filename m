Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011012.outbound.protection.outlook.com [52.101.125.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4804963A6;
	Fri,  4 Sep 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519792; cv=fail; b=ZHANU/oPW5Tv6+UoMeOFQ7/Na73CKZZfMgXbEErq9LieczGTZns94Uo6CAjsFgGmBQj4So2dPggLqfxYjb0QgYUWyM0idj5plYdoS7YzSPjkTkNNYikLlwbKI0sAvnmOHv8oQnxWX+4QpGtAPq8o8hUkTL3d3WbeoyzaPFWGxoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519792; c=relaxed/simple;
	bh=oA9QATiW061RWDYysm1fFiR0XCKl9JuM+zEgqHgirSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OaLTGZGAci8eaU6fiWxoVJAHqoQvUdhZxvngM3qcCEyVkloPuB3cnSEF3HU3l1LKrXUw/TnxoTokMxYPsku3M+VCvCbSRw13QM7NslsGTJk8t2qgvptG0B1TNn7G1N198Ch0Q0WzDyeT0SipnhjOFe847yISKVHdcDhppQQlc/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=VecRrLnF; arc=fail smtp.client-ip=52.101.125.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VecRrLnF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlS+pdBcAuSZINpNJOB8AWB77iu4YPZNXML29HWZODB5kYBvx664WIg8MxnkAQ1zLysNWuchiUTKEH8VF86Sjq/FNpQ5szI5Y1WPEsj+DkUwX0yASomvrYhuZtsJdZItQbWHh2tfJSw+YcKCZ8/e4knLAHKClcAKmCKccEXIrC9FNN12qgleTpACCKNiCNzmvSp/PhHdeQw2hASGWGWEGprX1pNbd8skbBGZe8cHF+V1BT8jPFpfuOzErTwRExJYwPllLcA683OtXgP85ktPyMLy4Wy9ige49BLf80EWc0ANEVlGVp5TIZ7I95rUVvREiEs/+IwiwCNpukf1W7GPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA9QATiW061RWDYysm1fFiR0XCKl9JuM+zEgqHgirSc=;
 b=TaSaSckeEEX5C+UOJqc1U/OXDORQdooecyJ8MvQZ35YmMsGSq8WWvaeJ5pPqwyOv0q7G4rILW5AgxbKKUzGWpDUmn4QUWAIBwC9EhcHKQ2ofyNc6eekLb5labjPrBGOyodPsmzdi4TkZP2Pf7jWE5Y9rZBmOpud6jdLb1UPW9eJ4LsIFqeeYmDGIEb2u6s0w4ywE1hg2zrzCJKBproT+Eyv8mhI35fRkztZdtROio5d8FefjFua7M6F8dzTr/IppLyo1dZGjNFayZyMtXCBJsiXFEf7n5Me92rcWogxlcGt0RrMJqGpZgbW5ff9Mo74+bP4eKPKp203xyeEjC6kslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA9QATiW061RWDYysm1fFiR0XCKl9JuM+zEgqHgirSc=;
 b=VecRrLnFGLmDzhMGbY1gAGQwvcquTTkHMpmH1tLsIOmDvOrovmKHGMbXryzb+FaRCpuinQPeqr2F90rcls2gDATMUFtwrEFxkBhWFbVMmJGTeZxjWZBIuTLm6pc1IPKFZocz3RZrsYQABplgrLkgS8aoazYwiErfZ1rai6So7Bk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB15147.jpnprd01.prod.outlook.com (2603:1096:405:27f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 11:03:05 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 11:03:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 03/15] mmc: renesas_sdhi: Add clk_mask field to
 support flexible clock divider widths
Thread-Topic: [PATCH v24 03/15] mmc: renesas_sdhi: Add clk_mask field to
 support flexible clock divider widths
Thread-Index: AQHdMMe7/cj9jKCVakKzhdB3/4BEu7a7MS0AgAMkuXA=
Date: Fri, 4 Sep 2026 11:03:05 +0000
Message-ID:
 <TY3PR01MB11346A72764B85A9F9C41F6BC86B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-4-biju.das.jz@bp.renesas.com>
 <apgATHptEbhkohZo@shikoro>
In-Reply-To: <apgATHptEbhkohZo@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB15147:EE_
x-ms-office365-filtering-correlation-id: 49ab324d-de64-4cf8-ecaf-08df0a741885
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|22082099003|18002099003|38070700021|6133799003|10067099003|4143699003|11063799006;
x-microsoft-antispam-message-info:
 PQsF8i2LCm5Ahhmo/jO/GifXB1CmJeq4x6wa7kd37JLgE14xIji9YOUIwdb2RgNtGY3QehpvqL/Zsyr/WXhzhMZirtV61k9GY28b+9bh0Ern3RLgqqsVmjTtCEbctIMUucgNl2xqFtUoSKO4BskQLFuT74uTJSFGyapKKuu3Uzis4loU8UUr5Eg8t2JJgXxgUI9UDVfVcQOuh63dYmQZ81TE6QaExsXeVdrU6Pyd6gBC+teGUnxt8nNpFES2TvkvqnnYktOzpj/2QKxybKxPAStcS7PehjuvFBotlTtHFMV6B34RRCi5zavSn+8BKcFvmLEKbDCfYsLGQ01KJC5rWmTtW9o188gBOUpM0Mo1JuaABaDTunPNasHPbxMBs6JVpN2Pq80w68h8VMd/jh5NF7Xtfdwm55WBx63fTdwyVTVZlSsmiFPtWEuL0TR5e1U0F0dxk23X0UJ11pq/+hQSLCvWpjnnMQAxfwaXLMuAkqlnfKPX4WR+gaYz8IxE03aSNNwTUltXLCEiASxBvGHYcHcSevLGViGoN8nQCuL+EugVQM5MgmqW2MqaohLGz9OXiGhYa+55OflkVye8YqYMWXzp6o4ql1J2tuVVBB11Vuv8tzeN3l9MWH7KS1qoOx6A9kC9Ypkb29AWBZduJXt/lZLUXHNK5/01R/fF5CrQi7I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(22082099003)(18002099003)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTZPQjBqdHU2QXcwRmx5SFdrMU9od0pjbjdLcVpob1BockJOV29PbzhCZXow?=
 =?utf-8?B?QlhZc0VxWC9XamtNYktZekR5SEJWQmpXL1NpUDVsSGlLMEgzbTFxemV1Z3BE?=
 =?utf-8?B?TlVEVEl1MGdTR1h0b1ZLeEdWUWwxQmxRcnZxMUw5UG1xQWdlTWdqcVRpdVd4?=
 =?utf-8?B?S2xsL2Fxb0NId01UTDZXdnNpQ3g1Ky95a3VPRGcvTVoxZncrdzMyL1RnNzVs?=
 =?utf-8?B?VEZtbElMOE14VDZqWldGckRSNVhkYVJORFNXbU9hTnNNdy9EUFVRdkNHNWM5?=
 =?utf-8?B?L01VTC82YnhzVG83Z3ZxbXZrNjQ4eEVtZkJCU1VZVHNkelpWUW5FTkVGVkZ5?=
 =?utf-8?B?eHZtMDFQak5GaFZNc1kwSDBkSTJUTmx1YmdKRFNaeGg5Z1ZVRVd1ZEE4Y3dJ?=
 =?utf-8?B?Q0FFMEkwOVVWNDEyTmZtTFd2UTNtTHZDeWR4Skxpa0ZleGVwdzhWTENEYzhW?=
 =?utf-8?B?UU9JdGJOUWRpaVhXeTd5WWx0OEZCVm9rY0xTbHVhTll5a0hOdFZ3bXMybjRs?=
 =?utf-8?B?SERFeWoveFZXMWx2alRmUEVZUzlQbHUwVWU1WUZrbThIekdlZzNjWWNiRmZz?=
 =?utf-8?B?VWFYaDE1MTZFTFV5ZFJVampCaEpmMlppYStzQ0xQcWVxaXNVSHl2SDBwSFo5?=
 =?utf-8?B?RmFXdlAzc0ttTVN6c0sxZ2drU1Z0M3I5NHB1a0dTWlZmeWhnbUhXY3ZoaXpL?=
 =?utf-8?B?N3NqUFFMKzIya3JqZjE4alpJb2xkam1lVVlYajFsRTI3M0FQdk41UnMyc0Fa?=
 =?utf-8?B?Z0o5S01yeS9IWFI0MnhLN0MxTk1WNkd1Q0dTaHkrNzFSVkdtWWI3OGxUbFov?=
 =?utf-8?B?M1Z2WU12UEIydnZVN1Y2aGx4aTVvZmdLT29IN0NUQ1E5V3JrZnVCZzhVSzgv?=
 =?utf-8?B?a0IzKzNIVjRXKzkrZkNRQVBBekVQbnRzZnhDZVNka01QakhIcWoza2dRWUpW?=
 =?utf-8?B?ZjlNLy9HUGs3ZkF0QTMrMWVpK1NocnBwUEhMUHRwcmg1bkhac3ZtQ1hDNGln?=
 =?utf-8?B?ZVpwMmliYzhtMnJpV0ordHZINC8wY1JTOTZkV0hMdUVoVlRyNXJ0Z2ZkSkJJ?=
 =?utf-8?B?eDBqMUluVUI3VjNyK2dZNzBWWHdqWEVHSGZpS3M5dTQvMGxhd0pnazdPcmh6?=
 =?utf-8?B?TmZiT3FiVU9YcmV6MFFSZDVic0ZUZzZmbk15bWtVajFIT1gzK3NleTZvdEZ6?=
 =?utf-8?B?bXBnR25KUklBZUsrMlJLSmd0dzRweTJDdnV1RDk0NzlqenNvTlFGc2w1bkJU?=
 =?utf-8?B?WnpYL2ZUNzBlS2t3U09kdSt3RGFYWlZpUWtVcmV0aXZGYjVpNTl6N1pvais0?=
 =?utf-8?B?YWU1K1ZkUXhYUTBMdmlnWlRaOU83aGJFY0t4TGdyYktCWXV4K05DSFQ2M0Zk?=
 =?utf-8?B?aWpkRko4a3FJOFMveXZZeVErYmRvNlBjUFdXbG9KQktrL1c0enJnR01TcmJN?=
 =?utf-8?B?U2VsOTVLUGplWkRSbldtWjd4QlQyZ29oa24yKzFMNkZZdkh6TmVaM2k2ZTlI?=
 =?utf-8?B?TktCT0QzdG8xVDBHWUV1WEhuWWN3UDk1ZW5sRStJYjlsdExRY3dnTkpzNmpz?=
 =?utf-8?B?WG55c2xRL0NDK0xWZ2ZsYVRhekwwTzdxK1pzRVBGY0tZWHdRTUJKUnY3L2V0?=
 =?utf-8?B?TlcxbGloQzR2dlVya0hQWitWM1doTFFzK0xVN05qaExDbXF2d29xMUNyZW10?=
 =?utf-8?B?cUhVcUcxUjExUlovR2U0MEtXUUd4NWFuU2kvTktuTkhtRTIwaWJxOXpEdGt3?=
 =?utf-8?B?eDl0ZGpPL0ZndCtIblJFcjRheXZVYUVEZ09KVmxmYzFYVlpHUlVBQUNGQ2pj?=
 =?utf-8?B?ekplUi9rVzZKOVJDdW11RkRrUjY0cjcxaVVIalJCRWY0cmRFU3FMcmVxU00v?=
 =?utf-8?B?RGtWeUJ3M09tNFNnWjZHY2d4dy9QUitxOEtSWVVpd01BczRRVzd6K25HbVpV?=
 =?utf-8?B?bSsxY1lHYjk3b1c2Zk9FRWg5dDUwdDNJT3JGRU1RSnc2ZDYrSUpkY0lMQ2I5?=
 =?utf-8?B?T0tVT1FGZWROcmZrRjZSakFTYkJaTWNFdjFxVDI3VVU1Rzh2WmJNR3NONnpB?=
 =?utf-8?B?aXI3WllsUjRJVmtYeVNEeEVXd0FoMXEwNXpMZ2tRVHNBcmEzMzZMczFSNjUy?=
 =?utf-8?B?ajR1a3ViUXFHNisyV05VUEpjWC9CR210OWh5TnlMVGlWRmFoOGRFZ3NIMGl6?=
 =?utf-8?B?b2J6T2FVRVVwMVNPeUlqQkxZZ0VTRkRzV0dnV2NFcSszdURNdDd4dDY1MFE2?=
 =?utf-8?B?NTlFVit1QklzWllHV3VGOWMrdmRTTXJrc1VHVnpPOGdOZ3c2c2U0RGZDMzRp?=
 =?utf-8?B?WFFQVUtmY1ZFWUlVNUxlT2tpc2p3dFFkd2tuaEdVWGFXdU5CajlYQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ab324d-de64-4cf8-ecaf-08df0a741885
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 11:03:05.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnBEKxgub70n9y8ShqlOLiKeEGetgZYL2IEhKr8+hPGK9xyFEeFbXwolRMPcqQNRo1ni4f0ZCj57amhPdnEQmj1O+DrdSCWLqJ63ptoUYvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15147

SGkgV29sZnJhbSwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdv
bGZyYW0gU2FuZyA8d3NhK3JlbmVzYXNAc2FuZy1lbmdpbmVlcmluZy5jb20+DQo+IFNlbnQ6IDAy
IFNlcHRlbWJlciAyMDI2IDExOjU0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjI0IDAzLzE1XSBt
bWM6IHJlbmVzYXNfc2RoaTogQWRkIGNsa19tYXNrIGZpZWxkIHRvIHN1cHBvcnQgZmxleGlibGUg
Y2xvY2sgZGl2aWRlcg0KPiB3aWR0aHMNCj4gDQo+IEhpLA0KPiANCj4gU2FzaGlrbyBmb3VuZCBp
c3N1ZXMgd2l0aCB5b3VyIHBhdGNoLiBJIGN1cmF0ZWQgdGhlIGxpc3QgYW5kIGxlZnQgb25seSB0
aG9zZSB3aGljaCBJIHNlZSBhcyB2YWxpZC4gUGxlYXNlDQo+IGhhdmUgYSBsb29rIGF0IHRoZXNl
IGlzc3Vlcy4NCg0KV2UgbmVlZCB0byBkaXNjdXNzIHBvdGVudGlhbCBzb2x1dGlvbiBmb3IgdGhp
cyBpc3N1ZS4NCg0KPiANCj4gVGhhbmsgeW91IGFuZCBoYXBweSBoYWNraW5nLA0KPiANCj4gICAg
V29sZnJhbQ0KPiANCj4gPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtv
IEFJIHJldmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gPg0K
PiA+IFByZS1leGlzdGluZyBpc3N1ZXM6DQo+ID4gLSBbSGlnaF0gQSB2ZXJ5IGxvdyBvciB6ZXJv
IGNsb2NrIHJhdGUgZnJvbSB0aGUgY2xvY2sgcHJvdmlkZXIgY2F1c2VzIGFuIGluZmluaXRlIGxv
b3AgaW4NCj4gYHJlbmVzYXNfc2RoaV9zZXRfY2xvY2tgLg0KPiA+IC0tDQo+ID4NCj4gPiAtLS0g
UGF0Y2ggWzNdOiBbUEFUQ0ggdjI0IDAzLzE1XSBtbWM6IHJlbmVzYXNfc2RoaTogQWRkIGNsa19t
YXNrIGZpZWxkDQo+ID4gdG8gc3VwcG9ydCBmbGV4aWJsZSBjbG9jayBkaXZpZGVyIHdpZHRocyAt
LS0gY29tbWl0DQo+ID4gMWM3MzE4YjE0YzAyODY4NmZjOGNhNzAzZWI4YWMyYmUyNjk5MzdiNg0K
PiA+IEF1dGhvcjogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+DQo+
ID4gbW1jOiByZW5lc2FzX3NkaGk6IEFkZCBjbGtfbWFzayBmaWVsZCB0byBzdXBwb3J0IGZsZXhp
YmxlIGNsb2NrDQo+ID4gZGl2aWRlciB3aWR0aHMNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaW50cm9k
dWNlcyBhIGNsa19tYXNrIGZpZWxkIGluIHBsYXRmb3JtIGRhdGEgdG8gcmVwbGFjZSBhDQo+ID4g
aGFyZGNvZGVkIDMyLWJpdCBjbG9jayBtYXNrLCBzdXBwb3J0aW5nIDExLWJpdCBjbG9jayBkaXZp
ZGVycyBvbiBuZXdlcg0KPiA+IFNvQ3MgbGlrZSB0aGUgUlovRzNMLiBJdCB1cGRhdGVzIHJlbmVz
YXNfc2RoaV9zZXRfY2xvY2soKSB0byB1c2UgdGhlDQo+ID4gZHluYW1pYyBtYXNrIGFuZCBzZXRz
IHVwIGJhY2t3YXJkLWNvbXBhdGlibGUgZGVmYXVsdCBtYXNrIHZhbHVlcy4NCj4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvcmVuZXNhc19zZGhpX2NvcmUuYw0KPiA+ID4g
Yi9kcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMNCj4gPiA+IGluZGV4IGY5ZWM3
OGQ2OTlmNDUuLjYwNGQ4ODZlNDgzYzcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21tYy9o
b3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvcmVu
ZXNhc19zZGhpX2NvcmUuYw0KPiA+IFsgLi4uIF0NCj4gPiA+IEBAIC0yMTMsNyArMjEzLDcgQEAg
c3RhdGljIHZvaWQgcmVuZXNhc19zZGhpX3NldF9jbG9jayhzdHJ1Y3QgdG1pb19tbWNfaG9zdCAq
aG9zdCwNCj4gPiA+ICAJICogcHJvdmlkZWQgZm9yIGFjdHVhbF9jbG9jayBpbiByZW5lc2FzX3Nk
aGlfY2xrX3VwZGF0ZSgpLg0KPiA+ID4gIAkgKi8NCj4gPiA+ICAJY2xrX21hcmdpbiA9IG5ld19j
bG9jayA+PiAxMDsNCj4gPiA+IC0JZm9yIChjbGsgPSAweDgwMDAwMDgwOyBuZXdfY2xvY2sgKyBj
bGtfbWFyZ2luID49IChjbG9jayA8PCAxKTsgY2xrID4+PSAxKQ0KPiA+ID4gKwlmb3IgKGNsayA9
IGhvc3QtPnBkYXRhLT5jbGtfbWFzazsgbmV3X2Nsb2NrICsgY2xrX21hcmdpbiA+PSAoY2xvY2sN
Cj4gPiA+ICs8PCAxKTsgY2xrID4+PSAxKQ0KPiA+DQo+ID4gW1NldmVyaXR5OiBIaWdoXQ0KPiA+
IFRoaXMgaXNuJ3QgYSBidWcgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBidXQgZG9lcyB0aGlz
IGxvb3AgcmlzayBhbg0KPiA+IGluZmluaXRlIGhhbmcgaWYgdGhlIGNsb2NrIHByb3ZpZGVyIHJl
dHVybnMgYSB2ZXJ5IGxvdyByYXRlPw0KPiA+DQo+ID4gSW4gcmVuZXNhc19zZGhpX3NldF9jbG9j
aygpLCBpZiB0aGUgY2xvY2sgcHJvdmlkZXIgc3VwcGxpZXMgYSByYXRlDQo+ID4gc21hbGxlciB0
aGFuIHRoZSBtYXhpbXVtIGRpdmlkZXIsIHRoZSBkaXZpc2lvbiB0byBjYWxjdWxhdGUgdGhlDQo+
ID4gaW5pdGlhbCBjbG9jayB2YWx1ZSBjYW4gZXZhbHVhdGUgdG8gMC4gU2luY2UgMCA8PCAxIGlz
IHN0aWxsIDAsIHRoZQ0KPiA+IGxvb3AgY29uZGl0aW9uIG5ld19jbG9jayArIGNsa19tYXJnaW4g
Pj0gKGNsb2NrIDw8IDEpIHdpbGwgcmVtYWluDQo+ID4gcGVybWFuZW50bHkgdHJ1ZSBmb3IgYW55
IHN0cmljdGx5IHBvc2l0aXZlIG5ld19jbG9jayB2YWx1ZS4NCg0KDQpJZiAoaG9zdC0+bW1jLT5h
Y3R1YWxfY2xvY2sgPCA1MTIpLCB3ZSBnZXQgY2xvY2s9MC4NCg0KDQpJbiB0aGlzIGNhc2UsIHNo
YWxsIHdlIHNldCBkaXZpZGVyIHRvIG1heGltdW0gYW5kIHNraXAgdGhlIGxvb3A/DQpTbyB0aGF0
IGNsayBydW5zIHdpdGggbWF4aW11bSBhbGxvd2FibGUgZGl2aWRlciB2YWx1ZS4NCg0KUGxlYXNl
IHNoYXJlIHlvdXIgdGhvdWdodHMgb24gdGhpcy4NCg0KT3INCg0KRG8geW91IGhhdmUgZGlmZmVy
ZW50IHNvbHV0aW9uLCBwbGVhc2UgbGV0IG1lIGtub3c/DQoNCkNoZWVycywNCkJpanUNCg0KDQo+
ID4NCj4gPiBDb3VsZCB0aGlzIHByZXZlbnQgdGhlIGxvb3AgZnJvbSBldmVyIHRlcm1pbmF0aW5n
LCBjYXVzaW5nIGFuDQo+ID4gdW5yZWNvdmVyYWJsZSBDUFUgaGFuZz8gU2hvdWxkIHRoZXJlIGJl
IGFuIGFkZGl0aW9uYWwgc2FmZXR5IGNoZWNrDQo+ID4gKHN1Y2ggYXMgY2xrICE9IDAgb3IgY2xv
Y2sgPiAwKSBhZGRlZCB0byB0aGUgbG9vcCBjb25kaXRpb24gdG8NCj4gPiBncmFjZWZ1bGx5IGhh
bmRsZSBtaXNiZWhhdmluZyBjbG9jayBwcm92aWRlcnM/DQo+ID4NCj4gPiA+ICAJCWNsb2NrIDw8
PSAxOw0KPiA+ID4NCj4gPiA+ICAJLyogMS8xIGNsb2NrIGlzIG9wdGlvbiAqLw0KPiA+DQo+ID4g
LS0NCj4gPiBTYXNoaWtvIEFJIHJldmlldyDCtw0KPiA+IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9w
YXRjaHNldC8yMDI2MDgyMDE3MTY1Ny42MjgxNS0xLWJpanUuZGFzLmp6QGJwLnINCj4gPiBlbmVz
YXMuY29tP3BhcnQ9Mw0K
