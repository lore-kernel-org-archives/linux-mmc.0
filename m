Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.115
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793754463;
	b=RqophxQmBEQugZ2nG57Xr4grgt0xqqf+6bF+9rEavYdAtPRjniR6nF20YnBR8yxrFeaP
	 TyWML1x/BimtOyozWW5GH4YJB51U0BGguXl4bY4bTI9MhiCIpTV9IVRpi4T6IeumtRd/2
	 VNXSXXrdfnyHCWOwnCyBPfQZM+DxnKQ4f+tKsdwLRq5wXlzjXjDN3MaxF+TE0YIZvNZK/
	 TyuQtgdOF6Iz7LQxZWhi8M0zzOqvl1IEN0UNtdBXJ90D2b1/Zwz+i68Dyc2g7i14v/yHs
	 XkjBAY7bykhbwxg1C4ahcZrsCpj8bhHPlJtoUEdxzaj7fNY0cw3NzZ+RXqHXEp2MndA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754463;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
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
	bh=T0rvYf6m2Go3KEq3+HnLPv/NnkE0RttsVc1PyeE6w7M=;
	b=fJHvETjxOpzZVP9qQHBZL2vGeNqUqMH/QheL/rr98/6rni8ohe77tb98ea9i9fi9SB82
	 PM/nqK2C6WssvslrQTSP0mKXXKFTP6vJB4v1u7xyT9jfanHH8kN2a9BmTxhPsrLJ8QX/L
	 bO+DY4cQp4/47Yh4bR/U+qkBmT/XwC0H+aUclkLA0AopGQr9qrjEThI1c0PB5Fb3zM2Iu
	 szezeH2n6GDt4nQF3oVTY2e070aCv81kS3F3JPaQO7ZeEWNNfk6vA8tr6fC2GW/3TMAr0
	 q1ScXZXeRF2u2W5C/fNtBzCpIxw/+7u30HY2tMXtDxlLmCeEioNjk18Qz4vKjyKgoXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.115
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2115.outbound.protection.partner.outlook.cn [139.219.17.115])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C7606A326;
	Wed,  4 Nov 2026 01:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB9C7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOuf1Tkex94HGNdIDumpZUcBWzeLF5Vm4v7VH/wNXYBZIdQ7vJpPXTzDRDmcxPL2M0V0F8LjOU7nSuS3eEvbKq62oviQyTsQeVfsr+tNGgwlChiB4J2OMFzBrjzc0ZhieEGh4SLFDr7+KhLArYrCGuMTl2V9aCxZWXGIgbezuvZmjr/iiN50AB/DhlQhsGvgwRdz32SwYoQxmU5BMOiUv07UOB1SvYZIUFV51aVnf6BUzECbUfinAq9KlJ/UJPQsoXFseGkGIU8mQL2C5HF5Jle8uvCzimqj+5mR6BWLQf+ExPQGcTMn2Mphli1Krnym/g9xW01l6w35q2YCrkfu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0rvYf6m2Go3KEq3+HnLPv/NnkE0RttsVc1PyeE6w7M=;
 b=bDf+D2zJahK00nToFiAZEvqArJNP+8WpK3mq5W0Rvonqp8Kx0V1cNAhh0fLDJLQ95o/44EicXn+ydAMQxet+c52E7rky68QFhQcXOa/OhKfwW+7NJSsOnrOWJQB27Z3fNBCUTgJ9jCyHCM5k0zlUW/s87ISC3EmwTDcUhGpaG2upPIrA8Q/oBKDEy11a9IeVNLDUZq5aEK2X7h/AeU0J8iwr18rfPxcY+sFeP3RV2FnR1ntqqIetWVkSgFV9GuLAR0rNKx8s9zjStssyj12fSxnWLkr54Swx4oBOGDAaq+NLEJjkPuQiRHmSZ22kQFnNiY9apSfN0gAQTZV/BXB2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1281.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 01:07:29 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0592.009; Wed, 4 Nov 2026 01:07:29 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Asutosh Das
	<quic_asutoshd@quicinc.com>, Ritesh Harjani <ritesh.list@gmail.com>, Ulf
 Hansson <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-dwcmshc: Set CQHCI command idle time
 for StarFive JHB100
