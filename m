Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15623E342;
	Mon, 16 Mar 2026 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773629560; cv=fail; b=Kyk5Ut1J7yx34FvNG8YOeWDAlaX+MVhEEvRocQjooZYgG5MQj5SdWbVkKxkB/rQgPZJkKhhL62nHY8XXHFpxD7vxeKlBRcSmZCzB2t9NpI5pAEZ82U5kYaJ07DBmwqjTXd+VFfunqBRbwo23v8vSE4v2MJqbkNW8toy0KvAPn5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773629560; c=relaxed/simple;
	bh=Q3ErMQG/Gew2cIJVz/z/nKlsoV+NqMQ/IKg1sAUwg1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WkaakKQYwWtbyeo2v65TyHLcxN7JjEcmXunbdfPSkfN+XLk/cHkMVXFTaoaH4H+J4VlMO9Yf6x6HZy0zHLpzF+xKiF2wfBzrnXcSjoE1qilePows603Eb2J6kWs2l7KqnCNYP3GNmOGxxFX0e50VcmYI1JJjNfpPZfhjppYF5S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fFIuiwVz; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fFIuiwVz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va0C1OX0u6sCJElCtms1mRw8wHYd8jEmDOXDCiAupyfYknaegXd6WJLLiQKjXBlNGD3XkzDlhYSe4KFCHZgWHPqwzurb0IQQ1pt+kKhdfva2sp3phXdVT3U4Xk8McI79uSZcH1fRTJJ7mIct6zdos0bCUZmTR2l28v6bXOJMCp9zIexhYC0VY46mAe5AyK7Nu9lMEwWCyKjx4YYYN1VoliUZq8GhwN3NKNNAVvKIb/hnTOBHZMnwhL2/W6pbOodhnah612G2NWqIUHKarJv7DA/Omn4If1XnRFKLW1Y9tG66X/TgtMrF7Fd9dJY09Gq9QtTazOS0JfqN0KhIH9vRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3ErMQG/Gew2cIJVz/z/nKlsoV+NqMQ/IKg1sAUwg1M=;
 b=Bl0rWRNo3ouRjVMb8rqIKLSt1V+6CFjB1JA4+Pr2boXZp+VdOzlWqwc9okrAHdWtS3NWaPKDqHBQvKZ3X7qjBktfF9DL/Kz+0KNMvxKOcx6dV9DrN4Zi2Mycbzr0kQGIwm0lKSfVtzPkJVFAmwDVk9nNmqObA/9GAgeBQwjhfImVkmj2pv4e9weSjialiJ8iIFz0AKhtZS5COJS4jjPySeU0mg1ba45ARbuKygLUl7Jvz/lg7lyIdGBRd5u1ZvwRA7bI2XQf5o6b/6GS65PbAMGMgXyp6oWeJGgVYBdB3vSlRxwZOyk6DEB10xwYxoMS+BPb6QuhKXneHBS2LUL7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3ErMQG/Gew2cIJVz/z/nKlsoV+NqMQ/IKg1sAUwg1M=;
 b=fFIuiwVzKSGfTkvCZI9IY2XvmskbcLaoFP6ldRyuvq5Py6EbWZo7XmCpwF3ZHuVRrUFTF6l7wotiHuWddaD936UNS9k78/Cec5urOfrgHCrWw4SExQkHn6rI28eaJsQuQsVV3mulufrXuXEon+FWQ52QSyhGwFxlFRDnfo1rG51moicl1zWOIsh2FvweKfp3klCI1jSgbBEMlLVRGk7eHE8ov6SkkzCrs+FmxXGIRKIDX8l/6+RymYZ9N3asuuhV4jLKuT+fvzww3zlubqu2iFiu4YK1AJOuCPZPwEY1ZJxoSwKDc+PWz9Hl2gotz0fgKffy9io5s5+ZqNVnrPr8Cw==
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 (2603:10a6:150:328::18) by PAXPR04MB9352.eurprd04.prod.outlook.com
 (2603:10a6:102:2b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Mon, 16 Mar
 2026 02:52:31 +0000
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908]) by GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908%7]) with mapi id 15.20.9700.018; Mon, 16 Mar 2026
 02:52:26 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: =?gb2312?B?QWRyaaiibiBHYXJjqKphIENhc2Fkbw==?=
	<adriangarciacasado42@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
CC: Frank Li <frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH v3 3/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data
 and add Kingston CID
