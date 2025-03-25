Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503EB158520;
	Tue, 25 Mar 2025 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742870498; cv=fail; b=ewp5xt+ECpRhV/9OSdtyruwMs4YtWoCGTY2pThGMkLeYJsXLfp4raeEz2eySroU4IYY47msYKe49OxU93QoF6Rr305dzqkl1H5h6yzAvVUWw0DVT+U1yFZw7dJqB9I/nxPNYU/qILMaZrcaXlrYqP89FP21WA9wcSX4fROBJRxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742870498; c=relaxed/simple;
	bh=1VOeMpcpPB9ZLrFn5ZXJrIGx49NJUmEjFFl/2JNKTGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jnLtVgSa9413Doum3Rw3r3FEeJ+7CCQRT5eIUHEPantlcOrDADVT1Lf7C3IQDmWZtuxbsoWOtJY5kLxcSSO2ZMO9dZjG3c2DE4xpHRBy79mDppI1/KElbvilT4j0zSlKgT9l+MCleStmtPRHBAz4Q4b+T8mQakd4kHtH+hg9roA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FY99LvVj; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pe5IQsv8; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FY99LvVj";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pe5IQsv8"
X-UUID: a7eff91a092211f08eb9c36241bbb6fb-20250325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1VOeMpcpPB9ZLrFn5ZXJrIGx49NJUmEjFFl/2JNKTGI=;
	b=FY99LvVjAVTWXCWCHwQMPxguptZLuU4UsblT62BvY9dY1wcxjmfNaMbOQcuqy49SlKi0B0CDfGRRbCZtJ0lveNCCo6p12955yGy+UJAw/RXAeFsF89EMVrJxqjySdA/LTtSaWnTfAvVJl+b/qw+qjY0BYzRKTdFE5SAK/PDwNbw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:7893dc8b-ffa5-4740-b224-4ecf533a4e92,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:b08141a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a7eff91a092211f08eb9c36241bbb6fb-20250325
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 357660618; Tue, 25 Mar 2025 10:41:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 25 Mar 2025 10:41:28 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 25 Mar 2025 10:41:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYuPPlxmuIAtAqs5DOCwOuxe0F12SkBJ+Lgc8Xng/uceEdqju5h9UcwNn1Sik8VtP6LjUMFaBjPndlr8bEwnLD4lICuQPZOMGnS23xymisVR5VoC0HMQU5gZc6A1HQRgQdNDbc//h3KJl4ogjZnLpzWn+zm6IT49t1icb6sm/gz/AWwvBEOVcex4s/pjq2qX3M3rbKsZd4w4RVWPcS13agNba7NInNfTXYP0m7aaZ7HiHvGBPkj/ZXxHJxmbaVbhIBGO/jUUkpcOOiSnOuPeWDROTQnR0KK5PAKNJWms4qgxfafY39Tve/mxAjxVm0RrdkfbBqfgFb5I/qnCv/v2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VOeMpcpPB9ZLrFn5ZXJrIGx49NJUmEjFFl/2JNKTGI=;
 b=x3pAI+0oWI8/H1w8nyzhJsKVVwS+R0M8Z2G0QHiBjHhpKWAmuIPYWNBVr8vCM7Figaqon8Hf8YXVKimTtLmNwiu166Asl3N39xuJ2indunhjE7pOgZaqAUHQRB7o2/xs/691JH9Yzkei0SkhKeJxxYJDK6JjlJLM8ZEZToRkDy+ZFhUGaGnUQK25y86lBUWA68KJ7vNzC3XvOShR0ZH/Wg2VhGVl0fQdcBoV/W28/H86maIwJ8t90CN1KQ95GCM2ADkS7e04VuFhxfltifGxbYk1CX+zO/9PZYjTs6+zvdpVfn+b6hwAD+sGjo4S903ePZlObE/7TAnWB28CdV6u9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VOeMpcpPB9ZLrFn5ZXJrIGx49NJUmEjFFl/2JNKTGI=;
 b=pe5IQsv8+DW2u4wlPMg0i3fqK4/jhavpCNXYZU8tFir8bGGK+p7OZ0LBEUX5l8q7X9/5roAKoUTxiizoko+5r15Ffo0Y25HxHiWprixRSGpFXZ57jfCtoMr3rBH5BIyOV9fWHoVA4rn6Lls39Y8utUjRNmj1F1497u9Wi0WUvb4=