Thread-Topic: [PATCH v1 2/2] mmc: sdhci-of-dwcmshc: Set CQHCI command idle
 time for StarFive JHB100
Thread-Index: AQHdW9VJc7VFprSSMU2hBM2kxQKb17cWZHyAgAbVkBA=
Date: Wed, 4 Nov 2026 01:07:29 +0000
Message-ID:
 <ZQ4PR01MB1202D773F81FF1E0EC35F428F2682@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20261014121222.31385-1-changhuang.liang@starfivetech.com>
 <20261014121222.31385-3-changhuang.liang@starfivetech.com>
 <1db96e86-8f70-4b72-a2e4-a251c41fb1e3@intel.com>
In-Reply-To: <1db96e86-8f70-4b72-a2e4-a251c41fb1e3@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1281:EE_
x-ms-office365-filtering-correlation-id: 1c1f5a2c-1d87-4933-59f1-08df3a0fff63
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|22082099003|18002099003|38070700021|56012099006|4143699003|261102123227099003|261022075727099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003;
x-microsoft-antispam-message-info:
 prHb1OEVA/wZO/8JtA4DQGyzBc06wVC1iP8dHqWkZxqRBNkl2RlyITEN8Y1YZ839ouF01HSqFZELp3Zn9JH16MccW4XuWTSDvNzgY5LnAqXq/fLV6oqg7mrDypwTllv7NkfMbgcHh3bWFfQgRVaHalYS6FXSKZJT4avG8qnr/hBvxl2OmqLKDaGzJ8Nht/5jHFn2R+yPc4eiF8QFZzriSzX7cxL/hdavKUdmMbw6vs738VQrfvbuSoAGAkr5gNrInXfZloMB5X4QbldfGX5wFfqPnrGVKoV3UTHJoyseneFIW6QNSGnwJj+Mx5VtUBhaW7YKwQ2zfvqOK2G6//K0bW4pLE/N+95d0sgkIH9ydjt3qCFDeYRAaAdpiVfE6ZIvxnKVrqP78BTmGQKBIKck6E1vQ7vCczcz6Jqmc+5SB+XVXjKW9HB6lG7mVJLsXA2c6sE4PX1sgCJEEC66fTzuMufb66qK6d1uLtb2de3GhiXZLg4OzkUlafrlV5ItJo3etWUaX6baCHC8kDhDA/TVAMEoUAhLjSTWBLwmJu/hRWrOoEO8USVjcjsbaiWB0kjK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(261102123227099003)(261022075727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2NZQkpYelp1Sm9jcGh4ZFBtRUNXQzdUdmFYSFAzZjZJZ3ZJeEV2SXkveWJJ?=
 =?utf-8?B?RFVIaWFVekxlTUduWFNibWc5Z0pvdXRvTXZPZ2t1M3JZRTRYbzcveGZkbDF0?=
 =?utf-8?B?VHdWNXpJUzM3UHdoQWRJSGZGQlZwbEk5Vkk5NXg4MlBoY1dwN0phSzdQNm5R?=
 =?utf-8?B?N3hha3k0SXFuK25mTkgvZXZVanlYZ1dVME0xMS9Pb2svcEYvVlc5N2NHcXhI?=
 =?utf-8?B?dDdhMy9IT2tlbG9NR0NlQUFUM2pSMjAxRkVzWGc1WUhtZG5uWmtKV29oZTAy?=
 =?utf-8?B?TlJJKzM5WmF4cTVkRGwyYmRWdVFNaElkcEI1a3JwSkVVS0wxdWdIT3FlNUFt?=
 =?utf-8?B?ZXdBZW03dDM1UFhrLy90TllidUI3dWdTeWpTYmh3YkdIVjlsTno4NjFYcUNI?=
 =?utf-8?B?MDUvZXYwbTJJTzZQU1NXN3ByZ3NmL3VJc3RyWVJKajRBNThMbGVZclZoUFZm?=
 =?utf-8?B?UU9OdlZxQlJ5S0RyQkVKQXBsQmJlTDc1UVVPRTA3bzByTE1xYm1MN216cGlV?=
 =?utf-8?B?c05XK1hrWHI0VDZGbTl4Z20xVkYzMWNoNWptdzM4U0w1b2I1dDhsSlo0NGZP?=
 =?utf-8?B?bzhKQ1ZEYmFzdW5nSHBnRkRoeG9GZzRpN1VyYkFCYmpGSE5obG5iRmlIeTk5?=
 =?utf-8?B?MC9ocmNKOS84ZUxmU1lMVVU4c01QRC9WYnhMNllsbm9VTXFSMStOUURtZ1Zj?=
 =?utf-8?B?eEF3N21VK3JuNHFYS1c3c2o5dUc1bGF0YVppRkhScmI1eTVJbytXTzN5WC9K?=
 =?utf-8?B?NHBwbkw2SUdHMVdZK2lxLy9UZ0RrRTJSRjhvb1FLaXZBck1zNzFNekdMQ04r?=
 =?utf-8?B?ZkpZdlNpUkU0ZWs4NWthU2I0UzJ2ZGxVM0xZNG45bUxRRTBpVy9WTE83MVNu?=
 =?utf-8?B?dlMyNE5NUDBwcHZnbjhtNmRIaWxvN0pUWVN6eGJuZnRPeDdrV29lcUMrNndZ?=
 =?utf-8?B?VER1NlBxYUxETTdWZWNrMkNkSVBzUDBtQlByaDVjLy9aOG5MZDJWZWVQdWJ1?=
 =?utf-8?B?eUdwM2JnRW1Dc2hkVHVkSjhHbi9pVmlzdytWMjFOdS9HSUpoV3RlL0FodCtk?=
 =?utf-8?B?SkFrempzb2JsRXVHYVV1M0xRL05EdWxYZ0ZaNnBoQWZwb3dPRWdzNFZCQVo3?=
 =?utf-8?B?YVBENXAwOEZkYkhLaEZMeXBMNTQyUE1yL2pOU3E0eUxNTzlGRDlHeDlReHNR?=
 =?utf-8?B?LzF2QStnYXZua3d4UlZIN2xDSmtKcEJkTGxwUGZBSjVOS0IzVkN4dmNuUjZS?=
 =?utf-8?B?RlJlVVVFR280WEgxRWtjOWQxSEpBN1RDV3lKWXA5L0NNWU5BYzB5bTN4MkRR?=
 =?utf-8?B?NTd4OU8wTmxnZThDT0RYZC85Y1pBOHZhL2tYUkhINEJJaCs3K3ZRcXl1dEg0?=
 =?utf-8?B?SGNybi8xUFhWb01EbEtpN3RINCtPSHBSYS9sSU9pem1aSzFHNFJmZnBkSUtC?=
 =?utf-8?B?YTdqTHRoc2lxTHU5WGY4MkJ5L1VPTFJVZ2ZhNiswSGhuWlhwVGdydE9wTnhC?=
 =?utf-8?B?RnMwRHdmMXFISXN4bEpMSXc4bnhWVGMxcHhVMGhlOW1QOERFbDdSbnpDZ0xO?=
 =?utf-8?B?VXVYUnRkdFo4aDNlQS91bXNKcGQwMVZjU05aMDF5TXAxdHUvNzh3b3pheXh0?=
 =?utf-8?B?TithbG0vL2JMenNJZS80YXUzbGVZTG1ESisyNDlMa3hvRkVvdDJrUlVHcTlt?=
 =?utf-8?B?bVhROXZwSmkrRGNzTk1NeTFsV1dwd21BaEFjRzh6UHo4RGp5YUpScHBzVjg2?=
 =?utf-8?B?MCtSeHlmZnRpQzZ2L0gxb1NMamxodVpIcVNEeTkvVUwxeVM5T2tQSDZRa3Js?=
 =?utf-8?B?N0FvaFNKVzh3UjBTZC9NK2d3ZFdyNlBBZFMrdVJCY2U5SEhoRFlYT0VOSU83?=
 =?utf-8?B?NGY1ZTViMzlhOFk0SE5yMVIzRkJhdjA1ZkRUSlR4QlQ4NWI2bGFhc1BtVUlV?=
 =?utf-8?B?Sk9mY3c3TURwbHRxUGc0Nzg4MVpuTTRBRVdIUnVTUGN6bmhqbTNYTXRjbDB4?=
 =?utf-8?B?TnNneHVPbW9FdElWTnFvSWNQUVFMdXp1ayttcmlOOWI2dEQyYzUxbFFBQkVn?=
 =?utf-8?B?UDBEOWp0bTJsL0s4Qi92eFRPd1lZc3VZSDU3Y3MrVXFUUFhXUExtb2I2eTFq?=
 =?utf-8?B?OWtyYzdFakU5bEIyQjB6cXp5VVA4T21SUFRUUTYyeXNNQ2FYYkUxd3krZ0RY?=
 =?utf-8?B?OG1HVkVod3VyWGZoK2Q1K3VVUjlrVTBsKzRTWldIZ2xxZHFRamREeWhBWk9v?=
 =?utf-8?B?SGE2cnE2bDRpWnZFYStMNVgxbGRxM1FIK0tERTZyWmpzeXJTRXlocTJ1RUR1?=
 =?utf-8?B?WjR6K3lnQ2EvT1B1WENpWHIwN2tSWHdvV2dOZVV5WC9idjFHSHpaSmc2SFlQ?=
 =?utf-8?Q?pTXSKt0Q2qWL7BUo=3D?=
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
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1f5a2c-1d87-4933-59f1-08df3a0fff63
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 01:07:29.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69j7acd9wYnU468DUVVLKYASQVADmrlEmpSsS6BoDeWWjbIiRUFZF+ui5EDh3DhSCAGI42f1a+x2diLX3oZK/1vpJIoVLfnuSjT9Ys6vMv+IncypBHiYKBNj7vykGUse
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1281