Thread-Topic: [PATCH v3 3/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data
 and add Kingston CID
Thread-Index: AQHctLl5IqJLl4iWxUe9j7I/D4MLXbWwdTYw
Date: Mon, 16 Mar 2026 02:52:26 +0000
Message-ID:
 <GV2PR04MB122725739F8402212914571CE9040A@GV2PR04MB12272.eurprd04.prod.outlook.com>
References: <20260315202238.15758-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260315202238.15758-1-adriangarciacasado42@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12272:EE_|PAXPR04MB9352:EE_
x-ms-office365-filtering-correlation-id: b9570ebd-9694-4521-a67b-08de83070e74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021|7053199007|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 6PFLZTVW+yDDGofXJ9aDnS/JMsqnIa4xgbFV3u64nt9SdwJVgP0V5opHkHfOJuK7WRCp0pVPpA9hrMDsQj9cgaarLcgsbvUlmrqokUewn1uNvOltTvxNkZfBuCD36c4yfenHKcdL/KQGnO1MjtzxOzhs5LXtOC4Ak2UzK0DEkaD/kn360ah5U12gvkKMc6YNOvfXRv/SJMk8R3UDwmUYXTWvr4vnrPU9mj6Yrpa1272o7i2mK5O60ZstDjOl3UxMRknX8U2LfOHlUATOUv2rRLYMxImbeQqjGx8iB/CGsw7fPFELIe9OAXMEMbT1Axck4MzODQQqeeqAYINtTxpN5GHVo5yxh0kQh1I51fTCQ6oS8C8LvAt6Ra6YWYOXcm+Hboq69fuBOBrUlbuiMtN+sr2gXjCWp2LAJnSc76701dsH2JOjh8++v8Mp5FxljAsNvKDLfxUDjKoot/NBXWxgItt8aDJrEb+nz5ekoXPAOMMGaG+/ZSGhnuyxo94o1SvsdCQKp96fqobV6WNO9g+MMeAcLt8QkcbZC+ZZXhacICxDgJ8HtbJQsUGLSlBvjGvev7t9Cu2SzbhaWpeeLvfowAeeoIeWLFWcvroc7dQHb5i1gxxVQIClQlwvlIeie1ZFKP/NDahuRSIqd6RDEARQ+KoPiYgKzCsNe1EhDkXh2D1vZQ/FoS1aSgfsm9lHkkNs4esKXQKNdKPhWVZZ2W8fcDIvnfCFizH7j9ybfigNgmSHzUq6T0EGFiUifz7bvAhYR/MiU28I51itfqETcKiEEk0luVJ85Pcgn1qt33PqAnQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NHBTZ0tGVi96ZnJMVzZXTEs2ajViY3VpdE5PR1k5REcydmZkbExmbFdOd1U2?=
 =?gb2312?B?Mjhza3JsM1JkbW9OTWlHSVhjeGhYQVMxZmF4eXFvOUtnd0xqTm1hM3pmOWNB?=
 =?gb2312?B?cFZ6QW9yamxTSVN3dWxwaWMrSFFTcVY0Y3lZbkhoN0FsbDhudWJOR2lBQ3Za?=
 =?gb2312?B?SUdieGttUE9VMVN3T2xUU2c4NEZrTmdNN2dSdkNBa0M3SVlhWVRiMi9YL3gv?=
 =?gb2312?B?SmZCVllZZzB1ajVzSlZuTEZESFZhT2d4dXFoSnk4ZEVERDRFRVZQR1V1QXht?=
 =?gb2312?B?YXJFR3gzRVc5YlZJMDcwTC9qYloxc3d4RUxDSDN0Z1AyN1NtMC8vMVk3SUcx?=
 =?gb2312?B?NE1oREVmRUJ3MHZjRlM2N1QvTWtCVXJrRG84NnVhZkZXVmx5SEhaQjJwT3o5?=
 =?gb2312?B?d1lTUVNYUlFqWmtoRHZGRmMvMWZ4eWxlRmJwdll3NnhFQmlEZG15SmdIQlE0?=
 =?gb2312?B?VWNrNGZ5ZDRpcXRZMjB1VTB1dDRma1d5ZWlwdnN3VUc4NFE5ekJRR1dTbUNT?=
 =?gb2312?B?cHBjRy9HZ2tMRTRTS1pEaVZ0LzlHZytKZEtxOUVXN0thcSs0TURwU1cyb1JK?=
 =?gb2312?B?Z3pDbktIRm5qWGRDQ1IzRkVqZWNUbXgrNnVPZWxIQXhlSS8wbFBoK1BYQ21m?=
 =?gb2312?B?R0cwVUJYTWl3NTA2Uk5jWXhQMjFsdjludEhZMnh0dDZhZVZmRytoZHJZalgr?=
 =?gb2312?B?ZGNOMW4vTjdySytOTXpkb21CU3lqRzZRczFObkZFS3AyM2Z1L2JNdnZqbHhn?=
 =?gb2312?B?djR5SnVOcUhOdFQ3Wjkzby9WY2xoT0t6TVB3SEVTY29mbWxiUWNLN2pHU0Ir?=
 =?gb2312?B?a3VRVzJONnNUQW1TbW00RFc0YXJtWXJmdHJYUlVCVnNLbU5ZbDh1KytQdC9V?=
 =?gb2312?B?aVlvK2JMY2pKOW9qbTBteWJ5R1ZlZDdGSU9zUUZjVVpESTkxd25LbEV0T0hh?=
 =?gb2312?B?ODRobnAvZHRMN2VyR0FDM0YzWWhONzdTSCtwdFdsblN1OWlKdXJabi9PZVAx?=
 =?gb2312?B?MDlYV2wvMW42Mlk0VU0weHlKb1E2dTZKUGEvSXM4NXJiK1cxOHpLcWN6dFVr?=
 =?gb2312?B?MStVZEU2QlZsTjF4cVNNeVNIOXBNMTJwZGVFUi8zZENwSkdJVmVLazl4MzR3?=
 =?gb2312?B?ZXd1NEpQZTRLRHNXRUhjMjM4VTdWSEVJVjBTSG9ibi9sK3NqVVB1d1J4VDZj?=
 =?gb2312?B?cE5HTVl3RHRBMFp6cDVwZDZRaElSVFNCR1ZaeUt2blYvTjJKUXRYZkZaVmc2?=
 =?gb2312?B?K09YM3p2SXlEVlBRYWF0b25jVWpucGVlN2tKd1FQUnpNNVdUM3E0UzdIc1k3?=
 =?gb2312?B?Z0hsck9ma2ZkbDR3SElSS0FEWTIrOFNqQlFsaHEvemdkWWZZU05OQ1J6a3lE?=
 =?gb2312?B?MU9MUFkvdmRzSzQydVNWcGU0RWhtTkFnY1AzRE5wTVpVbE5KaVZ5b3hGR3pi?=
 =?gb2312?B?ajFONU9VdGJ1Tm5NcnZENEphK3NHWkc5b2wxNW0reDhOVW1WUWRXT1FyYkMx?=
 =?gb2312?B?RytlVlVwbGJaRUtnRkwvdXJCZ3VadkJ1d0czQ3ZYOTBER29XN0RITzVSUHli?=
 =?gb2312?B?OUJYSjhGNmtrU2J3OUdpZGhIM3VnaklqYnhoVzhmeUM3ekpWdWFCL1R3QWJM?=
 =?gb2312?B?WVo2RS9FZm00ZmI3M2ZoRmJCeXFLaHVvQUNCYUo5SnNFUnFQOE52ZGhMUjE2?=
 =?gb2312?B?UWoydmtBYzgwQVY3T2FxSnNMd3Z4VFhvTlo4UjFkNDNzWWdzQnNxWmZQTWdN?=
 =?gb2312?B?VmpCRWlaMlNmQ3VOR2UyQjVFb1YzbGVvSVRNYjMwY2VHV0FkTnBKS2JCaUkz?=
 =?gb2312?B?SlVtMmUxN2tLOFJyZWlFOVJYSXVHazJQZVR5UVhocWFsc3E3OGhKb3h2dVcv?=
 =?gb2312?B?YmdmbUhHc3ZCSnZGc1lBdHkxOCtkSUJFYnkzL3BPN3NiREpYQ3JHdmNuU1h6?=
 =?gb2312?B?V29KaXVvVHJ2MlU5aTloYldIbW9ocFZnWEl5LzJOaWVaMi9ZbklER2dGSm9y?=
 =?gb2312?B?eUU3Q0dnZHRHRlZNZWE5TmNsMG1xQng1aUhDaGdwZDdhc0syeHcvNDF6MTNO?=
 =?gb2312?B?MzVabjNZMGJaVHJ0MXBlaUpCb25CaWxmelMrcTc0Q1JxRzNnU0NEYjFWZW14?=
 =?gb2312?B?aWEvRWtvQlBjb1lFWVdwT3JlVG9TZlBFdWprT0ZwckkxQ1FTeXhDREkwWGgv?=
 =?gb2312?B?UFNzam5LT21vbkVNNWk1ejRralJOYWxuWnQxSVVVY1NPVDVIU213TkZGOFJF?=
 =?gb2312?B?SmRtbWl6RWpGL1dBTWYxajhBWDB6UE9pRHJVVkZqdVZ2eXQrRzdMbG5PblVq?=
 =?gb2312?Q?qjlcVP/4Yu+hYnv6Z1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9570ebd-9694-4521-a67b-08de83070e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 02:52:26.3320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jb5OekYd/hbhnyphL5w+ejdM/i1T2bn7+nFhUW58djzWJ5He7GbOze5KnvnbIu0YniO4IS+idKGImzkaBgqGSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9352

PiBGcm9tOiBBZHJpqKJuIEdhcmOoqmEgQ2FzYWRvIDxhZHJpYW5nYXJjaWFjYXNhZG80MkBnbWFp
bC5jb20+DQo+IFNlbnQ6IDIwMjbE6jPUwjE2yNUgNDoyMw0KPiBUbzogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+OyBBZHJpYW4gSHVudGVyDQo+IDxhZHJpYW4uaHVudGVyQGlu
dGVsLmNvbT4NCj4gQ2M6IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IEZyYW5rIExp
IDxmcmFuay5saUBueHAuY29tPjsgU2FzY2hhDQo+IEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4
LmRlPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBNaWd1ZWwgT2plZGENCj4gPG1pZ3VlbC5vamVkYS5zYW5kb25pc0BnbWFp
bC5jb20+OyBBZHJpqKJuIEdhcmOoqmEgQ2FzYWRvDQo+IDxhZHJpYW5nYXJjaWFjYXNhZG80MkBn
bWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyAzLzNdIG1tYzogc2RoY2ktZXNkaGMtaW14
OiBjb25zb2xpZGF0ZSBpbXgyNS8zNSBkYXRhIGFuZA0KPiBhZGQgS2luZ3N0b24gQ0lEDQo+IA0K
PiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGFkcmlhbmdhcmNpYWNhc2FkbzQyQGdt
YWlsLmNvbS4gTGVhcm4gd2h5DQo+IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1z
L0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBDb25zb2xpZGF0ZSBlc2Ro
Y19pbXgyNSBhbmQgZXNkaGNfaW14MzUgc29jIGRhdGEgaW50byBhIHNpbmdsZSBzaGFyZWQgc3Ry
dWN0DQo+IHNpbmNlIHRoZXkgc2hhcmUgdGhlIHNhbWUgZmxhZ3MuIFRoaXMgcmVkdWNlcyByZWR1
bmRhbmN5LiBBbHNvIGFkZCB0aGUNCj4gQ0lEX01BTkZJRF9LSU5HU1RPTiBkZWZpbml0aW9uIHRv
IHF1aXJrcy5oIGZvciBjZW50cmFsaXplZCBtYW5hZ2VtZW50Lg0KDQpQbGVhc2UgZGl2aWRlIHRo
aXMgcGF0Y2ggaW50byB0d28gc2VwYXJhdGUgcGF0Y2hlcy4NCk9uZSBwYXRjaCBvbmx5IHRvdWNo
IHNkaGNpLWVzZGhjLWlteC5jLCBvbmUgcGF0Y2ggb25seSB0b3VjaCBxdWlya3MuaC4NCg0KUmVn
YXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWRyaaiibiBHYXJjqKphIENh
c2FkbyA8YWRyaWFuZ2FyY2lhY2FzYWRvNDJAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
bW1jL2NvcmUvcXVpcmtzLmggICAgICAgICAgfCAgNCArKysrDQo+ICBkcml2ZXJzL21tYy9ob3N0
L3NkaGNpLWVzZGhjLWlteC5jIHwgMTIgKysrKy0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9jb3JlL3F1aXJrcy5oIGIvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaCBpbmRleA0K
PiBjNDE3ZWQzNGMuLmQ3MzZiYjRiZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9x
dWlya3MuaA0KPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oDQo+IEBAIC0xNSw2ICsx
NSwxMCBAQA0KPiANCj4gICNpbmNsdWRlICJjYXJkLmgiDQo+IA0KPiArI2lmbmRlZiBDSURfTUFO
RklEX0tJTkdTVE9ODQo+ICsjZGVmaW5lIENJRF9NQU5GSURfS0lOR1NUT04gICAgMHg3MA0KPiAr
I2VuZGlmDQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW1jX2ZpeHVwIF9fbWF5YmVfdW51
c2VkIG1tY19zZF9maXh1cHNbXSA9IHsNCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIEtpbmdz
dG9uIENhbnZhcyBHbyEgUGx1cyBtaWNyb1NEIGNhcmRzIG5ldmVyIGZpbmlzaCBTRCBjYWNoZSBm
bHVzaC4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMN
Cj4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+IGluZGV4IGE3YTVkZjY3
My4uOWNmYTI2NzIyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhj
LWlteC5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gQEAg
LTI1NiwxMSArMjU2LDcgQEAgc3RydWN0IGVzZGhjX3NvY19kYXRhIHsNCj4gICAgICAgICB1MzIg
cXVpcmtzOw0KPiAgfTsNCj4gDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGVzZGhjX3NvY19kYXRh
IGVzZGhjX2lteDI1X2RhdGEgPSB7DQo+IC0gICAgICAgLmZsYWdzID0gRVNESENfRkxBR19FUlIw
MDQ1MzYsDQo+IC19Ow0KPiAtDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGVzZGhjX3NvY19kYXRh
IGVzZGhjX2lteDM1X2RhdGEgPSB7DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGVzZGhjX3NvY19k
YXRhIGVzZGhjX2lteDI1XzM1X2RhdGEgPSB7DQo+ICAgICAgICAgLmZsYWdzID0gRVNESENfRkxB
R19FUlIwMDQ1MzYsDQo+ICB9Ow0KPiANCj4gQEAgLTM5MSw4ICszODcsOCBAQCBzdHJ1Y3QgcGx0
Zm1faW14X2RhdGEgeyAgfTsNCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBpbXhfZXNkaGNfZHRfaWRzW10gPSB7DQo+IC0gICAgICAgeyAuY29tcGF0aWJsZSA9ICJmc2ws
aW14MjUtZXNkaGMiLCAuZGF0YSA9ICZlc2RoY19pbXgyNV9kYXRhLCB9LA0KPiAtICAgICAgIHsg
LmNvbXBhdGlibGUgPSAiZnNsLGlteDM1LWVzZGhjIiwgLmRhdGEgPSAmZXNkaGNfaW14MzVfZGF0
YSwgfSwNCj4gKyAgICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXgyNS1lc2RoYyIsIC5kYXRh
ID0gJmVzZGhjX2lteDI1XzM1X2RhdGEsIH0sDQo+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJm
c2wsaW14MzUtZXNkaGMiLCAuZGF0YSA9ICZlc2RoY19pbXgyNV8zNV9kYXRhLA0KPiArIH0sDQo+
ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14NTEtZXNkaGMiLCAuZGF0YSA9ICZlc2Ro
Y19pbXg1MV9kYXRhLCB9LA0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDUzLWVz
ZGhjIiwgLmRhdGEgPSAmZXNkaGNfaW14NTNfZGF0YSwgfSwNCj4gICAgICAgICB7IC5jb21wYXRp
YmxlID0gImZzbCxpbXg2c3gtdXNkaGMiLCAuZGF0YSA9ICZ1c2RoY19pbXg2c3hfZGF0YSwgfSwN
Cj4gQEAgLTQxNCw3ICs0MTAsNyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpbXhfZXNkaGNf
ZHRfaWRzKTsNCj4gDQo+ICBzdGF0aWMgaW5saW5lIGludCBpc19pbXgyNV9lc2RoYyhzdHJ1Y3Qg
cGx0Zm1faW14X2RhdGEgKmRhdGEpICB7DQo+IC0gICAgICAgcmV0dXJuIGRhdGEtPnNvY2RhdGEg
PT0gJmVzZGhjX2lteDI1X2RhdGE7DQo+ICsgICAgICAgcmV0dXJuIGRhdGEtPnNvY2RhdGEgPT0g
JmVzZGhjX2lteDI1XzM1X2RhdGE7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGlubGluZSBpbnQgaXNf
aW14NTNfZXNkaGMoc3RydWN0IHBsdGZtX2lteF9kYXRhICpkYXRhKQ0KPiAtLQ0KPiAyLjQ3LjMN
Cg0K
