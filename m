Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFCA1A3029;
	Mon,  6 Jul 2026 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783308349; cv=fail; b=XvX54ni2/9tTJU+QYUY26lHa1uZCo8qCbRWFmeLho6/7b3NotDtU7/9RsAbyth7dYTQxi8cm5fVoXOI6jtvjmYJYFAIDcaHWCaJvAXjWwd+UFqmatKna0UZC39fU4ni3Z5QHN25cNlCC5hmoYDo6BKCZoxxg1/0GBqB9VY+r+mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783308349; c=relaxed/simple;
	bh=zjFB4UxNqABznWbquXfwFiBem4Xa31fqE/xG7q9mwK8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lKGZe06PQuGzSp4vqTtUy6M8hBv7mfitrOp2KekBDIj6NlDJRyDB3LQHYMD8eOuJfqrpPXRbKC6LaHnBQe3Q0hxOFyVUAxGfsxMt/R2wIVFYpk62yVciCQrnGKMlt6I2/lUSSvFgaSz8Di1Jqc8umIEOgXH9muXvUDTCJmtpHRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MGY0AgQn; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MGY0AgQn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJRkP+hFs1FkqPLuoAWMErEuFtO2tsRZnw6Y+FZLqwNVy1GQr3p56EWrWli5dQBXSn0d+J809v/ICTmy5MUuLi7tH+fxXnh3L1GItwJBN5zS7f2Xp/7At1KBWIvOg0qo/tK5b2o3wSPXM4rroqdtxrVxmkHbmo6MzAIESLzhUbXA0aFQzd1wx4izONTE80OYwWsw31WT732kTNTi+WaVnbI/PVML/T2uqJduI8DO6qkb3/sFfo0+UQ5BvpAd9iF98RWO2j2LOCdGuR3pTgFQ0QPLrR6jbRbOc7vyEX61y2UmuEknWP8IPUjmk0Gbkzde+uZ3GWaHeErwp4PP+Cu3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjFB4UxNqABznWbquXfwFiBem4Xa31fqE/xG7q9mwK8=;
 b=J1vcTDxCG8+djmpWDUlyXmkwW/jbsd4S9zpd1Ijn8cjQi7etyvT8bYHzVOcFl5ii4Gd6xvJnWtoyR44y54I/nEaQu6c5Eviim44sy1zop/3eLYjKWLGH3ONo8sge8pOkgn7l29cXKVS8HoZHiphHmOS+V/6lyjXOEai6TqhtvynEYoraW4bIPme6s8SABpe7KV8J1noZ2O0TV8OXvqz2HVp3NdQgL6Rk3sJcUO51DH6e4+w/h7lDTzmlaJ2l273NZ2APDlyIc+QD/DojUDit/7gBeW9QK6zAchsu2/yjiLPzowrWYiwvNRJkmYmerFRD5RCdn1dN3xYzJSFSiAiV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjFB4UxNqABznWbquXfwFiBem4Xa31fqE/xG7q9mwK8=;
 b=MGY0AgQnA+XFwXQ8tJdsrNH8nTjvOEugHZ7adOTpTa49izjLjzAfcTufWx99OuzEHxmRn//YfVXD388yMQ2XucLkkTBM+b2iWutVtIR/ZTxUQtExSYtD16uBePMfqBiu1/MFypkGMqaS7V625MJkXIMDF9XAGJe1xWx6rVfMAbNj787D67188P/BpQOEeZKajiWwzXQ9/AZdKcxeP78OYqpts+YP7/+K/Qn8+RFiFG/3VBuzXHyfLvoJcGKaUoxCupurjMQpUYTsnNQvENSU5h4nGqjFDdgUJKkd4OKGDddNJ3Abev9o/au9ReKyDHtJW0QcFKRBLwZ8ji+QCFhs8Q==
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21)
 by GVXPR04MB10272.eurprd04.prod.outlook.com (2603:10a6:150:1bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 03:25:40 +0000
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f]) by AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 03:25:40 +0000
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
Subject: RE: [PATCH v4 3/7] mmc: sdhci-esdhc-imx: restore pinctrl before
 restoring ios timing on resume
Thread-Topic: [PATCH v4 3/7] mmc: sdhci-esdhc-imx: restore pinctrl before
 restoring ios timing on resume
Thread-Index: AQHdDPcet4F+bOtMJU2hbAUK2Oba5A==
Date: Mon, 6 Jul 2026 03:25:40 +0000
Message-ID:
 <AM7PR04MB6870824EB5AF3561B5D69DEFEDF12@AM7PR04MB6870.eurprd04.prod.outlook.com>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
 <20260703104208.3426374-4-ziniu.wang_1@oss.nxp.com>
 <c1cfc800-f590-454d-9493-55cf6bed938f@intel.com>
