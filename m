Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2EF420E8E;
	Mon,  6 Jul 2026 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318942; cv=fail; b=DjqtoKxrBXPfRd4jcwgD8lnZz8XhpXf0p/W98Uf8ProELarGzL8xxUFbvBlDkZVzK1j6cLzk1qQVDf4IJ5djVBsAP4JoHT12WbRAp89ltHnbCbZ0z88Q2MKVB3rim1V2RCyVBW4nptZm4cTXJ3CX26qyGHLUpSU1LMQTjWYIuGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318942; c=relaxed/simple;
	bh=bVD35WN2sB4JMe9ms1NZbnw7YZX6BuWI9rbJMj4Oyjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dA4ucYKQDwdl75OMUT2cnbuRQpNbuPfpW4MKJOKHcNaxXj5euoIo75bs3du4EAVubhmJdYOxkOz4/ga5nXqRnpZwjfxCZ8vKPOW4HOonOUy0FxMLT1+Ea2YA+sVy59OneQUJxaPwyxMWSvS/TAS7AbAJzYbFr6Ze2OwWB4nMHPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cf/u/rwO; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cf/u/rwO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8gNuHcRa7SSuxgBO2eZPb3RrivyxOORvf6PDkvjdSJOx/w8VFtc1SsNutiuZINsoB6AZbPP0KYfxP5gFGvk1CMMvRcQJ6ukQRjVfo48Qoeivp0VBXN8pIAerEqa+sHc1zQ6Udks9E8682haZMVyaclkc6D+7t/DCJuw29NObZsUlGFrap9bKgJ5ELvAATco26BQdTthyCEtQJ1frl49EnZ0xG/S33nQgv9wAGShTPqRQg0dgfu35vN2GK731kqcWhjOsrZourM2tThXJMnFH1qMaAxHsgxqh6GtbvHY39IzfJXGAa5lMDerNZ/7piOAXs5d3mHEAm/iahjNHBNdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVD35WN2sB4JMe9ms1NZbnw7YZX6BuWI9rbJMj4Oyjk=;
 b=dPgCE8oXYR0VjrNfUMbjQFHY5uS7SuT0I/4wlV/wjqk+khydfpPZXs17/n2li4faw3D5S+o4O2TaJ9sReI4G+/oDa2Q3yW31VUsReB3PHihh8TZZxn1kJgTKUs3Zd01F6uZouNU0azkvZgoD0m4I5rOLOHhiihfTYAGV4/Wj67IZf1QgjuI/Fkm3kU72doV9Jp65Gxi3NB/CY/t+9yFYnJENBu/73+KDJMgunMN62/AWnmR5iOtlMWgpPyHrVrsSGu5j27moFqcCIVolMg6AftgkRP4pLAYDkA7lviovwiKmr5E4Xfi3r7m9qsXYTAkEjdokIgsC2VHZs9tly5poLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVD35WN2sB4JMe9ms1NZbnw7YZX6BuWI9rbJMj4Oyjk=;
 b=cf/u/rwOz43JV6kfcA3fg9eugGbr1VV4IV3lQ6EiMeTGgr+0FaBDKED+UgSmbIxq+dL1Bc+08+CK91l11Umwjs6f/s+aoYWm+Z7uT9oUQxNVtSP4t1Wk7GJm2J0LCLgPDfNQcvUOgPE7UQcXZ/PnEzoSFUpLNa75pGpLuA0ewv6zQ/CTyHx0/hqMVT2hGowl5yjL7sQz0qVvRe89eLVhYgIif2viPBqNAq41IC1cmSbJXTo2B4IRnXMQxKjsxsGXJWa2ViBoDjUB4OlYPfcoe0ioh0gWhq8y7GmKKue/TMEj9YTSagXjG/VHpgK75oG51Bl7hM1S4uhKiYlGoW4uyQ==
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21)
 by VI0PR04MB12135.eurprd04.prod.outlook.com (2603:10a6:800:324::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 6 Jul
 2026 06:21:58 +0000
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f]) by AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 06:21:57 +0000
From: "Luke Wang (OSS)" <ziniu.wang_1@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>, "Luke Wang (OSS)"
	<ziniu.wang_1@oss.nxp.com>, "ulfh@kernel.org" <ulfh@kernel.org>, Bough Chen
	<haibo.chen@nxp.com>, Frank Li <frank.li@nxp.com>
