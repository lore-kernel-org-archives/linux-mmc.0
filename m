Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010065.outbound.protection.outlook.com [52.101.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027C39E191;
	Wed,  3 Jun 2026 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471253; cv=fail; b=G9esbf7rTgVAuGiUcgdUh+PnzQVJ8mAxdm5Q7ik7uvjYqigtSCCLlMNLhdt9SpWsDXr/9nrIlgr7UZLM/XOfadkWunaUegYUPu1oZZMeq32HvaLypz9gHqHmK+5JpbT1MGad+8UuNzu8GUAU1Cc8f2zOoolKLcI2xR2Sslcw/rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471253; c=relaxed/simple;
	bh=RwoHJJl0xydiagYvqeGzpr67uhu1gCG38M4bDV8hRGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CMwStI8VqIf8Vo7CHKVGKvDJy8eoBKAwm/XKRSCwNSH3U0+TZW3/k3Q+XsCfarUBJ4Jlf5Eyr6P2ecETSf1VS8+z4QdQ3xfgvJ5PQUaAOWZYUBY38ueazw/kbAobptTexzBuWT/oBVrWszu74zy2hGcd8OmHZBQmaKHztEL9wpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=iyDFXR0X; arc=fail smtp.client-ip=52.101.228.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iyDFXR0X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrcIeZiLkAi+b1JEyNC9lGxHl+XLzB2ye0C+Kn6pjMJQ4MnCBkVN3/AXYNVsFtaFokIOPeuWTC/D/EbQnxQcb0wEF80DljmPnXVHZZy7jDj8/H2AXH1Wo/tj4uVyXd+/ZrgmI1oQnUbjE5ONfuhRbGsBYp7a5zsDEwiZXkNN5zSjBs9xN20a7LO+AAa657NknlnOSQ7QghmhtVamKyLq/0dUlnyy+FXLTEaXmHT8VF13Ns5R0hDCC6l5N7ykBQoC22j2+GJW4gF6hvAXe9WGTwAqBa0kPzv9DrZuP/aLuc+16tNeFz7anJX69RCdYIy8r5Y2NEH8/efY4otfya3DPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwoHJJl0xydiagYvqeGzpr67uhu1gCG38M4bDV8hRGU=;
 b=Xrgx8AKksramABuDwIl41Ke+sjbhrNdC6/VgsVjgs6MYoELIRGyPeYLnQf9Kw0YrUUAnB+stXHwJYxJOFwgrm79gHTfgbx1Gt/40+ZV+i+0MSOb56+Jm6ga+ZL4AtcLTLuYSYYcV3+sWt7fvXeEF4YuA62vslp86pQMZl7yr/Qx6hLAuRrkVtptTLO9/DNpVp4oDyeR+wZKSR4JGA3bNFR7v/oG2UiF8HSCekVIMHJ0+eLqWInK3vgYZJp7rMWoXvvYyD6oRlcIuKQdh35/0BdMm9jXrKUR3jTWZSlPF4nE5+4EB9hjRS3gIGTVBPFYbAmiDt3PwyJgBbDbL6RYSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwoHJJl0xydiagYvqeGzpr67uhu1gCG38M4bDV8hRGU=;
 b=iyDFXR0XOqhPCDjsSzbGLcjzcHaiXEHwhtF7QSDSeGiB6wPAkDXpDZuvrct2Ovp8oeoI40Ut4kZ/pfDsVlykAwMLbKFFExH5ROA5WAJdYQEzWD/KxvceZoyT7xdLUIgInG8NOMmiGM1fIsNmnipaSN0SkD6MRfQ2X8WtGI1kFtc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB8105.jpnprd01.prod.outlook.com (2603:1096:604:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:20:48 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:20:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: biju.das.au <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>, magnus.damm <magnus.damm@gmail.com>,
	wsa+renesas <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v17 00/17] Add Renesas RZ/G3L SD/eMMC support
Thread-Topic: [PATCH v17 00/17] Add Renesas RZ/G3L SD/eMMC support
Thread-Index: AQHc8yZFMuP1bVIRGUixq2TgdBuPhLYsZmtggAAETACAAABwgA==
Date: Wed, 3 Jun 2026 07:20:48 +0000
Message-ID:
 <TY3PR01MB113466E7F02EA5D4244F7EFE786132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
 <TY3PR01MB11346485C16AFB6299B1711FD86132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdVFScg51Uj2_C9YmwAOfG1+pmGiHgEr1=s0UD=OwPb-uQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVFScg51Uj2_C9YmwAOfG1+pmGiHgEr1=s0UD=OwPb-uQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB8105:EE_
x-ms-office365-filtering-correlation-id: 4de10c8b-c1c8-4582-910c-08dec140a298
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|4143699003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 k24PthaFfKx9VQ3E6iyzcd4NRe+v+Aca4029XcEXT6PpNpacVQsVbLP5YbWerM0fN7E5TZSOD66XIzoIP/bYp48Nyi0YS9OyKLzE6Xk7nTSRyPpaIBTk99NCyY9tmeEBrvmoR5Fm8DdxjChb3zGZBJVRSPIzsx6IJ9CyKobcMGKgg0TpgBGlXdcUHlMxEvIvGNQ9wc9f6HXTsBWN446qgdVdrChjaGoKvVvooasm1F2Rk210POn14thMKaNCcu0Om4UcpPSA5oTygyrdf/kkpXZy6Kr78VJil7J1VLlfIltYCHSfcf/n5l2pUKu1Cc5o/ecrFJA7fCTOtixrSy5TEuAubF4fen+FyOTloKckgGASPmMMP6v2/GAzeWzpEF8osrsIsmQFPhxt0LRGcuqp0P2SK0GKorybQaokBo+oCrVV0T3SSKQe1q/uYjc30BwK6CIwqbvbw9+4UOLHK4OaVq4T3ScUzFSCJF8pJFy2yyRhYG02mXzqLg3PrScHb31i8M4R1Pm/4aNfDBDO4bwKy3HiBR4WX2zyN3ZZp5i6DBiU9GLTjlxkui3kN/5bAE4KHIHiwAYb88lUj9pMtMTjVFG0GpgUQXSAux18G8IAWato8dTXFxiCmAwDBSrWjVSXVKQ2v6dLWGS+HK3Hd3SG9rvhKPGUok/rk1HD9z4dB6cnmYM4a/w1GHhbofwwKmiGku237QcfHfFuG6KqYLC4ot+vkdPvQDMPNrm6yMoZoUZDnV5oy2IpwIqP2cD9QncQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVhUVFQrMWptVWtESHorb0hRRDJKRFVXb2Y1b1FJN0Y0SmtUMldZVDZDNWNp?=
 =?utf-8?B?aVZ4Ri9DZ3hjc1VWa3NaNVI0dVJqblVzcnhzNG9rMWFVQ2FsOEZvekp4YmYr?=
 =?utf-8?B?QWRYbjYxZkFaVFR6VkN3S3QwbGJMcjJkVDNoRUN4eVFhTzJZWVVMUm9va0kz?=
 =?utf-8?B?VGoySWFYYVh1RE5QTExjYXJiaVI5VjBHZEJXLzErQUI4alhJcHp4U2o5cnZW?=
 =?utf-8?B?Q2h3SGliRWZHUXdhTE5nc3VUVkE0TFZtZFh3b1h3bUdaRmU3YkhTRXhzTmND?=
 =?utf-8?B?c0RDNXE3cnh0NWNXNkZaVUtmRHovUWNQZ0lGd3pXOS9Rd0VyQno5RmJLVld3?=
 =?utf-8?B?UkVZTnB4MUhvUktVc2VxbXIzT28wSVFzek1iY1RtRFdncDZyUFVGVkFNV3ha?=
 =?utf-8?B?NXB6VVpKdVZTVU1tR3M4Z0FWVkp4RG9la1QzNDlveC9DQWNTSHlHaTRQTVAy?=
 =?utf-8?B?aGM1MHhPSlVkM1JTcldacnArcDR3RlNVaUhKeEZzZXVKZzhlbGV2Tnp5RWFB?=
 =?utf-8?B?Yy85VVM5dm10ckhPU2hROFhQRDgrM2pHd3M4Z1oyWURrVDlqOFZSd2REbDZE?=
 =?utf-8?B?eWx4Z2V6UlBsNzhaaXZVKzh6RmdLSGVGR0d4b0lrcVdreDFXak01UnVHYTBP?=
 =?utf-8?B?enc0Z0xDWVdIaWhRMGR0TGJ0TzMybDZhWnRtVmlkWllPUEo3MTBBSWZvMG9x?=
 =?utf-8?B?cWF4Y3NnRUpvVGtjb1QwamFIOEJRZmNFVEVER1d0T3V5ZVZzSXFGYlRwUUFU?=
 =?utf-8?B?U3VQNFc3S3Z5dGJDa0Z4V3FabDczajZqTGhvUjJUZHF2MVhBeERvY2NGRUhE?=
 =?utf-8?B?T0NjbGVUTFBoZ2drNEJSdUtJanZ3WnFJWUtub2RzODkvbTdCSU0rVC9sUkpm?=
 =?utf-8?B?VU0rcFpIdlFKMGRFZVRreHlicTVIL1RGZUFOUjJZSC9QSXQzMnUvdDJ2dlB4?=
 =?utf-8?B?Q0RPNG9RQm1DeTNVRURjTTFWRzM5VjdNUThwUGZPcTZzc0cxemxWZGxFcWl5?=
 =?utf-8?B?amgvaVo1WUpLTDh6UEFhUWszQytKblVuRDhldiswK3B5QnUrZVlIMHhhd3lX?=
 =?utf-8?B?T0M2MzFrblNKdHFtL3VxUkN4ajNPS1ZENjZibVBJdTByWTljWVpJSit2eFIr?=
 =?utf-8?B?Uy94Rno3SkROVHZCUTN1Y1Jnd0NQTVpoNVRucnZQY0NwR2FZMGZ0UXZOcEcw?=
 =?utf-8?B?UVRlNnc1MkIvdjNXZjNPdkVHRFY0R0dxa0J2TWN2TWtweXV2MlJnY0lObTQ3?=
 =?utf-8?B?TVhzV1pUdkx5dHRKZUd6UG9PUjFLOEdxUmwxZXhxZ0x6TlhMOUNJWjFpU2Vt?=
 =?utf-8?B?Nkdlb0hrNW8rb3JtMlRVeTlkWGdZU0wzYkxRQzBwZUlCV0haU01OdlVGWEZp?=
 =?utf-8?B?NkhJM1k1RWc0a1pFS2RIMVlKRHNteE1CTkFZT0RVenh1bXFBSXlMdEJPU1JW?=
 =?utf-8?B?cWIxRHJnMEd3WWNnYlhFS2dLQ09iZGlMVzlyaUF2L2dVOXRIMHVtRmJSYUxo?=
 =?utf-8?B?Q29ZRkhqVUxQYyt6N3JDbnVQK0dIUzUrMTA3ZUVBSWtUeG13YTgrU0crRnRz?=
 =?utf-8?B?N1V2cFlLeVZOelAzOUprMG1nOGkrK3MwempQblREOTNOL2I1QjQ5czY5czZS?=
 =?utf-8?B?WjRXYTBvczBpejVxSjl1OFdHY3J1Z3laazlydXdLa2xqV2Y3d3RzdmNMK1Fi?=
 =?utf-8?B?TFZnL3RlNmg3N2JYQiszS09NRUZPM3o3NVN6VEhRZ1dZa0NsQTEycWhkaVQx?=
 =?utf-8?B?c21WcDRSS0s5ZDQxSGJRMlBINzJDR3M5Z0pFNXZtOXl4djBvektqZ1lRSkdM?=
 =?utf-8?B?dmRlSTZIQmxvWUtRajBwYkxWSnpYV0RxbU1BTFBtUkVJeXVtUkk3NXdZSVJk?=
 =?utf-8?B?Ym1oUGpLb2NrT3NIeTQ0VXhZakxvUkJHVkswSlBwckZSb3U5dGF3SFFHK3Vy?=
 =?utf-8?B?K1NOMkR6clpmR3lJbk03RnpWQnVkV2tVajg0S250NVFKZDlrdy9FYnVYUEdK?=
 =?utf-8?B?R05xUUVFMjk5TnFUZU9QRERUMDQzdGdiN3FDMHNpYS82VEl1cGRiMDhvR2xx?=
 =?utf-8?B?ajFnY3ViSjVXUStKelhLUDRhMEsvdVZ0Y2V0RUg2TlpyM1NrNFNHUVUyWXli?=
 =?utf-8?B?U05tcXlINTVTMTNmSDMySFlQcXptdW1xUmRtTU9TbHpYV2d3Y2E5Szc5WmRE?=
 =?utf-8?B?czlYZzR4N0daR1pmSVNLODlNRG5ROFFKWGZPWWFZK2Ntb3I5Y1E0WFc4K1I4?=
 =?utf-8?B?andNSWRJQnBmUitLWlczaGN1Tkg3VWw3T3ZDbWQzb2xXYWlOT2dmcDRNKzlR?=
 =?utf-8?B?OE5HdytYR0N3L09QREYwVVBIOHFLRHVkU1JtcFZiQmkrOGQ1bU5GUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de10c8b-c1c8-4582-910c-08dec140a298
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 07:20:48.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwtqV/VR2b1spJsQ+t8tcW3VMl16WUv+BFbYBVDqUUtPbcFGxbueryFOn6Xs8pHc2f1O+DkfBe5dAZAQW/2vNhuPZiVClZEHgqkCN1jyZ+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8105

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMDMgSnVuZSAyMDI2
IDA4OjE0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE3IDAwLzE3XSBBZGQgUmVuZXNhcyBSWi9H
M0wgU0QvZU1NQyBzdXBwb3J0DQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gV2VkLCAzIEp1biAy
MDI2IGF0IDA5OjAwLCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3Rl
Og0KPiA+IFBsZWFzZSBpZ25vcmUgdGhpcyBzZXJpZXMgYXMgYnkgbWlzdGFrZSBpbnN0ZWFkIG9m
IHBhdGNoIHNlcmllcyAyIEkNCj4gPiBtZW50aW9uZWQgaXQgYXMgUGF0Y2ggc2VyaWVzIDE3Lg0K
PiA+DQo+ID4gSSB3aWxsIGZpeCB0aGUgaXNzdWUgc29vbi4NCj4gDQo+IEhvdz8gSSBhbSBhZnJh
aWQgdGhlIG5leHQgcmV2aXNpb24gbXVzdCBiZSB2MTgsIG5vdCB0byBjb25mdXNlIGI0Pw0KDQpQ
cmV2aW91c2x5IHBhdGNod29yayBoYXMgbGlzdGVkIGFsbCB0aGUgcGF0Y2hlcyBpbiBvcmRlclsx
XSBhbmQgYjQgc29tZQ0KcGF0Y2hlcyB3ZW50IG91dCBvZiBvcmRlciBiZWNhdXNlIG9mIGEgbWlz
dGFrZSBJIGRpZCB3aGlsZSBzZW5kaW5nIG91dC4NCg0KQXMgdGhpcyBwYXRjaCBzZXJpZXMgaXMg
djIgdmVyc2lvbiBhbmQgbm8gcGF0Y2ggaXMgYmVpbmcgcmV2aWV3ZWQgcmF0aGVyIHRoYW4NCmJp
bmRpbmcgcGF0Y2ggaW4gdjEsIGRvIHdlIGNhcmUgYWJvdXQgYjQgdG9vbGluZz8NCg0KWzFdIGh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yZW5lc2FzLXNvYy9saXN0
Lz9zZXJpZXM9MTEwMzM0Nw0KDQpDaGVlcnMsDQpCaWp1DQoNCg==
