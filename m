Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0E3806DC;
	Wed, 18 Mar 2026 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822712; cv=fail; b=II+Zghnum9DwUZd7sgLtlKTW1frPZSvQDPHPqVliUV5bvktt7MXTM4AD0/2+nwRPseaJdqos4lx7eYUmnwHs6D1J0mHLouvOIQRXdm/D01f0DA+GuYdJCqlXBkqOrtOupKNw4DQS5dPHozv1BLZB+JFEF9aRThIXRO+UZy3eo2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822712; c=relaxed/simple;
	bh=uXoE+OCoAPFL6fihNnhn52ZVh6TRGfS9vU6a+PlYsMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kM31cKK1ZJe2iZMCZ7x928tj7q2GTFInZZvboXEeGrUDNti2apui0Xw1v6y1Duy4hd75ft1wRVnQxDrBP5YXrduv5Y/7OxDJk7UUCmVLdaHTmjU+NfU+iyrGS0p9JaZ5KYx45wrSu/MwsrWzHCQRO/hly4+PFEgvmXl0qNNBuFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fJCEcZ0r; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fJCEcZ0r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIj4whI6oNMOJP5ng+SLgQxFYisT8crTK21the58QBZmZi2lP7qu4AXN6abN38KC3Hzn0zF8HqueVloLuHELbAYrgFokmTO2SpJ976dlkFB+QZJ/rS8tLXHT5wnsR6R3WlVws+aUK1O3AmHsAqCJM2xhcIrgBfDmQ1AGLg+5aOIc9V7eeZXjko8AhPzB2cC0CepMmIU+OdWAmp0A5k386Rmg9r7nHnyIg/N1yuXSaNTqVKjJNOw017juz6d8pLOtHYOxCaNjXyyMzKQQahxEkZuulsV5Qh0vJXUcc13vPt0w0aDKpSQRJMSj3lRdPn3+CsSXIEtYjUe39VOBQfKRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXoE+OCoAPFL6fihNnhn52ZVh6TRGfS9vU6a+PlYsMo=;
 b=rtQAnmGA5vAJOw29/Edknn5bjLJDX5PXL0LvcDEOaKN5LWEW0P34w4bBapxHoNi6dlM6TBm8uSruAC59Mf3IoVhmv2J/xH4khZ95iRasVtemJzWYfQGERdIJ9ybSK3zyMwdEVQbkVRMEZYWMZYObPms5biADHYN5uCf6X79bMVUQF27kuq4Qoe/U2fcf8X0FFdoLKPA7PCJ5tOAcKhOztuxwIzRbiH//2SeRhWTvUfqVYN0faR54VF63xHlkNZIpCABDz00j//CUuNExco5I7a/VXQC+kk6KuIHxDK0ABH+j/BqJ+PSUMeMHvIk/H5XqCcwTpz7xNNU6T7P6OQD+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXoE+OCoAPFL6fihNnhn52ZVh6TRGfS9vU6a+PlYsMo=;
 b=fJCEcZ0rc6zYj2XuQVYQ6SbVAf7ZTFul7ZLq+geJLCI4RBMVDb07HV6mhE+GXjOz2PIiVZ0s88RqOfrWqNuQVAtDITGUmjMuW+nmUPXDqK6EfLCIEnt5WaOXLfzSKlW0mUzdzfh/57OMoIQhMSxd2GawcE7A1+Z5+djnRkpZdttJq+Sv3f758k35C2ZGM9RyNzprD2VVKIJwuwStSWBl3f3nbseZ4W43uqAPfBIpeTI6bUt/3DtEehR8/mhcHLhwZpqIO1tvs1lWad7cpvkZwO60hkOpQzPWqusI7E1ma3L3PrUERWndSg6ezcQ3h3YNcsOwPIYjKneQmnoYcYgwIQ==
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com (2603:10a6:102:215::19)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 18 Mar
 2026 08:31:46 +0000
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::ef42:801e:d0b9:d9d0]) by PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::ef42:801e:d0b9:d9d0%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 08:31:45 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: =?utf-8?B?QWRyacOhbiBHYXJjw61hIENhc2Fkbw==?=
	<adriangarciacasado42@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Bough Chen <haibo.chen@nxp.com>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH v4] mmc: sdhci-esdhc-imx: consolidate imx25/35 data
