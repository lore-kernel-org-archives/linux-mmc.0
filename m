Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4093C454E;
	Wed, 11 Mar 2026 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223438; cv=fail; b=UbqgattnfmEfxpDDf5QEPy0deL6n8MVcyux/e3tk9BAFyVutmxmu3+BJIeO/iPtkamnoyahLeI+jGpHn+qVVsMfOfVICgiwCK/APEQT0+m1deBjhuB1bGK/Ce5BnMEY2HHE/dmH8LRtDIk3WaG3LGkVR+g2Hbqc04ZPVew8+8+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223438; c=relaxed/simple;
	bh=X6r2yohNmMwbi2yuOmUsHtqV6XSB7pT+Wazt6ea/Z2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jefRwj9BbvKYmwkqtjndnyZM4MH2JEtr3XRbpwopRkA94/BLqKQ5WUFkWpGx8Sb1vniNlqzVanzTT4yX/dteFPCiABWfstTNBvxfqlnU9wLrRStcNEM1eheQ1Jsi7sX3VUFH7v0bilV/tC5PoFZGFmuSJzdEs6SMADcFahdclEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LGbP0kOQ; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LGbP0kOQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyDuJi/Ucj16KN2M87L7jhoe9RLUcTT/l4/W1gU3hxYCfyaPM2tzMpeR+183FGlAxYN30md21NkeqQuvspvvBNH8RcRRf15k2Oo/NbEyzDQEZy46zIL1Bo/Y9r00HQV1YCxhaX0nLEMgL1k7YmaCDB2Dgf4YfX+LLFes6o08cd8uf4YKDvd7IACI3QuEB7EnbA8q36UMsIXT9QLkTtn33vlaYVlhnN1iVGdvsIzImfSguyUnTs7Wgw7AJKiTtXlVC8yloZ7ub4MPcS/Kv5WXebVYCPktSPjs282XDQoMUtwEuSRjP67aUHMlelb/rOdb0xE2AzPCwYyA3nmFdPtgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6r2yohNmMwbi2yuOmUsHtqV6XSB7pT+Wazt6ea/Z2c=;
 b=Vc7kHUJkm4zTZewTnhTNiWjHIUuorrc4DjfNwenga+4P+Umw0trFp2CAttuHP6JnOaakuwx5WcFizGJguxbcvlIm5Bfo/Gj/NcyvNZrvCDNdW1aVLBTnE12tzslhGYA5YQUPMhTV2FupYVmqiwpGzXmUWBQInNiWWKMyKsKc6gpyMA3ALOf/bLcR93eFUB90a7fWPLMOY4EAGVmj0Yw4UJF0UrTbE36OGR6liOinzehlD4sQgg4GaK37CF807DGcDg52RtxKNW2mLams+1VgM7Hmjz11RkE/fjBSKfXlZuHCJRNmuX48KAdzk1U8gR+fKu23iNZ3dbDgYClG+TQbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6r2yohNmMwbi2yuOmUsHtqV6XSB7pT+Wazt6ea/Z2c=;
 b=LGbP0kOQdQRYNwBx7dRGpUXJwsEdR4sE9FiH8tNdu9FBzQY0XJEIYVCbDbtSNO50xmSEy/y9V+dz1eFiSkFbdHHiTKImw6ss4zwDkjVLM5Ju/yR+pMBL8Cgzdr9kFLfvC1qY3GgoAfjUjIann+tq6h5bxEN+Chn9Kc+2wBc7jV0rwtiubh1KT7hZ/Jt2fPiYCTX+6O7eD9MSo0v4mzAVXu3B24v6s55nPwGT3A8wBqGXg7gNYGvRbsItneYrmJxR1es59KVCNKWjiv6y8WFaeizZuPRvLO+2pFZqioSn5y18T4EyfDOFvw/5WUuj5uvdbPvAohamnDKclI+upSWQ1g==
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 (2603:10a6:150:328::18) by GVXPR04MB10635.eurprd04.prod.outlook.com
 (2603:10a6:150:21b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 10:03:44 +0000
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908]) by GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908%7]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 10:03:47 +0000
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
Subject: RE: [PATCH v3 3/4] mmc: sdhci-esdhc-imx: remove duplicate HS400 bus
 width validation
