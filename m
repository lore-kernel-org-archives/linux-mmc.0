Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.118
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501606;
	b=FrwkJbEqaLkps/4uWPtU57yud3D2lxPsmes7GQhOd8T4C+vOteBhYDoLQ+ULFJkB4tY1
	 uBMnmyIKXUY2bo2AaKwjF4EEIR/3c7R/emFRfznpxIFhSS/h6Du94EdnQy7TzuXyDViaz
	 VCrqIHhn1YoIt8Vpx1ZePDi874Esk3xY0h13jmB14kxWrPqzm6it6aCI/GUCL6ChODZh9
	 OF6PJ3peFLTUciCZe92B1qcJiFpyzR7x3Rf2d+9ItMd5Q0cjKaXuAT/aZv+ZuS3CvqL8n
	 PBPavE2Um6vlBRGkea8bsQXvAdwvaAzTll+JzpIijTS2dv0OsywFcn1mA/hPHSP5Zcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501606;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/BtYkM//xVaEGtvJLdof5MoWRVjYxKyMzKesLsvbD1Y=;
	b=U786k5zmPZ+vjcZ3bVNmrKbkbpqWGGJSLDnIQSIGDXqHChh9grNwxjaJm60yxAG1yKR+
	 6GiQscMLGwWxMk63+/EQyx7o11BUS6HkX1gpgzwqpmWRZh10v0fvcP6W3GX4n6Z1K3bAP
	 5Voslob7qTPVviux6GojV6G024t4P2BPpQJfdMpOuvn/C+3hlZuoYXhyj3WTpBnpiOtG0
	 kfrcEMtbtDMohJqpOALuKtpP5enuGiVyiIZ9FUT6hB1/W5mcjOdoXm913byHAP4el+qKU
	 2rNFgVrprfN3YKVzE+b8Wrrd0UZFaG+XSA124BlWxwPRue8bE1RIllwRd48FXRVJT1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lenze.com;
	spf=pass smtp.mailfrom=lenze.com;
	dkim=pass header.d=lenze.com header.i=@lenze.com header.a=rsa-sha256 header.s=selector1 header.b="PKp/OIJZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.118
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022118.outbound.protection.outlook.com [52.101.66.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5C606A334;
	Thu, 12 Nov 2026 16:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DA5C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenze.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenze.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lenze.com header.i=@lenze.com header.a=rsa-sha256 header.s=selector1 header.b=PKp/OIJZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHlX4d8hTVx2xvucaA8aTdw7H63fSuTe9kuSNY5yMhT7u8svNvgESUTuv+FPBdkNHfR3LLUqh+IofMqdcGWuRGl7MDkcjCkgTXX3nU8+j2gm5Wr3hw7lPzlyxw3lAChpuLQxodrF0rUVDUi5Ota8264gEsL4ShdHt22pTYZJHHkX6HFIAq/y8laXBUo2bh0cyBsXHP5u6zqU8BcweucYViNias4gLtswhL97vIzzh1UQrMi3GLHbBNMXZv7ln93b7z9+F+NBntdH95Gp7w+G6+XdnmKaL3G+T74LX05gIJap/zUI8r2OHnX2cqcgI0S4nY4DnBwoaTQu0BgoVZ4IUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BtYkM//xVaEGtvJLdof5MoWRVjYxKyMzKesLsvbD1Y=;
 b=DbK9vw6fFTpK7E+CeGhXQGcv5kSZRhaxzxceFtmkUlJ2MhttGJDQuRt2nkmO49LBm5WqxfWUzkVeKMR9/8maTxhRHaoTSdh8MnTyLQvbvQzx0aeIe3wR1BP+7siKZwMlIQW3Bq1cDpEM1HFqI99Aey85eAS5t5h3j3Xd4sjCAl6A6k11PI/cCNwlo7mXpGKf21hNeqtCv2Ksru2iaGqjm2br08Krh7BxfqzX2IWPkyusAEln0m15pERaziCNxGtt6DMba3i6x43BaxGuAh2W6TiuMAjeh3YUbtydWVp4fGrzRZxT7BZ3RkSjTI8Z8v2KLylif1Au+5jGjps+Q7cBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenze.com; dmarc=pass action=none header.from=lenze.com;
 dkim=pass header.d=lenze.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenze.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BtYkM//xVaEGtvJLdof5MoWRVjYxKyMzKesLsvbD1Y=;
 b=PKp/OIJZbUAHELFgmH9mNWtdiuVOFJpJ2m6PDj6NiraZLd2+szWenSPMsunHWgq9M6WP8YtOtDsZObJBWgUoEKvWx4Yzh1lMbtd7yJ5cfCdDYkI0R07zHzp4CGqEQdgBQq/xzDxIYpLxDhy+jfgnRmsnkMigtauhtSVFRAHEejmiOlWebRlX2lsnJlL2y5YQ9meUNUEnSA3y1eqOEgtLGhU1OfUJVaN4JUDeA4Ma6Bf+pt6z3VCraR4BPFNi/UazAtlzbbCPU2+QtzG3QkkJnWDmLJ/S420AWzTlhQ1b+RX/Tvuu6pSgxAc/ts4tX4UhFHlc7pBSf9sQ7wqy9tWgfA==
Received: from ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM (2603:10a6:910:da::23)
 by VE1P194MB0815.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:163::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 16:40:00 +0000
Received: from ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
 ([fe80::9250:9858:e034:cd34]) by ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
 ([fe80::9250:9858:e034:cd34%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 16:40:00 +0000
From: "Brandt, Oliver - Lenze" <Oliver.Brandt@lenze.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: "ulfh@kernel.org" <ulfh@kernel.org>, "jh80.chung@samsung.com"
	<jh80.chung@samsung.com>, "shawn.lin@rock-chips.com"
	<shawn.lin@rock-chips.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: dw_mmc-pltfm: Fix usage of phase_map for SoCFPGA
Thread-Topic: [PATCH v2] mmc: dw_mmc-pltfm: Fix usage of phase_map for SoCFPGA
Thread-Index: AQHdcop8Kq3NbDgfOE6cAIDLsGKrMbcqo9UA
Date: Thu, 12 Nov 2026 16:40:00 +0000
Message-ID: <541c0004866a37c4ae94114b53932e087ca2889a.camel@lenze.com>
References: <140317dff0feb9d62b580b1e3170ccb10b8af181.camel@lenze.com>
In-Reply-To: <140317dff0feb9d62b580b1e3170ccb10b8af181.camel@lenze.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenze.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR6P194MB918907:EE_|VE1P194MB0815:EE_
x-ms-office365-filtering-correlation-id: b4038b96-f80b-423b-dff9-08df40db9863
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261102130727099003|261026121527099003|261022105027099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info:
 ZX9JAOQ16ChHwkxlNV2LDeYRs/d3cg+T5EyAsSKYWS3tRsyBTaFm/c36ZZ3UssxQ2Hd++PKOm9GPgDsiXmXUaZa6k5pBmsYPtPspc13NsYUbMWuqMNGXZMLvgQl5rhty3BEQXBrNI1jKObY+XPUuXBgW8P6IE+aHgUsA7xJr+CH4QkxKy3gOVqq+E89w1jPZCB9nKbeUyU5xIT/VmGbNINcnZ5hQLg7+xqa+WHEHHShA4VDOUjQpPDJ0EkIkYs0oga5niC3NvTGAp/S9JRLuw7UEAAgm1CiORWU1NHNNDDh2x61fHsUkZUyYHdO1UO7I1t0AenuSdPIdNYeo26IQH3hemdF/YRBPPUD3Z7cIQVCWIFwWVZVnRFALda4HAL821RrgGcAfIsZjzqs+8u87FZBEjtlIdAD9ZkH+jGqUULE6lMqoP/0hIdtN4nBVf/NLey0smH02hXs6LawrmSgepavlnN47FR95qANtO/jgQuVNWwXKt2A9Ib3NT017bGGKNTciWENF2pfs69BGZDKtox3VeYITQ+gExDuQeDW+1QUQGjoM2x80/9dboozpOpizkXAQXW5xsQfHh9TYONkmd5DGxPcq4vA2J/VXpoCDvc9UJbjKACnyZRHOssb11ELAMIn70xk0Q3LKuQlb2JD+nXGQhVap27TGlxTrlN6YWMQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWJLK2ZoQndLU2NvdmdBUDMrSGhpdjRUTkl6WU0vMFhNOW9EZVdZeGFSSmRR?=
 =?utf-8?B?aE84TFg4SGxSRkVhNndiSkVtOGRXVHlKUDVlajg0T3crdlprMEZuQW5FOXY3?=
 =?utf-8?B?c1VVWDY4REg2bVJvdFBib3BpcmphbDZEVWRLMXAwek5IL2xuWVlMaHd2aVV3?=
 =?utf-8?B?OXcxZkJyVzRhdHBJa2xRdlJRbGVMNVkxN3NkcFhWSlhFSjFzQzl2TDA2N2lI?=
 =?utf-8?B?NEFjclJQQjQ1ZGloT2t0clEzOVFvWUdRanltTjJsWmJZTHIzemlJdXJHYm1E?=
 =?utf-8?B?bDFoZGZaOTJjM3Q4cUJIZ2JJRDNwWWE5VWpEQW4wb1ZZdTEvWWVwZ0ZvdDFK?=
 =?utf-8?B?aFQwajRPWmMxTERTNXZQUDUxZTA4blJjby90dmJXdzJXcE9WWWFMTnlPcG9u?=
 =?utf-8?B?VVZFOGNUa1ZWaUt3aExRQ2Z1QVZ4bmdkNGpwL0dzRzNoNUlUa0oxdkFPeG5h?=
 =?utf-8?B?YWIwSWlIZndQTlcyajIvdmlIbUVFRzdienVKZmNGQkY2WFVyQTBvcUhrQ3ZC?=
 =?utf-8?B?K0o1V2tXdDhPWURwbEQzMEhZWnFkcDNJZUwrWHIySityMDNodmNQa0lNTzRL?=
 =?utf-8?B?WDZraW96cXBXZm1hOENsUkkzK3IwVE5PV3B0ODFFWGlKV2xudDlTRUQ3aWVQ?=
 =?utf-8?B?YkRmalpubStvdzJFbkgwRU80NjduUlNFVmc5eENGdUlPdFl2ZmVtRCtvSVIw?=
 =?utf-8?B?cVNsa0hTcTlIYkNJNFpHaWNLOTVWcisrdisxY1c2UUtnNEd5dWFGSHc3Q1Yz?=
 =?utf-8?B?NUs5aHZnYjlSMkJnRWEzdUhZUXZwaWRIeVhJL3g0UWxyb1Y4a2JYYlVicS9w?=
 =?utf-8?B?b1ljd29vN0MrUzkySkpqUHJZMDRBZldhL3FpSzNHRy9JYmlYZTBwclVCZTlN?=
 =?utf-8?B?UkV4TnVGa1puazdmb0FTY0NUd1hNWGdqKzdNTi9BOHE1SjZWUEdFS01sSXhO?=
 =?utf-8?B?Wm4zbC9TSSttc3dsYStlUk5JS0h6NElrMDlhWG1WcTBPN2xYcGFGRHhLV3FH?=
 =?utf-8?B?UTZ0dlorajJuQ0FwcWduYzU3d25Wd2hSZTVaTk85Tmhqc1FUYkE5TjlOQi9J?=
 =?utf-8?B?LzZGSUpxRlJ5V2NwOUZaN1lXQXZ3YWd4cU0wWEhoMHRLNVlZaWc5N0lCdkVU?=
 =?utf-8?B?b0lteUZ0M2IzYVdKZ1ZqWEt4RG8vdk1BQk1tUmFJV29paUlQRTZHU3JEd1pL?=
 =?utf-8?B?bUNlTjROLzdYVVZMR2Q3NStrdnl5a2YwSWRqUFpURGYxenNGS1I3clhSTFRX?=
 =?utf-8?B?anBiaXh5REdYc2JSLysyblpnald5bHdFb0FaaDNEVWV6TTZPS0lZcU91TmE5?=
 =?utf-8?B?ekhvL2R3RHhNaXZ3MkxaaHZ6NFV1MVFCNGhCUmJuSGxmU2VFdmc1d2ZyY0ZY?=
 =?utf-8?B?TGd0NXM1UkRURlJoRWZod3VaUCtRb2xaL2t1bXg3SGhHeEc4OGo4eXhGTTlO?=
 =?utf-8?B?THZPQmNuZmRncFUrUXlXT25lY1JkOWZLMFpWemVodTYwZDJOd0RpZ2g2L2JJ?=
 =?utf-8?B?d01qb2E1UU5Uc1JLNXFFQWY4NlVUd21lYmVZM1NBdHdUeVIreUYzZlpkTUcy?=
 =?utf-8?B?M2pwUDh4QjJNblpxNE9TR21xSlAzMXlaaEc3R0M3Mktld090US9BV3FCT29i?=
 =?utf-8?B?aWd1RE5INjVWR2JhMytuSnNRUDBPVW5UNGtkdWZIRHdUWUdpNVVxVVVZL213?=
 =?utf-8?B?bmEwNVpRRVNONklYTWdtM1cvNEQyWnpGS29CMFY2QXc2UlpGcXZEQkdBbmps?=
 =?utf-8?B?VklMMzdOblByUDU2OENHTWdxZnp3cGQ1MWpscXJJeWd4SDdsVWsxaW5MUDBj?=
 =?utf-8?B?TmlTUk1hNTBsb1R3MXBCWUJQbE00Q05MTnFpck0yajVBSnA1VUh3V2Fzb1NO?=
 =?utf-8?B?UWQ4QWpuM1BQVDcxaWJSTVZxbmM1WGVzdTk2RHNRa09xVDVqZ2JWMWJMSGRB?=
 =?utf-8?B?ak9kL3FOdjY0djVFRlc2K2lCWm1neFdjMDEyTWp0T3lleTRJVVdmWUhpNDR3?=
 =?utf-8?B?VURZenZXQXJ3NWwySDVpNHFGWSttb0NQWDVZZzFNeXR0VE9oWDNvUkR3SWNN?=
 =?utf-8?B?am5odGt4SDhmdHh4b2dzNTl2enBTeVJnVm5NSzlXcEJ4KzZuK0cvczdQRDZT?=
 =?utf-8?B?bHRCT1FYaXNneFljam4yS0pnRzZnU3oxY09wdlpadFBVdTZ4N00xNHIzWGUx?=
 =?utf-8?B?ZmNhaGRVdHExa080L2N6TS84M3VVb0YwV2xPSlBRU1lERWdxRUVLYngzUGpy?=
 =?utf-8?B?ZUlTKzJZN25ETWh2VDIyTkM3RW1yZnBEazhMSmppRXdncFRMbCtLbWRyeGFV?=
 =?utf-8?Q?40je3FTbxQzWEL7kOL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65E21B9DE23CA94CAB6F8605B94B578C@EURP194.PROD.OUTLOOK.COM>
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
X-OriginatorOrg: lenze.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR6P194MB918907.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4038b96-f80b-423b-dff9-08df40db9863
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 16:40:00.7447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37cf0ce8-ac09-4e7d-9ff2-f1da44914b3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sl5+3fOaNyQr5JAn0ubUGjz6sMwKHVJW2AAOSLh6cBrV/yF75OmAeokJv9zKv65bYEXvbEn1yBpnDJ8CBk18Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P194MB0815

T24gVGh1LCAyMDI2LTExLTEyIGF0IDA5OjQ1ICswMDAwLCBCcmFuZHQsIE9saXZlciAtIExlbnpl
IHdyb3RlOgo+IFdpdGggYSBrZXJuZWwgNy4zLjMgd2Ugc2F3IHRoZSBmb2xsb3dpbmcgb24gYSBT
b0NGUEdBIChDeWNsb25lIDUpIGJhc2VkCj4gYm9hcmQgZHVyaW5nIGluaXRpYWxpemF0aW9uIHdo
ZW4gdXNpbmcgYSBoaWdoLXNwZWVkIFNELWNhcmQ6Cj4gCj4gICBkd19tbWMgZmY3MDQwMDAubW1j
OiBEVyBNTUMgY29udHJvbGxlciBhdCBpcnEgNTMsMzIgYml0IGhvc3QgZGF0YSB3aWR0aCwxMDI0
IGRlZXAgZmlmbwo+ICAgZHdfbW1jIGZmNzA0MDAwLm1tYzogR290IENEIEdQSU8KPiAgIGR3X21t
YyBmZjcwNDAwMC5tbWM6IEdvdCBXUCBHUElPCj4gICBtbWNfaG9zdCBtbWMwOiBCdXMgc3BlZWQg
PSA1MDAwMDAwMEh6IChyZXEgNDAwMDAwSHosIGFjdHVhbCAzOTY4MjVIWiBkaXYgPSA2MykKPiAg
IG1tY19ob3N0IG1tYzA6IEJ1cyBzcGVlZCA9IDUwMDAwMDAwSHogKHJlcSA1MDAwMDAwMEh6LCBh
Y3R1YWwgNTAwMDAwMDBIWiBkaXYgPSAwKQo+ICAgbW1jMDogZXJyb3IgLTExMCB3aGlsc3QgaW5p
dGlhbGlzaW5nIFNEIGNhcmQKPiAgIG1tY19ob3N0IG1tYzA6IEJ1cyBzcGVlZCA9IDUwMDAwMDAw
SHogKHJlcSAzMDAwMDBIeiwgYWN0dWFsIDI5NzYxOUhaIGRpdiA9IDg0KQo+ICAgbW1jX2hvc3Qg
bW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDUwMDAwMDAwSHosIGFjdHVhbCA1MDAw
MDAwMEhaIGRpdiA9IDApCj4gICBtbWMwOiBlcnJvciAtMTEwIHdoaWxzdCBpbml0aWFsaXNpbmcg
U0QgY2FyZAo+ICAgbW1jX2hvc3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDIw
MDAwMEh6LCBhY3R1YWwgMjAwMDAwSFogZGl2ID0gMTI1KQo+ICAgbW1jX2hvc3QgbW1jMDogQnVz
IHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDUwMDAwMDAwSHosIGFjdHVhbCA1MDAwMDAwMEhaIGRp
diA9IDApCj4gICBtbWMwOiBlcnJvciAtMTEwIHdoaWxzdCBpbml0aWFsaXNpbmcgU0QgY2FyZAo+
ICAgbW1jX2hvc3QgbW1jMDogQnVzIHNwZWVkID0gNTAwMDAwMDBIeiAocmVxIDEwMDAwMEh6LCBh
Y3R1YWwgMTAwMDAwSFogZGl2ID0gMjUwKQo+ICAgbW1jX2hvc3QgbW1jMDogQnVzIHNwZWVkID0g
NTAwMDAwMDBIeiAocmVxIDUwMDAwMDAwSHosIGFjdHVhbCA1MDAwMDAwMEhaIGRpdiA9IDApCj4g
ICBtbWMwOiBlcnJvciAtMTEwIHdoaWxzdCBpbml0aWFsaXNpbmcgU0QgY2FyZAo+IAo+IFRoZSBT
RC1jYXJkIHdhcyBub3QgdXNhYmxlIGluIHRoZSBmb2xsb3dpbmcuCj4gCj4gUmVhc29uOiBTaW5j
ZSBjb21taXQgM2YxNjI4YmFhNTFlICgibW1jOiBkd19tbWMtcGx0Zm06IFVzZSBwaGFzZV9tYXAg
Zm9yCj4gU29DRlBHQSBjbG9jayBwaGFzZSBjb25maWd1cmF0aW9uIikgaG9zdC0+cGhhc2VfbWFw
IGlzIHVzZWQgaW4gb3JkZXIgdG8KPiBnZXQgdGhlIHBoYXNlIHNldHRpbmdzIGZvciBNTUNfVElN
SU5HX1NEX0hTLiBUaGlzIGlzIGRvbmUgaW4gZHJ2X2RhdGEtPmluaXQKPiAoZHdfbWNpX3NvY2Zw
Z2FfcHJpdl9pbml0KCkpIHdoaWNoIGlzIGNhbGxlZCBiZWZvcmUgZHdfbWNpX2luaXRfaG9zdCgp
LiBBcwo+IGhvc3QtPnBoYXNlX21hcCB3aWxsIGJlIGluaXRpYWxpemVkIG9ubHkgZHVyaW5nIGR3
X21jaV9pbml0X2hvc3QoKSwgd2UnbGwKPiBjYWxsIGR3X21jaV9zb2NmcGdhX3ByaXZfaW5pdCgp
IHdpdGhvdXQgdGhlIG5lZWRlZCBkYXRhLgo+IAo+IERvIGl0IGxpa2Ugb3RoZXIgdXNlcnMgb2Yg
ZHdfbWNpX3BsYXRmb20gYW5kIHVzZSBkcnZfZGF0YS0+c2V0X2lvcy4KPiAKPiBGaXhlczogM2Yx
NjI4YmFhNTFlICgibW1jOiBkd19tbWMtcGx0Zm06IFVzZSBwaGFzZV9tYXAgZm9yIFNvQ0ZQR0Eg
Y2xvY2sgcGhhc2UgY29uZmlndXJhdGlvbiIpCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcK
PiBTaWduZWQtb2ZmLWJ5OiBPbGl2ZXIgQnJhbmR0IDxvbGl2ZXIuYnJhbmR0QGxlbnplLmNvbT4K
PiAtLS0KPiBDaGFuZ2VzIGluIHYyOgo+IC0gQWRkICdyZXR1cm4nIGluIGNhc2Ugb2YgbWlzc2lu
ZyByZWdtYXAgKFNhc2hpa28gQUkpLgo+IC0gQXZvaWQgcmVwZWF0ZWQgZXhlY3V0aW9uIChTYXNo
aWtvIEFJKS4KPiAtIFdyaXRlIHJlZ2lzdGVyICdoc190aW1pbmcnIGV2ZW4gaWYgTU1DX1RJTUlO
R19TRF9IUyBpcyBub3QgcmVxdWVzdGVkCj4gICAoU2FzaGlrbyBBSSkuCj4gLSBMaW5rIHRvIHYx
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbWMvMmEwM2EyMjJjNGE5ZDMzMGViYzcx
NTdkZTA5ZWMzM2Y3Mjg3NWYyOC5jYW1lbEBsZW56ZS5jb20vVC8jdQo+IAo+ICBkcml2ZXJzL21t
Yy9ob3N0L2R3X21tYy1wbHRmbS5jIHwgMTQgKysrKysrKy0tLS0tLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tbWMvaG9zdC9kd19tbWMtcGx0Zm0uYyBiL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLXBs
dGZtLmMKPiBpbmRleCBjZjM4YmIxMThkYzJjLi5iNTE1NzRhMGExZmUxIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLXBsdGZtLmMKPiArKysgYi9kcml2ZXJzL21tYy9ob3N0
L2R3X21tYy1wbHRmbS5jCj4gQEAgLTU2LDIyICs1NiwyMyBAQCBpbnQgZHdfbWNpX3BsdGZtX3Jl
Z2lzdGVyKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCj4gIH0KPiAgRVhQT1JUX1NZTUJP
TF9HUEwoZHdfbWNpX3BsdGZtX3JlZ2lzdGVyKTsKPiAgCj4gLXN0YXRpYyBpbnQgZHdfbWNpX3Nv
Y2ZwZ2FfcHJpdl9pbml0KHN0cnVjdCBkd19tY2kgKmhvc3QpCj4gK3N0YXRpYyB2b2lkIGR3X21j
aV9zb2NmcGdhX3ByaXZfc2V0X2lvcyhzdHJ1Y3QgZHdfbWNpICpob3N0LCBzdHJ1Y3QgbW1jX2lv
cyAqaW9zKQo+ICB7Cj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gaG9zdC0+ZGV2LT5vZl9u
b2RlOwo+ICAJc3RydWN0IG1tY19jbGtfcGhhc2UgcGhhc2U7Cj4gIAlzdHJ1Y3QgcmVnbWFwICpz
eXNfbWdyX2Jhc2VfYWRkcjsKPiAgCXUzMiByZWdfb2Zmc2V0LCByZWdfc2hpZnQ7Cj4gIAlpbnQg
aHNfdGltaW5nOwo+ICsJc3RhdGljIGludCBwaGFzZV9hbHJlYWR5X3NldDsKPiAgCj4gIAlwaGFz
ZSA9IGhvc3QtPnBoYXNlX21hcC5waGFzZVtNTUNfVElNSU5HX1NEX0hTXTsKPiAtCWlmICghcGhh
c2UudmFsaWQpCj4gLQkJcmV0dXJuIDA7Cj4gKwlpZiAoIXBoYXNlLnZhbGlkIHx8IHBoYXNlX2Fs
cmVhZHlfc2V0KQo+ICsJCXJldHVybjsKPiAgCj4gIAlzeXNfbWdyX2Jhc2VfYWRkciA9IGFsdHJf
c3lzbWdyX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZShucCwgImFsdHIsc3lzbWdyLXN5c2NvbiIp
Owo+ICAJaWYgKElTX0VSUihzeXNfbWdyX2Jhc2VfYWRkcikpIHsKPiAgCQlkZXZfd2Fybihob3N0
LT5kZXYsICJjbGstcGhhc2Utc2QtaHMgd2FzIHNwZWNpZmllZCwgYnV0IGZhaWxlZCB0byBmaW5k
IGFsdHIsc3lzLW1nciByZWdtYXAhXG4iKTsKPiAtCQlyZXR1cm4gMDsKPiArCQlyZXR1cm47Cj4g
IAl9Cj4gIAo+ICAJb2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgobnAsICJhbHRyLHN5c21nci1z
eXNjb24iLCAxLCAmcmVnX29mZnNldCk7Cj4gQEAgLTgyLDEyICs4MywxMSBAQCBzdGF0aWMgaW50
IGR3X21jaV9zb2NmcGdhX3ByaXZfaW5pdChzdHJ1Y3QgZHdfbWNpICpob3N0KQo+ICAKPiAgCWhz
X3RpbWluZyA9IFNZU01HUl9TRE1NQ19DVFJMX1NFVChwaGFzZS5pbl9kZWcsIHBoYXNlLm91dF9k
ZWcsIHJlZ19zaGlmdCk7Cj4gIAlyZWdtYXBfd3JpdGUoc3lzX21ncl9iYXNlX2FkZHIsIHJlZ19v
ZmZzZXQsIGhzX3RpbWluZyk7Cj4gLQo+IC0JcmV0dXJuIDA7Cj4gKwlwaGFzZV9hbHJlYWR5X3Nl
dCA9IDE7Cj4gIH0KPiAgCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHdfbWNpX2Rydl9kYXRhIHNv
Y2ZwZ2FfZHJ2X2RhdGEgPSB7Cj4gLQkuaW5pdAkJPSBkd19tY2lfc29jZnBnYV9wcml2X2luaXQs
Cj4gKwkuc2V0X2lvcwk9IGR3X21jaV9zb2NmcGdhX3ByaXZfc2V0X2lvcywKPiAgfTsKPiAgCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGR3X21jaV9wbHRmbV9tYXRjaFtdID0g
ewoKU2FzaGlrbyBwb2ludGVkIG91dCB0aGF0IHVzaW5nIGEgc3RhdGljIHZhcmlhYmxlIGlzICJu
b3QgYSBnb29kCmlkZWEiLiBFdmVuIGlmLCBhdCB0aGUgbW9tZW50LCB3ZSBkb24ndCBoYXZlIGFu
eSBpbi10cmVlIERUUyB3aXRoCm1vcmUgdGhhbiBvbmUgaW5zdGFuY2Ugb2YgdGhlIGNvbnRyb2xs
ZXIsIGEgY2xlYW5lciBzb2x1dGlvbgpzZWVtcyB0byBiZSBuZWVkZWQuCgpJJ3ZlIGFscmVhZHkg
cHJlcGFyZWQgYSBuZXcgKGhvcGVmdWxseSBiZXR0ZXIpIHBhdGNoLiBUaGlzIG9uZQpzaG91bGQg
YmUgaWdub3JlZC4gU29ycnkgZm9yIHRoZSBub2lzZS4KClJlZ2FyZHMsCk9saXZlcgo=
