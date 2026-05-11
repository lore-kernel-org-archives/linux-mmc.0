Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8A135A53;
	Mon, 11 May 2026 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778467424; cv=fail; b=JM3HPN/JIYDZOSCnoGEW5y7fgAY5wS0C9VTB4c6vapyg5y4PQt0bQycn7CMT5CzmKKWyWhmXoluCLtd7WD6gfYGCwSg/fTKxChEPGgkehYqBkGAT3bVRXyfNFfhh40bDMlr4s/RgvgG9ALQTgO08YarDR9Q//Gv9liZRYP7Lid4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778467424; c=relaxed/simple;
	bh=g5P6gxDb7muuZz6pD3M6A1Pld2o0dRCgQwAuztHoYIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XvQJSkZYuewmo9TQFFnjsauoOKsUO12jU3Y4DCzS+YIUh5Du5SkPwmWkuDkKzd0jrYhVT7Sj0icHCfaJ+waaqcLvR3l60H/CIoI1Y+Ey54CsYI4ga1lesMfFOKh07LxXp4/VuAMu82Od3uc/98nSMgVcyvXvNjSOwC4uhyKWrRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BS3m/i+m; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BS3m/i+m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8gtw2q0GOyIzh7hESeRltzHUom3lkx6oD/DcTp0C+mFKBiXQCrneUgM4hvLXXs3LHr8PHxI+uZEWSqlwZk4+aDzK08kfY+9xleyjVS0dK6KpO1IzPG+0M4ARh1gxL2oMcc2ic/RxoclWaRkkCJHVpDwjRPrc20c4aG/fmC7wyC7IA0xhkxvMEz31WJqZ98uTPAccSxH+4q+mT1JplrtRPsoIWLB9YVPpjqcl/bld0UQIZrQvISbKIUP9vCxSm1fI7r9L470pj4hRcqvXBlsiSGgPlcLUFEDeWo5m2uLRg3ysFQPnRe2bHsR7EIwXHNi+TINYeQV5CqCntKHa3vnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5P6gxDb7muuZz6pD3M6A1Pld2o0dRCgQwAuztHoYIA=;
 b=oCIxsw6Dq4SxP3Qu4AM68MTCVPGkWIHJ4qA0hy0l1P69AfLzoo52CEMGDgvnWrC01wyq6m1PZRYCLK7//t4tbVNgDG2/iRZI3bSMGyJSc9R/5aOdA5dS7YkE/eZT/Ccu9TWGsS/fh/6Cmdf2dkE3sYCv12aFZYkUT8vzBPrJekIM+Adh2oEsv/44ZyQ6awBqNYeG8J14IvWi7Oc3QyYH20u7RXCQgKE4gwpgaPT70bHjkaApW12o7/N2eGb2SFVo+o45XN7YZeIacyKBI4G+AV3sM3XGYut3Y09MB/fUrok6JZ1TV+A8LBUEFPS/d3St6U5uFSom3bHR7K50P4zYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5P6gxDb7muuZz6pD3M6A1Pld2o0dRCgQwAuztHoYIA=;
 b=BS3m/i+mUFJYnyYeDf13sL0H1LM3zuClZa8imVyIaMG2MnnYz6i4HdKKecxPKpmBxiVz/LyDRL0WLCZR8uwQw8AQwECoXiIPZsL0iPq55I8ME/kcyS5KfJ69Zv/U6xAynOYn1bFOsy8Vbow8MdT6QadsVYxLjf+4oYKq85rSMVZqlSYZAmDx9361OVnwOwajeQBkpnR7zd8lPLmE24p9Sim0JnwdxLt0Q9TJAddustK3Ffufm13zYBdO6s5YsC6BgNsrVYlXDtgOTBVNXYBBqFiv7OLp/tGxkhxDXl2bXH33k3gsgPpYmekrG+YgX1T8bPhTwhcBsjzVZG7uLP9Row==
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 (2603:10a6:150:328::18) by PA4PR04MB9461.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 02:43:39 +0000
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908]) by GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908%7]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 02:43:39 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, linux-mmc
	<linux-mmc@vger.kernel.org>, "open list:GENERIC PM DOMAINS"
	<linux-pm@vger.kernel.org>
Subject: RE: sdhci-esdhc-imx: How to disable runtime PM via sysfs
Thread-Topic: sdhci-esdhc-imx: How to disable runtime PM via sysfs
Thread-Index: AQHc37VTTPtlQKTsy02xJ8dkerZCJbYIH1Mg
Date: Mon, 11 May 2026 02:43:39 +0000
Message-ID:
 <GV2PR04MB1227240AE6C5199C6D031D03D90382@GV2PR04MB12272.eurprd04.prod.outlook.com>