Thread-Topic: [PATCH v3 3/4] mmc: sdhci-esdhc-imx: remove duplicate HS400 bus
 width validation
Thread-Index: AQHcsTw4nKYL72mPikijeo4AJ0qsTLWpGiCw
Date: Wed, 11 Mar 2026 10:03:47 +0000
Message-ID:
 <GV2PR04MB122728BA9792850F4FA9234679047A@GV2PR04MB12272.eurprd04.prod.outlook.com>
References: <20260311095009.1254556-1-ziniu.wang_1@nxp.com>
 <20260311095009.1254556-4-ziniu.wang_1@nxp.com>
In-Reply-To: <20260311095009.1254556-4-ziniu.wang_1@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12272:EE_|GVXPR04MB10635:EE_
x-ms-office365-filtering-correlation-id: 81783f34-a39c-4584-68f9-08de7f557ce1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021|7053199007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 KrWHnln2PZi7Iaxp5aBXM9WhxjRzj2FIm4waHC1UWSSWNAg5vIZVshbV002ID+3nN685q269cD02pdBlzbg/CQmvAAtK9NPbyNhr/xwgwewAyaQ3burwmYUOdEaXYXIMaDYBhQxTz8zla0jHX0yGyW1liS6+r+Nh3m98zvWLRLPEe6wkmnyTAPaD4YqovYkMCDneosoX+u4eGtKtfcpCmEjzw+r/4uQ5+p5qY0weX2jZNFAwJoES72XjzKfgBxMVvbgbieQcCMDTvxjcCQw+GiUrvk8o6yI4dNnM7zp2DmFdDwhD24FVAbTsIO7oOhtNGdnMauSJ5To90YpGvTvr1ta4BOUax/llDywDzXvhzjidOa/JEpLOwKZg/CdVZC/GSxRqiHZ7MkVx/Jb1dyDfBgJvbcjl0P0gn1UmHmALSdpivqrkMRnCYl/swdCV4IfpKtr5uCLfcclv0fD7mg5xxEqDR2UFAbOzpCqlib6nGG2oCwBQ6dPOuJ7RY5NF5v71vgQwINZb9fD8dB+kZrhWWYUk9/cYz9YLblCKmXpa6pvf5kKn5TGKwV9h3tjLubi8bem/X6vH0ardvYnLv65mEgrIlPU89zAamtLD/GLBLU0wKEd82jhShu8LHGsr4dd9CiUyg70N2q8bWUES7KQBzWlXWm2/Zf0ojy3NeZd8PczmKUGRftnZ8GMXfxm+h43WMBumO14UEzr2akNhq+fTfKjJ37+aX9tTUgiUFWLJ8+czFMHUBoMm8HN1rQj6BvzzH7bMFfcyu8wq1U6KBQ/6XKKT0srUGoULsPkLkWKlxb4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cTdCL0hxWktXTWppNHpMby84RFQxZmczSFNSa1F2NTYwZ3UrT3hORDd6cUYz?=
 =?gb2312?B?QS9ReC94K1ZzZG0vRFFmck1XSlZzdkN4OUJpbU5YNDFvVVBuRWREUjVIUW5u?=
 =?gb2312?B?YTVHMVNQWTl4WGxSaVZhWCtLRG1wZlFFakhYa1U3d1poNGRNMzhhcUNLR2h4?=
 =?gb2312?B?dFI5VW16VncvWkdSaDNqanYvS2RpWHU1NEhmWG5jT2E2c2xxV0pSeU5XcFJJ?=
 =?gb2312?B?Y0NqWkRUemhGTnVrYzF0VzBCMHhIc3B5UUpDODFrVG1PUHVQTURtaFVsL21h?=
 =?gb2312?B?aitBbDcrL0VEY093YzhXQk5jeXczQjdRMDZHRDVZTTdaMnFiTytHZnNqWEdj?=
 =?gb2312?B?MjRQcjRxR2h2RnR1dENMMHVMSytLcDhJOHZVU2xPMm1wMDRPTTNwS1FEd3V4?=
 =?gb2312?B?VlVqOXVvcWdGM1kxdkxGNGozZzY3YkZ1S1dseVh5WnlEaVpZUU1UaVE3MHRK?=
 =?gb2312?B?ZG5qdjFWcXVVRDM5NFl1aHY3YTBkOEZuOXYwdkRsNVpWV0dVdDNNakp0enlv?=
 =?gb2312?B?bWdzWm1hMXJ3RWVmUVZVL0lybEdzZzhKNG14Tm9yblhFam9pblM0WHhkVm0r?=
 =?gb2312?B?emU0enErdUZVUFdQK3ZpSk5IbDlDTklpeXptcXRFbTc2a2V5NE90V002dmk1?=
 =?gb2312?B?dXJwd3hMbDJyZ05Hb3R1bkRIS0M1dXRyMFZRejhHNjhKTmxXZXJuamRtazky?=
 =?gb2312?B?ZHFiaVZJZjYzbm5PbE5FdVp1M1JZZkl3MmlmTXlIZGhlOVFKQk1Ua1Foc0pX?=
 =?gb2312?B?M01SRitEVTloRy84QzZtQjV5V1VON01nalJaNEptVGc3dEYwN3k2RUlCb1d5?=
 =?gb2312?B?b0JMN2t3QlBBMWhFeFZtV1AvdDJWS1BDRVR6ZGcyZyt3T1FLWmZVb2lGVi9y?=
 =?gb2312?B?ODBoRjhhU0J3bWs0dE9FSFlTcE82eStXWVl2c291eXE4b25NN3FNSWJLSGZa?=
 =?gb2312?B?NjZhRjFFaFNJdjZPUnQxS3BVVmg5azZTcWhwTEg0cmE0MjJsWjRCQ0NOYUpz?=
 =?gb2312?B?OXFVaVhKSVRTbGxncnJ0Vm0rK1BEYXViZDFQWTJFVWFPV3Y3Z1ZEVHFGYmI0?=
 =?gb2312?B?Um5qOHZoWTNOVGNJem9IYUU3Y1BJcXNja2QyMC9ZcllEMW5hUTZ3WDFqUEhH?=
 =?gb2312?B?bTErN2FUMm9RQVFjdWxKNkprR00wMHpYTEswR29MWm8yTkZSYkdxbC8vb3hx?=
 =?gb2312?B?dnlmV1oyOUR2SWFETnFoZ2k2RUQxejg2eE9STjVaUzFUK0RmN0hWdDdNZFcy?=
 =?gb2312?B?SVYzcFo4bnVYZUdOL29NM3NYUWh2RTRMenltR2V0T1R5SklvQVVnWEFmTmgy?=
 =?gb2312?B?VHZ0ZG9INzF5bWhPRTQ0ZytWUjhMRG9TSVFCdWJpVWVGK0tEVzcyZjMreHp1?=
 =?gb2312?B?d3RoaGRpb1lEYmF0d1VsTVFzUXI2N0hLVjRXUEV2VDJYK2lDQXJTZytHR0Ux?=
 =?gb2312?B?UitrOWprRU1XWTZxREI5THhNUkphZlZHRE5DaFNvVUlTRFowT0d6WVhFaWFk?=
 =?gb2312?B?YmE4MUhjZHBuNHRtSVFCMmlOaS9TT2w5UmxKN0xNWklXTTc1UFJBcEUxREhl?=
 =?gb2312?B?RW1SclVZc3preFA1MEY2bXp0cXJTZG53MGlBQ3Z3QmNFWTVmQzJ4SGJXalRH?=
 =?gb2312?B?SGw5QWVMK3BRR0JPczc5N3hxVzJOUVVteStIU0s3b1VzRFZtb3FlV245MDhK?=
 =?gb2312?B?Ymw3Ym9iQnppODZyWWZNZnVqNEUrZGJHeGR6SkYrWVNDWEZrQWgxM2FESU5v?=
 =?gb2312?B?YjRGNWNTYnhlQnhGOFc1ejY0TlExZHlSRElRSmt4Z09DYjhLOWQ1Z0hvVjVG?=
 =?gb2312?B?VkJscTdwUVE5V0VncUoxWmI4VG5kT1RwbzBhbHRDaFg5d0NQVHphODZrbUVC?=
 =?gb2312?B?UC9QREh1QWFwdnhjM0QwMXFSTVNnQkhVUmhBODlJMUhoTTB3YUFUWUZzZ0Q3?=
 =?gb2312?B?bElyelhGbG9kVEZxbkUyODlUWlUzMysvYmRJNCtWcE5wSy9ZT3dicFZhY2dS?=
 =?gb2312?B?c0Vhc1FzcnNhb1JhdnhkVm4wR2xucHlMbGxzMFRTd3pDS3Uzb2E1YnBQOFBV?=
 =?gb2312?B?S0k5dGpRSE15WEg2UzUxTkMwQS9jd0cxcFJnWDBGSkdlN2pvWldwWjBYeVRP?=
 =?gb2312?B?eXhYdTAwL2FBc1Z5dDhlZ3p1YXFreUltU0FXQUtJWkQyT01HNEFHMEhCMzNw?=
 =?gb2312?B?YWI3OURkZ0hSeWxMU0ZMM2wrc0J5YllnaVlXL3hkeDVFcE90OTFkQ3JXcWhU?=
 =?gb2312?B?akJxUC9sVkUvV2lNcEU3aW5Xd3NtWHhJV3BUN3V3ZDdnQkJ4UDJVelhOblFp?=
 =?gb2312?Q?xlxjV3FYHgehYC3Mw1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81783f34-a39c-4584-68f9-08de7f557ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 10:03:47.6660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ny7kjC7iLZEH4cfNdJO4WNcFBUs02qV9sv22zv6/0I+WJpiPH5N3AO4x/cBAQX+6TMzJyW4OKAQaCIZomBjIBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10635

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1Lndh
bmdfMUBueHAuY29tPg0KPiBTZW50OiAyMDI2xOoz1MIxMcjVIDE3OjUwDQo+IFRvOiBhZHJpYW4u
aHVudGVyQGludGVsLmNvbTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgQm91Z2ggQ2hlbg0KPiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFt
QGdtYWlsLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgtbW1jQHZnZXIua2VybmVs
Lm9yZzsgZGwtUzMyIDxTMzJAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFU
Q0ggdjMgMy80XSBtbWM6IHNkaGNpLWVzZGhjLWlteDogcmVtb3ZlIGR1cGxpY2F0ZSBIUzQwMCBi
dXMNCj4gd2lkdGggdmFsaWRhdGlvbg0KPiANCj4gRnJvbTogTHVrZSBXYW5nIDx6aW5pdS53YW5n
XzFAbnhwLmNvbT4NCj4gDQo+IG1tY192YWxpZGF0ZV9ob3N0X2NhcHMoKSBhbHJlYWR5IHZhbGlk
YXRlcyB0aGF0IEhTNDAwL0hTNDAwRVMgcmVxdWlyZXMgOC1iaXQNCj4gYnVzIHdpZHRoLiBSZW1v
dmUgdGhlIGR1cGxpY2F0ZSB2YWxpZGF0aW9uLg0KDQpSZXZpZXdlZC1ieTogSGFpYm8gQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiBBY2tlZC1ieTogQWRy
aWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDQgLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1l
c2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gaW5k
ZXggYjYwN2Q0ZmZjNTYyLi5kNDkwNjk5ODZlZmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1l
c2RoYy1pbXguYw0KPiBAQCAtMTgzMywxMCArMTgzMyw2IEBAIHNkaGNpX2VzZGhjX2lteF9wcm9i
ZV9kdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2LA0KPiANCj4gIAlzZGhjaV9nZXRf
cHJvcGVydHkocGRldik7DQo+IA0KPiAtCS8qIEhTNDAwL0hTNDAwRVMgcmVxdWlyZSA4IGJpdCBi
dXMgKi8NCj4gLQlpZiAoIShob3N0LT5tbWMtPmNhcHMgJiBNTUNfQ0FQXzhfQklUX0RBVEEpKQ0K
PiAtCQlob3N0LT5tbWMtPmNhcHMyICY9IH4oTU1DX0NBUDJfSFM0MDAgfA0KPiBNTUNfQ0FQMl9I
UzQwMF9FUyk7DQo+IC0NCj4gIAlpZiAobW1jX2dwaW9fZ2V0X2NkKGhvc3QtPm1tYykgPj0gMCkN
Cj4gIAkJaG9zdC0+cXVpcmtzICY9IH5TREhDSV9RVUlSS19CUk9LRU5fQ0FSRF9ERVRFQ1RJT047
DQo+IA0KPiAtLQ0KPiAyLjM0LjENCg0K