Thread-Topic: [PATCH v4] mmc: sdhci-esdhc-imx: consolidate imx25/35 data
Thread-Index: AQHctrGnW+hHY5stjkakNSME+M8jZQ==
Date: Wed, 18 Mar 2026 08:31:45 +0000
Message-ID:
 <PAXPR04MB8574B62A7894FDF287EA86A6ED4EA@PAXPR04MB8574.eurprd04.prod.outlook.com>
References: <20260317193309.14091-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260317193309.14091-1-adriangarciacasado42@gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8574:EE_|AS5PR04MB10042:EE_
x-ms-office365-filtering-correlation-id: 11e1bb5f-86fe-4f4a-c738-08de84c8ca53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 OUsP8hEQQoIYGsOE4MnJOBBoLahj+pPdSE9O8osXs7REaYZMsEquZmQw6fUJHd0IpBtOxgfWN1Gde4I9suwoqTcynI3WManY5edt1fxHKt20Yi8PJKXY01jKuF+Wy5nShgtMFRAfmfjBq98pGiNp2FenM+xzoxGWGH9pYrSlOGPSq6qn5s6DxPN/ZJ12TjaurFrZOO1hYg8HrZC2mmfQDRzyWiAz//+e/9Ci+UKXkB6nxK1vHx0CA4MzPhV089Auhbs3U1jMnZkWe3NV8Flcy3p4JY7qocrJbaClReg9aFSWChyMIxZ5HHFzqSS8jsPtj9O/dJw3DLAq+ERaUiVVNY90VAj0BAH+hpyKdV4CUkGGfClV7taSI9neGDBOoOK7gNK2pr18p+E8Wq1Ef3ABH79x62Tj2AUKYOu3D7DZCYC26jBjb5O0V49qRgYKX21lDMSypgASxKigRulLwyucSYio8esyLXqFEshmJGQu4rVZDNcY9twJ96C3fbz3w95AUtdL0WzSKEFVpbOlQJwoC9W6RDW9KJyInLMNtEqCPI7nfA3osiUYdEv1XV0CTDbAL2UUedHVFHXDR8YKjsbrb2tEoC9+P5PrLdaEvoEC9qS6cyz7pgJ5pPNtqhiDsO7sPCmUPLnZBIsFYSHMT+eSWpmmIZh7HYGV10VwPxVXThz6o94bkHd49/6v7GYAlBWq2CG/nPYRiV9yoCiYmTBuDDrPFB+hJlGbbrdzAuM1QIKZDn6bBqxEpZgrbahgMAfUEyRtAPLIjlEshVlTZL6P2uC2srhEGS8WvK2iLKlaa44=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8574.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1VsMzdveXZGZXBNeXNBWnJxOVNXeDd2OWZENHJFY3dJbDdpRlJwVHAvdnNk?=
 =?utf-8?B?ejEvV2ZFbS9RS2JTZWttaEJIRVlHRkJMMXZzTVAxL2lERSszcE5zWjAwOFlh?=
 =?utf-8?B?MXV3eXZGOUlScDFRVnNtRWlnS0FJc2hDZU5YenhzU3UwYStsOXB5N1EvNStp?=
 =?utf-8?B?ZHVMbzRMUTB6SUhkektFR2JXZ3J0N2xLcENncWZTK3ljMXVER0hpcER5c1Ny?=
 =?utf-8?B?ZzJIRjBTWHJNWVdvN0k3OGYvRHVuSkR3blk1aUVIN090bnV1QVpIOTNDNjlp?=
 =?utf-8?B?NGhQMzJlR3ppdVBPZEUwYnp3UWNiaEYyOHFweFdNaTQ0VjRiTmxOZzJuY2Ft?=
 =?utf-8?B?OU9BMkhNRW1Va0NvTFFTbWUrblhGemNSSWpDTDlUcFBYQ28yZS9NS2lnK0p2?=
 =?utf-8?B?U1ArQXRCY2xPSGRoUFU5NzdHUThkVENvUzF2Vm5rL1IyOGVSK0Q5S05MNVVK?=
 =?utf-8?B?RG9SZ1ZybXFDUDZMeXE1MUZQL3FsaFFieVVCWHR0SktjeUdZSzdpbHpvaGVR?=
 =?utf-8?B?SjFaNXZYeGZmeGhOU0RnS2FZcDVLUEU2bWluQUZLQ3hQT285ZnVtRVhuQmw2?=
 =?utf-8?B?Q1lrM1VzYVllR3c3VlhyenJKSEh0emZrOXpzc2hGVUV2NjgxeGdEUzRQbEQ4?=
 =?utf-8?B?d0FoZS9qc1pJYUMzSmVPdkpxU3FFbitGU1VxSEtYOEhySWpGV1JxT0xKcytm?=
 =?utf-8?B?eUFRSWRadC9obnZWcDdqcnA3OFErbEYzN3JUMk9oQnJGbnVYNzlPQlBuMVdi?=
 =?utf-8?B?cFZncTZCVDF3aFBxMC9HWlJrTkJRZlRra0Q3T21EaSsyMExMb2l5cXBIanRj?=
 =?utf-8?B?ekc3RVZBbmVhUWZwcGhQTDdra0h3alk5SHkySHl4NG9VWE9UNVAyRFpjWVMy?=
 =?utf-8?B?TThaUjBkRm9FNi9hTGZtZGFCQ2E3L3RSVlhWQy9HRFBrTU5NQ1MwOU10dkZz?=
 =?utf-8?B?UzhrYlZ5R0tCS2dWVDdWQ2EvODlLSFdjaDhkVXIwVzMrRjJVWTdNOXNVZ0hS?=
 =?utf-8?B?dnR1cFByaHdBVytCRVVHVzNobm1SbVdSYkoxYVFRWFViN0xFemludlVWTmpv?=
 =?utf-8?B?azRwWGhXMVF2WDI1a09tM3VWdldMbVFrcDNaaDVocVNFZjByci9MRytsZG5q?=
 =?utf-8?B?Z0RuZzVKeXFhZ29ScUpKbnNKTXZuM1BibkNKZmNpL2YzbHNPL0crTUllWTJH?=
 =?utf-8?B?TkFvc1JZOFBPZnRyNm1GMzZpRTdOQ1hkNTNzVjBSUXVrejMvcXMzeFRhQ0g0?=
 =?utf-8?B?bEcvVjNEdzliNjRnandULzBhV1k3M3YwYW9oNW1wQi9MWW9acnhxcFVjTjhD?=
 =?utf-8?B?S2lyM2RjT1FkNElPN1kwMlVGNjQ4SEpXMmpUWFdIR1VBN09NeHpxVTZoNDZi?=
 =?utf-8?B?MDUvakRoTUFDZ2l6SzlIQnVMNko5Tzg4QmdhZzVpT2hRc3B3SzFaUXZzTk94?=
 =?utf-8?B?Sk1nSEl6Sm4vR3pSbGk4bHZTSlNrQ0c0cUZaUkgyL2prQVBhUEw1QWZOM05k?=
 =?utf-8?B?UVVTKy83YnZFWVg4WXVua2IzY2hGMDFleVpYQnkyM0lyN25tNTEzSmU2dGdO?=
 =?utf-8?B?YStzeHlZREZ5YjVNcW04d0FsaDhRcnpJSFhCVUxIck1rcTNBUlNuajR3NldS?=
 =?utf-8?B?NHM5QkY4cHBqVU9Fa04yYXB3bjRPNy85YldOTXpPcmI4d0FqR2Npak9OVDAy?=
 =?utf-8?B?eVJ2em0ySkZEZTM1TXJKc0RRRERLbjV4SkNWYmt4QkkzMGJoaXlaRVJENitp?=
 =?utf-8?B?NmZZQzByTU9oRUp5Zmk4dEYydGplZVhNNThQQjRGWGlzYmdlKzZoNWFJVzVN?=
 =?utf-8?B?em9tR2FkNHp2cHUzWlVSdWxjVXVzWnJ0dmRVc0FLUFBLU3VDeVVvOVo1amhW?=
 =?utf-8?B?M2NpdVcvZjViYlQvMGVQNjV6OEdEVXppSDNRRld4RklDb1VkdjBxRkJaVjh5?=
 =?utf-8?B?eWhaNVZjbElENDBVdzRESDVoNnRnYitqcGg0M29zaHRIMmtic1lheFdEQ0Vu?=
 =?utf-8?B?QzA5RXRZcmxjQ2l3ZUQ1Y0RDcVFvQkRLSUttTnRnSmlsVzdMVm9ybDJZWmJY?=
 =?utf-8?B?cEEwdzFmd0lRN3FLK1YyMWdITzhwN2FtNEQ5S0tZTmc5TU5IZWNOd3oyTVg0?=
 =?utf-8?B?MlpKY0p2cExhUHA5Q2UyKyt4RXh6THdidld6Rnlxc1NtRENDOU9RTjI1RnlP?=
 =?utf-8?B?TXZ0ckY1cUJ4dCtjWXdGQk14Nk9FNGdOaTlRVGlhK212NU1ZTC9WcE1nSFRk?=
 =?utf-8?B?ZVNJNC9zTzU1WjNiSEhUL2ljQzF4Z1Q0TFQ0VnlRYXN4MlUzZDZtRmVOV2Rj?=
 =?utf-8?Q?QXZtAqkW5kPGgoVMTl?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8574.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e1bb5f-86fe-4f4a-c738-08de84c8ca53
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 08:31:45.5697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjIhfKhEGkhbYnwz9STFJaQGhxrH9GLefkZYw9pgtfn7kqck7qzktp4oUmVyCpJay9BhOTliv1a0DCIg6H/ntg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyacOhbiBHYXJjw61h
IENhc2FkbyA8YWRyaWFuZ2FyY2lhY2FzYWRvNDJAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIE1hcmNoIDE4LCAyMDI2IDM6MzMgQU0NCj4gVG86IFVsZiBIYW5zc29uIDx1bGYuaGFuc3Nv
bkBsaW5hcm8ub3JnPg0KPiBDYzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgRnJh
bmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXgu
ZGV2OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBNaWd1ZWwgT2plZGEgPG1pZ3VlbC5vamVkYS5zYW5kb25pc0Bn
bWFpbC5jb20+Ow0KPiBBZHJpw6FuIEdhcmPDrWEgQ2FzYWRvIDxhZHJpYW5nYXJjaWFjYXNhZG80
MkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFtQQVRDSCB2NF0gbW1jOiBzZGhjaS1lc2Ro
Yy1pbXg6IGNvbnNvbGlkYXRlIGlteDI1LzM1IGRhdGENCj4gDQo+IENhdXRpb246IFRoaXMgaXMg
YW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBv
cg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3Nh
Z2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gQ29u
c29saWRhdGUgZXNkaGNfaW14MjUgYW5kIGVzZGhjX2lteDM1IHNvYyBkYXRhIGludG8gYSBzaW5n
bGUgc2hhcmVkDQo+IHN0cnVjdCBzaW5jZSB0aGV5IHNoYXJlIHRoZSBzYW1lIGZsYWdzLiBUaGlz
IHJlZHVjZXMgcmVkdW5kYW5jeSBhbmQNCj4gc2ltcGxpZmllcyBkYXRhIG1hbmFnZW1lbnQgZm9y
IGkuTVgyNSBhbmQgaS5NWDM1IFNvQ3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBZHJpw6FuIEdh
cmPDrWEgQ2FzYWRvIDxhZHJpYW5nYXJjaWFjYXNhZG80MkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDEyICsrKystLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIGIvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS0NCj4gZXNkaGMtaW14LmMNCj4gaW5kZXggYTdhNWRmNjczLi45Y2ZhMjY3
MjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4g
KysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMjU2LDExICsy
NTYsNyBAQCBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgew0KPiAgICAgICAgIHUzMiBxdWlya3M7DQo+
ICB9Ow0KPiANCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgZXNkaGNfaW14
MjVfZGF0YSA9IHsNCj4gLSAgICAgICAuZmxhZ3MgPSBFU0RIQ19GTEFHX0VSUjAwNDUzNiwNCj4g
LX07DQo+IC0NCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgZXNkaGNfaW14
MzVfZGF0YSA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgZXNkaGNf
aW14MjVfMzVfZGF0YSA9IHsNCj4gICAgICAgICAuZmxhZ3MgPSBFU0RIQ19GTEFHX0VSUjAwNDUz
NiwNCj4gIH07DQo+IA0KPiBAQCAtMzkxLDggKzM4Nyw4IEBAIHN0cnVjdCBwbHRmbV9pbXhfZGF0
YSB7DQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteF9l
c2RoY19kdF9pZHNbXSA9IHsNCj4gLSAgICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXgyNS1l
c2RoYyIsIC5kYXRhID0gJmVzZGhjX2lteDI1X2RhdGEsIH0sDQo+IC0gICAgICAgeyAuY29tcGF0
aWJsZSA9ICJmc2wsaW14MzUtZXNkaGMiLCAuZGF0YSA9ICZlc2RoY19pbXgzNV9kYXRhLCB9LA0K
PiArICAgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDI1LWVzZGhjIiwgLmRhdGEgPSAmZXNk
aGNfaW14MjVfMzVfZGF0YSwgfSwNCj4gKyAgICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXgz
NS1lc2RoYyIsIC5kYXRhID0gJmVzZGhjX2lteDI1XzM1X2RhdGEsIH0sDQo+ICAgICAgICAgeyAu
Y29tcGF0aWJsZSA9ICJmc2wsaW14NTEtZXNkaGMiLCAuZGF0YSA9ICZlc2RoY19pbXg1MV9kYXRh
LCB9LA0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDUzLWVzZGhjIiwgLmRhdGEg
PSAmZXNkaGNfaW14NTNfZGF0YSwgfSwNCj4gICAgICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxp
bXg2c3gtdXNkaGMiLCAuZGF0YSA9ICZ1c2RoY19pbXg2c3hfZGF0YSwgfSwNCj4gQEAgLTQxNCw3
ICs0MTAsNyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpbXhfZXNkaGNfZHRfaWRzKTsNCj4g
DQo+ICBzdGF0aWMgaW5saW5lIGludCBpc19pbXgyNV9lc2RoYyhzdHJ1Y3QgcGx0Zm1faW14X2Rh
dGEgKmRhdGEpDQo+ICB7DQo+IC0gICAgICAgcmV0dXJuIGRhdGEtPnNvY2RhdGEgPT0gJmVzZGhj
X2lteDI1X2RhdGE7DQo+ICsgICAgICAgcmV0dXJuIGRhdGEtPnNvY2RhdGEgPT0gJmVzZGhjX2lt
eDI1XzM1X2RhdGE7DQo+ICB9DQoNCkkgdG9vayBhIGRlZXBlciBsb29rIGF0IHRoZSBoaXN0b3J5
IHJlbGF0ZWQgdG8gbXgyNS4NCg0KVGhlIG9yaWdpbmFsIHVzZSBvZiBpc19pbXgyNV9lc2RoYygp
IHRvIGF2b2lkIHNldHRpbmcgRE1BIFNFTEVDVCBiaXRzIHdhcyBiZWNhdXNlIG14MjUgZG9lc24n
dCBzdXBwb3J0IEFETUEsIGludHJvZHVjZWQgaW4gY29tbWl0IDlhMDk4NWI3OGQ3MC4NCg0KSG93
ZXZlciwgYmVmb3JlIHRoYXQgY29tbWl0LCBpbXgyNSB3YXMgYWxyZWFkeSB1c2luZyBTREhDSV9R
VUlSS19CUk9LRU5fQURNQSB0byBkaXNhYmxlIEFETUEgKGNvbW1pdCA5N2U0YmE2YTVlYTkpLCB3
aGljaCB0aGVvcmV0aWNhbGx5IHNob3VsZCBwcmV2ZW50IHRoZSBETUEgU0VMRUNUIGJpdHMgZnJv
bSBiZWluZyBzZXQuDQoNClRoZSBhY3R1YWwgcmVhc29uIERNQSBTRUxFQ1Qgd2FzIGJlaW5nIHNl
dCBpbmNvcnJlY3RseSB3YXMgZHVlIHRvIGEgYnVnOiB1MzIgbmV3X3ZhbCB3YXMgdXNlZCB3aXRo
b3V0IGJlaW5nIGluaXRpYWxpemVkLCBjYXVzaW5nIERNQSBTRUxFQ1QgdG8gcG90ZW50aWFsbHkg
YmUgc2V0IHRvIHJhbmRvbSB2YWx1ZXMuDQoNClRoZSBuZXdfdmFsIGluaXRpYWxpemF0aW9uIGlz
c3VlIHdhcyBmaXhlZCBpbiBjb21taXQgODFhMGE4YmMzODBkLCBidXQgdGhhdCBmaXggd2FzIG1h
ZGUgZm9yIGEgZGlmZmVyZW50IHJlYXNvbiAtIGl0IHdhcyBub3QgcmVjb2duaXplZCBhdCB0aGF0
IHRpbWUgdGhhdCB0aGUgRE1BIFNFTEVDVCBpc3N1ZSB3YXMgYWxzbyBjYXVzZWQgYnkgdGhlIHVu
aW5pdGlhbGl6ZWQgbmV3X3ZhbC4gQXMgYSByZXN1bHQsIHRoZSBpc19pbXgyNV9lc2RoYygpIGNo
ZWNrIHdhcyBwcmVzZXJ2ZWQuDQoNCkFmdGVyIHRoZSBuZXdfdmFsIGluaXRpYWxpemF0aW9uIGZp
eCwgaXNfaW14MjVfZXNkaGMoKSBzaG91bGQgbm8gbG9uZ2VyIGJlIG5lY2Vzc2FyeS4gU28gbWVy
Z2luZyBteDI1IGFuZCBteDM1IGlzIGluZGVlZCB2YWxpZC4gSWYgeW91J2QgbGlrZSwgeW91IGNh
biBnbyBmdXJ0aGVyIGFuZCByZW1vdmUgdGhlIGlzX2lteDI1X2VzZGhjKCkgcmVsYXRlZCBjb2Rl
IGVudGlyZWx5Lg0KDQpSZWdhcmRzLA0KTHVrZQ0KDQo+IA0KPiAgc3RhdGljIGlubGluZSBpbnQg
aXNfaW14NTNfZXNkaGMoc3RydWN0IHBsdGZtX2lteF9kYXRhICpkYXRhKQ0KPiAtLQ0KPiAyLjQ3
LjMNCj4gDQoNCg==