References: <6e863b3f-9fa6-4a5a-8ef1-08af4b1d3c33@gmx.net>
In-Reply-To: <6e863b3f-9fa6-4a5a-8ef1-08af4b1d3c33@gmx.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12272:EE_|PA4PR04MB9461:EE_
x-ms-office365-filtering-correlation-id: 72ed4bdd-d0e3-4316-99ea-08deaf071ba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 +ixC6OuofId70KRU3YQYIY/2OnH3HIXUArSXDBvwFbUi8gmlKUakPSUw3vMBNXsSGpbGSdWyXXrZ5v6XyAUb5cNDtVil4+ImcaIfA8K0CNbs6UntZSweXyNCTQOANXIfYPv5GNwS2jTor/PWmx1kb+ezc25xuRyB/fcoPHCWEDlSh5x/NWwGYyd6P5zuAUHbpHOjpTs13NM2yxIqCUMc69zMNn6lPuADGZqLrWP3+wjNgYm7uYlo6MZMHzVH7LKYzN+OnoLJyO0QaHud5jqccAseHjRs+cHG5GF0XmVRTZOGR+YarXyBw1xNNHR/wDtMioqKr/WEheMESIjmZs69h44C/TRhhXJevgADh53Xi9+KTztxcjgAcfbu9NxglDGpZzwHz6+utb87GFEown+82R8/J3HtPQx5qEBYOywQbwYuoTx/NBVA0wYPpnjTlTVNZZQzpyg/+5tKKsZxKgCTQkNMyFwPeX96lfFizxYa08hjOdKUG1BN1giM9Gg5WUyGtGzQhzQL0UQnIyFVKyO36t5Xqmw3YwjDG6PTplKgjGeo2AuUy5Z4AVu39k3AP4fjY11hZ9bob4F9JdlXV74ZIp42aHIYpRkowww7D686NSZjUJLAJ/GzL6LC+Fx5PnxiKjzAKq6Cl8ES+mfjCdJYCqSW8PhPADnAGsC+2P0+6CMm2uxOMmgsmH2a9vvcRrnC+uEDmUHsC0BYORqvojF8viNEhKKGF8LQrgCqIlxRaVoMcXZXRde9zls3OJVpt0g9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnZFZ01TUlExMDMxMS90NDVZY1VFMWdxOUZaOUJuY3hmQzBRS3VCOUh1am12?=
 =?utf-8?B?UytiYS90TVZBNFVmVnEzS0VENWwrOWlsdzRrdzFhb0RXdlMrcWlONVpyMVla?=
 =?utf-8?B?dzNXaDAvSExZRlp5OWhFTEFXbURhSE94WXRxUEdvTUlCS2w3Y0M3QlZ4dWpH?=
 =?utf-8?B?RVFpMldCRy80WjdFTU4vMG9EVFNabDFJMS9kNmdWNzhlTmxaU2dRemZETzd6?=
 =?utf-8?B?MjNsT1BacjljMCtTcnI5VlVtOTI2NWIyY0VCK0JLeGRXUWMyZ0lDZFJpY2tt?=
 =?utf-8?B?ZWxac0pNdytJQnBpUlFYZStOaTNBRGJrd2NidmNIalh1VEFWd1k3OHFyMG1C?=
 =?utf-8?B?a1J5cEdJV0ZheTUzRi9ld0pTVUh0VWZYejJ5SjNZZEJrOXNOL2pqbmI4ZzNF?=
 =?utf-8?B?eDFEd0lUSXozd2tlckZFV25MV3lwRE9jMzQ2MmlYL1RkbU05RkN2TEhkcGx5?=
 =?utf-8?B?UGk3MTBvZHNuU0pxWTMzM0pkYVhmSFJnWHAvY0h4Q3dLb1ZXY3NoTFVjNHUr?=
 =?utf-8?B?NWhXcTBZV1hScTFaN3o3LzVaTTVKcU9lUTQwbFlmWEgwYnN4ZGNaaTFBT3Rh?=
 =?utf-8?B?ODU1dmZ4V2RtQ2haL0lQUVZmQ0RvRUMxVnp5R3c0aUt4Sk41NFR5WG15MStZ?=
 =?utf-8?B?Rlc2QlpNMUFtNGZhU3l5ZkJyMVpjWWx4ZGR5K2M3c0pxQi9Wb3RFN2pVb0do?=
 =?utf-8?B?ZjN1QXMzeElubC9odytxTS9BajA1UGhiblY1TERZWloybE5NK1lSOGkvb3gx?=
 =?utf-8?B?Y08vaUs4ckI1VVlEMGd4bGViZHdFYWNjQmFqckV3RzFLM3R6MTZXMjhydTdE?=
 =?utf-8?B?U1J6bmc4NktHZ3RCU2NLSnBRYWVZKy8vVTZWR1MrUTVsVXpuZTMwaVk0NGhw?=
 =?utf-8?B?ajgrc1l5eEtPM2lTOCtXRys5SGV4TU1uN2x1eVBHcURuV3RsNDRBbG5HdW9p?=
 =?utf-8?B?RUFZQ0EzNS9qR3Npclc0ODdMK1R2WllVMjViWjUzUDRkTXpVVW1nMVYvSklS?=
 =?utf-8?B?QU9qTVZKdDZUNitGcnZCYXZYelRRYnJXcFpraWlhK2dEUlg1aThyM0xFcXgy?=
 =?utf-8?B?RDVSUUsxNEczR0VLMmY4Sjh1VDdxYXI3aDVqaEZva2hTdXBKdTBQUk1hZVFz?=
 =?utf-8?B?Rm84b2pCL3RGNnFkZlJCQUdkYzhHanVMcHYwMC91Y2RqdE5rcE1mVXN2Y3gx?=
 =?utf-8?B?cTJjOTB4a3NhZFBOeHFxMFRnUGdyV0FyRTdLVVRqTFhnaCtXb0hhNThZNC8v?=
 =?utf-8?B?OE1OaTRCVnlzT1dYUzNvUG8reTFkTVdGT3VReW03U0Q3Sm9ROGYra0VXbjkz?=
 =?utf-8?B?SzRETXRHYkJEbUw2OXNwQ3FyRzNEUUNSMjJJSW1kcmEwV1BkdERPUUt5aE5X?=
 =?utf-8?B?Zzl2cHZHMk96akxFTFdZUXFCNDVrZnphOFNza2hjYy9CZkh6cGovV3dmOWla?=
 =?utf-8?B?bEFlaUZ0SjJTUXJuOFV0Z2hCRFNXQm5BdnptbG5ZR0R0TmZWSU8wV2ZNYkxu?=
 =?utf-8?B?ckYxUm1NdWw3SXpwS2hiaWkvbkdkQjZwQ1puMDYyYTFRUmFoWW8zY1NDcWhQ?=
 =?utf-8?B?WC9wK3MwVmw5cklYU0pNY3pHYlRrR2xTYWVpUXdhdnFmbnB3bmh5Z2kwTnQz?=
 =?utf-8?B?TlZHUnk3RG1YeG1TWDFWQ3VXSnRwdTZhLzVlVEowN242RHk0cGovY2UvMUNW?=
 =?utf-8?B?UjRBUThlN1lQU3ZNYVg4MTZ4Q3p2c2RDbTQ3WUZIWmZWeXJMd0I0NklDei9o?=
 =?utf-8?B?YWlPNGc1aG5vTmxWdjZYRU84RHc4cWZWUlhtditmN2FsbVhJZXJkZ2hIeHJY?=
 =?utf-8?B?Y2YycWFORDNzbUsxeWRJclpWQmxqR1R5NTRUTEdpQUM4WWFaTktISzhKcHVv?=
 =?utf-8?B?S2hIQ254Y1ZjTmtQenpHY1FEYmlNRWxFdDNYTjM1NlZFY3JESk8rYlBJTGV2?=
 =?utf-8?B?QlZNOFZRZ2xjK1dFams2cVVqV1JBTzRmd0lnSVQzWHdUR1czRmtDT3FwZEdK?=
 =?utf-8?B?M0V4NmhKRFFwNXFFbTlqZWNqbHRsaVh2R0QwbTBnVTV6QWlEbGpEcXRRSkxS?=
 =?utf-8?B?YWsxbldYZU5zUHptKytpZnI1cm5IL3p2RnZCTVUvNlVudElsSXBYQmJGcGMr?=
 =?utf-8?B?MVJpbDNmN0NoSlY4TU1EMFV5T1g5ZWl5NXc3UUVWWHprbTQ4bXhWYWpCd25v?=
 =?utf-8?B?a2U4ZDJWVHNhY1dVZmFXdE5wMWJENmxzL3UyWW9FOWpLY2QzNUt1a3BkclRG?=
 =?utf-8?B?Y0FrQU1UVTdzV2F4cm5SM1RSN1VyeGNBM3I0S1BQVTZVeU13Q3FLdklDK0FS?=
 =?utf-8?Q?+KxyEE9tXsFRxL2KBz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ed4bdd-d0e3-4316-99ea-08deaf071ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 02:43:39.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWXjwT9itpv61wNuQvjXcWzHitOpilsv6SJyn4VxxTiY1hDIOV4A1NBvReJ/pCOFXZrp7gRVcmRiMA8RuKqNUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVmYW4gV2FocmVuIDx3YWhy
