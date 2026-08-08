Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011047.outbound.protection.outlook.com [40.107.74.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E13375F95;
	Sat,  8 Aug 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200006; cv=fail; b=NEZQlTO8PbTTSHjwI+ER7QOVj5QsIO00py7sb/v0m+G6AQChdmOF+DpZ23ftlxoIh/51OYf10PafpDEfFc5mYIsLQ+gaGZqCxeg5G2MmHwbgU1dTLWlsntcEs4LaxpQcnb8OVmvPsrXlzWGCzL2zOwHBIiI4WfRlmiO3h+SRSUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200006; c=relaxed/simple;
	bh=Q210HyGUPLvdSVOcRqM54x46ccR8aqSa00nrJiMKY7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OoDM/URLKo5Ekrgaz6IRPqWnI06hShXEumQ7ZiTVRgNOo4YzXEZNQ+L3oJehWxZRC9EjZdz0WnbzZtC4w3PmMGfoVgewvh/Apou4/TZ9VOVVPehoVP3RaTYbxa7TPoowvdNYsZh9Fz9MqOnwTSvHD/ZJ34trqqJ3yExccP8r5wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=eZzIeOXp; arc=fail smtp.client-ip=40.107.74.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="eZzIeOXp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTd/3opsC/tLNTPwCj2UR//PUMHNXjiWVIl8K6k98HN5JhS58bcPCAaw2wNQXGSVyy5iYOCpi8fexnDedV/ortFoWGOPRQAkd0OXenNCiyOsWUyr+rtbwzzN4DV1qgMdR/YTyhF0SIDycxKHNpygv5LMLxQXpU3xjSqe+rFdK2kYC8IWB/fu2J1FNAJsWoo5Jl0ILcHu+sPteJpbS+DYnkoAbi6Exomp3eWutbmj8gMzU45hRsWGmpNXgMX+CF1t+gfufuOerlw+IT89WBiobgnlfuGoY8kWLHcsN0xy9JtQA/2Bb3f17wa6ZgojNmtuebUtKF2whj4AwZNDwyzUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q210HyGUPLvdSVOcRqM54x46ccR8aqSa00nrJiMKY7I=;
 b=virv9SwfkfXjJCjiCFptm1P/nZbxAwyoz9dqW3IQl5FTapt84Vp/2GrogUYP9SDlHZp60/lmS2TcwNWEhAsdsguRcgp/ocDjhKoqrzZ7y9GrE3b1HhmccclXf1LKRenaAOmBQwBTSIk1h5oaHP4rOY/V3SbrkPE1y+ts9JxQkNT2In7Av/Bq9ci4NOYu9kzdkx5KII6YZCHgDmPIrc59zuRUR3sqUmW68fJfsCDSoj0cOMFLHyZNu83naUxuXWha5TgyT3jjDjhHiaQrjYFCQY8ZFoLt+l2B4+2a0jWR/CUsIHynzeDk0fs1HycbdGeI9/P5Omt3xpgFLhr4CiaDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q210HyGUPLvdSVOcRqM54x46ccR8aqSa00nrJiMKY7I=;
 b=eZzIeOXpWZlZ0DoR21JWnh63O3KgCPLHTiUHsJIKqa1wooiQF3GGe9hfihFbrHWCG6PRPAD69MEkW07NrGxSl8wTJgkUFb89mw8f911ZlOiFI7AFwLefNhGAcKKHHZ0AOG9DXFw6FKXjqoxK9pB1JEXrxtHpY1185gotjry4FpQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8227.jpnprd01.prod.outlook.com (2603:1096:604:175::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 14:40:00 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 14:39:59 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, "biju.das.au" <biju.das.au@gmail.com>
CC: wsa+renesas <wsa+renesas@sang-engineering.com>, Ulf Hansson
	<ulfh@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v23 10/14] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Thread-Topic: [PATCH v23 10/14] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Thread-Index: AQHdIBcWRvvBRAkt/0CJBFi+WSgTubaSoP0AgAGkgqA=
Date: Sat, 8 Aug 2026 14:39:59 +0000
Message-ID:
 <TY3PR01MB113462B2000CA9786B711C35986D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
 <20260730113200.36456-11-biju.das.jz@bp.renesas.com>
 <CAMuHMdVd-PQBPvoof650UjXfSZqg2kGN=9kOnVUDgZvnGUOLcQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVd-PQBPvoof650UjXfSZqg2kGN=9kOnVUDgZvnGUOLcQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8227:EE_
x-ms-office365-filtering-correlation-id: a48c3d8a-08c5-434c-b1d0-08def55aeca1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 FkzmDMEQK8tpLRGxFW+NSOSC9JwdXRsUq4N3w0WNI2i10Umqi/zYVsvBdnUl4EUDitvzol+nvzDINOo0WFjUxrkZiVhpLjVMkZR0UTXRRuMWiuLAExuX5xXAf7QVhcqnb15imbJRFAjF33MWsDe7bU2hx+dZNndM92FXki+3T9zT9QORfnGKyIdxE2xqcRyE3P5vozRfq33o0ZulsMG8kTDz22d+b3+hnojpbuxwme8uPLDHC5tVYHLPSfPJzZLvOB77yFMnGnfEjeDs7CV5P6CPKrgMY4WfBWVCxyyO+rGZWeYpGT1l/7ohZLzM39ypGlk+4iZOxiZLJy3hmPRBmnrVOVnWtNrfevN8pIV7kbCuWZ9Jg46MoRzALMO9sQzz+TNe8arFLD77ULoItLmYycUJLL3mwkDiovfyVfCQkFlqF9TB65JFSYLi1XIXSBdkorRpqXthSEP8dAWUBaSYFq0IdMdgQD3fpP0tyMJRwL7XB4VokvhtHM3hyO7dmPqCdgXhVfFZe6hg3TiUsZqOwDHxTewNzRSJcuMZyV3lV5e872Z9ojD2HId9l/3V+cITjExB32bEeQEvwou1zRyg4nikIep93vZ014j2tocod8EZVdqObybuZDLaO1vEfyJXLw/eoge0kcXyfhzir1YOSXrQOJtYP9CLfGB5PvPhbTHKMK1xcwyxJ0paYkvbUvaRSzBXpL+sZ8qkiOCzMzqCATizyCk0W4XRLSn/Qo38fmM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VitSZFIweHVrc0dtWGFxc0RjSnJKZXFnT0d2Z3RKbWdGNkhFc0lSZVhJcFVk?=
 =?utf-8?B?WisrdndRT2pheWliZTZoKzhkcXR2MDNJL2h2UmU0c1hmZTJ2aG5IVUtMVUxm?=
 =?utf-8?B?NUErU09PbHRmNjgrd21yZ1ljWWFiQ295Q2Z2eXpsMG4weTlMbEs1S2owMVhh?=
 =?utf-8?B?T2VwWGc3WVlVZlJacUtoSDRMSTVnbmx3bVdYenFwWkR2bkp0b2diNlhvSEZj?=
 =?utf-8?B?ZWJVK3MvSEVqVGNTM25pWDIveTFPcUFSNUpjTE40dy9vV1BsdWp1Y0dwVUw4?=
 =?utf-8?B?VnIycnlsYjZINWVPaURMK1RqYk5qQzlsTkNOTUlLcGVBUklBZm85SGo0M3ZE?=
 =?utf-8?B?M25LOVV1ZHNOMmNReCtEZzBHd1pEUVR3RTBMSVF3djRTaTN4Q2ZhS25vbnlw?=
 =?utf-8?B?Wi9kQ0FHbTZzdkxPa3hDREduZWNpZjNublJxWkF3STJkY1ZMdlRWMm8vYUVo?=
 =?utf-8?B?WEY4dlBDdzRqOHdiMGhmek9RbFAwUkVnRFVLNkFsRVdES3JDQVVmSmlYaDdY?=
 =?utf-8?B?eDdxeW1DT3JUUUhGdktxQVVyQ2llZzZhMFpIbFFlMiswYXVITUpjTEJsV1Vl?=
 =?utf-8?B?MU9oMEw4b2d5dk5OU0ppREt4WXRENGlienpueGIzd3ZHSnE2UlBhTENSS09K?=
 =?utf-8?B?NW9nRjRaRmpwN3prdGVLMUVud1hLa2RmOWNIc3JpMHFMdzJveEpnRzkzNGVm?=
 =?utf-8?B?KzhKdWhXSVE3OWVHMVVkM3I5OUJhWXg0eWxqTkZVcDVNK29BY3dLME9WM0lo?=
 =?utf-8?B?R2tmczVPTi8xMEFHYzZLZmkzYS9nNEhpblY0SGJzdzRhQmlmaU1LNFJ3VkZu?=
 =?utf-8?B?YWVRSlN5OUZ6ektDZnU2S3RIWmxjYy83NkVXbm5CQjJ1SStjVHQvWUZIcWdq?=
 =?utf-8?B?Z1VqSlNuUDdoZDhlRmZKT2NKOUt3WU5QVllMYTAvd0FpbDY0Zm41dlQxYm5L?=
 =?utf-8?B?MFZCWDd1YlNBa21xNzNQcnpQc2ZGV0NQeGxjQVpyS21Fb2hrTEhqanJvUVZM?=
 =?utf-8?B?WWI3UjlEV0RHV21QTkdsT1FyRi9hYjU4SVFITEliUHdxQjZuV3k5S3BWenB0?=
 =?utf-8?B?Mmx0aTBEZ0RGQ3J5RjNGb0VYM3VmeEhSUW1vRzZzWnZoNE9Ud1JGZENGdnpH?=
 =?utf-8?B?a2l3RUZnZkc2UHFxSDRXa2pLSjJPVFNxd2djMUJjZVpZYzFWQUd2S1FjbXNI?=
 =?utf-8?B?WnpqMlMzSWNVSHJWMTdJZWNXZU53TEtlOVFhaDdpWEpSejVURGNxc2VoMWZi?=
 =?utf-8?B?RXFiZEV6ZUMyN1V6TjFzZUlJM0lveUorYTdmZGxOdEQzVVE2SVkrbC9wK1RL?=
 =?utf-8?B?RVludi94Uk5ZVGlYa25sa2Z0SnpLdzlNcTZLY2duRlVGb1Eva3U3QTM0Nnh5?=
 =?utf-8?B?UTl2d2xCc0ZqVnBIMHFBWXBuNWlZb0FBNnlTZ1lYdTdpbm9qZ2l4UXY5Myts?=
 =?utf-8?B?b1h5S1AxUWcya015cHRidGxVbVhONlJaYXJobnVlN1pMeTZvMFZlODlNYUxZ?=
 =?utf-8?B?Ry9YWUFvcHUzdGVWWldQd05QQlZleGFpTUE2eXBCWWx5SEo2OFk2TEUzZU1t?=
 =?utf-8?B?eGpUSmdXcU1qMlFwUTMzZjBMckIxUjZiWXpMQklJWGNnT04xVG4yMUFJRGUx?=
 =?utf-8?B?N3A1QU8yaUxCTURJd2loQ2k0bDd3bEhJWnI3QloyY1hJMVFkUlozeXE5eVpv?=
 =?utf-8?B?aFpWOWQrL1dTQitNd1ZPS0ZVM2ZBM3hlOHV4bXc3YWxyWGdBWXFCZkdEUThZ?=
 =?utf-8?B?cmMvSklZTVJlR29uWWpwQUU0THpIUmllTGEyNktjY3Boa3RhclpucXBkRnpo?=
 =?utf-8?B?SEk5KzRDb3lrckJkNVc5OXIzWXFqaFVKbXJCdXErWGdOR21WRnJhODYxaEkv?=
 =?utf-8?B?ejZJdjlHOFlYMHpvREt5Q21Sd1ZIWjY1Y2s3bUc4NlBMYjZvYzVzSEFiMTZk?=
 =?utf-8?B?QWo5eWRMK3VxdkhjaktKTXNTTmFUYjRBaXduUVBMd0hEZGN2MnlOVFdpWkRn?=
 =?utf-8?B?aHp5d0g2L1dqZFFhUDV6Sy9OMDJVVmc4blhHcjhFdGgyTWNTTUt4Vkt1WVNP?=
 =?utf-8?B?KytDTWdDbW95ckFGcHY4OUN6eVRlMjNYUVZOSkE5WWFGa1lEdm8rTU9obkxT?=
 =?utf-8?B?bHZ2YlBYUjlRRW9WRkZwejYvbFYwclY5Slh0YmdxNGc4REdWdU15bm13aFVJ?=
 =?utf-8?B?Y2l5OGhzWWxvOXR3MG1IUGhUSzcxNzlBZ0xqQ3hqM1VkNTlzZWFJN3V0VFNx?=
 =?utf-8?B?dWlGaWdoMFd4b1BGWWp1czY0amhjMlpRUjU4dWs4cWZadytFRlhjNWRBR2F3?=
 =?utf-8?B?bGNVZnZiTys5MEtxczh5aXlwb3lyYk9mVHVReVJ1RStQSWJTSFdYZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a48c3d8a-08c5-434c-b1d0-08def55aeca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2026 14:39:59.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMG/JUip15y0QK8NKKAjUG3vKGLqgyerrZ+4RUx5FRR2t5P12PqQqqPZ6cz3izGvSFBATP3tMzphsAfpPNqxAJymQaq9cozP2RP105nihBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8227

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDA3IEF1Z3VzdCAyMDI2IDE0OjI4DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIzIDEwLzE0XSBtbWM6IHJlbmVzYXNfc2RoaTogQWRkIFJaL0czTCBTREhJIHN1cHBvcnQN
Cj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBUaHUsIDMwIEp1bCAyMDI2IGF0IDEzOjMyLCBCaWp1
IDxiaWp1LmRhcy5hdUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IEZyb206IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPg0KPiA+IFJaL0czTCAocjlhMDhnMDQ2KSBoYXMg
YW4gU0RISSBjb250cm9sbGVyIHRoYXQgZGlmZmVycyBmcm9tIGV4aXN0aW5nDQo+ID4gcGxhdGZv
cm1zIGluIGNsb2NrIGRpdmlkZXIgd2lkdGgsIGEgc2Vjb25kIEhXIGFkanVzdG1lbnQgcmVnaXN0
ZXIsIGFuZA0KPiA+IGFuIGV4dHJhIHR1bmluZyByZWdpc3Rlci4NCj4gPg0KPiA+IEFkZCBUTUlP
X01NQ19IV0FESiB0byBtYXJrIGNvbnRyb2xsZXJzIHdpdGggYSBzZWNvbmQgSFdBREoyIHJlZ2lz
dGVyDQo+ID4gKG9mZnNldCAweDAxMCksIHByb2dyYW1tZWQgYnkgcmVuZXNhc19zZGhpX3NldF9o
d19hZGp1c3RtZW50X2RlbGF5KCkNCj4gPiBhbG9uZ3NpZGUgVE1QUE9SVDIgKDB4M0ZGRiBhdCAz
LjNWLCAweEZGIGF0IDEuOFYpLiBDbGVhciB0aGUgbmV3DQo+ID4gSFdBREo0IHJlZ2lzdGVyICgw
eDAyMikgYXQgdHVuaW5nIHN0YXJ0IHdoZW4gVE1JT19NTUNfSU5URVJOQUxfRElWSURFUg0KPiA+
IGlzIHNldC4NCj4gPg0KPiA+IFVwZGF0ZSByZW5lc2FzX3NkaGlfc2V0X2Nsb2NrKCkgdG8gd3Jp
dGUgdGhlIGNsb2NrIGNvbnRyb2wgcmVnaXN0ZXINCj4gPiB3aXRoIGEgMzItYml0IGFjY2VzcyB3
aGVuIG1heF9kaXZpZGVyIGlzbid0IHRoZSBkZWZhdWx0LCBtb3ZpbmcgYml0cw0KPiA+IFs5Ojhd
IG9mIHRoZSBjbG9jayB2YWx1ZSBpbnRvIGJpdHMgWzE3OjE2XSBvZiB0aGUgcmVnaXN0ZXIg4oCU
IG5lZWRlZCB0bw0KPiA+IGRyaXZlIFJaL0czTCdzIHdpZGVyIDExLWJpdCBkaXZpZGVyIGZpZWxk
IHZpYSB0aGUgbWF4X2RpdmlkZXIvDQo+ID4gY2xrX2Rpdl9tYXNrIHN1cHBvcnQgYWRkZWQgZWFy
bGllciBpbiB0aGlzIHNlcmllcy4NCj4gPg0KPiA+IEFkZCBTREhJX1ZFUl9SWl9HM0xfU0RNTUMg
KDB4Y2UxMCkgYW5kIGhhbmRsZSBpdCBpbg0KPiA+IHJlbmVzYXNfc2RoaV9zZGJ1Zl93aWR0aCgp
LiBBZGQgb2ZfZGF0YV9yemczbCB3aXRoIFJaL0czTCdzIHdpZGVyDQo+ID4gY2xrX21hc2ssIGFu
IDExLWJpdCBtYXhfZGl2aWRlciBvZiAyMDQ4LCBhIGRlZGljYXRlZCB0YXAgdGFibGUsIGFuZA0K
PiA+IHRoZSByZWxldmFudCBmbGFncyBpbmNsdWRpbmcgVE1JT19NTUNfSU5URVJOQUxfRElWSURF
UiBhbmQNCj4gPiBUTUlPX01NQ19IV0FESi4gV2lyZSBpdCB1cCB2aWEgb2ZfcnpnM2xfY29tcGF0
aWJsZSAoZml4ZWRfYWRkcl9tb2RlDQo+ID4gcXVpcmspIGFuZCByZWdpc3RlciB0aGUgInJlbmVz
YXMsc2RoaS1yOWEwOGcwNDYiIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+
IHYyMi0+djIzOg0KPiA+ICAqIFVwZGF0ZWQgdG1pb19tbWNfcmVzZXQoKSB0byBoYW5kbGUgMzIg
Yml0IGRpdmlkZXIgcmVnaXN0ZXIgaW4gUlovRzNMLg0KPiA+IHYyMS0+djIyOg0KPiA+ICAqIFVw
ZGF0ZWQgY29tbWl0IGRlc2NyaXB0aW9uLg0KPiA+ICAqIEFkZGVkIGBjbG9jayAmPSB+R0VOTUFT
Syg5LCA4KWAgdG8gY2xlYXIgdGhlIGRpdmlkZXIgbWFzayBiaXRzIGluDQo+ID4gICAgdGhlIHJl
Z2lzdGVyIHZhbHVlLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgdXBkYXRlIQ0KPiANCj4gPiAtLS0g
YS9kcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJz
L21tYy9ob3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMNCj4gDQo+ID4gQEAgLTI1Myw3ICsyNTYsMTcg
QEAgc3RhdGljIHZvaWQgcmVuZXNhc19zZGhpX3NldF9jbG9jayhzdHJ1Y3QgdG1pb19tbWNfaG9z
dCAqaG9zdCwNCj4gPiAgICAgICAgIGlmIChjbG9jayAhPSBDTEtfQ1RMX0RJVl9NQVNLKQ0KPiA+
ICAgICAgICAgICAgICAgICBob3N0LT5tbWMtPmFjdHVhbF9jbG9jayAvPSAoMSA8PCAoZmZzKGNs
b2NrKSArIDEpKTsNCj4gPg0KPiA+IC0gICAgICAgc2RfY3RybF93cml0ZTE2KGhvc3QsIENUTF9T
RF9DQVJEX0NMS19DVEwsIGNsb2NrKTsNCj4gPiArICAgICAgIGlmIChob3N0LT5wZGF0YS0+bWF4
X2RpdmlkZXIgIT0gU0RISV9NQVhfRElWSURFUl9ERUZBVUxUKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIHU2NCB0bXA7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICB0bXAgPSBGSUVMRF9HRVQo
R0VOTUFTSyg5LCA4KSwgY2xrKTsNCj4gPiArICAgICAgICAgICAgICAgY2xvY2sgfD0gRklFTERf
UFJFUChHRU5NQVNLKDE3LCAxNiksIHRtcCk7DQo+ID4gKyAgICAgICAgICAgICAgIGNsb2NrICY9
IH5HRU5NQVNLKDksIDgpOw0KPiANCj4gQWRkICNkZWZpbmVzIGZvciB0aGUgbWFnaWMgYml0cz8N
ClNEX0NMS19DVFJMWzc6MF0gKERJVjAgdG8gNykNClNEX0NMS19DVFJMWzE3OjE2XSAoRElWOCB0
byA5KQ0KDQpUaGVzZSBhcmUgdGhlIGRpdmlkZXIgYml0cyBkZWZpbmVkIGluIHRoZSBTRF9DTEtf
Q1RSTCByZWdpc3RlciwNCg0KV2lsbCBkZWZpbmUgdGhpcyBhcyBTRF9DTEtfQ1RSTF9ISV9ESVZJ
REVSIGZvciBHRU5NQVNLKDE3LCAxNikNCmFuZCBTRF9DTEtfQ1RSTF9ISV9ESVZJREVSX1NSQ19N
QVNLIGZvciBHRU5NQVNLKDksIDgpLiBUaGUgbGF0ZXINCm1hY3JvIGlzIHRlbXBvcmFyeSBvbmUg
Zm9yIGNsayBkaXZpZGVyIG1hbmlwdWxhdGlvbi4NCg0KPiBXZSBhbHJlYWR5IGhhdmUgQ0xLX0NU
TF9TQ0xLRU4gZm9yIEJJVCg4KS4NCg0KT0suDQoNCkNoZWVycywNCkJpanUNCg0KPiANCj4gPiAr
ICAgICAgICAgICAgICAgc2RfY3RybF93cml0ZTMyKGhvc3QsIENUTF9TRF9DQVJEX0NMS19DVEws
IGNsb2NrKTsNCj4gPiArICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgIHNkX2N0
cmxfd3JpdGUxNihob3N0LCBDVExfU0RfQ0FSRF9DTEtfQ1RMLCBjbG9jayk7DQo+ID4gKyAgICAg
ICB9DQo+ID4gKw0KPiA+ICAgICAgICAgaWYgKCEoaG9zdC0+cGRhdGEtPmZsYWdzICYgVE1JT19N
TUNfTUlOX1JDQVIyKSkNCj4gPiAgICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDEwMDAwLCAx
MTAwMCk7DQo+ID4NCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVy
ZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4g
DQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNh
bGwgbXlzZWxmIGEgaGFja2VyLiBCdXQgd2hlbiBJJ20gdGFsa2luZyB0bw0KPiBqb3VybmFsaXN0
cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
