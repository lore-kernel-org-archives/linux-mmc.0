Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023098.outbound.protection.outlook.com [52.101.127.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3466184540;
	Sat, 14 Mar 2026 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773451273; cv=fail; b=N+Mfoyg+h91a2i/q2rVPxRhW7Hs5sE0KIzUJ0AhVF4H4k0nS4ansx6/WzJ9xQ5KCoXuJ4g1T9X0NVhFyQx+OmyVlh1nkX8cWvQaUX9jngI5A2mzCz0dOeStSj/SRpcSWCuZGmTxt00IjWEmC3Q26Ndx8Qh0jTCL/TnU1QPC13+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773451273; c=relaxed/simple;
	bh=HcO5BKX2erjNi6lNFw2a1MlsJGwhA/PDPL8ufBl0Hlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AxKKLFZNK3/IyeFCBdKG7oArrt15t4XpPZIkeD7IliQ3UMNHzEjaUlch/VCb6DqgpE/6TMeZqNUB4Y22H0yNrGQ9dvd+OyRJeh91EqsxYesRP+/otdvvM6RNm4jHJqw9vTqssGekyV2jKE9uU1cMrFC0fYrbo4T9lpDwSY+gOdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=meTdi7ay; arc=fail smtp.client-ip=52.101.127.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="meTdi7ay"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfe96FypEgW/NZfa4KOzswHruES9LUjw1sUlZeblioHW4FgqxqMHEyqK8z8bqYadPsxSdTOaMZb4NGEFPZ1o+e3QEsuOXyEk3Hw0RadlmALeoKHhCsroLpxz+1YLtTd2+a7G4/wwx5d72jsN0YRlgOPbklT8WnmSRfemZo4UlyCN124816WqRl3N5zpvg0yhY96VOw5lzVEmNsgPHy7kcz3EuZ2llLlD9IQpyH4bHC4qza2xtIMw1TXoRnHXMBPEG1FyNKvEIGwLPdwLY28h7THUVTevxLaN3tVelqvk0/Mw8gvlO9v7oC1rKQAAV2IS0A/OFAfeprFC8ngREiIYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcO5BKX2erjNi6lNFw2a1MlsJGwhA/PDPL8ufBl0Hlc=;
 b=MFItin9wq7aO/0of2xGbwYu2Oryd+IXPjKuwkdxJDvvqHOtnK/Fmml1R2TwWi0Il5zXwzU+aYcfwT2wHQuYFCO3GA+MNSMug7afDFItlflnxxaZvXlN1uW1+Vhu2cOBlhx2TSCbTSXDgQ/Yrf3vMDiCaYYVG4YoUqicADiBnOzhpQKsLBJIMVOeYY6w6Rxh/mnl54hNLrrM0gxzaDMnkbuXhQjEL6BYI8IwRMJo+YwDKaRq94a/DpW2zx3wUEjkRce0oly3hi2JqjxeNh4oxKN4F7KIioqmCBFXzQniMZJUbLZAVqZTxeQbQnnCmwzvw9QKhxWtD/mlbE2YgXQ84RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcO5BKX2erjNi6lNFw2a1MlsJGwhA/PDPL8ufBl0Hlc=;
 b=meTdi7ayywZmIJYgxELOr83EL9MWwr8R+cg+qMqB8cH5D64NxKety+7cRL0VcvGOq/ZgJI3Phuh75jcbvK7CuqfgTAWj/JuFStgS2PErb/E9UFJtB3YFBo6R4PyxKCGQZcski21ISToqluIKaT0XG0hGUyyBXYa26+IglFpnJHEOXPnOB/en6zUEERhN1lww6P76kJQE3LhnuLzhgiB+6USbopVx/VAFvr1vuFdSJ496YjseFNyAVoNzKoimiS7wl8qE91/CqmfHT3j+YiVr9bsTCrx7JIC+Oq9jJQJiFKJG7WJEvdufZlT+tq171/lalQtHCvBnO5/Hytou4EhmcA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by KUZPR06MB7962.apcprd06.prod.outlook.com (2603:1096:d10:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Sat, 14 Mar
 2026 01:21:03 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Sat, 14 Mar 2026
 01:21:03 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf
 Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian
 Hunter <adrian.hunter@intel.com>
CC: Andrew Jeffery <andrew@aj.id.au>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
Thread-Topic: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
Thread-Index: AQHcsqoqa/wkH2eIMUucFBg3jcknirWsIJ8AgAAB8kCAARlecA==
Date: Sat, 14 Mar 2026 01:21:03 +0000
Message-ID:
 <TY2PPF5CB9A1BE6CFB3FA0165159C68D3F0F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
	 <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>
 <352a522b5325e9db80c880dd7a3a052516f3b673.camel@pengutronix.de>
 <TY2PPF5CB9A1BE6C2F2EFFA36CD917C623CF245A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
In-Reply-To:
 <TY2PPF5CB9A1BE6C2F2EFFA36CD917C623CF245A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|KUZPR06MB7962:EE_
x-ms-office365-filtering-correlation-id: 9665f8a6-bade-4a53-7580-08de8167f5a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|56012099003|921020;
x-microsoft-antispam-message-info:
 BXvN+LV61/OqtP+p4uwM/3VZzbPTiBvKEFtxs9YLhaFtPXWypx5ZEPI0gS8whhhzFVXIOcIJ0tD9gZ8nVeb1TFqzmZC74SDbyOVBmEOaUxIV3XYzot7ygpSxjGcvUuyY/Aizn55PUpW4N5Zg+zx/FGZ2R3DlQByXfDVjGWPxvcOTriOoWAUEheOtlP3NcFtSuXt0+4ATQBDQJOQdE0nH24NTWMOkahOFnZLMR0K1SFxOJRXTc5OUXBjO8+W4ioB1/NKUfwpBY8Va3SUcVB92W7iZ/4RQPWtRS9nYhN2uFdcS7QjZYmRyt2Fqq/c19sln78iHRCsQ3TUwa475QGaeFJ2jwV+YlWUu7oVR6MjQlwfePrlWk7QUxDIsFZEBw7ClPgrhP2RZ0JotDga/n7d6QRTfmJfw25aGFpT7gOb5IcsPcRgqOfldNdWsoK2a7abVQ1krL7uZA+za6+ZFPfZAaZgLRc7pDM2EEVWxfN2UATZOc7rkOeNnV0vE0i1tRp2RG37KJVyv48C0DvbZOLh+2boLlkIrrNhXNkm8j5o6CCP+Jbv8VY4uTCWqnCF7t8LYoHrT2Z41czGfmc1Rl1J0o3oSICl8uQL3rrX8Byi7SlONFRfejfZzhfekIJ2eWSZJ/Hwu5Pnx/pembsTCf1m2GFLdt7lNUZe3ykYNPDebEvKfAApAH17ZsDGMZSet4dKq3jWMQ2fzdg/LfphXhaLJraB/pRRcTFZBneqDes2pV9TzgNPzghj/0Vp6KXkk+x/IhpwvlvPqEt7SMuoz219SG3OsPjLMWuOj3AMjggfolR38eotPRPAC66vs2LkyfeM8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEErNnZPUG1Jb1JyRFdOTmVxeFdMQnpHdjR4eGpNUnkzcnNLNTN0TDlzVVB2?=
 =?utf-8?B?a0JUb3FRTlp6V0ZuaW9MNVpwaEsxNC83MEF5RFUvcFNDaWJ6Yzc2TVl1cm5W?=
 =?utf-8?B?UlNYUS9ZOFJ2QUEwOHZJWm9XTXYvZlB0d1dCZTFUWGFrYnNnSmQzUXZtSmV6?=
 =?utf-8?B?Sy9vMDJyOTFCWnRqR2N5TlRzUW5lZ2kyRTVhaFFoc0NHQ2Fza2txZSsrQ0tS?=
 =?utf-8?B?SWdKZzlNdHk2YTJ2a095NUJLSDlxcjc0TGVaeVpQT3U4S0RMU2NwWVRhRW96?=
 =?utf-8?B?ZEo3RnN1QlQ2dFNKUC9jSm9xTGRUOEFUN3dXY2xBNnpTNHJRT09LMExIMUVu?=
 =?utf-8?B?ZzVQSmpETU01bTVxaFRRekNlQkh4bE5HN3RNUHNsWkp3RDV4V0lkaVNtdG5v?=
 =?utf-8?B?d2JkUGV4dzdmQUF6aUtqQ0NHZnJKUjZiWUdvTzhqMEVnMnBZNGhPL2RxN1hj?=
 =?utf-8?B?eFpnR3VNNlZMb1FtL3EzZmpIQU1WUU1WTjBoL1ZCTFYyVnl4K3dHckNBTWVo?=
 =?utf-8?B?MW0yanFNdkVVTHEzcHY3NHNncmVYV2I2bGNCYUdxbkwxWGRKR0hpWHh2NkRz?=
 =?utf-8?B?UDNianBUSzRsT00xZm5XZ1ZuSUJqOVU3Vk44bVlRcDhlSnBta1B2N3hiZzVG?=
 =?utf-8?B?WjY4LzhFRDZ3R2M2OUVhMlFYZjd1ejhRWGN1NW9WRjRWQUFwdzAwUSt3NU1q?=
 =?utf-8?B?R1Q1UkxsbzVHWDkwdi91WUxIbWk5azc5YmtNcFFLZmFra3hQeGVmRW81ZDRl?=
 =?utf-8?B?VFhqWnJqVDFyOWJSNmFMelNlZHlUTzVSMit0RmhsWWJPbGVqREt3V3pWemJr?=
 =?utf-8?B?N2RkMnVmTDBNTWIrb2VqWG8rYmFMQjJBc0lIRWhLTU05SWE2VHFKUndMKzdw?=
 =?utf-8?B?UDJSV2p5RU1Ebm5yYkxBZGVMOEdjRzNYSmZTbmUyTm8vM0l6YzhtNmZYcjZZ?=
 =?utf-8?B?MFVLWFFBYUVmbm1UejM1WlRrSnJramk1QS9PZDV2eCtWS0MvdHE5a2M5dWZ6?=
 =?utf-8?B?T2JJeGhZYklEK29pU2I2WmVJRFpIQ0VLUUFZMzJZcU5tVWZjT0ZGdGF1cG5w?=
 =?utf-8?B?WVdRMGtacHArSnRwcHJROExGMUgrSHhwZ0VROGRKcExYRHppejhIa2tLZGdT?=
 =?utf-8?B?Z0kzS3pSZVBBSVlMRS92QWhad21WVWlQUXVBYStvTEFWRDRKV3lnek1ldkcv?=
 =?utf-8?B?Q24xQnlSQ1BrUGo1Tm9EQ0lURkE3bjhNVWFua2dodE9aTkR6eEZUMlY5YzFC?=
 =?utf-8?B?T1lHRFk1cTZoK3gzVzQ4d01TWGRLaEJ6anB1U1M4dE5hNDBXMXdDZ0REbXF1?=
 =?utf-8?B?MEFYN1p1WjF5Ti9YY3k0eVB3dlgrc2ltZG5qKzJQZjlETVFRVWMzUzZMaVlO?=
 =?utf-8?B?cUcvajZwTzFOSzEydmNleGRweFpXUWlVUDJZQTlaemJhU3hScEhZTGhEdnVp?=
 =?utf-8?B?bjhPeUVscXRlQXNsM25Gdko3MmFuNGphTGJPOHZNek9LN1JpREhnMTJqUXJn?=
 =?utf-8?B?bVNhcnJ2Y2REa1lySEVtUzBWMndZNFVITk9NYllrOEhjSGNQN0U2Y0RzekVJ?=
 =?utf-8?B?eU5LMVRFS2lMZ3hFWXdxNVVXN0x0bXBOYXNoS21rcS9pYUw0Q1J6alV1REdr?=
 =?utf-8?B?eTBZYVcvZkdiQTZwbXBMQjdPNEVtUGpSZUNnM2dsNjZvRXowRzhITmR5ZExL?=
 =?utf-8?B?cHlHMFNiSzJPbFlGZi9vODVSVGdObHJCazNocnZENWJucTl1T2hIU1Yzd0Y3?=
 =?utf-8?B?OURKOXhRd2l4d2tSQWZiV2hYUmd3UHRWSCtkb214ZHpQT2RnT3pSaGhiOVF0?=
 =?utf-8?B?cS8yRHRwanpKeHVhWVA4VmE1SmxLdjVMa002cXVrS1Ywa1VIN1Q2dU0wbjR4?=
 =?utf-8?B?TFlkMVBtMXVLUk5HMFB4SE45bUsvMzBzLzBNTkV5Rm1mZHJCZEUyNlNDOUlR?=
 =?utf-8?B?OVVjUmtrc1ExWFpCbW9xZ2xINHBNU3Q2cStFdGl2QTVGTEpsV29LRTZSR3Rk?=
 =?utf-8?B?Um1OTFZpR3FyNkV3K0pQWjBtN3dBK1pGbkV4Y29ZVUl2MXpsRmlqQU5sV3hX?=
 =?utf-8?B?Q3g1bWJCKy9TeUZyLzVZYk5iTGRCZnJpYkxtOWRMTEJMbDRLVFA2YmxMOWcz?=
 =?utf-8?B?eTU4bzIzRVlUQ3Q0WmwvS0IvSVpjUmZGem1mRXIzL3lKTE1hUGlpeFMzUkVX?=
 =?utf-8?B?MDIwRU1URk9CMEFJN3VlNmpGVVRPUkRVa3RIZ0VEeTBhQTFPWERRdjgyZit4?=
 =?utf-8?B?c2lmSW8rU2YyK2hPK1pLNnBrU2RFWFMvSWdWMHpSUUdEOWZDOEcrM1J0b2Jv?=
 =?utf-8?B?SGxyMjNiVXNCOUd3ZWNTRFVlbExkbFNqQmlSeEtQdXlaRUlBU0hYUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LYzzGBBFgsOWuMynY95qDyHEx4qg7ZC0pE8YV7pyeS7OkQbk5eJT+ye3f2Sz7KIZksn960Tf4xp2inmMMKPYcQqlyP5trYUS84OQu9lVA7q7Hem8SECr84lGk66W9NOE0GxtldtVrNWnK5cgYoA7ktxu0IQlOOjwUz7trrJdtzI3K9sm0r0aeKomBiRk/9u4hVHHoE5iZ4IvwAyOdTimAvipTZKH/FErohXttrRpvrEL6UoNd34rvm5hgMtvz1vtS+e7qkGL4dITt2gP1wvBLBY4rWzr63ZRDECKjd99gaGgupFK4NOfyuooX46uQeE2SLrUR8gz5yH85o2O4Oua/A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9665f8a6-bade-4a53-7580-08de8167f5a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2026 01:21:03.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulY70yIkftYy+4hfZ3z921/3Hn7BRGKrUJ6svBugE010p00eQ8v0B1TJ/Tw0xPlFx+MWvheyBH/sXsNHevXA85DywLH3R/aHlVmpmXjCzxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB7962

PiBTdWJqZWN0OiBSRTogW1BBVENIIDIvMl0gbW1jOiBzZGhjaS1vZi1hc3BlZWQ6IEFkZCBhc3Qy
NzAwIHN1cHBvcnQNCj4gDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIG1tYzogc2RoY2kt
b2YtYXNwZWVkOiBBZGQgYXN0MjcwMCBzdXBwb3J0DQo+ID4NCj4gPiBPbiBGciwgMjAyNi0wMy0x
MyBhdCAxMzoyNyArMDgwMCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+ID4gQWRkIHN1cHBvcnQgZm9y
IHRoZSBBU1QyNzAwIFNPQyBpbiB0aGUgc2QgY29udHJvbGxlciBkcml2ZXIuIEFTVDI3MDANCj4g
PiA+IHNkIGNvbnRyb2xsZXIgcmVxdWlyZXMgYW4gcmVzZXQgbGluZSwgc28gaG9vayB1cCB0aGUg
b3B0aW9uYWwgcmVzZXQNCj4gPiA+IGNvbnRyb2wgYW5kIGRlYXNzZXJ0IGl0IGR1cmluZyBwcm9i
ZS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3Bl
ZWR0ZWNoLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2Yt
YXNwZWVkLmMgfCAxMSArKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktb2YtYXNwZWVkLmMNCj4gPiA+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hc3BlZWQu
Yw0KPiA+ID4gaW5kZXggY2E5N2IwMTk5NmIxLi45MWMzNjI0NWU1MDYgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFzcGVlZC5jDQo+ID4gPiArKysgYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFzcGVlZC5jDQo+ID4gPiBAQCAtNTIwLDYgKzUyMCw3IEBA
IHN0YXRpYyBpbnQgYXNwZWVkX3NkY19wcm9iZShzdHJ1Y3QNCj4gPiA+IHBsYXRmb3JtX2Rldmlj
ZQ0KPiA+ID4gKnBkZXYpDQo+ID4gPg0KPiA+ID4gIHsNCj4gPiA+ICAJc3RydWN0IGRldmljZV9u
b2RlICpwYXJlbnQsICpjaGlsZDsNCj4gPiA+ICsJc3RydWN0IHJlc2V0X2NvbnRyb2wgKnJlc2V0
Ow0KPiA+ID4gIAlzdHJ1Y3QgYXNwZWVkX3NkYyAqc2RjOw0KPiA+ID4gIAlpbnQgcmV0Ow0KPiA+
ID4NCj4gPiA+IEBAIC01MjksNiArNTMwLDE1IEBAIHN0YXRpYyBpbnQgYXNwZWVkX3NkY19wcm9i
ZShzdHJ1Y3QNCj4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+DQo+ID4gPiAgCXNw
aW5fbG9ja19pbml0KCZzZGMtPmxvY2spOw0KPiA+ID4NCj4gPiA+ICsJcmVzZXQgPSByZXNldF9j
b250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUoJnBkZXYtPmRldiwgTlVMTCk7DQo+ID4NCj4g
PiBUaGlzIGlzIG1pc3NpbmcgYSByZXNldF9jb250cm9sX3B1dCgpIGluIGFzcGVlZF9zZGNfcmVt
b3ZlKCkuIE9yIHVzZQ0KPiA+IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVz
aXZlKCkuDQo+ID4NCj4gPiBJcyBpdCBvayB0byBhc3NlcnQgdGhpcyByZXNldCBjb250cm9sIGlu
IF9yZW1vdmUoKT8gSWYgc28sIHlvdSBjb3VsZA0KPiA+IHVzZSBkZXZtX3Jlc2V0X2NvbnRyb2xf
Z2V0X29wdGlvbmFsX2V4Y2x1c2l2ZV9kZWFzc2VydGVkKCkuDQo+ID4NCj4gVGhhbmtzIHRoZSBn
dWlkYW5jZS4NCj4gSSB3aWxsIHVwZGF0ZSB1c2UNCj4gc2RjLT5yc3QgPSBkZXZtX3Jlc2V0X2Nv
bnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZSgmcGRldi0+ZGV2LCBOVUxMKTsNCj4gaWYgKElT
X0VSUihzZGMtPnJzdCkpDQo+IAlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCBQVFJf
RVJSKHNkYy0+cnN0KSwNCj4gCQkJICAgICAidW5hYmxlIHRvIGFjcXVpcmUgcmVzZXRcbiIpOw0K
PiANClNvcnJ5LCBJIHJldmlldyB0aGUgZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9l
eGNsdXNpdmVfZGVhc3NlcnRlZA0KSSB3aWxsIG1vZGlmeSB3aXRoIGZvbGxvd2luZyBpbiBwcm9i
ZS4NCg0KCXNkYy0+cnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNp
dmVfZGVhc3NlcnRlZCgmcGRldi0+ZGV2LA0KCQkJCQkJCQkJTlVMTCk7DQoJaWYgKElTX0VSUihz
ZGMtPnJzdCkpDQoJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsIFBUUl9FUlIoc2Rj
LT5yc3QpLA0KCQkJCSAgICAgInVuYWJsZSB0byBhY3F1aXJlIHJlc2V0XG4iKTsNCg0KQW5kIGFk
ZCByZXNldF9jb250cm9sX2Fzc2VydChzZGMtPnJzdCk7IGluIHJlbW92ZS4NCg0KDQo=