Received: from KL1PR03MB8416.apcprd03.prod.outlook.com (2603:1096:820:12c::7)
 by TYZPR03MB8167.apcprd03.prod.outlook.com (2603:1096:400:453::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 02:41:26 +0000
Received: from KL1PR03MB8416.apcprd03.prod.outlook.com
 ([fe80::1816:49d1:d866:bb7a]) by KL1PR03MB8416.apcprd03.prod.outlook.com
 ([fe80::1816:49d1:d866:bb7a%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 02:41:26 +0000
From: =?utf-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>
To: =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
	<Chaotian.Jing@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	=?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?WW9uZyBNYW8gKOavm+WLhyk=?= <yong.mao@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?UWluZ2xpYW5nIExpICjpu47mmbTkuq4p?= <Qingliang.Li@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: add single burst switch
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: mtk-sd: add single burst switch
Thread-Index: AQHbjnTYCsmvU5APUkGIYiImQzZRM7Nl1OqAgAFq/QCABnhcgIABW0IAgBQuXoA=
Date: Tue, 25 Mar 2025 02:41:26 +0000
Message-ID: <52d2f247a3058b96625bcdf5ab370282dfc9fb0e.camel@mediatek.com>
References: <20250306085028.5024-1-axe.yang@mediatek.com>
	 <20250306085028.5024-2-axe.yang@mediatek.com>
	 <3e84fda8-2566-4f18-8ef9-850c84789c34@collabora.com>
	 <f84800fac589429157cd84034ef2f4541d3486a7.camel@mediatek.com>
	 <b09f618a-eaf9-4258-ae2d-67eff1cb249f@collabora.com>
	 <f8ce830d831aaba0d2748d31f8ba4a9915b7a14e.camel@mediatek.com>
In-Reply-To: <f8ce830d831aaba0d2748d31f8ba4a9915b7a14e.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8416:EE_|TYZPR03MB8167:EE_
x-ms-office365-filtering-correlation-id: 3c5dafb8-01e5-44b7-5f26-08dd6b4689fa
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L2l5TFRhSmYrOEVhclhIaXExTzhBUWNmcXlaUjJ4NU8rTkFTOVZldTdtYW1N?=
 =?utf-8?B?eWdBVHA1QTB4enc5TDVsMVBhMnRBVUJGTmk5N21wMFdRam9uU0QvK094N3JD?=
 =?utf-8?B?U2pQaUhDZ0xZRTJjQWEzdVhleDFvazFxK3ZKYTBZSk5rem9ZR2ZOaTIvREZK?=
 =?utf-8?B?ckJJOXVkMFR4ZHVLWDgxaTBLZlFyMW9YQjRLb3BqTjMvdzVjQ3EvREtlWkZZ?=
 =?utf-8?B?SFZkOFFuYXE3NHo1dDE2UlpYeWtUemFOOGN0MUI5TEtBQjdNakNFYUlEWXdZ?=
 =?utf-8?B?N2VuWWZHSXZoODVidWlvQXArdjZ3SGZzZWozWlBQaWtZL0JaR0V3K3lEOXJL?=
 =?utf-8?B?NmZKWWZ3SHk1NDhsNzJXT3c4dE1PRnduQlBuMTk4a3IzY3hPMUQwekx0S0dX?=
 =?utf-8?B?K1hIUkwrL3gvOU13S1d3R1VsbExCVjhpRElLL0Q0NEJZN1lsazI1YjJjVVVE?=
 =?utf-8?B?emlmT2hEUzFkVDJjbWtjOEhiM3NXaHR1VTVKVU0zM0poZi8vVG1KSnVBTEdj?=
 =?utf-8?B?T09uOU1IVTc1bnE2Zjh1NUwyb05rdVF6U3pjUDg4VlhwTlBwOVJ3T3JDQlZ4?=
 =?utf-8?B?Vm9lTm04QnIzUERqSlIyQWFWcElEblNadmJCVEkySWthZldJYmx2RFdOYW1r?=
 =?utf-8?B?NWxOc2k5T013cStRYjBkdHVhNlZ1TkcvZTd6RWlmMnZ6RTVQdENYbjdERTQ0?=
 =?utf-8?B?UUlGTkVnNXlDeEUrNXcxOWFOdmtMaE8zczJGbityRmh3a1F3MHROcUxVY3RO?=
 =?utf-8?B?VkRaMHFYOWx3SkNzVHA1S2ZyNWFJd1FrZzRnNEJESWdTZXVNak1McnBMSlhu?=
 =?utf-8?B?bkJ6anFiMUptRGpFMi9mQ0U2TzFXN2hISFh4dG14bGhQemU0Q0FrYjBmQzRL?=
 =?utf-8?B?ckNuZXJiTDNuVGliZlpqbERmTzFuUmNZTFlFdWVBOXFlVnJEZXFmUlM2ejhD?=
 =?utf-8?B?Q3o5QjVxQzROL1FBWmpVdnFNWjJJUkErZnV3VEdDZVdXcGt3cXZBaFMwT0ZX?=
 =?utf-8?B?M0Zyc29DZDVYNUtGaWhMbytYcUNCK3NiVER6d3hwSDRyaHVYWkZTRGJ4NmIr?=
 =?utf-8?B?cHl1VkVRUDVvT0NyZFQwRS91NXdJWkErc1VBWUNCMXNHUWFRbVc1VHdkaWUr?=
 =?utf-8?B?dkswYWpwdU1naUhaZWdmbTgxTnBQNlRtemxCQ2REWTZiWmtYbXVHaW1FQlE4?=
 =?utf-8?B?bWxSTnNlbDNDTUQ0NXREYjJ0SFVsODB5c2I2TWFIbUJ3b3NkTmVQYUxzYkp1?=
 =?utf-8?B?TFNiMFhhSXlxSXpmcmE4Mm1PNTdRWXpCQVVVNitpcUxLSUFnUGZkdjRGd2Fn?=
 =?utf-8?B?TndoSG9qcXVRazQrcHBQR0habjU2TXlwQXppWk1Qb1NPWGYwMEQ4UXQ4aEk0?=
 =?utf-8?B?dzV2dStVWDBSM010VS8rVy9FbnNjc2xSZjhPUTRUNmJlMTBTMTA1T2pkRUt3?=
 =?utf-8?B?VzRwSHBvcGU0dlFhNEpIemZmSnRHRTUvM2dEVVI5Q2FTQmE3ZTRpRFVwdGl6?=
 =?utf-8?B?Q3Ywbzg3SnEwdHBLWlhPUy9zSGRacWZUc0Q3QU5nNURMWjBCb0pHOTBhNFRO?=
 =?utf-8?B?TUdDek1uYlIyVUZqMkFpTzVQMUMrTjBkWEVveVJKVENQZXpoYUtjaEN3R09i?=
 =?utf-8?B?L3dLeDQveXBUK2pXZCtUNDZhV3lsL29zVHBEeC9pYnRWczhUeU5sV3VJS2JE?=
 =?utf-8?B?eWRuN3NHV2NaU0doWW5tdkIwTEdidm1ON2xsZ1cvSVpVS0owenhubTlCSGlw?=
 =?utf-8?B?QnZ0QWRiY2s3MHpLR0tmYUNIVWl5L3NkMU9NUDZGMjVNZVlYelJIaThPdUlG?=
 =?utf-8?B?OGtRN0FOeVllMlBUQnJEOTZVUnAwTWFaMStQOXNOb245cjU3YmQxQWhLazFJ?=
 =?utf-8?B?dklOUTBEempSTWlBNXB3cmFuYmpObXlPV0psUUllbXdKcSthNzR1bXVxN0Vq?=
 =?utf-8?B?bVhBa0hjTWlMbDVUYWRSajYvUVRLWHFWYU5hMU1wTDNwN2h0WHFQSGlVZ3FD?=
 =?utf-8?B?NGZiUmpXektBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB8416.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFhVcnFpVjg5a1RxMHJXcXFwVlUzWER6OHhSalJtUnlBdTRVSjZXQ3lnU1pX?=
 =?utf-8?B?NTFFcVRHekJyRForZWhnZ0U3Rk1YMVBHaG5jMXZlR29DdVRkRXU3UnBaZzd3?=
 =?utf-8?B?UWJKcWJ0cG41TFVmRGVKM3I4N0hzWW9RdjAxMXI1NllsZHhCb3NFMldpKy9n?=
 =?utf-8?B?R3JUT3ZXaFQvUzFJTmY1TzhOdHFEeHNKQU9NWS9La2FHVGZ0dXV6SUFLQ1R6?=
 =?utf-8?B?b00rVW1KSTdudmtLUVM0bWdPL1o3a3hJbGFKVWMwWTlZZWlMOWpTRVJ4ZVk5?=
 =?utf-8?B?TXV0S3U3OVptQkhWTWRlcW1FVlhNZkU2M3VaS3hyTnV0UHZGTWtVaUNzRmVk?=
 =?utf-8?B?QjYwZ0QzUVFSZ0xlNDE2elBKdGVOU1Z1WFdQZU1KbkpHbVEvWHZ6ZkZBTjZ3?=
 =?utf-8?B?eDRrMTVkOTh6VjUzcU1OU3lLanp1aVBmanR5WjBoc2orUTVEUG9GbzlZTGVF?=
 =?utf-8?B?Z1kzNEZCSDgwQnpzb2oybHQyN3ZySEx2ZmVBRGV0TjIrMElNZ1R6SHhwcmEv?=
 =?utf-8?B?QUN2SzZYNjJoU2ErUnVDejllOGtWZGlzeWFIL01yZlFHSWZ3OFFjV3F3NE00?=
 =?utf-8?B?RVorQUdzdTFOSm5qRk0xcXpGZEQwclQyc2JWenlBaytNSDVtbi9DU2tqM3B4?=
 =?utf-8?B?blUyelE4eFdXYmt0bTc4VjhzTzlNMFBZUkNkTGZ2eDRXRlhmZ1FHek1DaXZz?=
 =?utf-8?B?QlZyRjZYVGtZZWFDNWdGNW9HUWFKenJHRm8zakVidjU0ZGJuK01NZDBnRDgy?=
 =?utf-8?B?bTF6VVdkSThQMW1vYmNmRGlza2RvOW5ML0pDbTIxc3FCMGhmNUdZTmlBb1hK?=
 =?utf-8?B?SUNuNU45K1lEZnkwemhESkFhQkxBLzE2U1cvdjBXa3g4UStHZk5wRkZraE15?=
 =?utf-8?B?UXdqaWg4am85YzVqSyt1czBQVzVWdFFzeFMzTWJuY1lhTzVOYks0Tk9OdDNV?=
 =?utf-8?B?MmcraTFNNEk2dWtlanh1aGtZMkFBV1RaNmRNY2Y3MXJkRWpTczQwQjFkUlFU?=
 =?utf-8?B?MzdUSE03YlpLYkhsbkVRQm9TTGlhSlVNRWpnYmZYSnBSZGNtQU1aSEFrYUhw?=
 =?utf-8?B?S2VVTXozZ05jaUViVk45dXkvV253T1o2MERSQ09xelVBUzl3eTJZMGZDNGRE?=
 =?utf-8?B?dkZQWHdOQ0EvY2owd3UxWDJsVnVybG9IMmFvZGZIYVo4V3Y2U09SVVp0N0RJ?=
 =?utf-8?B?VitQQmJyVFF6c3dQZGZ5L1hOdm9SL3NWVzJaYVUrSjBnMUJTdDZ5eTRZdFJ2?=
 =?utf-8?B?a2hlbklqQ3pSZWZoZmZJQStUQ1F5Qlo2dkZUNElwZVlacXdFZHhoT2FHWG5G?=
 =?utf-8?B?d3BpRnZRc0ZvdC9vMVkzRlFMenBmbUVJY3dDMFlvQmRQeWFBM2JkcG9MRHcy?=
 =?utf-8?B?ODZZTHE1cGNiYVpiYlRXdkJ1L2cxb2poMXNuR0tZNDdTNGtLLy9XSzc3TU9q?=
 =?utf-8?B?OFg0OHU4Q2hyS1grcjIwL0lTRkhOTUJCVy9EQysrY3NXM3F3WDFuZXBDcHpu?=
 =?utf-8?B?dG1vSWc5bTBuMEVWbWgzajA4bzg4azZGZCs4VHpxKzliWGYxU0tncHQvNWlS?=
 =?utf-8?B?aEZNUmVIR0drU0dzUzJtdFdPQVlUUVlLdFN3dkNsSE1abjBUWTBOdm4yT0ky?=
 =?utf-8?B?TXI2SGsyamR4MkdmMDVMbkdBZXBsalhvS1o3RTlWcEdObDcrRmpCbmNIZkh6?=
 =?utf-8?B?elVzbWRzWWQ2U1IyYTNlSkt2bHdoMG1EU0t2M3g5U1RBR1NMWVZ5aEVwbUF0?=
 =?utf-8?B?VWR1MGtrNUhNNkFHcWZCcS9IWU1zTFFoeTQ1Q3grdDZXcjZ3TzRQU0IwVnhm?=
 =?utf-8?B?Q1VBSFhoVFFJZTlCOE0zaGQyTnY2SmFjZW9oRktUYnJ5cjBlSW9YUThZTFE2?=
 =?utf-8?B?cUEwN0szc1pZWWxTb21rVlJFcVBadFZXMjJZZ3lBZjBZcUtjMWlSNDR2eURz?=
 =?utf-8?B?eWdXVTBvSnhHSmNXWGREbzJaYjAwYlhoejBRWUtJRFJ5ZDlmb0JLclFTL2tL?=
 =?utf-8?B?MGVrU1U4cnljYTdxeE5xcXBSVVk3RUUwaHYrR1JFUGVLMVNXdjBTSEZHVGoy?=
 =?utf-8?B?QUlFeW9ZU1lQckpCUXJzeEdWMUh4Y29FcU5uRXBEb1NQUEJHQm1JUDROWXl2?=
 =?utf-8?Q?/U3jly1BzYjQc3KNEMfSFGKX6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BF0FCF5DEDAC74A9D31475CCF5DF939@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8416.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5dafb8-01e5-44b7-5f26-08dd6b4689fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 02:41:26.2755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJUHeCVwJkd0K8WXfMtTz3X3DrVpafyJuLYF3zFzw1ICuUrno2JL2U0Yv0+aou1mFJRZys4JuxY7ZJJbGsD6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8167
X-MTK: N

SGkgQW5nZWxvLA0KDQpBbnkgY29tbWVudCBvbiB0aGlzIDpEIA0KDQpSZWdhcmRzLA0KQXhlDQoN
Ck9uIFdlZCwgMjAyNS0wMy0xMiBhdCAxNDozMCArMDgwMCwgYXhlLnlhbmcgd3JvdGU6DQo+IE9u
IFR1ZSwgMjAyNS0wMy0xMSBhdCAxMDo0NyArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gd3JvdGU6DQo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiB1bnRpbA0KPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gDQo+ID4gDQo+ID4gSWwgMDcvMDMvMjUgMDc6
NTksIEF4ZSBZYW5nICjmnajno4opIGhhIHNjcml0dG86DQo+ID4gPiBPbiBUaHUsIDIwMjUtMDMt
MDYgYXQgMTA6MTkgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gPiB3cm90
ZToNCj4gPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMNCj4gPiA+ID4gdW50aWwNCj4gPiA+ID4geW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiBJbCAwNi8wMy8yNSAwOTo0OCwgQXhlIFlhbmcgaGEgc2NyaXR0bzoNCj4gPiA+ID4gPiBBZGQg
J21lZGlhdGVrLGRpc2FibGUtc2luZ2xlLWJ1cnN0JyBzZXR0aW5nLiBUaGlzIHByb3BlcnR5DQo+
ID4gPiA+ID4gY2FuDQo+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiB1c2VkIHRvIHN3aXRjaCBidXMg
YnVyc3QgdHlwZSwgZnJvbSBzaW5nbGUgYnVyc3QgdG8gSU5DUiwNCj4gPiA+ID4gPiB3aGljaA0K
PiA+ID4gPiA+IGlzDQo+ID4gPiA+ID4gZGV0ZXJtaW5lZCBieSB0aGUgYnVzIHR5cGUgd2l0aGlu
IHRoZSBJUC4gU29tZSB2ZXJzaW9ucyBvZg0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IElQDQo+
ID4gPiA+ID4gYXJlIHVzaW5nIEFYSSBidXMsIHRodXMgdGhpcyBzd2l0Y2ggaXMgbmVjZXNzYXJ5
IGFzICdzaW5nbGUnDQo+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiBub3QNCj4gPiA+ID4gPiB0aGUg
YnVyc3QgdHlwZSBzdXBwb3J0ZWQgYnkgdGhlIGJ1cy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBBeGUgWWFuZyA8YXhlLnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAN
Cj4gPiA+ID4gSSBhbSBtb3N0bHkgc3VyZSB0aGF0IHRoaXMgaXMgbm90IHNvbWV0aGluZyB0byBw
dXQgaW4NCj4gPiA+ID4gZGV2aWNldHJlZSwNCj4gPiA+ID4gYnV0DQo+ID4gPiA+IGFzDQo+ID4g
PiA+IHBsYXRmb3JtIGRhdGEgZm9yIHNwZWNpZmljIFNvQyhzKSwgYXMgbXVjaCBhcyBJJ20gbW9z
dGx5IHN1cmUNCj4gPiA+ID4gdGhhdA0KPiA+ID4gPiBhbGwgb2YNCj4gPiA+ID4gdGhlIGluc3Rh
bmNlcyBvZiB0aGUgTVNEQyBJUCBpbiBvbmUgU29DIHdpbGwgYmUgKmFsbCogdXNpbmcNCj4gPiA+
ID4gZWl0aGVyDQo+ID4gPiA+IHNpbmdsZQ0KPiA+ID4gPiBvciBJTkNSLg0KPiA+ID4gDQo+ID4g
PiBObywgYWN0dWFsbHkgTVNEQyBJUHMgaW4gb25lIFNvQyBhcmUgdXNpbmcgZGlmZmVyZW50IHZl
cnNpb25zLg0KPiA+ID4gVXN1YWxseSBNU0RDMSAoaW5kZXggZnJvbSAxKSBpcyB1c2VkIGFzIGVN
TUMgaG9zdCwgdGhlIGxlZnQgaG9zdHMNCj4gPiA+IGFyZQ0KPiA+ID4gdXNlZCBhcyBTRC9TRElP
IGhvc3RzLiBUaGV5IGhhdmUgc2ltaWxhciBkZXNpZ25zLCBidXQgdGhlcmUgYXJlDQo+ID4gPiBz
dGlsbA0KPiA+ID4gZGlmZmVyZW5jZS4NCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gU28sIEkg
dGhpbmsgSSBrbm93IHRoZSBhbnN3ZXIgYnV0IEknbGwgc3RpbGwgYXNrIGp1c3QgdG8gYmUNCj4g
PiA+ID4gZXh0cmVtZWx5DQo+ID4gPiA+IHN1cmU6DQo+ID4gPiA+IA0KPiA+ID4gPiBpcyB0aGVy
ZSBhbnkgTWVkaWFUZWsgU29DIHRoYXQgaGFzIGRpZmZlcmVudCBJUCB2ZXJzaW9ucyBmb3INCj4g
PiA+ID4gZGlmZmVyZW50IE1TREMNCj4gPiA+ID4gaW5zdGFuY2VzLCBhbmQgdGhhdCBoZW5jZSBy
ZXF1aXJlIHNpbmdsZSBidXJzdCBvbiBvbmUgaW5zdGFuY2UNCj4gPiA+ID4gYW5kDQo+ID4gPiA+
IElOQ1Igb24NCj4gPiA+ID4gYW5vdGhlciBpbnN0YW5jZT8NCj4gPiA+IA0KPiA+ID4gWWVzLiBB
Y3R1YWxseSBldmVyeSBTb0MgaGFzIGRpZmZlcmVudCBJUCB2ZXJzaW9ucyBmb3IgZU1NQyBhbmQN
Cj4gPiA+IFNEL1NESU8NCj4gPiA+IGhvc3QgYXMgSSBzYWlkLg0KPiA+ID4gZS5nLiBGb3IgTVQ4
MTY4LCBzaWduZWwgYnVyc3QgYml0IHNob3VsZCBiZSBzZXQgdG8gMSBmb3IgZU1NQw0KPiA+ID4g
SG9zdCwNCj4gPiA+IGJ1dA0KPiA+ID4gMCBmb3IgU0QvU0RJTyBIb3N0Lg0KPiA+ID4gDQo+ID4g
PiA+IA0KPiA+ID4gPiBBbmQgaWYgdGhlcmUgaXMgLSBpcyB0aGVyZSBhIHBhdHRlcm4/IElzIGl0
IGFsd2F5cyBTRElPDQo+ID4gPiA+IHJlcXVpcmluZw0KPiA+ID4gPiBJTkNSIG9yDQo+ID4gPiA+
IGFsd2F5cyBlTU1DL1NEIHJlcXVpcmluZyBpdD8NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBObywgdGhlcmUgaXMgbm8gcGF0dGVybi4gQm90aCBlTU1DIGFuZCBTRC9TRElPIGhv
c3RzIG5lZWQgdG8gYmUNCj4gPiA+IGNvbmZpZ3VyZWQgYmFzZSBvbiBJUCB2ZXJzaW9uLiBUaGVy
ZSBpcyBubyBiaW5kaW5nIHJlbGF0aW9uc2hpcA0KPiA+ID4gYmV0d2Vlbg0KPiA+ID4gZU1NQy9T
RC9TRElPIGFuZCB0aGUgYnVyc3QgdHlwZS4gZU1NQyBidXJzdCB0eXBlIG1pZ2h0IGJlIElOQ1Ig
b3INCj4gPiA+IHNpbmdsZSwgc2FtZSBhcyBTRC9TRElPLg0KPiA+ID4gDQo+ID4gDQo+ID4gT2th
eSBidXQgaWYgdGhlcmUgYXJlIGRpZmZlcmVudCBJUCB2ZXJzaW9ucywgYW5kIEFYSS9BSEIgaXMN
Cj4gPiBkZXRlcm1pbmVkDQo+ID4gYnkgdGhlIElQIHZlcnNpb24sIHdoeSBhcmVuJ3QgeW91IHBh
cnNpbmcgdGhlIE1BSU5fVkVSL0VDT19WRVINCj4gPiByZWdpc3RlcnMgb2YNCj4gPiB0aGUgTVNE
QyBJUCB0byBjaGVjayB3aGV0aGVyIHRvIHVzZSBJTkNSIG9yIFNJTkdMRT8NCj4gDQo+IA0KPiBU
byBhZGRyZXNzIHlvdXIgY29uY2VybnMsIEkgaGFkIGZ1cnRoZXIgZGlzY3Vzc2lvbnMgd2l0aCB0
aGUNCj4gZGVzaWduZXIuDQo+IFRoZWlyIHJlc3BvbnNlIHdhcyB0aGF0IHRoZSBidXMgdHlwZSBh
bmQgSVAgdmVyc2lvbiBhcmUgbm90IGJvdW5kDQo+IHRvZ2V0aGVyLiBUaGlzIGNvbnRyYWRpY3Rz
IG15IHByZXZpb3VzIHN0YXRlbWVudHMsIGFuZCBJIGFwb2xvZ2l6ZQ0KPiBmb3INCj4gdGhhdC4N
Cj4gQWNjb3JkaW5nIHRvIHRoZSBkZXNpZ25lcidzIGZlZWRiYWNrLCBJIG11c3Qgc2F5IHRoYXQg
dGhlIHNpbmdsZQ0KPiBidXJzdA0KPiBzZXR0aW5nIGlzIGluZGVlZCB0aWVkIHRvIHRoZSBJQywg
YnV0IHRoZSBncmFudWxhcml0eSBpcyBzdWNoIHRoYXQgaXQNCj4gbmVlZHMgdG8gYmUgc2V0IGlu
ZGl2aWR1YWxseSBmb3IgZWFjaCBob3N0Lg0KPiBHaXZlbiB0aGUgbGFyZ2UgbnVtYmVyIG9mIElD
cyBNZWRpYXRlayBjdXJyZW50bHkgaGFzLCBhZGRpbmcgYnVyc3QNCj4gdHlwZQ0KPiBpbmZvcm1h
dGlvbiBmb3IgZWFjaCBob3N0IHRvIHRoZSBkcml2ZXIncyBjb21wYXRpYmxlIHN0cnVjdHVyZSB3
b3VsZA0KPiBtZWFuIGFkZGluZyBodW5kcmVkcyhtYXliZSB0aG91c2FuZHMgOigpIG9mIGxpbmVz
IHRvIHRoZSBkcml2ZXIgZm9yDQo+IHRoZQ0KPiBjb21wYXRpYmxlIHN0cnVjdHVyZXMgZm9yICph
bGwgcHJldmlvdXMgU29DcyogKGN1cnJlbnRseSB0aGVyZSBhcmUNCj4gb25seQ0KPiAxMyBjb21w
YXRpYmxlIHN0cnVjdHVyZXMsIGFuZCB0aGV5IGNhbiBiZSByZXVzZSBieSBuZXcgU29DKS4gVGhp
cw0KPiBhcHByb2FjaCBzZWVtcyB2ZXJ5IGN1bWJlcnNvbWUuDQo+IA0KPiBTbyBJIHN0aWxsIGJl
bGlldmUgdGhhdCBwbGFjaW5nIHRoaXMgc2V0dGluZyBpbiB0aGUgRFRTIGlzIGEgbW9yZQ0KPiBh
cHByb3ByaWF0ZSBhcHByb2FjaC4NCj4gDQo+IFJlZ2FyZHMsDQo+IEF4ZQ0KPiANCj4gPiANCj4g
PiBDaGVlcnMsDQo+ID4gQW5nZWxvDQo+ID4gDQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4g
PiBBeGUNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwgfCA4
DQo+ID4gPiA+ID4gKysrKysrKysNCj4gPiA+ID4gPiAgICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLQ0KPiA+ID4gPiA+IHNkLnlhbWwNCj4gPiA+
ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwN
Cj4gPiA+ID4gPiBpbmRleCAwZGViY2NiZDY1MTkuLjYwNzZhZmYwYTY4OSAxMDA2NDQNCj4gPiA+
ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55
YW1sDQo+ID4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21t
Yy9tdGstc2QueWFtbA0KPiA+ID4gPiA+IEBAIC0xMDAsNiArMTAwLDE0IEBAIHByb3BlcnRpZXM6
DQo+ID4gPiA+ID4gICAgICAgIG1pbmltdW06IDANCj4gPiA+ID4gPiAgICAgICAgbWF4aW11bTog
MHhmZmZmZmZmZg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICsgIG1lZGlhdGVrLGRpc2FibGUtc2lu
Z2xlLWJ1cnN0Og0KPiA+ID4gPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVm
aW5pdGlvbnMvZmxhZw0KPiA+ID4gPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiA+ID4gKyAg
ICAgIEJ1cnN0IHR5cGUgc2V0dGluZy4gRm9yIHNvbWUgdmVyc2lvbnMgb2YgdGhlIElQIHRoYXQN
Cj4gPiA+ID4gPiBkbw0KPiA+ID4gPiA+IG5vdA0KPiA+ID4gPiA+IHVzZQ0KPiA+ID4gPiA+ICsg
ICAgICBBSEIgYnVzLCB0aGUgYnVyc3QgdHlwZSBuZWVkIHRvIGJlIHN3aXRjaGVkIHRvIElOQ1Iu
DQo+ID4gPiA+ID4gKyAgICAgIElmIHByZXNlbnQsIHVzZSBJTkNSIGJ1cnN0IHR5cGUuDQo+ID4g
PiA+ID4gKyAgICAgIElmIG5vdCBwcmVzZW50LCB1c2Ugc2luZ2xlIGJ1cnN0IHR5cGUuDQo+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ICAgICAgbWVkaWF0ZWssaHMyMDAtY21kLWludC1kZWxheToNCj4g
PiA+ID4gPiAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWlu
dDMyDQo+ID4gPiA+ID4gICAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+
ID4gPiA+IA0KPiA+IA0KPiA+IA0K
