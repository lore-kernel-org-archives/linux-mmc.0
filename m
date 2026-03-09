Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BE1DF74F;
	Mon,  9 Mar 2026 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773026025; cv=fail; b=iLlg4bEBVgy++mewY1MnSy851uhrsoEvFWP5ESXWhQFdtKaJ7O4T7L8xUEbW+VyXFJCoHxBE7bhHJ1Evq/Sxy+GzPaoo3nNfl74CWG43lsAN+ztrOf0fR/vYqH0uCXzdLiT+z44KdfTr80oarVblX01Ze6qb0Kc8J3WVjV53Rv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773026025; c=relaxed/simple;
	bh=U3RCPnvGeRWZxWSMycqRW8xp5xw3LTWK7DrFNDpsPd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F5zKOb88/cv7iwYjtWDD/Ujjm/iwTC24t4Sp5mJMGQgjgAgrj5fKLJdgT7HHGf6s2nl68wg0VeH6NboiFikrOWbM4Bv5gitweNFSMpsvEQDT0pWBU4gKOOO/knlrF0oKWUbE7dg2xgOK9CDpbn7X55dtxMVaLRDCPpNw6355lVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ky6miMJz; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ky6miMJz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ienEhg6FaBvZlnvCKqjVDmfMaH0BVekHW0iMqspTqqoTZG9ysAddU5ff4/nOvlY7dWj6SbzWYT3j2PYqq1RnLankumXRBcFpdzFUY/KYA+jawry0QGNuz7qQAi/lfbT/AhrLsEbM8PJMR24WujjnWjN8mBg3Oy4omdpDMeFkYJKDgTyj9qsevNTXNydtzEmyxrYlKVRXCrEkJaJ4U2+Uc9SjQBn/HDFFsX+Dmv1WAAqMtDNYDS7cERLQh8GL79uhxlys7ugFuYhYZPDvSzvu0pSVlrIO2Shk0NUMrPOMs623JCVRGCkarXEhyJpvMlAbkufDHaRFK4JXKZhY4rCx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3RCPnvGeRWZxWSMycqRW8xp5xw3LTWK7DrFNDpsPd0=;
 b=hjz/XMx+VkURIgpsOn6++JO1LMAQ9iXGMyBQDFbwZo5HBtzUb+Yq0yyMwsCAiyM0SH14TU0EDm5NdTbSLL9ilhpGB/cHE6iBVa12pqKuZcRqaI0S/oLZy5ndszo39RSKWee1PDhDb03JatQIgAG7xe1PGJMKlWX3+ixJQuBvhiC6OErFNEd55EqeIzqd0qLR2o+v6vgBklBxyDxZ+pMcpen7EpyjpLhWbpFE2381V+ulz0s4Clmn9VSTG6YlfyF7/vIy4z/wPBLARdMeLs4w98ncmrZLkziW13A3zAaqojCYrX6ieiiGiy0vWsZKM4ChtaG+QTuWawm0CmLPSMlw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3RCPnvGeRWZxWSMycqRW8xp5xw3LTWK7DrFNDpsPd0=;
 b=ky6miMJzQ+HFztA/A4ZOVukbKfj3NbQvmOme7BSS815+GcgDniAXGBJ87WpQbnbpRIeJzYj5r9BKmmfCOxGAS9d7PaA1+wKYlXQhOZ1Rq3DeevF5/JE2tqwoX2w9ElgFw1jrq7/+NyCEyLnA+7zBob4gcZxc1iNnZMVKUgK9DauSDcIxuWUFiA4PZawyD0y18pMSXl/e9YdxPionm/sfGdbdNXcBJtCZv7bKWdbOswL4//ObsiJ+5tbt3B3TdkZ8TNB4t/DSOoz1ccr5QLPNX1ahXnCUQvBJZ4/Z/bnMw7yCH1VJTHUmGJ1YOpSozMhp8Xt6fU4ZRLHo/RJ3J/pMXw==
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 (2603:10a6:150:328::18) by AM7PR04MB6837.eurprd04.prod.outlook.com
 (2603:10a6:20b:10b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Mon, 9 Mar
 2026 03:13:39 +0000
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908]) by GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908%7]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 03:13:39 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Ciprian Marian Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Shawn Guo <shawnguo@kernel.org>, Lucas Stach
	<l.stach@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, dl-S32 <S32@nxp.com>, Christophe
 Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo
	<eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>, Larisa Ileana
 Grigore <larisa.grigore@nxp.com>