ZW5zdEBnbXgubmV0Pg0KPiBTZW50OiAyMDI25bm0NeaciDnml6UgMjE6MTENCj4gVG86IEJvdWdo
IENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IGlteEBsaXN0cy5saW51eC5kZXY7IGxp
bnV4LW1tYyA8bGludXgtbW1jQHZnZXIua2VybmVsLm9yZz47IG9wZW4NCj4gbGlzdDpHRU5FUklD
IFBNIERPTUFJTlMgPGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogc2RoY2kt
ZXNkaGMtaW14OiBIb3cgdG8gZGlzYWJsZSBydW50aW1lIFBNIHZpYSBzeXNmcw0KPiANCj4gSGks
DQo+IEknbSBpbnZlc3RpZ2F0aW5nIGEgcGVyZm9ybWFuY2UgLyBsYXRlbmN5IGlzc3VlIG9uIG15
IGkuTVg5MyBib2FyZCB3aXRoIGFuDQo+IGVNTUMgYW5kIHNkIGNhcmQgdXNlIExpbnV4IDcuMC4z
LiBXaXRoIGxhdGVuY3l0b3AgSSBmb3VuZCBvdXQgdGhhdA0KPiBzZGhjaV9zdGFydF9zaWduYWxf
dm9sdGFnZV9zd2l0Y2goKSBpcyBjYWxsZWQgZnJvbSB0aW1lIHRvIHRpbWUgKH4gNSBzZWNzKS4g
VGhlDQo+IHJlYXNvbiBiZWhpbmQgdGhpcyBpcyB0aGUgcnVudGltZSBQTSBvZiB0aGUgYm9vdCBk
ZXZpY2UgaXMgaGFuZGxlZCBieQ0KPiBzZGhjaS1lc2RoYy1pbXguDQo+IA0KPiBTbyBJIHRyaWVk
IHRvIGRpc2FibGUgcnVudGltZSBQTSB2aWEgc3lzZnM6DQo+IA0KPiBTdHJhbmdlbHkgL3N5cy9j
bGFzcy9tbWNfaG9zdC9tbWMqL3Bvd2VyIHJlcG9ydHMgdGhhdCBjaGFuZ2luZw0KPiBhdXRvc3Vz
cGVuZF9kZWxheV9tcyBpcyBub3Qgc3VwcG9ydGVkLiBCdXQgYWNjb3JkaW5nIHRvIHRoZSBkcml2
ZXIgY29kZSBpdA0KPiBzaG91bGQgYmUgc2V0IHRvIDUwIG1zLg0KPiANCj4gQ2hhbmdpbmcgL3N5
cy9jbGFzcy9tbWNfaG9zdC9tbWMqL3Bvd2VyL2NvbnRyb2wgYW5kDQo+IC9zeXMvY2xhc3MvbW1j
X2hvc3QvbW1jKi9tbWMqL3Bvd2VyL2NvbnRyb2wgdG8gIm9uIiBhbmQNCj4gc3lzL2NsYXNzL21t
Y19ob3N0L21tYyovbW1jKi9wb3dlci9hdXRvc3VzcGVuZF9kZWxheV9tcyB0byAiLTEiDQo+IGRv
ZXNuJ3QgZGlzYWJsZSBydW50aW1lIFBNIG9mIHNkaGNpLWVzZGhjLWlteC4gVGhlIGZ1bmN0aW9u
DQo+IHNkaGNpX2VzZGhjX3J1bnRpbWVfcmVzdW1lIGlzIHN0aWxsIGNhbGxlZCwgSSBkb3VibGVj
aGVja2VkIGl0IGJ5IGFkZGluZyBhDQo+IGRldl9pbmZvIGludG8gaXQuDQo+IA0KPiBJcyB0aGlz
IGV4cGVjdGVkIG9yIGRvIEkgbWlzcyBzb21ldGhpbmc/DQoNCkhpIFN0ZWZhbiwNCg0KVGhlIGNv
cnJlY3QgcGF0aCB0byBkaXNhYmxlIHJ1bnRpbWUgUE0gZm9yIGkuTVggVVNESEMgaXM6IC9zeXMv
Y2xhc3MvbW1jX2hvc3QvbW1jKi9kZXZpY2UvcG93ZXIvY29udHJvbA0KWW91IGNhbiB1c2UgY29t
bWFuZCAiZWNobyBlbmFibGVkID4gL3N5cy9jbGFzcy9tbWNfaG9zdC9tbWMwL2RldmljZS9wb3dl
ci9jb250cm9sIiB0byBkaXNhYmxlIHVzZGhjMSdzIHJ1bnRpbWUgUE0sIHdoaWNoIGNvbm5lY3Qg
d2l0aCBhbiBFTU1DIGNoaXAuDQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IEJlc3QgcmVn
YXJkcw0K
