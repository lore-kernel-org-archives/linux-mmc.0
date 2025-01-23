Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9117C91;
	Thu, 23 Jan 2025 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596536; cv=fail; b=N8LIy97WIghOdhzwuD9aje9xDxbSectXDmDa+j4VwqsjQ7RwzN045tAXpjixlQRUg1+0K9KMUISRaGUx4LVJoGviwdMvAQwn3tUcGveLFGeBsx16ShHzww5nXufex9V8NIx7HWXSN5+THRhgSV4LklDBy48CFvx/i62YvYO6u3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596536; c=relaxed/simple;
	bh=wHPl9bK3UfcM2z/CmpBaKZKJGgGxj7305Mq7C4R+oK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EMtqYkqKbo6nnTAPnE1Y2enjHT5m2IFwwwZViQKjVaB5rk8vCr3Q7rQ8NpdvAC5pFBhOVC8sL0GQRBDlJ1q24kZc9NYJYlARGDKF9eVttG1IDy27wPxjs4AUTidzTkEaTosJc+3PVucRqTpDpLHcdKFVUQo4YERsDYovsh6I4ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SeU5Gpqy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dC/73wSG; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SeU5Gpqy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dC/73wSG"
X-UUID: 41ddc6a6d92b11ef99858b75a2457dd9-20250123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wHPl9bK3UfcM2z/CmpBaKZKJGgGxj7305Mq7C4R+oK0=;
	b=SeU5Gpqy+B4hSvX0zsG0u3yfkIL+RYaLNGcygOCq1zLWBsdJ4SNxNWD58YLOrYytdIZS/E4oS4qpDS29lD/Uxepx1+ntkYYWOeN0bw56Ab5hdy18U7VEMaM66khlsYhzflyVo55unwSrc63NLYiuOL80+4S5edpHRy21y9KrQ64=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:063b0209-eaa5-4da2-96cb-1463e1bebf51,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:167ddca9-a151-42b8-a6f0-8a479a6bae47,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 41ddc6a6d92b11ef99858b75a2457dd9-20250123
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 460676399; Thu, 23 Jan 2025 09:42:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 23 Jan 2025 09:42:07 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 23 Jan 2025 09:42:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFu+J1FNtTjvFAY8hoX5o3sQ/xDw++1fRBwjqrZPniLUWclfb6GNQlKp+u1RVrrCSD/oU9q+7IHlq7fFsUZAxNcZxJtfoYgQjGRZCdZ56E/lxa3XG5I4V9zAaZyLpQvnQrEjhE4YF7RLi+R6U61kmyj8X0GwCIdrdr10t8MD+a/+I9rQUMSevswMvM5RWb/MQfCqLz07+DDxBvBTcde5+m/W5qP1xe9sBUF17ZyEQkyRcbnrcwynUz/iloSskkYiTEZX9i9zbMbbtKNTVH/SKoY/gtiz/aPsyg6PxbPh+ygdXfgF2Co9xIUU8RAivC9KezlaHc02OV+OxZ7pizgdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHPl9bK3UfcM2z/CmpBaKZKJGgGxj7305Mq7C4R+oK0=;
 b=Z8uUicB3rI55kZwSRb6ydMfrG4FWEwSsMpgq0ABnz74Azeqg0RIvTrT+21JSsD/+IHxMO9UlnulPENP7jDyJoSCSH4WNeu9yfqI11xJtbrCpgAWS7wLhnqqom5/4xDKdvSG9jUdgwyaQevYD14D6EpQITCG7fTFMbUBf3Cn0F0+l/krqFDrgzeOcF0mulXxMP0guCkFpJwHY4vRneXBw/tzMM2L2FG//AXxwNL+VY2/3y4192oHoUcfpIWPxh6YhzRJtdzQZiH+GNT0jzZI2+cBuwf/8xlfZuhdexvTBO5HCui7GAMSzId1fgVitCOEKv1vIzhU/ekuNTw+b0H5VWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHPl9bK3UfcM2z/CmpBaKZKJGgGxj7305Mq7C4R+oK0=;
 b=dC/73wSG9UJiAY9PiuUcDdYkuUTnV9+T1Pcl3k9//965NNQfDvl6eDY/9FJaGyb7U2Rh+4kJ6YeJ+coQ4jteD3GfMr7g8gANvApU4kXRIggw7cylpmfTV5KyZWkODaqcg8aZfCtsgqsyGWmb75PtlXVl40ul2QY57/BbG3xOI34=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by TYZPR03MB7457.apcprd03.prod.outlook.com (2603:1096:400:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Thu, 23 Jan
 2025 01:42:03 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%5]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 01:42:03 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	=?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
	<Chaotian.Jing@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, upstream <upstream@airoha.com>