In-Reply-To: <c1cfc800-f590-454d-9493-55cf6bed938f@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6870:EE_|GVXPR04MB10272:EE_
x-ms-office365-filtering-correlation-id: 89eafa4e-e211-4e1d-0d3f-08dedb0e4136
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|23010399003|38070700021|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 qv9u3z1rtc7f1y01XEyLL9nkMBQFZtReIAFL9dTqfSJJoZoJMcGZ2RLjdmXHL4xCNAs0F/pixPiKCxUSyb+uDCeQ4+WzP5kZln8RVPew+JJ9H1gMQvmsHRO6VB2rF0iz6gFcs4cebJ7dUwGHkUvUM8f9OVZ5TOnZp96E7e1enmqgmk5OaIa0Wj2IgQsbiGDqe7XDxfNqF4vm2qnC9IsDtA5j6KP7nd1x5Vt/NtolzD23hMy1MY8dw/1tcAxPQU7VeeDZwS+I3Z10ZzsnWHgSLf3FB6B/john2MIw7Ar6wRzRxMUWpbCSRML8AG8SL1amXQxUTphQHl0QXMZW4hBbZ4UeLiDwDFFopZDW2kSzy6UtYRvLfH+/diCyVfEHVJ++Eiw37fI9LwtSyMRq9JwPySoFa1uimdfBOaPNmmtXtcwE4DF23BwPN3aT/daGXB6gUUmyc8gd50Ng/rD5/EAw+HYCdn4diGswAo4BQI7vgXLUi4mV9CEPb2JlU2PLgnBp9kwd/4THHvRSAnPvpGUSBA1EKgCa1APbcVNYH8CsFBC0IJQeCy8Luce8JIx2llLgfxsscAt1ycya27lQqimqQi3/pjgNOI26cIkoSzcLvu+Rfs6VWj1GQSDEn4stKD+H3cBoC9vC2vLhE5VsMxF0h2bOby03y8EA7XcRpH16XYQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6870.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(23010399003)(38070700021)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tks1VW1icytXMmdEa0IxWUhNby96d2w5amtMRjd2Qk5BYTJqSHJhTS81Zm9i?=
 =?utf-8?B?NlVaamZrYjdyeUZFZVVtZmpML2J4Slh0ZDhEWHhHWWtzNVlQc2ZpUlJHS1JE?=
 =?utf-8?B?VXRleXFjbldzeTY0MFo3UHFnMGpJSHY5S0tHMW1BeXBXSzQ4amdXY1g0b0Fr?=
 =?utf-8?B?ZHFEWmErQmlkU1M4OHc5Wk45OUVYOG9ESGVtMWJrVXZMUlhZQ0pURjZXTFo5?=
 =?utf-8?B?WEpTaDNqUXowY3ZLQkI5REFoM1VaTExQY0FFTldvYXovd1l4NEpvN3JvS3N4?=
 =?utf-8?B?UUZlQ3dVdjlRaFd0aWJaRUdOcFJwbHJjL0EvWGZYZFBNb09GcTJVWG8zeU1Y?=
 =?utf-8?B?UXp6T1lyZnVyc1NUQklmRHBTN1NMZTB4U1A1SEhvSDdCRGtwWlVMR0VLTG16?=
 =?utf-8?B?S3Zld1NlRmVuVWdwaFFDcTAvcnRKWnEwQ2Q4dkxqbHljM1ZxdnI1WFRoVU5l?=
 =?utf-8?B?SXNadUc5MDAvU1o2VStMQnVwUTVvUWk0MjlvOGxqeDNaM2phNjQzdWxLcUJx?=
 =?utf-8?B?dEN4aGx2UmZhaSs0MGlUOURyUlo4QWs5dWY3QWZCWnlQTWVvNThHZzNPOGww?=
 =?utf-8?B?U2xtSEhrMWVDVjAvTTlmclZNcFk2V2Z6ZDFxRXpFK1BDeDRmQklCQmNuNjBv?=
 =?utf-8?B?cFZSZEtxZGRydXREa1NWdG1SaFg2UFZpY0MvbDdmMks1USt3N2FOTlhLVVdQ?=
 =?utf-8?B?OHVGeGhCMGtDdkFyKzhzZ1dzQVNvOGVMWDFaLzMzbXd5ZExybWtjNSsxaFp3?=
 =?utf-8?B?bVphZ3Bjd2pJU2NxK0cxWmxFb0xKbXBITWY3SEZ1V29ybW83NWJVWlpiM0s3?=
 =?utf-8?B?VzAzR0ZEbzVuSVJtNDVuaGVidzdzTGV2SWxxVFM2RUhMeGZydWlqYlo2MFJ1?=
 =?utf-8?B?a1dhYmFjNHRSVGZURXl6L0ZLOTV1UC9sSld2Tmw4cnVYTjRMaUl3bGliaFcx?=
 =?utf-8?B?MGQ5bjd0NVZnK3hNQTJ1Qjl6bjJyOFpIaGNvWWlpRGJETElrRm1ESmVyanFS?=
 =?utf-8?B?dkgybE84VDYzbmRxN0t2cCtUMVR3cCs0Nzc1bHk5VVpQSU1BWFpsWkk1V3pU?=
 =?utf-8?B?M1pjQURaWHRheFZqakZxWDZhcXJEQTRmNkZtemJPejlTT1c4dlByZVZ6Qkdo?=
 =?utf-8?B?VzJXN2poNWVKS3BxYk5zT2pjUVpTMXN1VEFYbHhnQy96cEp2SUtBZjYyWVJj?=
 =?utf-8?B?SXF2VkpNdHd2NXpQNHUzTll2TE04NlJodTgrRXpnNzNiUHh3ek1KRzZuUmZQ?=
 =?utf-8?B?bGZCd2NXNTRvUWttN2dqcXY5NzBaRFZybEJsdW1ET3hodmx0VytrckxOdVBF?=
 =?utf-8?B?akhnRktyMXJEcmVZMnREek4zdzZVekFkaVBZQS92VU0wTDRQaldWb0t4aVIx?=
 =?utf-8?B?elpPdEZ4RC9wKzhGMnJCSE5HSG80Um1LWldVMytodDIzbnkvSjZtQ2NXcThV?=
 =?utf-8?B?cDd1NzBvNFd3aW5SVWlQSTZaZ2JDZWVFVVJjd1NaMk0remp4a3lzS1JXbnM3?=
 =?utf-8?B?SXNHVUozMktaa0xvQzMycjBFZWlqV21kUFJmcVNoRkg0ZFUrVFJTYktmUHow?=
 =?utf-8?B?SCtiWE9FcE50S3Y3bGkwMnRpNW93S1UvRmpPd0lMYlVSK2l3VzBzcVFiZFpQ?=
 =?utf-8?B?TjZsZnJrcFB2NWlhdEEvTmR5c0U2M0htaWFJRHg2UVdEQ1ptL2dYRkhSbldh?=
 =?utf-8?B?eVlqZ3MwSU1rNDVHcitLSUJSbVJSL1gxMDN0b1hGR1YrQ2ZydnVteEhFLytm?=
 =?utf-8?B?ZHQxWmRKRm42RmNlNE5CWG1RdVNKMFpmYXRnR1FDZmhoVTF2NjZlRnRXaHpv?=
 =?utf-8?B?NjBpOXUxd282V2J6VDU4WmZBQ1BsUk9MOGtjRkxiV0NXd0EyT1lxWmhBWVc1?=
 =?utf-8?B?Z3VWVzVBdWlYZ3I0TndqdzhLOFl3V1JqMUhHcU1kNnFySkl3R1orUWY2UVo5?=
 =?utf-8?B?UDVPdE5ucU1WcUl2RFFpelkvYUdOWWZXcXRtcEZCQkkwejExd1BpaU4zVFhG?=
 =?utf-8?B?TWplUElsWlFDWGRjTWJEaE5scFQzV1JXS0Z3aXVidStQOU8wS1BXV1lVdFZJ?=
 =?utf-8?B?d0U4WUduc2hKaWE1OHVsU0pWU3hWZExSYnp4K1YxQWMyT3RENW05d01oSVlF?=
 =?utf-8?B?Rm42UEhPUzRRNk9vS1MwYSt5Z3ZwRlBFOWtEZHlwd2NReFVpWXVqOWF5OWV6?=
 =?utf-8?B?SnFMc3djVUxaNlZDNEkxWUlGRUZPd2x5cUYrRWFZdDlXcGNTU1J6UTZVeThm?=
 =?utf-8?B?QVlpNXBaM2YyRkxuY1BBMktSK25kYnZEMFRxMFVvZHczVjBkMzZYeFkzRzhu?=
 =?utf-8?B?bWVXWEE3dmtNZG56TC82SXRjK2xabVgyUzBUL09FZGNUWUgvZ2hSQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89eafa4e-e211-4e1d-0d3f-08dedb0e4136
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 03:25:40.3077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGp4f6+Jl4hbbqsK9maOz7oX8qVFKC06PIRIMDQvvgPwVUl3vMuMPMWx1VsP6TQmGTVQEnmt7YRctxqgq2/lsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10272

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgSnVseSA1LCAyMDI2IDQ6
MTUgUE0NCj4gVG86IEx1a2UgV2FuZyAoT1NTKSA8emluaXUud2FuZ18xQG9zcy5ueHAuY29tPjsg
dWxmaEBrZXJuZWwub3JnOyBCb3VnaA0KPiBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBGcmFu
ayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gQ2M6IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBpbXhAbGlzdHMubGlu
dXguZGV2OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBkbC1TMzIgPFMzMkBueHAuY29tPjsN
Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy83XSBtbWM6IHNkaGNpLWVz
ZGhjLWlteDogcmVzdG9yZSBwaW5jdHJsIGJlZm9yZQ0KPiByZXN0b3JpbmcgaW9zIHRpbWluZyBv
biByZXN1bWUNCj4gDQo+IE9uIDAzLzA3LzIwMjYgMTM6NDIsIHppbml1LndhbmdfMUBvc3Mubnhw
LmNvbSB3cm90ZToNCj4gPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0K
PiA+DQo+ID4gU0RJTyBkZXZpY2VzIHN1Y2ggYXMgV2lGaSBtYXkga2VlcCBwb3dlciBkdXJpbmcg
c3VzcGVuZCwgc28gdGhlIE1NQw0KPiA+IGNvcmUgc2tpcHMgZnVsbCBjYXJkIHJlLWluaXRpYWxp
emF0aW9uIG9uIHJlc3VtZSBhbmQgZGlyZWN0bHkgcmVzdG9yZXMNCj4gPiB0aGUgaG9zdCBjb250
cm9sbGVyJ3MgaW9zIHRpbWluZyB0byBtYXRjaCB0aGUgY2FyZC4gRm9yIEREUiBtb2RlLA0KPiA+
IHBtX3J1bnRpbWVfZm9yY2VfcmVzdW1lKCkgc2V0cyBERFJfRU4gYmVmb3JlIHRoZSBwaW4gY29u
ZmlndXJhdGlvbiBpcw0KPiA+IHJlc3RvcmVkIGZyb20gc2xlZXAgc3RhdGUuDQo+ID4NCj4gPiBU
aGlzIGlzIHJlbGF0ZWQgdG8gdGhlIFNvQyBJUCBpbnRlZ3JhdGlvbjogc3dpdGNoaW5nIHBpbmN0
cmwgc2V0dGluZw0KPiA+IChjaGFuZ2luZyBhbHQgZnJvbSBHUElPIHRvIFVTREhDKSBpbXBhY3Rz
IHRoZSBpbnRlcm5hbCBsb29wYmFjayBwYXRoLg0KPiA+IElmIHBpbmN0cmwgY29uZmlndXJlcyB0
aGUgcGFkIHRvIEdQSU8gZnVuY3Rpb24sIG9uY2UgRERSX0VOIGlzIHNldCwgdGhlDQo+ID4gRExM
IGRlbGF5IHdpbGwgYmUgZml4ZWQgYmFzZWQgb24gdGhlIEdQSU8gZnVuY3Rpb24gbG9vcGJhY2sg
cGF0aC4gV2hlbg0KPiA+IHRoZSBwaW5jdHJsIGlzIGxhdGVyIGNoYW5nZWQgdG8gVVNESEMgZnVu
Y3Rpb24sIHRoZSBpbnRlcm5hbCBsb29wYmFjaw0KPiA+IHBhdGggY2hhbmdlcywgbWFraW5nIHRo
ZSBvcmlnaW5hbCBmaXhlZCBzYW1wbGUgcG9pbnQgbm8gbG9uZ2VyIHN1aXRhYmxlDQo+ID4gZm9y
IHRoZSBjdXJyZW50IGxvb3BiYWNrIHBhdGguIFRoaXMgY2F1c2VzIHBlcnNpc3RlbnQgcmVhZCBD
UkMgZXJyb3JzIG9uDQo+ID4gc3Vic2VxdWVudCBkYXRhIHRyYW5zZmVycy4NCj4gPg0KPiA+IFNE
L2VNTUMgcnVubmluZyBpbiBERFIgbW9kZSBhcmUgdW5hZmZlY3RlZCBhcyB0aGV5IGFyZSBmdWxs
eQ0KPiA+IHJlLWluaXRpYWxpemVkIGZyb20gbGVnYWN5IHRpbWluZyBhZnRlciByZXN1bWUuDQo+
ID4NCj4gPiBGaXggdGhpcyBieSByZXN0b3JpbmcgdGhlIHBpbmN0cmwgc3RhdGUgYmFzZWQgb24g
Y3VycmVudCB0aW1pbmcgbW9kZQ0KPiA+IHVzaW5nIGVzZGhjX2NoYW5nZV9waW5zdGF0ZSgpIGJl
Zm9yZSBwbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZSgpLiBUaGlzDQo+ID4gZW5zdXJlcyB0aGUgY29y
cmVjdCBwaW4gY29uZmlndXJhdGlvbiAoZS5nLiwgMTAwLzIwME1IeiBmb3IgVUhTIG1vZGVzKQ0K
PiA+IGlzIGFwcGxpZWQgYmVmb3JlIEREUl9FTiBpcyBzZXQuIE9ubHkgcmVzdG9yZSBmb3Igbm9u
LXdha2V1cCBkZXZpY2VzDQo+ID4gc2luY2Ugd2FrZXVwIGRldmljZXMga2VwdCB0aGVpciBhY3Rp
dmUgcGluIHN0YXRlIGR1cmluZyBzdXNwZW5kLg0KPiA+DQo+ID4gRml4ZXM6IDY3NmE4Mzg1NTYx
NCAoIm1tYzogaG9zdDogc2RoY2ktZXNkaGMtaW14OiByZWZhY3RvciB0aGUgc3lzdGVtIFBNDQo+
IGxvZ2ljIikNCj4gPiBSZXZpZXdlZC1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCA2ICsrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktDQo+IGVzZGhjLWlteC5jDQo+ID4gaW5kZXggNzIzMGQ3MGUwMmFlLi4zYjFlNjM0
MjVhMTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBAQCAt
MjExMyw2ICsyMTEzLDEyIEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfcmVzdW1lKHN0cnVjdCBk
ZXZpY2UNCj4gKmRldikNCj4gPiAgCXN0cnVjdCBwbHRmbV9pbXhfZGF0YSAqaW14X2RhdGEgPSBz
ZGhjaV9wbHRmbV9wcml2KHBsdGZtX2hvc3QpOw0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+ICsJ
aWYgKCFkZXZpY2VfbWF5X3dha2V1cChkZXYpKSB7DQo+ID4gKwkJcmV0ID0gZXNkaGNfY2hhbmdl
X3BpbnN0YXRlKGhvc3QsIGhvc3QtPnRpbWluZyk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJ
ZGV2X3dhcm4oZGV2LCAiRmFpbGVkIHRvIHJlc3RvcmUgcGluY3RybCBzdGF0ZVxuIik7DQo+IA0K
PiBTYXNoaWtvIGhhcyBhIHBvaW50IGFib3V0IHRoaXMgZGV2X3dhcm4oKS4gIFNlZSBpdHMgZmly
c3QgY29tbWVudCBpbjoNCj4gDQo+IAlodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAy
NjA3MDMxMDQyMDguMzQyNjM3NC0xLQ0KPiB6aW5pdS53YW5nXzElNDBvc3MubnhwLmNvbT9wYXJ0
PTMNCg0KVGhhbmtzIGZvciBjYXRjaGluZyB0aGlzLiBJdCdzIGEgcmVhbCBpc3N1ZS4NCg0KVGhl
IHJvb3QgY2F1c2UgaXMgaW4gZXNkaGNfY2hhbmdlX3BpbnN0YXRlKCkgLSB0aGUgZWFybHkgY2hl
Y2sgZm9yIA0KcGluc18xMDBtaHovcGluc18yMDBtaHogYmxvY2tzIHRoZSBkZWZhdWx0IHN3aXRj
aCBjYXNlIGZyb20gcmVzdG9yaW5nIA0KcGluY3RybCB2aWEgcGluY3RybF9zZWxlY3RfZGVmYXVs
dF9zdGF0ZSgpLCBldmVuIGZvciB0aW1pbmdzIHRoYXQgZG9uJ3QNCm5lZWQgVUhTIHN0YXRlcy4N
Cg0KV2lsbCBzZW5kIHY1IHBhdGNoIGZpeGluZyB0aGlzLg0KDQpUaGFua3MsDQpMdWtlDQoNCj4g
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcG1fcnVudGltZV9mb3JjZV9yZXN1bWUoZGV2KTsNCj4g
Pg0KPiA+ICAJcmV0ID0gbW1jX2dwaW9fc2V0X2NkX3dha2UoaG9zdC0+bW1jLCBmYWxzZSk7DQoN
Cg==
