Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795613843;
	b=I2W57VSL1lT8i5Il4mAIf4OeSOc0trPciXXU0l6TNsX61C1l8j0OWV8MR5vJ32wrpwu0
	 61lLT8EzJmvVgtUr83P/WW7t85KT9iyGs1LPCj4vGMIklddFs3fegu4fdabIGJNT5MYzS
	 kwHH1ipQ/G7Q6EJNBDpUblx8ve5laGXo2LSZK7oIIBwAMf99jauP4LYmw8blT4FC1hCdR
	 +GlWNh1FJXsoHFmEnTOhpI6Pq6W3peR9xUesAxVO3LlIETb3AxafhoIxDdv8fSCwBuDO6
	 mB3yRiso+Zeq5Sqb1Qzih5hrJX6v3jZ0/omeFAS5yetZpjhux8JhWkW9iJl9S81tQ4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613843;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SIjMCdL1EP8F5P/yiz5gkpMaVfdCXWPxjL203CPCSwk=;
	b=lcMKAElmxl0PexGKatSc3bHX9NuqsmBNVW0m4NOQXpth2nR1y+UbrgGsJfrwwJUCfB0z
	 CHxTs93BSMaOKnI8/HWEUHgDSyZYi44cvVsNVj2n7dG5fIfjAre8m3K9toK+2XfwP0N7R
	 Xcgl/nUi011bkiir0uZt2e45hmJbOCh7z2TML0DeEwKWikgzcjUz6js73cBcp1uH01PuQ
	 hpOdTStNCR3vlr/5kamuzLuzG6ubMPWKsxlfeq1pQn14LWANEg7J26Chh5Lw4ZRIWW1yy
	 BbaR9l62Kogs2NtMLqGKSA916il9nFfrtyVBVWTrDBNQ9KwmrD+yl322adjL4OIbMng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=nB0+RdUl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.25
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011025.outbound.protection.outlook.com [52.101.125.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900A606A321;
	Wed, 25 Nov 2026 13:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9900A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=nB0+RdUl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIcFEYSENrqPe49hhLnVkckzd45ZM4O0b0B1gWnq7CPq/E/S/lgcpXWnHolrRKzmjLmA+SI++0Im+LmMMKz7VLhQ8vUmGw/eJDhe9pC/f/OviqctJamvDibHWca4yEgbK3rJl06F2ngDvjpskKe/ynqXYrNJ7Oa+UrJ3TBFe4SF7AKwMtAnMbS3xDKqpd9jKcx3dpLWfPVaA5URXS3lO8RuNOwskNV+aVlWyhDuSW0Hat5xYcw48lhfv5UeXSakYcgTiZ+0vAwqWM2/Ytp8yS/gVHLkWti/nQjSnSUK8rgfmIcT5XJIUHDJlWUmieNzqdwJL5FeEtxRagx/zC13faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIjMCdL1EP8F5P/yiz5gkpMaVfdCXWPxjL203CPCSwk=;
 b=QsjBi2if3jWS2SIfBzyZnOnxpCuNXd6TH41WbdoxGHjvgZtRABvPdb1Zx2u2ZJ+S2EbIXTIZJrTHBbFVoZJ7lheuX6EEhocUGBtZh+PuZirU9IhQ3JRwDVV5W2LVUUCqgcBjoTrCG3SjD5Ej9h40LOd2DKIJqJ/Ua+TdI/8MkwANL+DcwhRNKmolRIW+ynDLUZNgJOSFLrnVVNCHAXfOjQYwzhv+chQEBI8WUefEdLkFCreSMdmZsvYDH+xiV4LhYqrJjE4xza6rZ/zqp2UwcladawqE06iOFOSpUgirFubXzcePPr5eiGlmEU3JlKAyiq9a4kHUL44SNdlALzbQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIjMCdL1EP8F5P/yiz5gkpMaVfdCXWPxjL203CPCSwk=;
 b=nB0+RdUl2iGpEZ51V63hYTFPhNa2wD/zIvzAlUk2hjl/o0ob1sichTYPMrBkEYGgnXCJBEXJKam+las8vogVz2AHNMFGi6gQc6IIrwo+KPLM13dFd+xY8/MQiRKx9uRwXxLm9rFvXYmEmsQ2M5L22s201OTlfQUCsXzMNeXsAx0=
Received: from OS3PR01MB6596.jpnprd01.prod.outlook.com (2603:1096:604:10a::8)
 by TYRPR01MB15470.jpnprd01.prod.outlook.com (2603:1096:405:287::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 13:37:18 +0000
Received: from OS3PR01MB6596.jpnprd01.prod.outlook.com
 ([fe80::58ce:825e:c38b:ec98]) by OS3PR01MB6596.jpnprd01.prod.outlook.com
 ([fe80::58ce:825e:c38b:ec98%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 13:37:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lee Jones <lee@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	=?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= <niklas.soderlund+renesas@ragnatech.se>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Adrian
 Hunter <adrian.hunter@intel.com>, Aidan MacDonald
	<aidanmacdonald.0x0@gmail.com>, Al Cooper <alcooperx@gmail.com>, Alex Dubov
	<oakad@yahoo.com>, Allen Pais <allen.lkml@gmail.com>, Apelete Seketeli
	<apelete@seketeli.net>, Aubin Constans <aubin.constans@microchip.com>, Binbin
 Zhou <zhoubinbin@loongson.cn>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Cavium Inc <support@cavium.com>,
	Christian Loehle <christian.loehle@arm.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Georgi Djakov <djakov@kernel.org>, Guangshuo Li
	<lgs201920130244@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Hiroshi
 DOYU <Hiroshi.DOYU@nokia.com>, Huacai Chen <chenhuacai@kernel.org>, Jaehoon
 Chung <jh80.chung@samsung.com>, Jan Glauber <jan.glauber@gmail.com>, Jarkko
 Lavinen <jarkko.lavinen@nokia.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Josua Mayer <josua@solid-run.com>, Juha Yrjola <juha.yrjola@nokia.com>, Kamal
 Dasu <kamal.dasu@broadcom.com>, Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Prabhakar Mahadev
 Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Lars-Peter Clausen
	<lars@metafoo.de>, "linux-amlogic@lists.infradead.org"
	<linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Paul Cercueil <paul@crapouillou.net>, Phil
 Blundell <pb@handhelds.org>, Pierre Ossman <drzeus@drzeus.cx>, Pramod Gurav
	<pramod.gurav@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>, Robert
 Richter <rric@kernel.org>, Samuel Ortiz <sameo@openedhand.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Tony Lindgren <tony@atomide.com>, Ulf Hansson
	<ulfh@kernel.org>, wsa+renesas <wsa+renesas@sang-engineering.com>, Yoshihiro
 Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 00/13] mmc: Assorted bug fixes across MMC host drivers
Thread-Topic: [PATCH 00/13] mmc: Assorted bug fixes across MMC host drivers
Thread-Index: AQHde39EmwGk/BJHN0mctvCzIQKx+bc+zFjw
Date: Wed, 25 Nov 2026 13:37:18 +0000
Message-ID:
 <OS3PR01MB65968B3C9FD48C0A7515AA1986432@OS3PR01MB6596.jpnprd01.prod.outlook.com>
References: <20261123191703.179283-1-lee@kernel.org>
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6596:EE_|TYRPR01MB15470:EE_
x-ms-office365-filtering-correlation-id: b878f87e-7e3d-44ae-b3e2-08df4af939a9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|38070700021|10067099003|5023799004|11063799006|56012099006|261021121427099003|261022075727099003|261021123027099003|261026121527099003|261022105027099003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 YmZo/FV+OIftOrSGjQBqwxzOPQ8Lci/FSTw1fzbTVcp28ggRWWM1PpQsUMXXfKXnjWUudpgoBBt70tz+SS6MR0FyWSQSxwTUWv0kCPlioutEBbva80eXERH8xeoZsbYGoFh8t877JE/KkVzIx0qFQEoPj4gYHKacgDva5exddvbGtRLm/IwkiK8IR7s3lTkywl0gQUuOV+oZa0ltFxZRrsEJgnoW/1ZPvlFkAMUEZBfjyDWoEaVX3WVBv32zCYdw/QvQJ3IXHPk9Ct8SSUo2J244WJ2L/NTKKwE0PLevXYWywAt3jcQTR6w0lLUq7K6zG1+xVFidK/FUhpVYx5qHedNko7i9Eh7HbbOC6kwjTfqQbgBC3lSahV5/G8Gq0jB2TQuxigc0fziD/yipofkj8JX3f9guUUNY9edtsxoQl4NPAD8S5eYA9HS1fC6x2FRouJbOTlILsS/kA34v9cuwjWBAG4pR7AnuUXY6qmJdEQIni47OaDxHTllLiY51Qg9qNH8pUcs8sng2Y6580FW2opXzSkw/XHGgHpj02WxLcYEC2OmQbWqVX66Zd8g0VU582Mu9qgzaLyhmvJl/eENkDV2Fa0qeRZCp3WOGf63dnuDnHvNBeybgisEzNjaSI8qVtKT9Ar243agyLtfTXCPXUiFr56iZtIb6bbeK2RD3VFIKA3JobP5bE0dQPpfvBsvZneaJovAOBf/nygCKARPPXmcNvVXRqFqsTh/TMzuvFwU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6596.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(38070700021)(10067099003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bG1KZTREZ0Zzeit0TXhhcFBnSy9jZGEwUEVxbkppTnpKVHFEVFdia2RMRDR3?=
 =?utf-8?B?VGthU2RHYnJaRTVsM1U5QjhLY0lyVHdreTBRR2JESTZwK2xqdGdyUjVET2Ur?=
 =?utf-8?B?bHZ1RHlSWEZhVy95aHBSd3lQdHZNdjFhalFvSVgyUWoyTjkxVmd3cit1YkNu?=
 =?utf-8?B?Z0F5bUMvOXJwMHhyYlhHK1EzSnFjQ2ltM0ppK1Ivam5ab21wUGpMRUR0SDls?=
 =?utf-8?B?RlNONnpyclV5Z0JHOGRjZ3c2WHlYT0pRWFk2ZFFma2pFWFNrSHBIbFhxUVdV?=
 =?utf-8?B?Ukdmc0hYVFpzbTZKQWt3UEg4OEdsUmx0eURoR2NVQjgvaG5rTWhrV1d6TDNE?=
 =?utf-8?B?RUdjejdtWE5yYndOUjdwdk1QU05wcEFhRXQ5bnFIU0ZUbHhyeC83VnNmT1hY?=
 =?utf-8?B?M1VHOTZXVlNXcVlzaE1GYjFLekV3aUVGRk9GK2k4SWQ3SVRBa2tsaTVHU0R1?=
 =?utf-8?B?eWR2ZTZYQ2ozTHJWOURBeXZMdlhrOUFoYklqQmorRDJqVVRMRmFpM282UWQ5?=
 =?utf-8?B?MkQ3cWxvYWEyUVNicVhIaENPTXlwUnJQVHRkK0R6TERtV2VwZEpSaDZwLzVS?=
 =?utf-8?B?UUhRcUMxRVFBbzUwNFlkdC9OaHZJaWg4RnBhMElleDkwY21mWStpaS9Pd1dI?=
 =?utf-8?B?Z1l4TUliQlRyQ3QrQVRyM2plMVkzcEFDMzBzZFYzdkkybUxUcXh2K2pYUGZv?=
 =?utf-8?B?T1drcmNVYW16RE9JMDJKRkpLMVRQSFZFSE9TM3N6SE5idW9UU2pxSGcybVBY?=
 =?utf-8?B?OElMZmJYTVA1eEJSSUFnZ1I1MEdzZ0lMRXVBY1dwYTFQNlBtcDgrWWYrTGJj?=
 =?utf-8?B?V28xaWM1OE5yUUlmYjU2dEVSaXFJMlVCR0R2YUoxMnRVcExuOVpabnJMZVpV?=
 =?utf-8?B?c0UybDc5MEZLd3IzdkJPWFVLTkJFNmgrVllCSTN5cStueUtsS3IwQU5mMVFS?=
 =?utf-8?B?b2I5UzltaXJWc29pTEJya3BpaDRlYTBRT2dUaUZIb3NRTGxnQVdtUis5eVpE?=
 =?utf-8?B?VGNqTHkwcnpzVTBWR2JjR0oxNjVzcC9sWWp2a0RleWZmK3RxeXUrNGp6RVBm?=
 =?utf-8?B?aHl2SGIrNGRKaE9DbXBwazdFMXhRTENLaEFZU0pmemhSTE1aQllrdU5aYnFH?=
 =?utf-8?B?dURWK1ZIaEVWYXZJVmNiUnBtdWc1Mk91QXRQOXoxbCtSZzV3NTYyNHpPbGhv?=
 =?utf-8?B?aXQrMi8rc2JSYTkwZUNHTHh3Qm42cktCR2sySWNlQmtoTTVmakhRRzBDazVZ?=
 =?utf-8?B?NGRLYTVZbG9PMlZON0p5Wko0YzhoRzRabE9hYkdLbm1FUUtiQnpHUkFBQ0pM?=
 =?utf-8?B?Z1NhcG01RmRGTEM4NVRIblVuV0s0Um93dG9PamNxeGgxOVRPS3hscFdPbnJ1?=
 =?utf-8?B?RUpxMHdWVVV0MEVIbURNNmtUV29BNHVUSEU1Q1R0d2xPZGllc3F2c0xCYU50?=
 =?utf-8?B?TGZsLzZxM0MrYTFwcE5iMmEyTVg5U3hQRU1FbjBONURoZ2huc29qSFdGeXBV?=
 =?utf-8?B?dGxrOWczSGJnSGNRMHBZQzVwZ2pybzZKVTBoVk1rYzh1N0lWNm9ZaFJLcm43?=
 =?utf-8?B?azRVQi83MnJLeG5nNUhYQXBrQjZIWkYzOXA3Sml4V1RtNGdkVzlqV0tqUnc5?=
 =?utf-8?B?amZoY0RTVHJ1TlIvT1MzWEV2N3FsSStqMmhzQ016dlB0OStpem9Wby9TUGNP?=
 =?utf-8?B?c1FaQjNZa0lkMmdkOW4zZEU2eTAzeSt6TnNHMm1uaFRtMVlWVGtSK2tQRmgr?=
 =?utf-8?B?V3RwaFJUdkgzTFJhSE9ta3Z4MFc0VUN1Y2FxNXNabWdjNXl5RURUVGhTYzk1?=
 =?utf-8?B?Z05jeGJNbStEMlBKTTFNZkRhU3lyVWM2WktwSGpXeGVrWkIyK2FpazRqc3lm?=
 =?utf-8?B?N0ZtQnI2K1ZDOVZORlNSU0RVU3ZJWFp2S29tNXllTmk2U3pUNXE3VVpGNGNs?=
 =?utf-8?B?aWU3bnd0UzhhK2I2c3MzOTdGY2dtV0VuNkxkMEVXeXVIQm9BcXg5VytZdlNi?=
 =?utf-8?B?WjVmSnZwRGFVSWxMWkxzelNVb0NjQmxOMUxFWWd1K295eU5GS2pFU3ZHYVR6?=
 =?utf-8?B?R3FnYmE0RFRGYzBBcXlEbFZRdW8razczS0NrUmRQVWxXNmE3cEdrTXB0Vk1o?=
 =?utf-8?B?cEcyUmtGVG51a1RVRVYvbHZuWXJmN2Q4eHZNRmMrUHRHeDluZlFKOTZONnVP?=
 =?utf-8?B?ZnprU0RIZjM3YkNUUjA1OHRRZ04zSzBPemczeVcxckljWlJ5STl6Z3hRaTBv?=
 =?utf-8?B?OEpZR2d4U05lci9seFZwV0dWeHdaVDdLeFNrblh5TUdUQzhBQmxhRURXWXBu?=
 =?utf-8?B?ZGcvWmtOV012SXRBbXYrN2QvYlkyTnRyZkxuZnZjOXd2Y3BwM3FWUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6596.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b878f87e-7e3d-44ae-b3e2-08df4af939a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 13:37:18.3969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QycnvyH/MDTYn8eNGjBQfpjlpAmmYQ/R9cRP+cEN34vmEnmyMRWXoZ1fx9wUVagmJyD1N9gK5uJwU/AnkK4I2l3tIWFjku1beetpKlWMfyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15470

SGkgTGVlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExlZSBKb25l
cyA8bGVlQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIzIE5vdmVtYmVyIDIwMjYgMTk6MTYNCj4gU3Vi
amVjdDogW1BBVENIIDAwLzEzXSBtbWM6IEFzc29ydGVkIGJ1ZyBmaXhlcyBhY3Jvc3MgTU1DIGhv
c3QgZHJpdmVycw0KPiANCj4gVGhlc2UgaXNzdWVzIHdlcmUgcmVwb3J0ZWQgYnkgU2FzaGlrby4N
Cj4gDQo+IE5vbmUgb2YgdGhlc2UgY2hhbmdlcyBoYXZlIGJlZW4gdGVzdGVkIG9uIHBoeXNpY2Fs
IGhhcmR3YXJlLg0KPiANCj4gQ2M6ICJNaWNoYcWCIE1pcm9zxYJhdyIgPG1pcnEtbGludXhAcmVy
ZS5xbXFtLnBsPg0KPiBDYzogIk5pa2xhcyBTw7ZkZXJsdW5kIiA8bmlrbGFzLnNvZGVybHVuZCty
ZW5lc2FzQHJhZ25hdGVjaC5zZT4NCj4gQ2M6ICJVd2UgS2xlaW5lLUvDtm5pZyAoVGhlIENhcGFi
bGUgSHViKSIgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+DQo+IENjOiBBYXJvIEtvc2tp
bmVuIDxhYXJvLmtvc2tpbmVuQGlraS5maT4NCj4gQ2M6IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5o
dW50ZXJAaW50ZWwuY29tPg0KPiBDYzogQWlkYW4gTWFjRG9uYWxkIDxhaWRhbm1hY2RvbmFsZC4w
eDBAZ21haWwuY29tPg0KPiBDYzogQWwgQ29vcGVyIDxhbGNvb3BlcnhAZ21haWwuY29tPg0KPiBD
YzogQWxleCBEdWJvdiA8b2FrYWRAeWFob28uY29tPg0KPiBDYzogQWxsZW4gUGFpcyA8YWxsZW4u
bGttbEBnbWFpbC5jb20+DQo+IENjOiBBcGVsZXRlIFNla2V0ZWxpIDxhcGVsZXRlQHNla2V0ZWxp
Lm5ldD4NCj4gQ2M6IEF1YmluIENvbnN0YW5zIDxhdWJpbi5jb25zdGFuc0BtaWNyb2NoaXAuY29t
Pg0KPiBDYzogQmluYmluIFpob3UgPHpob3ViaW5iaW5AbG9vbmdzb24uY24+DQo+IENjOiBCcm9h
ZGNvbSBpbnRlcm5hbCBrZXJuZWwgcmV2aWV3IGxpc3QgPGJjbS1rZXJuZWwtZmVlZGJhY2stbGlz
dEBicm9hZGNvbS5jb20+DQo+IENjOiBDYXZpdW0gSW5jIDxzdXBwb3J0QGNhdml1bS5jb20+DQo+
IENjOiBDaHJpc3RpYW4gTG9laGxlIDxjaHJpc3RpYW4ubG9laGxlQGFybS5jb20+DQo+IENjOiBG
bG9yaWFuIEZhaW5lbGxpIDxmbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbT4NCj4gQ2M6IEdl
ZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IENjOiBHZW9yZ2kg
RGpha292IDxkamFrb3ZAa2VybmVsLm9yZz4NCj4gQ2M6IEd1YW5nc2h1byBMaSA8bGdzMjAxOTIw
MTMwMjQ0QGdtYWlsLmNvbT4NCj4gQ2M6IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFp
bC5jb20+DQo+IENjOiBIaXJvc2hpIERPWVUgPEhpcm9zaGkuRE9ZVUBub2tpYS5jb20+DQo+IENj
OiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNhaUBrZXJuZWwub3JnPg0KPiBDYzogSmFlaG9vbiBDaHVu
ZyA8amg4MC5jaHVuZ0BzYW1zdW5nLmNvbT4NCj4gQ2M6IEphbiBHbGF1YmVyIDxqYW4uZ2xhdWJl
ckBnbWFpbC5jb20+DQo+IENjOiBKYXJra28gTGF2aW5lbiA8amFya2tvLmxhdmluZW5Abm9raWEu
Y29tPg0KPiBDYzogSmVyb21lIEJydW5ldCA8amJydW5ldEBiYXlsaWJyZS5jb20+DQo+IENjOiBK
b3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4gQ2M6IEp1aGEgWXJqb2xhIDxqdWhh
Lnlyam9sYUBub2tpYS5jb20+DQo+IENjOiBLYW1hbCBEYXN1IDxrYW1hbC5kYXN1QGJyb2FkY29t
LmNvbT4NCj4gQ2M6IEtldmluIEhpbG1hbiA8a2hpbG1hbkBiYXlsaWJyZS5jb20+DQo+IENjOiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+
DQo+IENjOiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNh
cy5jb20+DQo+IENjOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gQ2M6
IGxpbnV4LWFtbG9naWNAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogbGludXgtbWlwc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LW1tY0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51
eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1hcnRpbiBCbHVtZW5zdGluZ2wg
PG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+DQo+IENjOiBOZWlsIEFybXN0cm9u
ZyA8bmVpbC5hcm1zdHJvbmdAbGluYXJvLm9yZz4NCj4gQ2M6IFBhdWwgQ2VyY3VlaWwgPHBhdWxA
Y3JhcG91aWxsb3UubmV0Pg0KPiBDYzogUGhpbCBCbHVuZGVsbCA8cGJAaGFuZGhlbGRzLm9yZz4N
Cj4gQ2M6IFBpZXJyZSBPc3NtYW4gPGRyemV1c0BkcnpldXMuY3g+DQo+IENjOiBQcmFtb2QgR3Vy
YXYgPHByYW1vZC5ndXJhdkBsaW5hcm8ub3JnPg0KPiBDYzogUml0ZXNoIEhhcmphbmkgPHJpdGVz
aGhAY29kZWF1cm9yYS5vcmc+DQo+IENjOiBSb2JlcnQgUmljaHRlciA8cnJpY0BrZXJuZWwub3Jn
Pg0KPiBDYzogU2FtdWVsIE9ydGl6IDxzYW1lb0BvcGVuZWRoYW5kLmNvbT4NCj4gQ2M6IFNoYXdu
IExpbiA8c2hhd24ubGluQHJvY2stY2hpcHMuY29tPg0KPiBDYzogVG9ueSBMaW5kZ3JlbiA8dG9u
eUBhdG9taWRlLmNvbT4NCj4gQ2M6IFVsZiBIYW5zc29uIDx1bGZoQGtlcm5lbC5vcmc+DQo+IENj
OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcuY29tPg0KPiBDYzog
WW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiAN
Cj4gTGVlIEpvbmVzICgxMyk6DQo+ICAgbW1jOiBjYXZpdW06IFJlbW92ZSBNTUMgc2xvdHMgYmVm
b3JlIGRlc3Ryb3lpbmcgc2xvdCBwbGF0Zm9ybSBkZXZpY2VzDQo+ICAgbW1jOiBjYXZpdW06IFBy
ZXZlbnQgc2xvdF9wZGV2W10gb3V0LW9mLWJvdW5kcyB3cml0ZSBkdXJpbmcgcHJvYmUNCj4gICBt
bWM6IHNkaGNpLW1zbTogUmVzdW1lIHJ1bnRpbWUgUE0gYmVmb3JlIGFjY2Vzc2luZyByZWdpc3Rl
cnMgb24gcmVtb3ZlDQo+ICAgbW1jOiBtZXNvbi1neDogRmFpbCByZXF1ZXN0IHdoZW4gZGVzY3Jp
cHRvciBjaGFpbiBETUEgbWFwcGluZyBmYWlscw0KPiAgIG1tYzogano0NzQwOiBTa2lwIERNQSBj
bGVhbnVwIGluIFBJTyBtb2RlIGR1cmluZyBwb3N0X3JlcQ0KPiAgIG1tYzogcmVuZXNhc19zZGhp
OiBHdWFyZCBob3N0LT5jbWQgYWNjZXNzIGluIGludGVybmFsIERNQUMgaXNzdWUgd29yaw0KPiAg
IG1tYzogdGlmbV9zZDogU3luY2hyb25pc2UgdGltZW91dCBoYW5kbGVyIHdpdGggcmVxdWVzdCBj
b21wbGV0aW9uDQo+ICAgbW1jOiBvbWFwOiBTaHV0IGRvd24gY292ZXIgdGltZXIgYmVmb3JlIGRp
c2FibGluZyBjb3ZlciBCSCB3b3JrDQo+ICAgbW1jOiByZW5lc2FzX3NkaGk6IERpc2FibGUgaW50
ZXJuYWwgRE1BQyBCSCB3b3JrIGl0ZW1zIG9uIHJlbGVhc2UNCj4gICBtbWM6IGp6NDc0MDogQXBw
bHkgRE1BIG1heF9zZWdfc2l6ZSBsaW1pdCB0byB1bmlmaWVkIHR4LXJ4IGNoYW5uZWwNCj4gICBt
bWM6IGR3X21tYzogRGlzYXJtIGNlbnRyYWwgd2F0Y2hkb2cgd2hlbiBlbmRpbmcgYSByZXF1ZXN0
DQo+ICAgbW1jOiByZW5lc2FzX3NkaGk6IEZpeCBTRElPIG1hbnVhbCB0YXAgY29ycmVjdGlvbiBp
biBTRFIxMDQgbW9kZQ0KPiAgIG1tYzogc2RoY2ktYnJjbXN0YjogSGFuZGxlIGFic2VudCBvcHRp
b25hbCBzZGlvX2ZyZXEgY2xvY2sgaW4gcHJvYmUNCj4gDQo+ICBkcml2ZXJzL21tYy9ob3N0L2Nh
dml1bS1vY3Rlb24uYyAgICAgICAgICAgICAgfCAxNyArKysrKysrKysrKysrLS0tLQ0KPiAgZHJp
dmVycy9tbWMvaG9zdC9jYXZpdW0tdGh1bmRlcnguYyAgICAgICAgICAgIHwgMTUgKysrKysrKysr
KysrKy0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L2R3X21tYy5jICAgICAgICAgICAgICAgICAgICAg
fCAxNCArKysrKysrKysrKy0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9qejQ3NDBfbW1jLmMgICAg
ICAgICAgICAgICAgIHwgIDYgKysrKystDQo+ICBkcml2ZXJzL21tYy9ob3N0L21lc29uLWd4LW1t
Yy5jICAgICAgICAgICAgICAgfCAgNyArKysrKysrDQo+ICBkcml2ZXJzL21tYy9ob3N0L29tYXAu
YyAgICAgICAgICAgICAgICAgICAgICAgfCAgOCArKysrLS0tLQ0KPiAgZHJpdmVycy9tbWMvaG9z
dC9yZW5lc2FzX3NkaGlfY29yZS5jICAgICAgICAgIHwgIDkgKysrKy0tLS0tDQo+ICBkcml2ZXJz
L21tYy9ob3N0L3JlbmVzYXNfc2RoaV9pbnRlcm5hbF9kbWFjLmMgfCAxMyArKysrKysrKysrKysr
DQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWJyY21zdGIuYyAgICAgICAgICAgICAgfCAgNiAr
KysrLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktbXNtLmMgICAgICAgICAgICAgICAgICB8
ICA4ICsrKystLS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L3RpZm1fc2QuYyAgICAgICAgICAgICAg
ICAgICAgfCAxNiArKysrKysrKysrKysrKy0tDQo+ICAxMSBmaWxlcyBjaGFuZ2VkLCA5MiBpbnNl
cnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuNTYuMS43NTAuZ2Y3MGRj
NjgyY2YtZ29vZw0KPiANCg0KVGhpcyBzZXJpZXMgdGVzdGVkIG9uIHRoZSBmb2xsb3dpbmcgUmVu
ZXNhcyBib2FyZHMgYW5kDQp0aGVyZSBpcyBubyByZWdyZXNzaW9uLg0KDQpUZXN0ZWQtYnk6IEJp
anUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCg0Kc21hcmMtcnp2MmwsDQpzbWFy
Yy1yemczcywNCnNtYXJjLXJ6ZzNlLA0Kc21hcmMtcnpnMnVsLA0Kc21hcmMtcnpnMmxjLA0Kc21h
cmMtcnpnMmwsDQpyenYyaC1ldmssDQpyenQyaC1ldmssDQpoaWhvcGUtcnpnMm4tZXgsDQpoaWhv
cGUtcnpnMm0tZXgtdjFfMywNCmhpaG9wZS1yemcyaC1leA0KDQpDaGVlcnMsDQpCaWp1DQoNCg==