SGksIEFkcmlhbg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gKyBTaGF3bg0KPiANCj4g
T24gMTQvMTAvMjAyNiAxNToxMiwgQ2hhbmdodWFuZyBMaWFuZyB3cm90ZToNCj4gPiBBZGQgYSBj
cWhjaV9ob3N0X29wcyBmb3IgdGhlIFN0YXJGaXZlIEpIQjEwMCBwbGF0Zm9ybSB0aGF0IHNldHMg
dGhlDQo+ID4gQ1FIQ0kgY29tbWFuZCBpZGxlIHRpbWUgKENJVCkgdG8gMzIwIG5zIGR1cmluZyBw
cmVfZW5hYmxlLg0KPiA+DQo+ID4gU2V0dGluZyB0aGUgY29tbWFuZCBpZGxlIHRpbWUgaW1wcm92
ZXMgZU1NQyBwZXJmb3JtYW5jZSBvbiB0aGlzDQo+ID4gcGxhdGZvcm0uIEJlZm9yZS9hZnRlciBk
ZCByZXN1bHRzOg0KPiA+DQo+ID4gYmVmb3JlOg0KPiA+IGRkIGlmPS9kZXYvbW1jYmxrMCBvZj0v
ZGV2L251bGwgYnM9MU0gY291bnQ9ODAwDQo+ID4gODM4ODYwODAwIGJ5dGVzICg4MzkgTUIsIDgw
MCBNaUIpIGNvcGllZCwgOS4zODUxMSBzLCA4OS40IE1CL3MgZGQNCj4gPiBpZj0vZGV2L3plcm8g
b2Y9L2Rldi9tbWNibGswIGJzPTFNIGNvdW50PTgwMA0KPiA+IDgzODg2MDgwMCBieXRlcyAoODM5
IE1CLCA4MDAgTWlCKSBjb3BpZWQsIDEyLjIxMjcgcywgNjguNyBNQi9zDQo+ID4NCj4gPiBhZnRl
cjoNCj4gPiBkZCBpZj0vZGV2L21tY2JsazAgb2Y9L2Rldi9udWxsIGJzPTFNIGNvdW50PTgwMA0K
PiA+IDgzODg2MDgwMCBieXRlcyAoODM5IE1CLCA4MDAgTWlCKSBjb3BpZWQsIDMuMTk0NzIgcywg
MjYzIE1CL3MgZGQNCj4gPiBpZj0vZGV2L3plcm8gb2Y9L2Rldi9tbWNibGswIGJzPTFNIGNvdW50
PTgwMA0KPiA+IDgzODg2MDgwMCBieXRlcyAoODM5IE1CLCA4MDAgTWlCKSBjb3BpZWQsIDEwLjc1
ODcgcywgNzguMCBNQi9zDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGFuZ2h1YW5nIExpYW5n
IDxjaGFuZ2h1YW5nLmxpYW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jDQo+ID4gYi9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYw0KPiA+IGluZGV4IDI0OTA1NWYxNDE2Mi4uMzY2
MjhiNDRmNzhiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdj
bXNoYy5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMNCj4g
PiBAQCAtMjgzLDYgKzI4Myw4IEBADQo+ID4gICNkZWZpbmUgUEhZX0RFTEFZX0NPREVfU0QJCTB4
NTUNCj4gPiAgI2RlZmluZSBQSFlfREVMQVlfQ09ERV9TRElPCQkweDI5DQo+ID4NCj4gPiArLyog
Q0lUIGZvciB0aGUgSkhCMTAwIFNvQyAqLw0KPiA+ICsjZGVmaW5lIEpIQjEwMF9DUUhDSV9DSVRf
TlMJMzIwDQo+ID4gIHN0cnVjdCByazM1eHhfcHJpdiB7DQo+ID4gIAlzdHJ1Y3QgcmVzZXRfY29u
dHJvbCAqcmVzZXQ7DQo+ID4gIAl1OCB0eGNsa190YXBudW07DQo+ID4gQEAgLTIzNDAsNiArMjM0
MiwyNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX29wcw0KPiBzdGFyZml2ZV9qaGIxMDBf
b3BzID0gew0KPiA+ICAJLnBsYXRmb3JtX2V4ZWN1dGVfdHVuaW5nID0gdGgxNTIwX2V4ZWN1dGVf
dHVuaW5nLCAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBkd2Ntc2hjX3N0YXJmaXZlX2poYjEw
MF9wcmVfZW5hYmxlKHN0cnVjdCBtbWNfaG9zdCAqbW1jKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qg
Y3FoY2lfaG9zdCAqY3FfaG9zdCA9IG1tYy0+Y3FlX3ByaXZhdGU7DQo+ID4gKwlpbnQgcmV0Ow0K
PiA+ICsNCj4gPiArCXJldCA9IGNxaGNpX3NldF9jbWRfaWRsZV90aW1lKGNxX2hvc3QsIEpIQjEw
MF9DUUhDSV9DSVRfTlMpOw0KPiANCj4gQ3VycmVudGx5IGRvaW5nIHRoaXMgZnJvbSAtPnByZV9l
bmFibGUoKSBsZWF2ZXMgYSBnYXAuICBJdCBuZWVkczoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9ob3N0L2NxaGNpLWNvcmUuYyBiL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5j
DQo+IGluZGV4IGE0NjZjZDg4YjA0My4uZTFiZjZkNTBlOGViIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL21tYy9ob3N0L2NxaGNpLWNvcmUuYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L2NxaGNp
LWNvcmUuYw0KPiBAQCAtMjgzLDYgKzI4Myw5IEBAIHN0YXRpYyB2b2lkIF9fY3FoY2lfZW5hYmxl
KHN0cnVjdCBjcWhjaV9ob3N0DQo+ICpjcV9ob3N0KQ0KPiANCj4gIAljcWhjaV9zZXRfaXJxcyhj
cV9ob3N0LCAwKTsNCj4gDQo+ICsJaWYgKGNxX2hvc3QtPm9wcy0+cHJlX2VuYWJsZSkNCj4gKwkJ
Y3FfaG9zdC0+b3BzLT5wcmVfZW5hYmxlKG1tYyk7DQo+ICsNCj4gIAljcWNmZyB8PSBDUUhDSV9F
TkFCTEU7DQo+IA0KPiAgCWNxaGNpX3dyaXRlbChjcV9ob3N0LCBjcWNmZywgQ1FIQ0lfQ0ZHKTsN
Cj4gDQo+IHdoaWNoIGlzIHByb2JhYmx5Og0KPiANCj4gRml4ZXM6IDc5Y2Y3MWMwYjE3NyAoIm1t
Yzogc2RoY2ktb2YtZHdjbXNoYzogcmVkdWNlIENJVCBmb3IgYmV0dGVyDQo+IHBlcmZvcm1hbmNl
IikNCj4gDQo+IFNoYXduPw0KPiANCj4gDQo+IEdvaW5nIGZvcndhcmQsIGl0IHdvdWxkIHByb2Jh
Ymx5IGJlIHNpbXBsZXIgdG8gcHV0ICdjaXQnIGluIHN0cnVjdCBjcWhjaV9ob3N0DQo+IGFuZCB3
cml0ZSBpdCwgaWYgaXQgaXMgbm90IDAsIGluIF9fY3FoY2lfZW5hYmxlKCkgZS5nLg0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jIGIvZHJpdmVycy9tbWMv
aG9zdC9jcWhjaS1jb3JlLmMNCj4gaW5kZXggYTQ2NmNkODhiMDQzLi5kNWY4YjQyN2UxZjggMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jDQo+ICsrKyBiL2RyaXZl
cnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jDQo+IEBAIC0yNzksNiArMjc5LDE0IEBAIHN0YXRpYyB2
b2lkIF9fY3FoY2lfZW5hYmxlKHN0cnVjdCBjcWhjaV9ob3N0DQo+ICpjcV9ob3N0KQ0KPiAgCWNx
aGNpX3dyaXRlbChjcV9ob3N0LCB1cHBlcl8zMl9iaXRzKGNxX2hvc3QtPmRlc2NfZG1hX2Jhc2Up
LA0KPiAgCQkgICAgIENRSENJX1RETEJBVSk7DQo+IA0KPiArCWlmIChjcV9ob3N0LT5jaXQpIHsN
Cj4gKwkJdTMyIHNzYzEgPSBjcWhjaV9yZWFkbChjcV9ob3N0LCBDUUhDSV9TU0MxKTsNCj4gKw0K
PiArCQlzc2MxICY9IH5DUUhDSV9TU0MxX0NJVF9NQVNLOw0KPiArCQlzc2MxIHw9IEZJRUxEX1BS
RVAoQ1FIQ0lfU1NDMV9DSVRfTUFTSywgY3FfaG9zdC0+Y2l0KTsNCj4gKwkJY3FoY2lfd3JpdGVs
KGNxX2hvc3QsIHNzYzEsIENRSENJX1NTQzEpOw0KPiArCX0NCj4gKw0KPiAgCWNxaGNpX3dyaXRl
bChjcV9ob3N0LCBjcV9ob3N0LT5yY2EsIENRSENJX1NTQzIpOw0KDQpPa2F5LCBJJ2xsIHRyeSB0
aGlzIG1vZGlmaWNhdGlvbiBwbGFuLg0KDQpCZXN0IFJlZ2FyZHMsDQpDaGFuZ2h1YW5nDQo=