Subject: RE: [PATCH v4 4/8] mmc: sdhci-esdhc-imx: add NXP S32N79 support
Thread-Topic: [PATCH v4 4/8] mmc: sdhci-esdhc-imx: add NXP S32N79 support
Thread-Index: AQHcrYSJyGdCP41OB0+vK3ps4t3TKLWliimg
Date: Mon, 9 Mar 2026 03:13:39 +0000
Message-ID:
 <GV2PR04MB1227273EA558622A56DED46F99079A@GV2PR04MB12272.eurprd04.prod.outlook.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
 <20260306161555.9000-5-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260306161555.9000-5-ciprianmarian.costea@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12272:EE_|AM7PR04MB6837:EE_
x-ms-office365-filtering-correlation-id: 7a27b09e-c1b5-43e7-1d77-08de7d89dc7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|1800799024|366016|376014|38070700021|921020;
x-microsoft-antispam-message-info:
 PR8HiEeoxa0FbJnnt+ZADcRGwFFG+GMzrIcbYhcLf3hPNDzIAWcpqkbGuGHgXr0eGFJ5c8n0IvBH4x7XnYpCGFx0pfcZipHjjSayhP0Y04CGNBkeZKnx2UlTMLf8B/43w6XQrU2baSjkI+XkpDrZOaxu6CXGpU/w6uXUAb19YV7msGRBFPE/i72I+3HWTUuuhuv26mCetU3c0gtozXdTwZOWuKpW8f8nyoqeSkS1LjqN1OFmkZlVfZ4BIU0j92vt9sejo0f8ETAPoi+18vLl/lIbc5zoDRspTZxIr8LOJvN4fAqwIR4eb1rYz5cJfPMybbZmuwnXnox3F0ayhj5yT/SaFUNZmQKNXtZAwUS1bry5qByqCta2h4B+yhlNtJsYmhtk7NGm6Fwb2Ip4Boj+1R4x/V9pYE1nuG29Ppa4646O/d1YO3pKG6x/MZ2U6fi+6evGzkS9mfBIZq+xr7Z6SP8EYVbTpSaM9D+z8Bln11HLIZLazANe7KmYGx5sz1qSKxeKmEEdF5oahNrGv/BIgRboMORhattaWLokXDMPUDTSlOQ+GH5sTpCeHUwAAmC4ohGWiWLTNx/fNFpTr8ZwXSQCQlZvZUNMrhOwBlTiWt09uGCQ5oE0EsxRKX3Ds31TrckIYF/GxrFDzFHhP+3KKqtnMCRaRIKPFTDKUoHr135JhMnj5fdOuxnIE8xwX2aNT0B2iowrFbMWdBKjl/2moPI54ykMmF6yKjO6rwhIKLaBShP2tb3fX5dTZHjnmeocTalV/u6PtN7Llj2odo+nj3sFppb/dUcSuRq8YySEUbSYpwywPpaSS7yLj5I8kH8F
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(366016)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3lQazhZQ3NpcHNQR2RjRGpsQk1XV0tFMGpYTW03cTZjRlNDUXduN0QrKy82?=
 =?utf-8?B?RmVuM2xwZjRpcFlZNFI4YkMrVDN1SHhNcUx3R3U1WENzdFdmTlQ0L0dFWDc4?=
 =?utf-8?B?K0VCalRaOC8rd0t0eUhSQTVwMWFrdmwrTnVRZ1FzcVZtcWpoeFNBN2tiNWxK?=
 =?utf-8?B?SHdEbFZWT3kzMDQyVmNjV2dYU2NyZEJaRFh3ajZVOXNBTnJwaTBTZkdUWTlr?=
 =?utf-8?B?a1FJZEF4c3BDMDVGaGVoUjVCY3RGeFVKNEllOW1ELzFHaW9TRUJwQ3g4V2x6?=
 =?utf-8?B?cHVNSS9aN29LQUxCRjE5Rll0RVdaL0hVclVKV1VieE1YQ0FRbnpyMVlIOFZ1?=
 =?utf-8?B?bi9qNXJYYS96L3Q4dW15aGRxY3hoZzlXazk5b3ozY1BmbDFXQW83MkRXNjhC?=
 =?utf-8?B?WjJqV0t3eXg4cUlIMU94WSs3SndUSGNHbEd0dWFlTmNWQjl2Z0l6OFgxRDl3?=
 =?utf-8?B?VVdpNG5vZDBlU1dFcHVraldOMGl0QVV6V0NkUFplWU9qdmh4Um5CNjZUbG5W?=
 =?utf-8?B?eDU4enRxSE55MDQ4dVlhSzlBUThDYmZVNXEydXR4SVdmK0d1R0dMOGhGYTQ0?=
 =?utf-8?B?RHVPOW55ZFdmK3pqNEFQeHVYclUwMjFXSWljRDJKdzdtTnRGL2l4cVFVSVRn?=
 =?utf-8?B?aFdBU0swaGlIU3F1Y1dOV1o0NjlBSzl2TW1WMGRrUjR4bHVRb2YreHJCdXE2?=
 =?utf-8?B?YThubStKbncyQU16OEVsMC96czR6SUJNUDBWRUw1SFphRTEweUkxS0tNTEIw?=
 =?utf-8?B?NlFZN1liS0R2R09oVzNhSVpkeCtSa0hRWE1uY0dmVGJFRVcxLzJZMXJSS1VY?=
 =?utf-8?B?UmYzeTRnaVVXcUQ1cTJmV29TZUxiNnRkNmpWMWFPU2EyWTFFYUNYalFYM3lo?=
 =?utf-8?B?V005d0txUU9VWjNIdHY2TkdueXRyc2RuZmdaZ09od2dRc3RiZC9IbnVYUWxU?=
 =?utf-8?B?cGlqV1hudUo5c1RtV3ZmZUd4dGYxR05ud1AvVG4ySFg5TU9RU1I3ZG4xN1FN?=
 =?utf-8?B?Y1lMdTl4R1BVVUIzay9IdmgwUWJ2RDR1MXhlMEVkeXFsSHZBNnhxTkhSNFA2?=
 =?utf-8?B?QlRNRHBMSVlyV3pRZEZXNlVaUzhMME1HbktOUGpEWFZ2OGh2RUViQW1LK1Zp?=
 =?utf-8?B?eDNBbjhOQ3FmV1BhZ0xoZVJkcEZnVzFqOXFaR1Nzak1OYlkyQkhrRGJBKzhF?=
 =?utf-8?B?ekliSW01eUlBK2I3WFU2T3lXM3dockZDdzM4ekw5cFpPT2hCWW5QM1cvMzNn?=
 =?utf-8?B?OGdpSXUzQ0Y0ODhkMllockRldWd6djJDQk8vcm8zbnRWWUtpL2RBNi9lcnN0?=
 =?utf-8?B?cjJsZGR1VmNRVm93dUtVdm9Yd3dOUkJwb3VlTWxveG5BdEM3VjVXZXJyMXZZ?=
 =?utf-8?B?T25RNmp2ME03TzcvVGpEc2R1YkRxTzM2N1RtRUg4OFNwRktmT1N3SjhmbU16?=
 =?utf-8?B?QWZncE5uY0tFWGlUanJ6RTltWnVnVU9ucCsydkNqazdmcXJkRi9ENkJ2QXFL?=
 =?utf-8?B?QTZNN3ZUdUZIU09USDVYRTllaEJJZE14Qk1XR21PV0M1TWZxbmZGWmsxSU8v?=
 =?utf-8?B?S2lQbERUSEE2UEJzQ0NaU084czdZRXptcE5yQ1ExMTI5RUlEaU1ZL2RMMWFL?=
 =?utf-8?B?SlpaaEZ5TXV5eVFnRXhlbExubFRIczhHWUFiSHE3OHJmTHFmQmFsMm4zTS9U?=
 =?utf-8?B?dlBWYW9EMDBobW5GajBMWVBnMmpGcTd6VjdMVDBPN1hPYW5VRjd4S295VFM2?=
 =?utf-8?B?VFJzYmUxTHZKSnFNRWNFT29mekk5YmNZQlpSbzMvd3RUZzVZUmduYjlEeG9V?=
 =?utf-8?B?M01YUzdSWFZnV3Z3MzJhL2ZTZjlxK045R1gzZlZMeVdmeWZDcHhRQVhJNGFz?=
 =?utf-8?B?bmM4OFlhT0pHSU03akFPajRldmhBcElOc2RvaWlNclhhK0Y0eXU2SDJQcFk0?=
 =?utf-8?B?NUpVUVZMK1FUTU00VEhGUzNUaEdKR0FTZGRVeVVscW9mUzF0dzVla1VZbHBp?=
 =?utf-8?B?U0Npc3FWdE9HeThJTlQyZkZyblNzNkp2eDhPT3lWNWptV1BTb242TnVZUTRX?=
 =?utf-8?B?L1dxdys3K0IxL0ZzbFZ5OVlGVDMxQmtGTW13RzJTNVg4bFNWRFlsbFF0Y0FK?=
 =?utf-8?B?bUo0WGpKVDkvQk12M0Yxalp3S3RRU2xuK1Uvb2E4elBSMG9SQURJaC8rRE9E?=
 =?utf-8?B?RWNMVXJyNzdTcm5qYzdseGFwYjFMY2ZVSjBHRkVVV0lhU2g1dDhDZkVGQlhM?=
 =?utf-8?B?S0NtcFgyMndyUjZyOTBmRGMxNVZIcXlkUlVBeTF2TDB0Mk1uWkZCeDlzYjBk?=
 =?utf-8?Q?hOg0KD/qYwFn2h9vYb?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a27b09e-c1b5-43e7-1d77-08de7d89dc7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 03:13:39.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eewuFsKIjYzYdUFvhCcycdPVssRkTaiWEEOyJnoyyMQzmtVg6uJC+WEd24JCsnCrttw1wRGlj+deX3ihUcncQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6837

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaXByaWFuIE1hcmlhbiBDb3N0
ZWEgKE9TUykgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9zcy5ueHAuY29tPg0KPiBTZW50OiAyMDI2
5bm0M+aciDfml6UgMDoxNg0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEty
enlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47DQo+IENvbm9yIERvb2xleSA8
Y29ub3IrZHRAa2VybmVsLm9yZz47IFRob21hcyBHbGVpeG5lciA8dGdseEBrZXJuZWwub3JnPjsg
VWxmDQo+IEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBGcmFuayBMaSA8ZnJhbmsu
bGlAbnhwLmNvbT47IFNhc2NoYSBIYXVlcg0KPiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IEZh
YmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IEJvdWdoDQo+IENoZW4gPGhhaWJvLmNo
ZW5AbnhwLmNvbT47IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsNCj4g
U2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVu
Z3V0cm9uaXguZGU+DQo+IENjOiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1
dHJvbml4LmRlPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5s
aW51eC5kZXY7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGwtUzMy
IDxTMzJAbnhwLmNvbT47IENocmlzdG9waGUgTGl6emkNCj4gPGNsaXp6aUByZWRoYXQuY29tPjsg
QWxiZXJ0byBSdWl6IDxhcnVpenJ1aUByZWRoYXQuY29tPjsgRW5yaWMgQmFsbGV0Ym8NCj4gPGVi
YWxsZXRiQHJlZGhhdC5jb20+OyBFcmljIENoYW51ZGV0IDxlY2hhbnVkZUByZWRoYXQuY29tPjsg
Q2lwcmlhbg0KPiBNYXJpYW4gQ29zdGVhIChPU1MpIDxjaXByaWFubWFyaWFuLmNvc3RlYUBvc3Mu
bnhwLmNvbT47IExhcmlzYSBJbGVhbmENCj4gR3JpZ29yZSA8bGFyaXNhLmdyaWdvcmVAbnhwLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIIHY0IDQvOF0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6IGFkZCBO
WFAgUzMyTjc5IHN1cHBvcnQNCj4gDQo+IEZyb206IENpcHJpYW4gTWFyaWFuIENvc3RlYSA8Y2lw
cmlhbm1hcmlhbi5jb3N0ZWFAb3NzLm54cC5jb20+DQo+IA0KPiBBZGQgc3VwcG9ydCBmb3IgdGhl
IHVTREhDIGNvbnRyb2xsZXIgZm91bmQgaW4gTlhQIFMzMk43OSBhdXRvbW90aXZlIFNvQ3MsDQo+
IHdoaWNoIHJldXNlIHRoZSBleGlzdGluZyBzZGhjaS1lc2RoYy1pbXggZHJpdmVyIHdpdGggc2xp
Y2UgZGlmZmVyZW5jZS4NCj4gDQo+IENvbXBhcmVkIHdpdGggczMyZzIvczMyZzMsIG5lZWRuJ3Qg
c2V0IEVTREhDX0ZMQUdfU0tJUF9DRF9XQUtFIGZsYWcNCj4gYmVjYXVzZSBzMzJuNzkgZG9lcyBu
b3QgaGF2ZSB0aGlzIGxpbWl0YXRpb24uDQoNClJldmlld2VkLWJ5OiBIYWlibyBDaGVuIDxoYWli
by5jaGVuQG54cC5jb20+DQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IENvLWRldmVsb3Bl
ZC1ieTogTGFyaXNhIEdyaWdvcmUgPGxhcmlzYS5ncmlnb3JlQG54cC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IExhcmlzYSBHcmlnb3JlIDxsYXJpc2EuZ3JpZ29yZUBueHAuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBDaXByaWFuIE1hcmlhbiBDb3N0ZWEgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9zcy5u
eHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCA5
ICsrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gYi9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGluZGV4IGE3YTVkZjY3M2IwZi4uMjgyODhm
Y2E4N2ZmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5j
DQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gQEAgLTMyMSw2
ICszMjEsMTQgQEAgc3RhdGljIHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19zMzJnMl9kYXRh
ID0gew0KPiAgCS5xdWlya3MgPSBTREhDSV9RVUlSS19OT19MRUQsDQo+ICB9Ow0KPiANCj4gK3N0
YXRpYyBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgdXNkaGNfczMybjc5X2RhdGEgPSB7DQo+ICsJLmZs
YWdzID0gRVNESENfRkxBR19VU0RIQyB8IEVTREhDX0ZMQUdfTUFOX1RVTklORw0KPiArCQkJfCBF
U0RIQ19GTEFHX0hBVkVfQ0FQMSB8IEVTREhDX0ZMQUdfSFMyMDANCj4gKwkJCXwgRVNESENfRkxB
R19IUzQwMCB8IEVTREhDX0ZMQUdfSFM0MDBfRVMNCj4gKwkJCXwgRVNESENfRkxBR19TS0lQX0VS
UjAwNDUzNiwNCj4gKwkucXVpcmtzID0gU0RIQ0lfUVVJUktfTk9fTEVELA0KPiArfTsNCj4gKw0K
PiAgc3RhdGljIHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19pbXg3dWxwX2RhdGEgPSB7DQo+
ICAJLmZsYWdzID0gRVNESENfRkxBR19VU0RIQyB8IEVTREhDX0ZMQUdfTUFOX1RVTklORw0KPiAg
CQkJfCBFU0RIQ19GTEFHX0hBVkVfQ0FQMSB8IEVTREhDX0ZMQUdfSFMyMDAgQEAgLTQwOCw2DQo+
ICs0MTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXhfZXNkaGNfZHRf
aWRzW10gPSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OTUtdXNkaGMiLCAuZGF0YSA9
ICZ1c2RoY19pbXg5NV9kYXRhLCB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteHJ0MTA1
MC11c2RoYyIsIC5kYXRhID0gJnVzZGhjX2lteHJ0MTA1MF9kYXRhLCB9LA0KPiAgCXsgLmNvbXBh
dGlibGUgPSAibnhwLHMzMmcyLXVzZGhjIiwgLmRhdGEgPSAmdXNkaGNfczMyZzJfZGF0YSwgfSwN
Cj4gKwl7IC5jb21wYXRpYmxlID0gIm54cCxzMzJuNzktdXNkaGMiLCAuZGF0YSA9ICZ1c2RoY19z
MzJuNzlfZGF0YSwgfSwNCj4gIAl7IC8qIHNlbnRpbmVsICovIH0NCj4gIH07DQo+ICBNT0RVTEVf
REVWSUNFX1RBQkxFKG9mLCBpbXhfZXNkaGNfZHRfaWRzKTsNCj4gLS0NCj4gMi40My4wDQoNCg==