CC: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/7] mmc: sdhci-esdhc-imx: disable irq during suspend
 to fix unhandled interrupt
Thread-Topic: [PATCH v4 4/7] mmc: sdhci-esdhc-imx: disable irq during suspend
 to fix unhandled interrupt
Thread-Index: AQHdDQ+/YER166jN+U+NjNqZLdQxqA==
Date: Mon, 6 Jul 2026 06:21:57 +0000
Message-ID:
 <AM7PR04MB6870ECE26A02E0913BB4070BEDF12@AM7PR04MB6870.eurprd04.prod.outlook.com>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
 <20260703104208.3426374-5-ziniu.wang_1@oss.nxp.com>
 <0b8c3e61-e0d8-46dd-8c91-e793310087ab@intel.com>
In-Reply-To: <0b8c3e61-e0d8-46dd-8c91-e793310087ab@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6870:EE_|VI0PR04MB12135:EE_
x-ms-office365-filtering-correlation-id: c3630a03-14e2-4303-ab44-08dedb26e1e2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|23010399003|38070700021|4143699003|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 V8OEwGFxT+Jhq3EyQwOW5os90itSbp8k9ZkNzOPwDoWSztw9TJJCMRl0UJiZ323UtWtiDmHNAUQe19h+c3pdhpqMyme9sDua1eV/eHajDj61HGr7gxvZ6w9wtfdmCMO9U9vOLvkB9tpPaqYYFuJ4/eLTEbnmsk3U0ry1cnzhlYNeANy/nmdLDZSffgwDvG5/wyc3GdkWJq1TGbV6Dgs62vy6HZNuEpPUWyG5PU5YDRVhnQNt21vFEqhzSDsp6UN/jxqcU6A9SmS9EwJvvMnWwZbdNRV8li49abMzUkZHScZkWlr+VKpK9fAb3khv4M/QQKUhBDziHpfpYaVa0RbDOK4dU4I2sYQ8JKFfYsXfXi8LUGQvPFUtA4ua7AeIbz7EEOQ1VHWlHJTeCuV/XzQe1pObjEJFHqmmacMWFA/mk65hruDz4EUIiOA8cK9oo0uhgH4JuLgj0ddrBQRhLwPKWRDunmqh91xaBKvvFFB65FM63TuA4fyp4KRnp6h/mQi0nh5wXY2EQDp+0La7xeZ286VrWRd286ascto5aI2C+MPYluNzhXoUyvZ1VWXdtfXtEdPm8JSJRoefIbAivA1FCt6+vISrPfPCDwRsax3p1xzhdmfJACTeQ/YUPnCd5qakfaNCIVeaJHdViqD6SKhMgqTyx6UfOjrIfZIf8Wd3/Y99ZUhUeDwwGd2ohHeTFDpHsPZAna0Pg6rhD8wwTAmrjjc2sFH+VptPzKxNOJeFk4U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6870.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(38070700021)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2ZEM3pvOGFOK0RMK1pUcUxkZElqQjFQMG1Td1VGclRCWWc0SE1MVXJEUTh2?=
 =?utf-8?B?VWFXRkdlZ0lFMjZaVlJRc1l0UWZ5V2VQU2U4T2k2eDFCVmZSbGVNTW1aUTBt?=
 =?utf-8?B?MUVZTUJ1dUtvYzZZSkVvZmdONjhkcnBMQWpnNGhVazJQMWR1TEdITkFaMCt4?=
 =?utf-8?B?bCtmSHBubE9wU3VsOXdYUFU0M2hTcjdTRkN6TXZ5cnhCMFo3UFdYUUJaUG4w?=
 =?utf-8?B?cEorY053bCtOeDhuYXlKRjVFelBydW5PMnkzU0ZwRkg2eVZOV3BySzhHNVBq?=
 =?utf-8?B?Sk40Zkszb1JkWVN6MEJqWUsxMkxWa0ttcEEwS3RvRCtRTDFiRGxLbytxQzBh?=
 =?utf-8?B?M3V4TnhOSWNieWdnaHhYNTdLNlpGSXVnNk5kZHNPM01MekVMUGJhaDJTNjJz?=
 =?utf-8?B?MURUSkN6T0RMd09FU2R3KzY5UFRvWC9GbldNckRlOVRHYm8vL2hCemJCWFFS?=
 =?utf-8?B?RENObUc4dnA2dGVQbW1LdUdaSUpsQzMyU1pzdHUxR044emprbkhoQmxzYzZR?=
 =?utf-8?B?SmFDVVlkcmZCaTlyTlEwR2F0YVpwQm0yRXVQQnhLTVhNMzZBVHdhRW9PVTl1?=
 =?utf-8?B?RUpOUnBqak9tTTBuS2tlS1hjY0JqcE9WY1k1TlNRdEJzejAxUjNvU0wzSytp?=
 =?utf-8?B?ZG5IalNMcFp3QTU3a0ZNSEM4TmpXemNMdHQyNHZOanRWTEZaVnBWRzBEM2dv?=
 =?utf-8?B?YU5yTG55WitBeHczcW5kYmVaRXVZcmFGNlhHWnY3QTBkZ1lad2xWbkQyYlN1?=
 =?utf-8?B?WWVLd2FYUWlrVzFVRW1EbS9ab25QcGpvOVozOFVydUpSZWpVNU9GVEFrMDlh?=
 =?utf-8?B?UklaRjVocTFzUW5UWG1aUVFXWHc4TTdDdFBxaGM1bkhJYmc5cTNtMmRIZU9V?=
 =?utf-8?B?OCtHcS93MmJZUUlIeXoyTW9aQWFGekNpQUFLN1JhTXkxMkpMNko4U1dTWE1l?=
 =?utf-8?B?emJNUmRqcGQvV0N1a1VGemxiTldPVzI2SmRBTGY2LzJZa0tNRkc2N3MxSXVm?=
 =?utf-8?B?VUtMZW1Pc1FvcDU5S3VjWGRaelRTbWV5NjRpYWhxTHpNWlFzTHhiTFBrd2Ur?=
 =?utf-8?B?Q2FNMUN2b1Y0Zkh3cFdIVGpuT3Z6OTBFQWhzaDF0QmI5TDZoa0l4ZnRNVFZz?=
 =?utf-8?B?M0UrVVgrdk5GRFYvYkhnQUFMZ2dmUTBNRTJIRzNuVCtXTXBpYWdmTnE2azJo?=
 =?utf-8?B?Zy9ScmM2NFZ3aUhibDc3R216b3BVSGZac0tPeW04dzR1S21qZkpUL1J3aVNG?=
 =?utf-8?B?WkxMckNSWlZpZTJtU2MzUnhzSjR2MERzZGR2YzVGcUZuUmx6MkVZcis0R1lX?=
 =?utf-8?B?NmZQSEhZRzc5QXBVMi8xMitCRC9kSXhnVG4wU2VqQnJ1SHNtRUtiR2ZMNVVJ?=
 =?utf-8?B?Ni9aUGJ6MXVGcy9ySmUxbUJDSXRxRUdvcUovN0lmVEZINmc5dDZSSkxBSzVM?=
 =?utf-8?B?OTZEQnd0NFZqQnV6dEhDeU9zbTNzYWUwaFRWaG5PMTFrcXA5cmtlMVV4a3hN?=
 =?utf-8?B?R2JoRjA0cjFLNVg1RzZoZjVITS9lOWdOb2w4MlJhSEFuZ0F2U005ZTNBcndL?=
 =?utf-8?B?MVhjTi9nSHhkTm1iZ1VQR2N6TEMxdWppa1FnQVNWeWc1SkNiS3RPL3U4WG5z?=
 =?utf-8?B?MzFGeGIvS3FMVXA4SjlwemIyNVorTGovSGtrWS9aVE5yWU1rcG0zd3VmemUw?=
 =?utf-8?B?Y2UzcFFybzBMRGtob0VWeEZqZWZzQWJKQ2tyZ2l3d3llTU1lUVIyem1zSHZ5?=
 =?utf-8?B?b2RIdGJ1YTNRa1RMS2g5dG5vREg0ZmVnSDNhRXNTZjh4SDRqUTViUktZS2dH?=
 =?utf-8?B?Nmo0bzhvQzE3b1hwK2hYZVAvKzl6QU1TcnRoWnVYcm1sS0FCUExnUlZWQzRU?=
 =?utf-8?B?bDVFVGt0M0VKWGc0NXFYcWxVRkNjNzVRNXRzRTU5V1V1bUFCODlCdnJWbnVH?=
 =?utf-8?B?ZGNrOExkT3hiMTJmMis4eEJFV0NxM2FhR3hvc21saGpOUEltUm5aeHVPZXd5?=
 =?utf-8?B?THN6TGxSSVNLQXdXUWNnVWNabm0relpOQXJLRHcrWEhXOERMN1JKcFZrNTB3?=
 =?utf-8?B?elVRNUVkYTRyZGNmU2JTVG5YN1F6UG1LTmRRcXorSUxZYmFKUVNkWFdUWG5V?=
 =?utf-8?B?K0xtck81Y1RLTjhlaVJMMUV2ZyswQ1JRWXVCcUFMSWVLZkQvWUh0S1JsRHZm?=
 =?utf-8?B?NlVqd1dDbjZyUkdvaFlUNERXMVR0a2NVMWY3bkgzZ3F5UmFqcXFBbTVjWHVL?=
 =?utf-8?B?Z01yZ0FreUpkUGRSaHN2STlPU0dKd1FIVHVzVGtCbzU2RFBOMWJBenZaQTNP?=
 =?utf-8?B?VVhXUE1GOHdVMm5JdmhhQVBjMFVQT2tXc25UOStSejIyeWZVWEVyQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6870.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3630a03-14e2-4303-ab44-08dedb26e1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 06:21:57.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOYe35c3KGkJnhRnDT1003PvKuOJNi1C4HNiQqnVprqlxKn7Bz3lWZCDonGHRp04dvn0fTRkPTMV5t/i93fGLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12135

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgSnVseSA1LCAyMDI2IDQ6
MzAgUE0NCj4gVG86IEx1a2UgV2FuZyAoT1NTKSA8emluaXUud2FuZ18xQG9zcy5ueHAuY29tPjsg
dWxmaEBrZXJuZWwub3JnOyBCb3VnaA0KPiBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBGcmFu
ayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gQ2M6IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBpbXhAbGlzdHMubGlu
dXguZGV2OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBkbC1TMzIgPFMzMkBueHAuY29tPjsN
Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNC83XSBtbWM6IHNkaGNpLWVz
ZGhjLWlteDogZGlzYWJsZSBpcnEgZHVyaW5nDQo+IHN1c3BlbmQgdG8gZml4IHVuaGFuZGxlZCBp
bnRlcnJ1cHQNCj4gDQo+IE9uIDAzLzA3LzIwMjYgMTM6NDIsIHppbml1LndhbmdfMUBvc3Mubnhw
LmNvbSB3cm90ZToNCj4gPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0K
PiA+DQo+ID4gV2hlbiB1c2luZyBXSUZJIG91dC1vZi1iYW5kIHdha2V1cCwgYW4gImlycSB4eHg6
IG5vYm9keSBjYXJlZCIgd2FybmluZw0KPiA+IG9jY3Vycy4gVGhpcyBoYXBwZW5zIGJlY2F1c2Ug
dGhlIHVzZGhjIGludGVycnVwdCBpcyBub3QgZGlzYWJsZWQgZHVyaW5nDQo+ID4gc3lzdGVtIHN1
c3BlbmQgd2hlbiBkZXZpY2VfbWF5X3dha2V1cCgpIHJldHVybnMgZmFsc2UuDQo+ID4NCj4gPiBU
aGUgc2VxdWVuY2Ugb2YgZXZlbnRzIGxlYWRpbmcgdG8gdGhpcyBpc3N1ZToNCj4gPiAxLiBTeXN0
ZW0gZW50ZXJzIHN1c3BlbmQgd2l0aG91dCBkaXNhYmxpbmcgdXNkaGMgaW50ZXJydXB0DQo+ID4g
KGJlY2F1c2UgZGV2aWNlX21heV93YWtldXAoKSByZXR1cm5zIGZhbHNlIGZvciB1c2RoYyBkZXZp
Y2UpDQo+ID4gMi4gV0lGSSBvdXQtb2YtYmFuZCB3YWtldXAgdHJpZ2dlcnMgc3lzdGVtIHJlc3Vt
ZSB2aWEgR1BJTyBpbnRlcnJ1cHQNCj4gPiAzLiBXSUZJIHNlbmRzIGEgQ2FyZCBpbnRlcnJ1cHQg
YmVmb3JlIHVzZGhjIGhhcyBmdWxseSByZXN1bWVkDQo+ID4gNC4gdXNkaGMgaXMgc3RpbGwgaW4g
cnVudGltZSBzdXNwZW5kIHN0YXRlIGFuZCBjYW5ub3QgaGFuZGxlIHRoZQ0KPiA+IGludGVycnVw
dCBwcm9wZXJseQ0KPiA+IDUuIFRoZSB1bmhhbmRsZWQgaW50ZXJydXB0IHRyaWdnZXJzICJub2Jv
ZHkgY2FyZWQiIHdhcm5pbmcNCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IHVuY29uZGl0aW9uYWxseSBk
aXNhYmxpbmcgdGhlIHVzZGhjIGludGVycnVwdCBkdXJpbmcgc3VzcGVuZA0KPiA+IGFuZCByZS1l
bmFibGluZyBpdCBkdXJpbmcgcmVzdW1lLCByZWdhcmRsZXNzIG9mIHRoZSB3YWtldXAgY2FwYWJp
bGl0eS4NCj4gPiBUaGlzIGVuc3VyZXMgbm8gaW50ZXJydXB0cyBhcmUgcHJvY2Vzc2VkIGR1cmlu
ZyB0aGUgc3VzcGVuZC9yZXN1bWUNCj4gPiB0cmFuc2l0aW9uLg0KPiA+DQo+ID4gRml4ZXM6IDY3
NmE4Mzg1NTYxNCAoIm1tYzogaG9zdDogc2RoY2ktZXNkaGMtaW14OiByZWZhY3RvciB0aGUgc3lz
dGVtIFBNDQo+IGxvZ2ljIikNCj4gPiBSZXZpZXdlZC1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hl
bkBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54
cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMg
fCAxMSArKysrKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktZXNkaGMtaW14LmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLQ0KPiBlc2RoYy1pbXguYw0K
PiA+IGluZGV4IDNiMWU2MzQyNWExOS4uYWRlOTlkYWJkYjVmIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gQEAgLTIwNzUsOSArMjA3NSwxMCBAQCBzdGF0aWMg
aW50IHNkaGNpX2VzZGhjX3N1c3BlbmQoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiA+ICAJaWYg
KG1tY19jYXJkX2tlZXBfcG93ZXIoaG9zdC0+bW1jKSAmJg0KPiBlc2RoY19pc191c2RoYyhpbXhf
ZGF0YSkpDQo+ID4gIAkJc2RoY19lc2RoY190dW5pbmdfc2F2ZShob3N0KTsNCj4gPg0KPiA+ICsJ
LyogVGhlIGlycXMgb2YgaW14IGFyZSBub3Qgc2hhcmVkLiBJdCBpcyBzYWZlIHRvIGRpc2FibGUg
Ki8NCj4gPiArCWRpc2FibGVfaXJxKGhvc3QtPmlycSk7DQo+IA0KPiBQcmUtZXhpc3RpbmcsIGJ1
dCBJUlEgc3RheXMgZGlzYWJsZWQgZXZlbiBpZiB0aGVyZSBpcyBhbiBlcnJvciBsYXRlciBvbg0K
DQpBZnRlciBwYXRjaCA2IGluIHRoaXMgc2VyaWVzLCBhbGwgZmFpbHVyZSBwYXRocyBhZnRlciBk
aXNhYmxlX2lycSgpIHdlcmUNCmNoYW5nZWQgZnJvbSBlcnJvciByZXR1cm5zIHRvIGRldl93YXJu
KCkg4oCUIHRoZSBmdW5jdGlvbiBhbHdheXMgcmVhY2hlcw0KcG1fcnVudGltZV9mb3JjZV9zdXNw
ZW5kKCkgYW5kIHJldHVybnMgMC4gU28gdGhlIElSUSB3b24ndCBiZSBsZWZ0IGRpc2FibGVkDQpv
biBhbiBlcnJvciBwYXRoLg0KDQo+IA0KPiA+ICsNCj4gPiAgCWlmIChkZXZpY2VfbWF5X3dha2V1
cChkZXYpKSB7DQo+ID4gLQkJLyogVGhlIGlycXMgb2YgaW14IGFyZSBub3Qgc2hhcmVkLiBJdCBp
cyBzYWZlIHRvIGRpc2FibGUgKi8NCj4gPiAtCQlkaXNhYmxlX2lycShob3N0LT5pcnEpOw0KPiA+
ICAJCXJldCA9IHNkaGNpX2VuYWJsZV9pcnFfd2FrZXVwcyhob3N0KTsNCj4gPiAgCQlpZiAoIXJl
dCkNCj4gPiAgCQkJZGV2X3dhcm4oZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBpcnEgd2FrZXVwXG4i
KTsNCj4gPiBAQCAtMjEyOCwxMCArMjEyOSwxMCBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3Jl
c3VtZShzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ID4gIAkvKiByZS1pbml0aWFsaXplIGh3IHN0
YXRlIGluIGNhc2UgaXQncyBsb3N0IGluIGxvdyBwb3dlciBtb2RlICovDQo+ID4gIAlzZGhjaV9l
c2RoY19pbXhfaHdpbml0KGhvc3QpOw0KPiA+DQo+ID4gLQlpZiAoaG9zdC0+aXJxX3dha2VfZW5h
YmxlZCkgew0KPiA+ICsJaWYgKGhvc3QtPmlycV93YWtlX2VuYWJsZWQpDQo+ID4gIAkJc2RoY2lf
ZGlzYWJsZV9pcnFfd2FrZXVwcyhob3N0KTsNCj4gPiAtCQllbmFibGVfaXJxKGhvc3QtPmlycSk7
DQo+ID4gLQl9DQo+ID4gKw0KPiA+ICsJZW5hYmxlX2lycShob3N0LT5pcnEpOw0KPiANCj4gSXMg
aXQgT0sgdG8gZW5hYmxlIGludGVycnVwdHMgYmVmb3JlIHNkaGNfZXNkaGNfdHVuaW5nX3Jlc3Rv
cmUoKQ0KPiBhbmQgZXNkaGNfc2V0X2RsbF9vdmVycmlkZSgpID8NCg0KRHVyaW5nIHN5c3RlbSBy
ZXN1bWUsIHRoZSBvbmx5IGludGVycnVwdCB0aGF0IGNvdWxkIGJlIHBlbmRpbmcgaXMgdGhlDQpT
RElPIENhcmQgSW50ZXJydXB0LiBUaGUgaGFuZGxlciBmb3IgdGhpcyBqdXN0IGNhbGxzIHNkaW9f
c2lnbmFsX2lycSgpIHRvDQp3YWtlIHRoZSBTRElPIElSUSB0aHJlYWQg4oCUIGl0IGRvZXNuJ3Qg
aW52b2x2ZSBhbnkgZGF0YSB0cmFuc2ZlciBhbmQgaGFzDQpubyBkZXBlbmRlbmN5IG9uIHR1bmlu
ZyBvciBETEwgc2V0dGluZ3MuIA0KDQpJJ20gaGFwcHkgdG8gbW92ZSBlbmFibGVfaXJxKCkgYWZ0
ZXIgc2RoY19lc2RoY190dW5pbmdfcmVzdG9yZSgpIGFuZA0KZXNkaGNfc2V0X2RsbF9vdmVycmlk
ZSgpIGlmIHlvdSBzdGlsbCBwcmVmZXIgdGhhdCBmb3IgZGVmZW5zaXZlIHJlYXNvbnMuDQoNClRo
YW5rcywNCkx1a2UNCg0KPiANCj4gPg0KPiA+ICAJLyoNCj4gPiAgCSAqIHJlc3RvcmUgdGhlIHNh
dmVkIHR1bmluZyBkZWxheSB2YWx1ZSBmb3IgdGhlIGRldmljZSB3aGljaCBrZWVwDQoNCg==
