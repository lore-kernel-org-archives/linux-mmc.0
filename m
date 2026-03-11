Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C83C343B;
	Wed, 11 Mar 2026 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223408; cv=fail; b=AhOYKb+MbH74smuDEgAeSrCjkF5W4bIIj4Al1esdX6BFqYdp2F1jblXaQBcdkT7b9PvakNUbcVq0qyr0mzHx34nQK44d5V7T/XrVO51s7mdA9tocdKjW9vFE0YwY2BFw24sYzysvv0KM3YKxWtYl7JWboxRM03+bdRhB3EpXqzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223408; c=relaxed/simple;
	bh=/6r4LnS5O1187ooPmN2TGq4m51mBrB91zgTpqrZqKq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EXp9MZ7+3FbPZ8yk34hEbmDpReAEiOWLxunmyH2PoN/8/VL18PsWnewsEqQpYacE/cm3K4bvXDfYE9IQUD8w61IHx5LJzApqGX4Lvoj4fAm0XVpMAa3L7nZ1uZogVmHWcEEHQffv+80UWy4pyfducZpRg9omne3LURW6Iw0jkQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ipLag4yc; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ipLag4yc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpEd+E9UG2+4wBmMSd99CCSaNIicRMUrFBa+2s99eD1C7ZZj3rYUoXA09JjEVcgGyzJaixpnLxOZC/KbcVNCsac/FK+iuiQtUQYHOeYJ20JBPSITcBIKphuK2NmKupZ/KbF2BR16Szptxh1/b3kfFHA5f7M5xRt7GJjyYNExleJy2L38RYKtzPhWIzMAauRaXoeCfBfQgHPe9r4FoLoloAgW1ZmEgYTLmSVkwS5peAZAapzULtDazxku+pwV8KWVIidNTZkv7JVu8qQ4a/q5hTQm2RwyTPYhergmFWeHKI5jwB8v4oTZ2LZ7YHiI6gw3hfTqkTnpMyV4a3JrUJDbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6r4LnS5O1187ooPmN2TGq4m51mBrB91zgTpqrZqKq0=;
 b=mk7CHdgTxAkBZVBSETITEZRBcUATuc9GvmtXvRvL+DFw8pORXgUMuLYTuHnx75xCveXBJxyeOcRSK0iAf8vmFZjfWM+udXPVfjao37vMopVEi2aPjURAvhAwUYHP4eTmXyYaTuo4A1qSzzAx2oZR+BFWkDsnjWeWVP8+Tk8UmLOeV7g57x8LdybwqjAieAeRUOLTuKuMYMmJYZ+S6O3IP4qCA1zpuQqFGEbLba0CYOrPNwdv0MATIXG3GHGObOejmiI9ngVGg3eeLTsRbUKImImbwWrgi7avvo4U/gZSvt68IVxuwEzGsvfVRUdOdglJdZm7GossfEyTvp3bwuZpSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6r4LnS5O1187ooPmN2TGq4m51mBrB91zgTpqrZqKq0=;
 b=ipLag4ycwb5WHJGvgquM3r/LOI0ofHACSkZ4I3wEcwYQ9d5XTnD72TAnqHpUeWKt4q9RsbKhTuCzQGcHRB4g0O1BtMPOjKOQY53ON3Ug7OTcvAwSr/Xt5gxTndHSARms/QrnUb0g0cJQEUNs7Yfe5pwd3Qn/7sOqCCutBfXtntYI4H5Qm8kCwVBApekSvcLW4J55zn9ZxrfifWeWWPYdK+7uFZLATK2oEYUap6l0jvrdnwgrto38oNrutCqdrsWgpVNbeBLDqv+2k1cKmBpBd9zDJ8EaeG/1HsjtJun5VDgAHNspPKjGM8dOZtY3xk0JzaMyj0u6+SUrDhvhbLe8bA==
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 (2603:10a6:150:328::18) by VI0PR04MB11501.eurprd04.prod.outlook.com
 (2603:10a6:800:2c8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 10:03:22 +0000
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908]) by GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908%7]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 10:03:22 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Luke Wang <ziniu.wang_1@nxp.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
Thread-Topic: [PATCH v3 2/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
Thread-Index: AQHcsTw1vvM4u/tV70+fGz+TZPM92LWpGfDQ
Date: Wed, 11 Mar 2026 10:03:22 +0000
Message-ID:
 <GV2PR04MB122727D9E21D1128F93FBDCD69047A@GV2PR04MB12272.eurprd04.prod.outlook.com>
References: <20260311095009.1254556-1-ziniu.wang_1@nxp.com>
 <20260311095009.1254556-3-ziniu.wang_1@nxp.com>
In-Reply-To: <20260311095009.1254556-3-ziniu.wang_1@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12272:EE_|VI0PR04MB11501:EE_
x-ms-office365-filtering-correlation-id: a16cd8d9-027b-4288-71b9-08de7f556daf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|56012099003|18002099003|22082099003|7053199007|38070700021;
x-microsoft-antispam-message-info:
 eLAec/Q/PMsJfpZTj8V2RgNH52ehhu6k3TUiLRsneh09pO/Kiem/PPm6AVliba3rQ2tZsZvBOHsuG3hY/IcuIQZSxww/xW9321++sU6LFMqQ52QRa+vtKvezILJtYSCami94rvImzWgFysCtTXHcTFsAqorMhsKTRRv+eTMYJo1yaro7CWdkChU3K9WXnBRKQe1AIQkDgS2or5D73/BhlOPKyIEcE3E9U6PpVmAebEaMoZP5hrHkjSZGszVWL90DRbh65a5oYQzgtTMKm76tuKPCOy9P7ZwgnFEqhXzWhLnl6YKEQX/ZyRghJkQBfgjiUpSK8N4xKawFfu0Ew/7IX6ZZAELzdy5+RwOBt3LNwVyyRRIGBBtWiMYI0fVkApF7Z/pNvltC3qjLQ50xJOBw2fPjdinK1DxFitQ8Rwhg9TBFxIy0ye3DKtCaV3a9HWyz7tGb4vcwzPnkKDvl3XFCGioX+mPsl6ITJhDJ6lxCyChqSVzn1VpueJcncVntzeJXYjDUpx6GjC+RFvoDsqBqSky8Qu63KJc3iIEHnq2VnEHh2zt8Q4A7dYcIq7OLydENjRjPHcYikqindnmyn8PNb/GlkRU4DM2VLSuPJLvd3881Rt+b7ZAndvbr6mEb2CHJNZLnWQSdLlvbJpTbBHxdrsQqsUk1MuU+lXjwaE/Ma0xP0gCbS1BKKmA5wT71dBCzOIaxVUp4rdIJewDIrvO3RJN0tVjm8TzAjL7suK4oEQuvZqj6ZQAzirYNgjD+aaAjBTzeXFmBHLrzXFDUSlmCeWktq0L66lGpDqv1+WJGEp0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(56012099003)(18002099003)(22082099003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?K3V6S21Da0RYUHptUnFqNzNJUytIclRhQ3U2bUtQL29DRStIbjl1MTI4UU8r?=
 =?gb2312?B?OXo0dGhDd3dPRHNrbCtsMDQyRHlmWnFtQUJSM0x3OHVRS2pYWVFaK2JXcHVz?=
 =?gb2312?B?U1B2d1pVRmpWNHM4M05KcG5KS2xwQnNoTjZlSHZCZWM0MGloV3haYTRaTE1h?=
 =?gb2312?B?UzBqOForN2JsbFRuTTF1V21qeUJmM0ErSm9ncFAxRFFJSmtvQlFkZHY3eDc0?=
 =?gb2312?B?bUFHaWlXemxXY0ZMeHVoekpLR25VVDdtMTFGM3ZMeXRhRVF5NUg2NnhpK3Y5?=
 =?gb2312?B?aHNqWmtOS0dkalA3RWxpNlhIMmNObVpTaXF3SE5mMHJiZlZFQUZaSUdJRDU3?=
 =?gb2312?B?a3NNUkpzZHBGOFZBRUJkTGxZWDZkZ1ZkVDVVZEt1UEkxbkF0VXZRMUMxUDNl?=
 =?gb2312?B?NXI2TEsxSDV1V012aUZZdVVDc3U4ZWlGOXJKeDR6MHQweWhPeDVLSzMyMHVM?=
 =?gb2312?B?eTgrYnhzZStubEl6c0c3aFhzWHhXa2dFTk1NYUIzVXRBa1hwTlFMNzFkeE9Q?=
 =?gb2312?B?TVBzcEhmZjk1b0hnekhmazJ0OGxOaDV2bVVZd1dGTnVIUmQ2L0EvdStGZXBs?=
 =?gb2312?B?b3k1M3FBdnNDWnJhM2lHdzBkdG1rZXBsNkJpNFpJNnlxNjkxeU9qSE9jcTBm?=
 =?gb2312?B?SGw5anM3OU1ocktXcXRPWUxMM1dKT0xPYkY0bmtiVGdrbkZpNnRIN1hyV3Rp?=
 =?gb2312?B?TnpoakNmeVUwNkg5bCtkOE9kUjQxb2NoQjV3Q0U0QXRwdENSK2pQNDNERXJw?=
 =?gb2312?B?MGg3NWM0ZUl2OVZwcmUvaWNlQUwxME1pajRTTkpmM3p0VjNxc0tzMnJZTTE1?=
 =?gb2312?B?YjJQemZnNmsyOHN2WjZYeGZMK2pPNnVITmovMVlLWGtxcHE3NzFhcUZqK0Z1?=
 =?gb2312?B?V3gzdjhJT2tSRlhEWUlQbUU5ejN2aWhpTFExdm9vd1E3N3RQTkt3bjNHelN1?=
 =?gb2312?B?cExRMEt0MVoxckFkOEdlUWs4VHBZYTZxa2R2R3gwOFZoZVp6RXE4UWFtS2Nq?=
 =?gb2312?B?aFR5b0VFWGE0a1NXSG5ldWJoUm52L01mSWxLNkFRWi9sMUM0Wk9TMVMrNlJK?=
 =?gb2312?B?QzdMTlN4aTljZ1ZhQStoZFRaMjdVeC8zVTdMUEtsdkJheVJvUHAvUlQxai8r?=
 =?gb2312?B?MW5rVUwrZmJ0QmlWU0I4Ymt6dlpaMk1sbFJtcFQycURza1ZQZDNaTS90cWxL?=
 =?gb2312?B?N21CWm5WVG4wT2RDd1ZaTHBrcXNHWUxIMGtlbnA4T1pHYktTZmNmSlJFUjJn?=
 =?gb2312?B?d0ZVdlg0UkdQRU1CNmF0Z0xuWHpUbDJSK2p1ZnBZLzVhK2dUZzZvUUdLTHF4?=
 =?gb2312?B?OGV0M285c0pzMnBtOGszeDJQQi9HUEp4Q2VVNk9wSk4xUllKM2MxaWZHZmdY?=
 =?gb2312?B?TTUwdTJEODdPTjBPam1IcmJCSHhRcjd4WkdIb21Qc2I1VmF6WUcvbGIzYzlK?=
 =?gb2312?B?eXBwWS9RRXQvTHI1cVJDc01mQ1Zva0xjMk9BR3d5V3dwL2ZFMldZcVJVV29U?=
 =?gb2312?B?QUo2THNxaUZ0RE82MVlFWm84YURNMmdtVE5mbnVCeUQzNjBzZmRtaFpVbjBu?=
 =?gb2312?B?ZHp4eXdmQjVnK3JuYURHa1Y2ektCT1NySTIvc2VKekFiV0pqRlZRaDkwdnZh?=
 =?gb2312?B?U2QvZEtsRlN4cXZhSk5GcjdlMFIyNVpVWEVhNVZKN0ttdmllU1VyNEhKK1NZ?=
 =?gb2312?B?SFh6V0Nnb2VMMjMyY3FBMjJQNGJucFhlRk0veTE1aVpLeHFJeDNiRGY5K09V?=
 =?gb2312?B?OFhOVThoa1BLbXhFNi9saklneG1Zd1doamdEY1lISjVacjhLbTcyNTQ5SHVL?=
 =?gb2312?B?T2w1Zm5ORDh0Qy9CRmNzVGVWeUNYaVo3bVhHWWZXOWxDSjJWYWc1TEJCcGYy?=
 =?gb2312?B?MWV6QUo2Y1AyRGlWMUJXZ2ZaNDJRWkd2ZElDdW9sa25mVk45VnFZM2pDMkhX?=
 =?gb2312?B?aHJuOXpOUHhqRjg2UmVYQnY0SEFtWVRYVmVJcFdDUWNUTkZqdlVhd2tuWmdp?=
 =?gb2312?B?bkx3YzhTa1J2bEVVMS9OK1FwbTVxVkZrZUh4K3FaVjlMdXVvc0R2UkppL09o?=
 =?gb2312?B?YmgrUUtKRDh3TFhFMkxOSTJsRjA4K2c4bkROUFRlbnY5dWNpUlJlWTZZQjV0?=
 =?gb2312?B?QzZVTDhGQ01tSGUyN2FkODFnRmRmUnJVVjE1R1dDV2s3NFV6TlFIVEFBdWc3?=
 =?gb2312?B?cE95aDdhN2ozN09yS0Y4VUdPR3JFTHc3OFdPTHJiaEI0ajJnU3o1WXFkMW11?=
 =?gb2312?B?UlVBd0h6S2VtWmM5Ump5TTNTVzhxQ3JSZTJjYjdlSGMzWkk3UjlSZ0dXVnpF?=
 =?gb2312?Q?LKJmUl0tOyXe2xgWJB?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12272.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16cd8d9-027b-4288-71b9-08de7f556daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 10:03:22.2285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CN6IdG62JFwGd8MIVGAC86nU7NNNzS+007ICfFmPkKLqGMxZTfCXqg23nCSi3IZbSx1YADp3BUU7QcXnGzE9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11501

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1Lndh
bmdfMUBueHAuY29tPg0KPiBTZW50OiAyMDI2xOoz1MIxMcjVIDE3OjUwDQo+IFRvOiBhZHJpYW4u
aHVudGVyQGludGVsLmNvbTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgQm91Z2ggQ2hlbg0KPiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFt
QGdtYWlsLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgtbW1jQHZnZXIua2VybmVs
Lm9yZzsgZGwtUzMyIDxTMzJAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFU
Q0ggdjMgMi80XSBtbWM6IHNkaGNpLWVzZGhjLWlteDogYWRkIDEtYml0IGJ1cyB3aWR0aCBzdXBw
b3J0DQo+IA0KPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiANCj4g
QWRkIHNkaGNpX2dldF9wcm9wZXJ0eSgpIGNhbGwgdG8gcGFyc2UgY29tbW9uIFNESENJIERUIHBy
b3BlcnRpZXMsIGluY2x1ZGluZw0KPiAiYnVzLXdpZHRoID0gPDE+IiB3aGljaCBzZXRzIFNESENJ
X1FVSVJLX0ZPUkNFXzFfQklUX0RBVEEgcXVpcmsgZm9yIDEtYml0DQo+IGRhdGEgYnVzIHdpZHRo
IGNvbmZpZ3VyYXRpb24uDQo+IA0KPiBSZW1vdmUgdGhlIGR1cGxpY2F0ZSAibm8tMS04LXYiIHBy
b3BlcnR5IHBhcnNpbmcgc2luY2UNCj4gc2RoY2lfZ2V0X3Byb3BlcnR5KCkgYWxyZWFkeSBoYW5k
bGVzIGl0Lg0KDQpSZXZpZXdlZC1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0K
DQpSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWtlIFdhbmcgPHpp
bml1LndhbmdfMUBueHAuY29tPg0KPiBBY2tlZC1ieTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1
bnRlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1p
bXguYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhj
LWlteC5jDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBpbmRleCA5
NzQ2MWUyMDQyNWQuLmI2MDdkNGZmYzU2MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1lc2RoYy1pbXguYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhj
LWlteC5jDQo+IEBAIC0xODEzLDggKzE4MTMsNiBAQCBzZGhjaV9lc2RoY19pbXhfcHJvYmVfZHQo
c3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldiwNCj4gDQo+ICAJb2ZfcHJvcGVydHlfcmVh
ZF91MzIobnAsICJmc2wsc3Ryb2JlLWRsbC1kZWxheS10YXJnZXQiLA0KPiAgCQkJCSZib2FyZGRh
dGEtPnN0cm9iZV9kbGxfZGVsYXlfdGFyZ2V0KTsNCj4gLQlpZiAob2ZfcHJvcGVydHlfcmVhZF9i
b29sKG5wLCAibm8tMS04LXYiKSkNCj4gLQkJaG9zdC0+cXVpcmtzMiB8PSBTREhDSV9RVUlSSzJf
Tk9fMV84X1Y7DQo+IA0KPiAgCWlmIChvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgImZzbCxkZWxh
eS1saW5lIiwgJmJvYXJkZGF0YS0+ZGVsYXlfbGluZSkpDQo+ICAJCWJvYXJkZGF0YS0+ZGVsYXlf
bGluZSA9IDA7DQo+IEBAIC0xODMzLDYgKzE4MzEsOCBAQCBzZGhjaV9lc2RoY19pbXhfcHJvYmVf
ZHQoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldiwNCj4gIAlpZiAocmV0KQ0KPiAgCQly
ZXR1cm4gcmV0Ow0KPiANCj4gKwlzZGhjaV9nZXRfcHJvcGVydHkocGRldik7DQo+ICsNCj4gIAkv
KiBIUzQwMC9IUzQwMEVTIHJlcXVpcmUgOCBiaXQgYnVzICovDQo+ICAJaWYgKCEoaG9zdC0+bW1j
LT5jYXBzICYgTU1DX0NBUF84X0JJVF9EQVRBKSkNCj4gIAkJaG9zdC0+bW1jLT5jYXBzMiAmPSB+
KE1NQ19DQVAyX0hTNDAwIHwNCj4gTU1DX0NBUDJfSFM0MDBfRVMpOw0KPiAtLQ0KPiAyLjM0LjEN
Cg0K