Subject: Re: [PATCH 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
Thread-Topic: [PATCH 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
Thread-Index: AQHbZ8RDxfMK8AnxDEeTry1MKcHJqLMY+U8AgAb4/gCAANjHgIABxoGAgAEO4IA=
Date: Thu, 23 Jan 2025 01:42:03 +0000
Message-ID: <362d66661fcafc09c8d8d15be9e81823caa4ad1b.camel@mediatek.com>
References: <20250115073026.31552-1-ansuelsmth@gmail.com>
	 <20250115073026.31552-2-ansuelsmth@gmail.com>
	 <9e022bf13354f544962491cf8061ff3edb878c30.camel@mediatek.com>
	 <678e8816.050a0220.b6bb9.f588@mx.google.com>
	 <eb064f0873fd47e7cbd07f8e403f11dd6060ff34.camel@mediatek.com>
	 <6790bb32.5d0a0220.168b1e.7c5b@mx.google.com>
In-Reply-To: <6790bb32.5d0a0220.168b1e.7c5b@mx.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|TYZPR03MB7457:EE_
x-ms-office365-filtering-correlation-id: c55e8633-3e9a-4ea7-bc02-08dd3b4f2300
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c1hZSnlGbVcwVUl3WmRIWWN3S0trZkFIT0ZaWVNHVVhLQjFNcTJCQUl4Skc2?=
 =?utf-8?B?aTlobjNkRTlOSFpUdlJFejJlb2dOTjNJVEZJS3RkVHlZcVpJbkg5TE9pSmtv?=
 =?utf-8?B?NXlrVDcvR0tpNkZvcmFhQmpZSGxvbFc2ZW1kY25tRXlnRUs3YUhsS1Jad1B2?=
 =?utf-8?B?a056UGlCVnJuYm1vdFUrN2RhVU5oUDJCRnNKQkF6S240MkpGRnloU0Jua283?=
 =?utf-8?B?TkU0Q0piMEcyTUdKY1Z1UURhT1J1SGhiRit0SHZEY3dZTkc4amxHUUdBUFJL?=
 =?utf-8?B?OGZSN3JJOTFUWUpRWFI5d2FUMW0yL3ppR2VrWG9aWUM3VFRyZXlTRDQ2MVdT?=
 =?utf-8?B?QlJZQWZacVN3d0FTSFk4bmQ3T1Y4dG00bjRZYWVxOTA0UnBTd1JpemNZME1Y?=
 =?utf-8?B?blNCWWJuVWlqMUYybmJydHJjZ2Y3QUFSMG9DbzNlTmdmeVlwSnVvVmw2RXU1?=
 =?utf-8?B?dnhqWERFbXRVcmF4aXpFOFVvakI1T2x4MTh5clA1WUxPK0JHN2xVbzNqTkJW?=
 =?utf-8?B?Qm1JQjI0VFg0c3lUcUwyQWthbFVqdzk4a3lNVlQ1TU9vY2hoUW4ySVpNZ20r?=
 =?utf-8?B?blJuUE1OZUF1SFlLWW40dzkvS21aaHNoOXlySHd1eU5uRWZFWHRDSWFBcWNB?=
 =?utf-8?B?QzU3VXhEekJMczdsNVczVlBueEVLZk1scTF3Ym5NZlR3MTJ5Sjl2UmNiczNk?=
 =?utf-8?B?d2tiYXFNejZMVUlzM0IwdlYxT0k0MzYyVy9UOE5sZnpWVkgzUXNsWnhUSkxp?=
 =?utf-8?B?Q0YxcGdycmp1dGVWNWI2RWtIZ3N5d0JUL25iTlR0eThpNEJMUzdFL1NUOVJi?=
 =?utf-8?B?bENFNEV4aW9xb0pPbVRUUzVDSXB0aURPMEVvcmJMMXVZRVVtQVd6ZmdybnVp?=
 =?utf-8?B?NWVGdm9PYm01cnVZRmt5UG5GQWRzSUt3RS8vdFNSeG02dHlGcHdPaXIzN0dC?=
 =?utf-8?B?VzViRG9tZEdZRVpkQjJvQjM4NnUySk91UHMzWWFRMFBSWUhBK0piWG9aRE9J?=
 =?utf-8?B?M3A2TkZIRWdiQjFqc0dTdGhJazJIVE1vbzVCWWRTekE2MFZkWkRvaktqZ3Jv?=
 =?utf-8?B?OTV6L0JWUWtSTXpUQUQ2VTNEUFlUNzA1SnR1cmZiSkMzL2FZcXNrZm1sYjZz?=
 =?utf-8?B?dGYyZVhMYzdjalJTKzZOMnFKUzBPY2cwMEdpZ3lsNFBoQVZuM1lKbGxtK012?=
 =?utf-8?B?ZDZOemFJS0Eya05OcXQzTiswUy93WjJJZ1IrbjA1YTVqY05QaDJESENrcmpj?=
 =?utf-8?B?TFhTWGQwOU80STUwUTV0c3UwUFdrK0FScmx2RXFkMlhjNUdNYXhWaFlwcmxO?=
 =?utf-8?B?elI5RDhUR2hLRWdRa2s1WTE2YTlIb2gzTkJjTk9pL0p0QlRXSEhoYlNIMks3?=
 =?utf-8?B?MmJCdUJheVZJeEpTSkNZZFBNTyt1RHZHWHVNTHJpVnZUeks4dEZXRHZYQWNS?=
 =?utf-8?B?L3N6UldraUIvMWJ0Wks4OEJuRGJscG9QVUV6VC9mZnBlbzhkZkk2MjVwRDMy?=
 =?utf-8?B?SjdUMmFxdkpJcTc5aEtDYmlkT3lnWjlraEZXZjh5N0tqaTNVVm5SNW9oRHJi?=
 =?utf-8?B?SHpNL20wV2ZRczNhU1Y4bXR2ZnBmNENDUUZQQU51cUhUUzFVMWdPeVNwTU1q?=
 =?utf-8?B?TTVKZkV1YU44dHdtek04bVNzRW1qTGhPdktuZWd3bkdkdUxUQ09lSGdhWjZU?=
 =?utf-8?B?dWRITGRrTFhpWEU0ZUVRL0VNU2c4dDZzakFnZXRxN09jWVlLbHhyenA2dy84?=
 =?utf-8?B?MExpZjZZcE9MQjhaZGR5WjI5ZzJiSHk3K0piZFZxVk5OejU3RnZRL0ovajhN?=
 =?utf-8?B?TldIMGp3UVFGczhzR21qT2F1TlJwRldnRnEyR0hWZUJFNGJ4WTUwNGlKRkZq?=
 =?utf-8?B?MlFDOEpPWk9jN3lOaG5iby9wRlM0bVJqRi9LVWJ0VDBNcE44b1pTaWdUYlk4?=
 =?utf-8?Q?q9RpVTVsxcMbwRfhFBLlmSlcgIq07v0/?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGdjdjg4UVpyRFVtM2RUZ0laZEF2RWJwTUNMYmRQbXcwa1M2QlpPVC9jL3Q2?=
 =?utf-8?B?QURFdy9RalRKQXZyaGdLcGlnbmZZRTVXVG1tWUtSMmRPZk9ObmV6MXpzSWFp?=
 =?utf-8?B?dHN1MStOZmk5aEdRVlMrNjZXdytoVnRPY3V4RFo4RkdWVWRnU1grZjdNQ05t?=
 =?utf-8?B?TUJvSGtrY1lJNTVubzJEaXhwTmh3UG1qTHFheGU1S0M5REd6Rnp4NHZEeHhG?=
 =?utf-8?B?MGtra2ZtS3ZlRXNZU3l1a2Q2Z0NQNDArem0yYjlMbW9iKzR5OVY3cTZRbFUv?=
 =?utf-8?B?UUk3NjRZZTdJOGgwblBKdEVPTjdtK0txU0NJRlVrWnJITmVrV3dvZ0RpeXc3?=
 =?utf-8?B?TzIvR0R4aWJnVXQzUlJ5VFBuYUhTbmxrbHNFNFdWTHplR254bndQS2FWTW8v?=
 =?utf-8?B?OVhNVDBmOEpVM1ZkalM3QkFvZngvbERrREliMHRxUDdTakh1eXFYd0h0NUVT?=
 =?utf-8?B?aHBQS3NFSFd4c1Z0V3ZtVVBRQmFDZzhXTHRNM050L1NQSGlIeWhhZnJTZ05P?=
 =?utf-8?B?bEtGeFJQdVg5MjcvcXBTUkwwZU0vWERPcVZuN01hTjRhY05Ya3lxeXhDN3pM?=
 =?utf-8?B?bkd5dFRybjVGb2czamEwRytOVTdnbGlxbVB5UEN1UU94U1Y2M3dpdW03MTNP?=
 =?utf-8?B?Y3BBVUMwMlV0R3M0REo0WkhwdnBVMVhhcHNNdzA4dVZwUkwwRGRMRVNuL1Ft?=
 =?utf-8?B?aFNWSzNFYmQ5OEZjRUpEQjBWM2JSY0k2ejlMWDNMUk4rYnBiRjZjOE1HandW?=
 =?utf-8?B?UUFUWDAyT2Z0UXJZR1lWcUVtMjUvQ3RLS2wzZTNuNS8zLy9DZVozcFphL253?=
 =?utf-8?B?SVUxQk5RUjc0NjdpWUhNbVJUbUVpRnZ6T3ZaT0lTanlsQjZTYlJXaDBka1hn?=
 =?utf-8?B?WHJQUllkSGptWk04NE96Zk4xY0xkcHNFSldrUkRsZXhrZWdTSGM0Y0FpY0FY?=
 =?utf-8?B?eDd4MTVtRWV5ZUNRUkx1VFI5MnFqLzRURTU2MUQ5eThuUk52RHdkOHlpOFpX?=
 =?utf-8?B?dkY1T3J1cFR6S0J2STRRa2FHbnJmQkZyTkJrQkFWUVU2djRTeUlDTndXZ1c5?=
 =?utf-8?B?bkw2V1R5cE9pNk1TRnRSajYvSm1tRmhpdnBXSG9IbXBHVE5Vc2lOV3dhNnZR?=
 =?utf-8?B?bExhTnN4TG95MHhFcmdPQnh0VUNoeVpjN2tPRXBOdmlQZFNSN0I1c1lXTUZu?=
 =?utf-8?B?ZWFSY2w1NWVTVkNrajRFellwTmNQZFVlc1BNTGRtb1dEN1hjK3lYUDlsVDNj?=
 =?utf-8?B?V3JQODcrOStqNWE2WW82eGhtMnA1V24xRU5kandnN0VHN0hnaFVlMUJKcUQv?=
 =?utf-8?B?a1cyNUxxUnk0cllHeDl1L05kckR2Umk1ZEFab1FHOE5vMVZzWVpXKzBWdDdV?=
 =?utf-8?B?Wm1iMGV4Y0VDNnREcmc5S2M4UWdIT08vRDB6RDd2SUJpWUg3dVkra3ZOY3M1?=
 =?utf-8?B?em0vZjRiZnAzTmt4bnpmYXBmdmovYjYrbVNFSFpibG45dWxRSGJwUjVXcmxT?=
 =?utf-8?B?MlVSMEFTTm1pWHE4OTVvM0pvOExxdjl2YnJsMElBT3R2NERYYmJraStTYzZV?=
 =?utf-8?B?QTBWbEczMEQ3dmtQdDZIQ251V2J1SzJtVmY0K0pxdGxkZFZkOVJma0FuSG1W?=
 =?utf-8?B?NHM4THl5Z1Qwa3dvRGwrR0NZSEJSVWl6SHVkeXpEcTNvdTRhQWV0ZldKcU9S?=
 =?utf-8?B?cXNlYUc4ckVYLzZwemkzU3RwRjQyVk1Bd3BmMWVub3JuT2VwaVJxelRNbEpp?=
 =?utf-8?B?ajVFdHk0NHc1aXpUZnZiUE52R0ttMkpiVjlRMW5PT0kxNStQdGRrc2VoVHJz?=
 =?utf-8?B?OENMN0h3Tjh6eUVnK1dTN0FXMk03bUlab3YyK2xZd3Q2WTlBSGFXa01tdjJX?=
 =?utf-8?B?bWxRWWlzZG5hWTI0ZnRpeU4zTy8xUWJ4eUUyeDhVbmN6ejg4T05laWFBUG9G?=
 =?utf-8?B?a1RDZElQaGUrU29SYWwydHRzaWJrdmowN3ZWV1RTS05RaWpUUDVVaks3U3BX?=
 =?utf-8?B?b1g3dzRsTlg0a1dCMlJFZnFMNW01RC9IUmRMR3lMMk5Pc2pMMlUwdHhlaDJP?=
 =?utf-8?B?OWtEaXBnQVBULzJBTWVhdi8xNkc2OEowOHFGby9XemV1MlU4ditZZ3draHVC?=
 =?utf-8?B?SkVxSVI1aVloS1dDOXcyU0E4eEVWZzFKOS9adldXaGZLNnZRKzdaY0xuWjJp?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2192BA672E8C1E4A8B001B5A54F88A38@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55e8633-3e9a-4ea7-bc02-08dd3b4f2300
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 01:42:03.1657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AESd0+jjiQMxR0QgQhUuA1sALjkG/Dviao+b9H2OqTUwGhA93T/VHJoxFdjCUea1Gkftlluc7uz4noAWY05ljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7457

T24gV2VkLCAyMDI1LTAxLTIyIGF0IDEwOjMyICswMTAwLCBDaHJpc3RpYW4gTWFyYW5naSB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiBUdWUsIEphbiAyMSwgMjAyNSBhdCAwNjoyNTo0OEFNICsw
MDAwLCBBbmR5LWxkIEx1ICjljaLkuJwpIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNS0wMS0yMCBh
dCAxODoyOSArMDEwMCwgQ2hyaXN0aWFuIE1hcmFuZ2kgd3JvdGU6DQo+ID4gPiBFeHRlcm5hbCBl
bWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+
ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gT24gVGh1LCBKYW4gMTYsIDIwMjUgYXQgMDc6MDE6
MTNBTSArMDAwMCwgQW5keS1sZCBMdSAo5Y2i5LicKSB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCAy
MDI1LTAxLTE1IGF0IDA4OjI5ICswMTAwLCBDaHJpc3RpYW4gTWFyYW5naSB3cm90ZToNCj4gPiA+
ID4gPiBBZGQgc3VwcG9ydCBmb3IgQU43NTgxIE1NQyBIb3N0LiBUaGUgTU1DIEhvc3QgY29udHJv
bGxlciBpcw0KPiA+ID4gPiA+IGJhc2VkDQo+ID4gPiA+ID4gb24NCj4gPiA+ID4gPiBtdDc2MjIg
d2l0aCB0aGUgZGlmZmVyZW5jZSBvZiBub3QgaGF2aW5nIHJlZ3VsYXRvciBzdXBwbHkgYW5kDQo+
ID4gPiA+ID4gc3RhdGVfdWhzDQo+ID4gPiA+ID4gcGlucyBhbmQgaGNsayBjbG9jay4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBTb21lIG1pbm9yIGZpeGVzIGFyZSBhcHBsaWVkIHRvIGNoZWNrIGlm
IHRoZSBzdGF0ZV91aHMgcGlucw0KPiA+ID4gPiA+IGFyZQ0KPiA+ID4gPiA+IGRlZmluZWQNCj4g
PiA+ID4gPiBhbmQgbWFrZSBoY2xrIG9wdGlvbmFsIGZvciB0aGUgbmV3IGFpcm9oYSBjb21wYXRp
YmxlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBNYXJh
bmdpIDxhbnN1ZWxzbXRoQGdtYWlsLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYyB8IDU1DQo+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gPiA+ID4gLS0tLQ0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+
ID4gPiA+ID4gYi9kcml2ZXJzL21tYy9ob3N0L210ay0NCj4gPiA+ID4gPiBzZC5jDQo+ID4gPiA+
ID4gaW5kZXggZWZiMGQyZDU3MTZiLi45ZDY4Njg4ODNjOTEgMTAwNjQ0DQo+ID4gPiA+ID4gLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbW1j
L2hvc3QvbXRrLXNkLmMNCj4gPiA+ID4gPiBAQCAtNjY2LDYgKzY2NiwyMCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19tbWNfY29tcGF0aWJsZQ0KPiA+ID4gPiA+IG10ODE5Nl9jb21wYXQgPSB7
DQo+ID4gPiA+ID4gICAgIC5zdXBwb3J0X25ld19yeCA9IHRydWUsDQo+ID4gPiA+ID4gIH07DQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX21tY19jb21wYXRp
YmxlIGFuNzU4MV9jb21wYXQgPSB7DQo+ID4gPiA+ID4gKyAgIC5jbGtfZGl2X2JpdHMgPSAxMiwN
Cj4gPiA+ID4gPiArICAgLnJlY2hlY2tfc2Rpb19pcnEgPSB0cnVlLA0KPiA+ID4gPiA+ICsgICAu
aHM0MDBfdHVuZSA9IGZhbHNlLA0KPiA+ID4gPiA+ICsgICAucGFkX3R1bmVfcmVnID0gTVNEQ19Q
QURfVFVORTAsDQo+ID4gPiA+ID4gKyAgIC5hc3luY19maWZvID0gdHJ1ZSwNCj4gPiA+ID4gPiAr
ICAgLmRhdGFfdHVuZSA9IHRydWUsDQo+ID4gPiA+ID4gKyAgIC5idXN5X2NoZWNrID0gdHJ1ZSwN
Cj4gPiA+ID4gPiArICAgLnN0b3BfY2xrX2ZpeCA9IHRydWUsDQo+ID4gPiA+ID4gKyAgIC5zdG9w
X2RseV9zZWwgPSAzLA0KPiA+ID4gPiA+ICsgICAuZW5oYW5jZV9yeCA9IHRydWUsDQo+ID4gPiA+
ID4gKyAgIC5zdXBwb3J0XzY0ZyA9IGZhbHNlLA0KPiA+ID4gPiA+ICt9Ow0KPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXNkY19vZl9pZHNb
XSA9IHsNCj4gPiA+ID4gPiAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtbW1j
IiwgLmRhdGEgPQ0KPiA+ID4gPiA+ICZtdDI3MDFfY29tcGF0fSwNCj4gPiA+ID4gPiAgICAgeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItbW1jIiwgLmRhdGEgPQ0KPiA+ID4gPiA+ICZt
dDI3MTJfY29tcGF0fSwNCj4gPiA+ID4gPiBAQCAtNjgwLDcgKzY5NCw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gPiA+ID4gbXNkY19vZl9pZHNbXSA9DQo+ID4gPiA+
ID4gew0KPiA+ID4gPiA+ICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1tbWMi
LCAuZGF0YSA9DQo+ID4gPiA+ID4gJm10ODE4M19jb21wYXR9LA0KPiA+ID4gPiA+ICAgICB7IC5j
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Ni1tbWMiLCAuZGF0YSA9DQo+ID4gPiA+ID4gJm10
ODE5Nl9jb21wYXR9LA0KPiA+ID4gPiA+ICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODUxNi1tbWMiLCAuZGF0YSA9DQo+ID4gPiA+ID4gJm10ODUxNl9jb21wYXR9LA0KPiA+ID4gPiA+
IC0NCj4gPiA+ID4gPiArICAgeyAuY29tcGF0aWJsZSA9ICJhaXJvaGEsYW43NTgxLW1tYyIsIC5k
YXRhID0NCj4gPiA+ID4gPiAmYW43NTgxX2NvbXBhdH0sDQo+ID4gPiA+ID4gICAgIHt9DQo+ID4g
PiA+ID4gIH07DQo+ID4gPiA+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG1zZGNfb2ZfaWRz
KTsNCj4gPiA+ID4gPiBAQCAtMTYwMCw2ICsxNjE0LDEwIEBAIHN0YXRpYyBpbnQgbXNkY19vcHNf
c3dpdGNoX3ZvbHQoc3RydWN0DQo+ID4gPiA+ID4gbW1jX2hvc3QgKm1tYywgc3RydWN0IG1tY19p
b3MgKmlvcykNCj4gPiA+ID4gPiAgICAgc3RydWN0IG1zZGNfaG9zdCAqaG9zdCA9IG1tY19wcml2
KG1tYyk7DQo+ID4gPiA+ID4gICAgIGludCByZXQ7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gKyAg
IC8qIFNraXAgc2V0dGluZyBzdXBwbHkgaWYgbm90IHN1cHBvcnRlZCAqLw0KPiA+ID4gPiA+ICsg
ICBpZiAoIW1tYy0+c3VwcGx5LnZxbW1jKQ0KPiA+ID4gPiA+ICsgICAgICAgICAgIHJldHVybiAw
Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gDQo+ID4gPiA+IEhpIENocmlzdGlhbiwNCj4gPiA+ID4g
DQo+ID4gPiA+IEkgdGhpbmsgaGVyZSBpcyBubyBuZWVkLiBJZiB5b3UgaGF2ZSBub3QgJ3ZxbW1j
JyBpbiB0aGUNCj4gPiA+ID4gZHRzLCBJU19FUlIobW1jLT5zdXBwbHkudnFtbWMpIHdvdWxkIGJl
IC1FTk9ERVYgYW5kIHRoZQ0KPiA+ID4gPiBjb3JyZXNwb25kaW5nDQo+ID4gPiA+IGZsb3cgd291
bGQgbm90IGJlIGV4ZWN1dGVkLg0KPiA+ID4gPiANCj4gPiA+ID4gQW5kIGFub3RoZXIgcXVlc3Rp
b24sIGhvc3QtPnBpbnNfZGVmYXVsdCBpcyBqdXN0IHNlbGVjdGVkIGhlcmUsDQo+ID4gPiA+IHRo
YXQNCj4gPiA+ID4gd291bGQgYmUgbG9zdC4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gICAgIGlmICgh
SVNfRVJSKG1tYy0+c3VwcGx5LnZxbW1jKSkgew0KPiA+ID4gPiA+ICAgICAgICAgICAgIGlmIChp
b3MtPnNpZ25hbF92b2x0YWdlICE9IE1NQ19TSUdOQUxfVk9MVEFHRV8zMzANCj4gPiA+ID4gPiAm
Jg0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBpb3MtPnNpZ25hbF92b2x0YWdlICE9DQo+ID4g
PiA+ID4gTU1DX1NJR05BTF9WT0xUQUdFXzE4MCkgew0KPiA+ID4gPiA+IEBAIC0xNjk5LDcgKzE3
MTcsOSBAQCBzdGF0aWMgdm9pZCBtc2RjX2VuYWJsZV9zZGlvX2lycShzdHJ1Y3QNCj4gPiA+ID4g
PiBtbWNfaG9zdCAqbW1jLCBpbnQgZW5iKQ0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBkZXZfZGJnKGhvc3QtPmRldiwgIlNESU8gZWludA0KPiA+ID4gPiA+IGlycToNCj4g
PiA+ID4gPiAlZCFcbiIsIGhvc3QtPmVpbnRfaXJxKTsNCj4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgIH0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgIHBpbmN0
cmxfc2VsZWN0X3N0YXRlKGhvc3QtPnBpbmN0cmwsIGhvc3QtDQo+ID4gPiA+ID4gPiBwaW5zX3Vo
cyk7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAvKiBTa2lwIHNl
dHRpbmcgdWhzIHBpbnMgaWYgbm90IHN1cHBvcnRlZA0KPiA+ID4gPiA+ICovDQo+ID4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICBpZiAoaG9zdC0+cGluc191aHMpDQo+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHBpbmN0cmxfc2VsZWN0X3N0YXRlKGhvc3QtDQo+ID4gPiA+
ID4gPnBpbmN0cmwsDQo+ID4gPiA+ID4gaG9zdC0+cGluc191aHMpOw0KPiA+ID4gPiA+ICAgICAg
ICAgICAgIH0gZWxzZSB7DQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBkZXZfcG1fY2xl
YXJfd2FrZV9pcnEoaG9zdC0+ZGV2KTsNCj4gPiA+ID4gPiAgICAgICAgICAgICB9DQo+ID4gPiA+
ID4gQEAgLTIwMzYsNiArMjA1NiwxMCBAQCBzdGF0aWMgdm9pZCBtc2RjX29wc19zZXRfaW9zKHN0
cnVjdA0KPiA+ID4gPiA+IG1tY19ob3N0DQo+ID4gPiA+ID4gKm1tYywgc3RydWN0IG1tY19pb3Mg
KmlvcykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAgICAgbXNkY19zZXRfYnVzd2lkdGgoaG9zdCwg
aW9zLT5idXNfd2lkdGgpOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICsgICAvKiBTa2lwIHJlZ3Vs
YXRvciBpZiBub3Qgc3VwcG9ydGVkICovDQo+ID4gPiA+ID4gKyAgIGlmICghbW1jLT5zdXBwbHku
dm1tYykNCj4gPiA+ID4gPiArICAgICAgICAgICBnb3RvIHNraXBfcmVndWxhdG9yOw0KPiA+ID4g
PiA+ICsNCj4gPiA+ID4gDQo+ID4gPiA+IE5vIG5lZWQgdG9vLg0KPiA+ID4gPiANCj4gPiA+ID4g
PiAgICAgLyogU3VzcGVuZC9SZXN1bWUgd2lsbCBkbyBwb3dlciBvZmYvb24gKi8NCj4gPiA+ID4g
PiAgICAgc3dpdGNoIChpb3MtPnBvd2VyX21vZGUpIHsNCj4gPiA+ID4gPiAgICAgY2FzZSBNTUNf
UE9XRVJfVVA6DQo+ID4gPiA+ID4gQEAgLTIwNzEsNiArMjA5NSw3IEBAIHN0YXRpYyB2b2lkIG1z
ZGNfb3BzX3NldF9pb3Moc3RydWN0DQo+ID4gPiA+ID4gbW1jX2hvc3QNCj4gPiA+ID4gPiAqbW1j
LCBzdHJ1Y3QgbW1jX2lvcyAqaW9zKQ0KPiA+ID4gPiA+ICAgICAgICAgICAgIGJyZWFrOw0KPiA+
ID4gPiA+ICAgICB9DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gK3NraXBfcmVndWxhdG9yOg0KPiA+
ID4gPiA+ICAgICBpZiAoaG9zdC0+bWNsayAhPSBpb3MtPmNsb2NrIHx8IGhvc3QtPnRpbWluZyAh
PSBpb3MtDQo+ID4gPiA+ID4gPnRpbWluZykNCj4gPiA+ID4gPiAgICAgICAgICAgICBtc2RjX3Nl
dF9tY2xrKGhvc3QsIGlvcy0+dGltaW5nLCBpb3MtPmNsb2NrKTsNCj4gPiA+ID4gPiAgfQ0KPiA+
ID4gPiA+IEBAIC0yODE2LDkgKzI4NDEsMTIgQEAgc3RhdGljIGludCBtc2RjX29mX2Nsb2NrX3Bh
cnNlKHN0cnVjdA0KPiA+ID4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gPiA+ID4gPiAg
ICAgaWYgKElTX0VSUihob3N0LT5zcmNfY2xrKSkNCj4gPiA+ID4gPiAgICAgICAgICAgICByZXR1
cm4gUFRSX0VSUihob3N0LT5zcmNfY2xrKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAtICAgaG9z
dC0+aF9jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImhjbGsiKTsNCj4gPiA+ID4gPiAt
ICAgaWYgKElTX0VSUihob3N0LT5oX2NsaykpDQo+ID4gPiA+ID4gLSAgICAgICAgICAgcmV0dXJu
IFBUUl9FUlIoaG9zdC0+aF9jbGspOw0KPiA+ID4gPiA+ICsgICAvKiBBTjc1ODEgU29DIGRvZXNu
J3QgaGF2ZSBoY2xrICovDQo+ID4gPiA+ID4gKyAgIGlmICghZGV2aWNlX2lzX2NvbXBhdGlibGUo
JnBkZXYtPmRldiwgImFpcm9oYSxhbjc1ODEtDQo+ID4gPiA+ID4gbW1jIikpIHsNCj4gPiA+ID4g
PiArICAgICAgICAgICBob3N0LT5oX2NsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAiaGNs
ayIpOw0KPiA+ID4gPiA+ICsgICAgICAgICAgIGlmIChJU19FUlIoaG9zdC0+aF9jbGspKQ0KPiA+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoaG9zdC0+aF9jbGspOw0K
PiA+ID4gPiA+ICsgICB9DQo+ID4gPiA+IA0KPiA+ID4gPiBkZXZtX2Nsa19nZXRfb3B0aW9uYWwg
Y291bGQgYmUgdXNlZCB0byBpbnN0ZWFkIGhlcmUsIG5vIG5lZWQgdG8NCj4gPiA+ID4gdXNlDQo+
ID4gPiA+IGNvbXBhdGlibGUgdG8gZGlzdGluZ3Vpc2guDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4g
PiBJIGNhbiBtYWtlIHRoZSBoY2xrIG9wdGlvbmFsIGJ1dCBJIHRoaW5rIHRoaXMgd291bGQgYWZm
ZWN0IGFsc28NCj4gPiA+IGV2ZXJ5DQo+ID4gPiBvdGhlciBjb21wYXRpYmxlIGJ5IGhpZGluZyBi
cm9rZW4gY2xvY2sgY29uZmlndXJhdGlvbi4NCj4gPiA+IA0KPiA+ID4gPiA+ICAgICBob3N0LT5i
dXNfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsDQo+ID4gPiA+ID4gImJ1
c19jbGsiKTsNCj4gPiA+ID4gPiAgICAgaWYgKElTX0VSUihob3N0LT5idXNfY2xrKSkNCj4gPiA+
ID4gPiBAQCAtMjkyNiwxMCArMjk1NCwxMyBAQCBzdGF0aWMgaW50IG1zZGNfZHJ2X3Byb2JlKHN0
cnVjdA0KPiA+ID4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+ID4gPiAgICAgICAg
ICAgICByZXR1cm4gUFRSX0VSUihob3N0LT5waW5zX2RlZmF1bHQpOw0KPiA+ID4gPiA+ICAgICB9
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gLSAgIGhvc3QtPnBpbnNfdWhzID0gcGluY3RybF9sb29r
dXBfc3RhdGUoaG9zdC0+cGluY3RybCwNCj4gPiA+ID4gPiAic3RhdGVfdWhzIik7DQo+ID4gPiA+
ID4gLSAgIGlmIChJU19FUlIoaG9zdC0+cGluc191aHMpKSB7DQo+ID4gPiA+ID4gLSAgICAgICAg
ICAgZGV2X2VycigmcGRldi0+ZGV2LCAiQ2Fubm90IGZpbmQgcGluY3RybA0KPiA+ID4gPiA+IHVo
cyFcbiIpOw0KPiA+ID4gPiA+IC0gICAgICAgICAgIHJldHVybiBQVFJfRVJSKGhvc3QtPnBpbnNf
dWhzKTsNCj4gPiA+ID4gPiArICAgLyogQU43NTgxIGRvZXNuJ3QgaGF2ZSBzdGF0ZV91aHMgcGlu
cyAqLw0KPiA+ID4gPiA+ICsgICBpZiAoIWRldmljZV9pc19jb21wYXRpYmxlKCZwZGV2LT5kZXYs
ICJhaXJvaGEsYW43NTgxLQ0KPiA+ID4gPiA+IG1tYyIpKSB7DQo+ID4gPiA+ID4gKyAgICAgICAg
ICAgaG9zdC0+cGluc191aHMgPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShob3N0LQ0KPiA+ID4gPiA+
ID5waW5jdHJsLA0KPiA+ID4gPiA+ICJzdGF0ZV91aHMiKTsNCj4gPiA+ID4gPiArICAgICAgICAg
ICBpZiAoSVNfRVJSKGhvc3QtPnBpbnNfdWhzKSkgew0KPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAiQ2Fubm90IGZpbmQgcGluY3RybA0KPiA+ID4gPiA+
IHVocyFcbiIpOw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIo
aG9zdC0+cGluc191aHMpOw0KPiA+ID4gPiA+ICsgICAgICAgICAgIH0NCj4gPiA+ID4gPiAgICAg
fQ0KPiA+ID4gPiANCj4gPiA+ID4gQ291bGQgeW91IGNvbnNpZGVyIHRvIHNldCBhIGR1bW15ICdz
dGF0ZV91aHMnIHNhbWUgYXMNCj4gPiA+ID4gJ3N0YXRlX2RlZmF1bHQnDQo+ID4gPiA+IGluIHRo
ZSBkdHMsIHRoYXQgeW91IGNvdWxkIG5vdCB1c2UgY29tcGF0aWJsZSB0byBkaXN0aW5ndWlzaA0K
PiA+ID4gPiBoZXJlLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gVGhpcyBpcyBwcm9ibGVtYXRp
YywgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcsIHlvdSBhcmUgc3VnZ2VzdGluZw0KPiA+ID4gdG8N
Cj4gPiA+IGFzc2lnbiB0aGUgZW1tYyBwaW5zIHRvIGJvdGggZGVmYXVsdCBhbmQgdWhzPyBUaGlz
IGlzIHByb2JsZW1hdGljDQo+ID4gPiBhcw0KPiA+ID4gdGhlDQo+ID4gPiBwaW5jdHJsIGRyaXZl
ciB3b3VsZCBjb21wbGFpbiB0aGF0IHN1Y2ggcGlucyBhcmUgYWxyZWFkeSBhc3NpZ25lZA0KPiA+
ID4gdG8NCj4gPiA+IHNvbWV0aGluZy4gQWxzbyBJIGRvbid0IHRoaW5rIGl0J3MgcG9zc2libGUg
dG8gYXNzaWduIHRoZXNlIHBpbnMNCj4gPiA+IHRvIGENCj4gPiA+IGR1bW15IHBpbi4NCj4gPiA+
IA0KPiA+IA0KPiA+IE1heWJlIEkgaGF2ZSBub3QgZXhwcmVzc2VkIGNsZWFybHkuLi5XaGF0IEkg
bWVhbiBpcyB0aGF0IHlvdSBjb3VsZA0KPiA+IHNldA0KPiA+IGFzIGJlbG93LCBhbmQgdGhlIGNv
bnRlbnQgb2YgJm1tY19waW5zX3VocyBpcyBqdXN0IGNvcGllZCBmcm9tDQo+ID4gJm1tY19waW5z
X2RlZmF1bHQuDQo+ID4gDQo+ID4gbW1jQDFmYTBlMDAwIHsNCj4gPiAgICAgICAuLi4NCj4gPiAg
ICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAic3RhdGVfdWhzIjsNCj4gPiAgICAgICBw
aW5jdHJsLTAgPSA8Jm1tY19waW5zX2RlZmF1bHQ+Ow0KPiA+ICAgICAgIHBpbmN0cmwtMSA9IDwm
bW1jX3BpbnNfdWhzPjsNCj4gPiB9DQo+IA0KPiBPayBteSBiYWQuIEkgZGlkIGRlY2xhcmVkIHRo
ZSBzZWNvbmQgcGluIHRvIHBpbmN0cmwtMCBpbnN0ZWFkIG9mDQo+IGFkZGluZw0KPiBwaW5jdHJs
LTEuIFdpdGggdGhhdCBpdCBkb2VzIHdvcmsgY29ycmVjdGx5Lg0KPiANCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiAgICAgLyogU3VwcG9ydCBmb3IgU0RJTyBlaW50IGlycSA/ICovDQo+ID4gPiA+ID4g
QEAgLTMwMTAsNiArMzA0MSwxMiBAQCBzdGF0aWMgaW50IG1zZGNfZHJ2X3Byb2JlKHN0cnVjdA0K
PiA+ID4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+ID4gPiAgICAgICAgICAgICBk
ZXZfZXJyKCZwZGV2LT5kZXYsICJDYW5ub3QgdW5nYXRlIGNsb2NrcyFcbiIpOw0KPiA+ID4gPiA+
ICAgICAgICAgICAgIGdvdG8gcmVsZWFzZV9jbGs7DQo+ID4gPiA+ID4gICAgIH0NCj4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gKyAgIC8qIEFONzU4MSB3aXRob3V0IHJlZ3VsYXRvciByZXF1aXJlIHR1
bmUgdG8gT0NSIHZhbHVlcyAqLw0KPiA+ID4gPiA+ICsgICBpZiAoZGV2aWNlX2lzX2NvbXBhdGli
bGUoJnBkZXYtPmRldiwgImFpcm9oYSxhbjc1ODEtbW1jIikgDQo+ID4gPiA+ID4gJiYNCj4gPiA+
ID4gPiArICAgICAgICFtbWMtPm9jcl9hdmFpbCkNCj4gPiA+ID4gPiArICAgICAgICAgICBtbWMt
Pm9jcl9hdmFpbCA9IE1NQ19WRERfMzJfMzMgfCBNTUNfVkREXzMzXzM0Ow0KPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gDQo+ID4gPiA+IE1heWJlIHlvdSBjb3VsZCB1c2UgcmVndWxhdG9yLWZpeGVkIGlu
IHRoZSBkdHMgYW5kIGNvbmZpZ3VyZQ0KPiA+ID4gPiBtaW4vbWF4DQo+ID4gPiA+IHZvbHRhZ2Ug
dG8gZ2V0IG9jcl9hdmFpbCwgbm8gbmVlZCB0byBzZXQgaGFyZCBjb2RlIGhlcmUuDQo+ID4gPiA+
IA0KPiA+ID4gDQo+ID4gPiBBbHNvIHN1Z2dlc3RlZCBieSBXZW5iaW4gTWVpICjmooXmloflvawp
IGFuZCBJIGp1c3QgdHJpZWQgdGhpcy4NCj4gPiA+IA0KPiA+ID4gVGhpcyBjYW4ndCBiZSBkb25l
LCBmaXhlZC1yZWd1bGF0b3IgbmVlZHMgdG8gaGF2ZSB0aGUgc2FtZSBtaW4NCj4gPiA+IGFuZA0K
PiA+ID4gbWF4DQo+ID4gPiB2b2x0YWdlIG9yIHRoZXkgZmFpbCB0byBwcm9iZSBzb29vIGZpeGVk
LXJlZ3VsYXRvciBzYWRkbHkgY2FuJ3QNCj4gPiA+IGJlDQo+ID4gPiB1c2VkDQo+ID4gPiA6KA0K
PiA+ID4gDQo+ID4gPiBJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIG9mIHRoaXMgd2l0aCB0aGUg
b3RoZXIgcG9pbnQgY29ycmVjdGVkDQo+ID4gPiBidXQNCj4gPiA+IEkNCj4gPiA+IHRoaW5rIGEg
Y29tcGF0aWJsZSBhbmQgdGhlc2UgYWRkaXRpb25hbCBpZiBpcyBhIG11c3QgOigNCj4gPiANCj4g
PiBJZiB1c2UgdGhlIGZpeGVkIHJlZ3VsYXRvciBzdWNoIGFzIGJlbG93LCB5b3Ugd2lsbCBnZXQg
dGhlIHNhbWUNCj4gPiBvY3JfYXZhaWwgYXMgJ01NQ19WRERfMzJfMzMgfCBNTUNfVkREXzMzXzM0
JyB0aHJvdWdoDQo+ID4gbW1jX3JlZ3VsYXRvcl9nZXRfb2NybWFzaygpLg0KPiA+IA0KPiA+IHZt
bWNfM3YzOiByZWd1bGF0b3Itdm1tYy0zdjMgew0KPiA+ICAgICAgIGNvbXBhdGlibGUgPSAicmVn
dWxhdG9yLWZpeGVkIjsNCj4gPiAgICAgICByZWd1bGF0b3ItbmFtZSA9ICJ2bW1jIjsNCj4gPiAg
ICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gPiAgICAgICByZWd1
bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gPiAgICAgICByZWd1bGF0b3ItYWx3
YXlzLW9uOw0KPiA+IH0NCj4gDQo+IE9rIHRoZSBjb2RlIHdhcyBhIGJpdCBjb25mdXNpbmcgYnV0
IHllcyBJIGNhbiBjb25maXJtIHRoYXQgYSAzLjMNCj4gZml4ZWQNCj4gcmVndWxhdG9yIGRlZmlu
ZSB0aG9zZSAyIGZsYWdzIHNvIGFsc28gdGhpcyBpcyBPSy4NCj4gDQo+IFRoZXJlIGlzIHN0aWxs
IHRoZSBkaXNjdXNzaW9uIGFib3V0IGNsb2NrLiBZb3UgYXJlIHRvdGFsbHkgYWdhaW5zdCBhDQo+
IG5ldw0KPiBjb21wYXRpYmxlIGZvciB0aGUgaGNsaz8NCj4gDQpBcyB0aGUgY29tbWVudCBpbiB0
aGUgdjIgcGF0Y2hlcywgdGhlIGJldHRlciB3YXkgaXMgdG8gYWRkIGEgYm9vbA0KdmFyaWFibGUg
bGlrZSAnbmVlZHNfbm90X2hjbGsnIGluIHRoZSBjb21wYXQgZGF0YSwgd2hpY2ggaXMganVzdCB0
cnVlDQpmb3IgeW91LCBhbmQgdXNlICFob3N0LT5kZXZfY29tcC0+bmVlZHNfbm90X2hjbGsgYXMg
dGhlIGNvbmRpdGlvbiB0bw0KZ2V0ICdoY2xrJy4NCg0KQnV0IEkgd291bGQgbGlrZSB0byBjb25m
aXJtIGlmIHRoZSAnZml4ZWQtY2xvY2snIGNvdWxkIGJlIHN1cHBvcnRlZCBpbg0KeW91ciBwcm9q
ZWN0LCB3aGljaCBpcyBhbHNvIHVzZWQgaW4gbXQ3NjIyLmR0c2ksIHlvdSBtYXkgYWxpZ24gJ2hj
bGsnDQp0byBhIGR1bW15IGZpeGVkLWNsb2NrLi4uIA0KDQo+ID4gPiANCj4gPiA+ID4gPiAgICAg
bXNkY19pbml0X2h3KGhvc3QpOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICAgICBpZiAobW1jLT5j
YXBzMiAmIE1NQ19DQVAyX0NRRSkgew0KPiA+ID4gDQo+ID4gPiAtLQ0KPiA+ID4gICAgICAgICBB
bnN1ZWwNCj4gDQo+IC0tDQo+ICAgICAgICAgQW5zdWVsDQo=
