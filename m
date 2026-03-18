Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022135.outbound.protection.outlook.com [52.101.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAE36AB6E;
	Wed, 18 Mar 2026 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823988; cv=fail; b=ZWjLZnZUPdP28TjnngCb58matBX7s6y7g/HkEqjLicFxu79kZoaT1xeooINR1UyI13qwzBTKNJ4k65cBCY5a2U+hH+rzDwNmjj0x6fXJw70bT595fL0GE4zSoQvEcfjlGGzM3eC9Ezc3kRqk/oj91WbGtePdnQF6Ho4NLwJ+H7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823988; c=relaxed/simple;
	bh=Qu+Nq2BHQ+zzI2YcqflncdbpQaQ3aDReWRUj3INs0P8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MJqXZIgGR2WaRZgg6avmJa4KtfD6e/auRhfzdQnInkGlXMhiy3k4f4rr8GZugZC42PsNiZ5qKdOicJhvzegeFI//gltGa4VTTMm82ucNxRpNS7Dl7DccylksqLUmysjK0XEDp553rhxNJcqbN8Q60XNzMCrR3bpIZtxaTQDt0g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=HOdkvk6t; arc=fail smtp.client-ip=52.101.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="HOdkvk6t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewW9DpjUZiidwqYB51cmJZxrnmSRdMgMVDmtDBeHJ7Blpxwv7YSpEqx7dBz3C7t7bhIiwdGHrEE33ScsyR/G1VH1FynuX6Vt2Bf2H3Zg+j4pp1TlA/6KokpPnbaBubtHEj/XX51hmjUQCMVOAtrCpaKFphKYRckc3gHwkzsuJeSDMcroSvAJk7wVIVDNx40GiLZ3HvrMICkkFJ4KOEbjOfLMD3mo1tdwJvMGKqmKExqxlN/stVfq8BtbSrWPuPQI+12wWzTOxeC0WX6uq1QvhLnWM35nfG3UFrjoNgLKOKQgldaXgdT9BtmkWTC2dpAylhMhGL08d2GMeTjt/5dRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu+Nq2BHQ+zzI2YcqflncdbpQaQ3aDReWRUj3INs0P8=;
 b=BTuYrt/qlv48+dfl4/7UuFD51xWUKNZ0UlUu9pNJcOjgcmKia+1K7CvJObuXSzYjQNhIlIBJJ5KICHQiQlJ+89udOdfjQ/5b7fkij9f6VXgZ84kOfS1uF5OUdmBmv93BQurDoddByAEqLDyg3jnpNvlQaAgOnC2XdfUjIaEFuEMyosGSiFmxQcxLxREd3xx/wagpjT4SLNDHJi9AJz7AF1crajA8hDYypk8jD/CIxY7bwDCdyU8NQ3DF5xlqdQ8fXiolGkHU/I/l39MbZq/Eq9jUOh5tMzWN3hDWrsRT6KqBcairfDt8s2M5K8tTnod8jdPH3IXOUGfsBl6C/UQC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu+Nq2BHQ+zzI2YcqflncdbpQaQ3aDReWRUj3INs0P8=;
 b=HOdkvk6t8dcO7ikVJWc8C3IpY/+4jsh1AiqpF0cuhhIT11bhXqe4s+Hm9sODKwsQi/1kx4+azuzK/Oie8600cpMsnxsE7WZFxBBU51pmxPtABWPgWM9G5CTc5G9lLRZIxUuNm1cus6cKGZSSmsWhTcNKZovzb79E86z1iXaKdAcSJr9xyeMGizEIwE6Zk0gDOSWr7D6A2wG+Y2g1SUw+wsH4W0vLGIfxtlBgiyiL4n0hEQZBsFjTwXi+ZLSaf2hK30mvfCqXCWwbxsKtKkSlo2U9v4JvKoYouMWY/1MTZAApBnE0sfqZwBXXoJGrKrRlNbt4pmVj0pf6ruccFoi3kg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYZPR06MB5417.apcprd06.prod.outlook.com (2603:1096:400:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 18 Mar
 2026 08:53:02 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Wed, 18 Mar 2026
 08:53:02 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, Andrew
 Jeffery <andrew@aj.id.au>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] mmc: dt-bindings: sdhci-of-aspeed: Add AST2700
 fallback compatibles
Thread-Topic: [PATCH v2 1/2] mmc: dt-bindings: sdhci-of-aspeed: Add AST2700
 fallback compatibles
Thread-Index: AQHctdLYEgta6oUwokG3QEh/PPkOl7Wz7V8AgAAA4JCAAAUVgIAABEVw
Date: Wed, 18 Mar 2026 08:53:02 +0000
Message-ID:
 <TY2PPF5CB9A1BE6E474E78EED4F320F2B30F24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260317-sdhci-v2-0-39b1f063061b@aspeedtech.com>
 <20260317-sdhci-v2-1-39b1f063061b@aspeedtech.com>
 <20260318-abiding-sloppy-poodle-efd3e5@quoll>
 <TY2PPF5CB9A1BE666DEF10944BBA2A2256BF24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <f46bf4fb-b6e5-4238-9c23-c435c4b8e275@kernel.org>
In-Reply-To: <f46bf4fb-b6e5-4238-9c23-c435c4b8e275@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYZPR06MB5417:EE_
x-ms-office365-filtering-correlation-id: aa107f9f-78d8-4463-ce0d-08de84cbc361
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 //FrzoTwZTDmu/7eUyjQC1NALcRKkv0sCmnfnmt10XSzVr9PIXsIUBNXYbB3O8xCWqzYniud9eDkqReH4P5EWcNpqUjJEbRXBCjrcozwD9l4O4037WStxd8fhlEokPiKGzkOsAP6rsyqVGS2CLsBkGOPeQVhNvA6jdHlzGLj7DjosNpEE4mLt2ihaU/PKrX/ap6BpCezxX3VqCkfuJQE22ZYxe3uQt8SvGuVWsM0gx2aUxT1a94toY/lxl7ogcD4O1Ep8nDS1GmMSJ7duExxjwchfqJ5xsfFbSFc4fC4xWHmXytmkxr2vzY3RIHG+gpWVXuyzLmP7iJ2cH/TQhzHlTFw+pXhLXu+RhXPMITEs1j2jKswfCU0M2M3HrgM+57cF6e1bF4fx0zJqztLxiKvUqn3FYUkyw9tBBJ3GdZlg0fM18gKWw2SCrrCBM+MwlZJ84GaXJyFbzbYpmG87nE5vqKfDKGizedBa9QnrLDQ5IKYHw0ZGnqOWJZXPLRTA++NUxUB11bzfECTTg62vZjE/PVQhCjriZ7MTNyc9wJE3WGljBWY1GHAckOy60QYBAKQS2AImOMM9IQDQCE+KOoS4lgNAQMz13oIWKb2EFJvnJECPjtl0x8qf8+o87+MIyoLbfiH9nMLiTobnkFpzH9Skv+p8uwJKtHg0bPzgSZ1FAQ/piqPpzSZWnJdh0xGI53ROKf+2pTocG4Ggz2XEpRb7nGbRg8gYyBiRhzljdgp1gga7kz6f3H+jlYd7HtV8C5GM+3emCdfVgLAwtHEz7NycU2ad5wPD5GLgjXROo0TKT4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHcxcWdLRWFPUTYzQjFXNlpDUWp1R08wSm9HSW9qM0tBTzc2T2JtMTcrMWlH?=
 =?utf-8?B?ZjVDQ0ZJTXFMOW5pQ21peWVMeCtMUjJxQjFtRHE1akVRSUYyb0hUeXhTaGRv?=
 =?utf-8?B?SHk3cmFwWi9JU3hVUVlVK3h2eDA2RHZ1ckFLblBqbEVJTkZRUGM5ZU01cjB4?=
 =?utf-8?B?cVg5ZDZLZlQ3RUFQQjhUYWpLamhmb3VXRGFxVFN5MlJNSzdnbGs3bU1XdExP?=
 =?utf-8?B?Mk14cGJlRnVwdmlBRDFldDJCWTV1SndGMjgvYm90QlVRajJjVVVvQUdlbXJB?=
 =?utf-8?B?ZmVLZXhBY09WRUVJWVRnMHk0dHM3WHBRZGpuZXVNTkV1dmhqZnZGYlFEODNv?=
 =?utf-8?B?eGkrSE5NQjVPaHdYS0tNVHo2cTh1cFF2WmplWTRCRWpsenhpeUptMFEvdUFJ?=
 =?utf-8?B?ZFo1ZmVrTTJ3TVRTcWVMSVA4cVE4TDg2aEZhaTY2VXhqZUxCQ1dYYlJMS1ZL?=
 =?utf-8?B?dnhFdzJ1bkFuL0V5MjJxVnR5RzhiTGFXS1VGbDQ2ZWtwUXMwT2VxTzFuaGsz?=
 =?utf-8?B?RnNwNTcwem9jcGtIZUVLb2FrUGN6aWhYSlJHSDh6NEh5Nm0xczJWV0tGcDRD?=
 =?utf-8?B?K2JUaDkyWXFlYjJ6cGtnTnU0UmsvMi93dldiNUtjeE9zV25qU1V2N2k4SVha?=
 =?utf-8?B?UzdPdGUvWlZsZ3cwbzFrM0JzT21KcTgvVTdTajd0UDYvWVp0VFQ2UDdrM2ZV?=
 =?utf-8?B?K3ZMRVVkbXVvT0tiMHZtaUVmcklZS0w5NkoxQXA4aUZnRTFWU0FieTZCVEpP?=
 =?utf-8?B?c21rZVFxbEtuRkx1SklORlR3a2tOR1d2TmtOYnZySno3UkpkbXZhaUt3N3JG?=
 =?utf-8?B?OThMc04yRUZRZjIyc0EyTnZNUzNIcGF2c3JNOWlqaHVrRDZXdEdyd2d6MkhH?=
 =?utf-8?B?bHUxQ0lGVnhBSkxHc0diRkVTNDBGTVc1Tk5pRXZqcEJNUUVOOVp5anZONmxu?=
 =?utf-8?B?MlFxUkQzVzFwY0JyNjE2amI1WXVyMmtJeUp5UGJRZC90Y3oxODJmOEdES3Zh?=
 =?utf-8?B?a1QxSzlnM1dBN1YwbkNCWUY1eno3a3lNb0VMemEwVUQ2UjVFMTVwNGkvOWRN?=
 =?utf-8?B?M3F1M1BpNFBwYzhBZnNGTXJFa3Z2Mit6UjhOMTd4OWkrZXk0YXY5OVR6R04z?=
 =?utf-8?B?c3RueEVOZmdZSHk1SGFuaXh2a0NOLzB1czVKSmJaQklobGFvVWQxZ3U0VjRL?=
 =?utf-8?B?VVFyWG9HNzhSazV4ZkMvSXYzVkN6L3hpdG13ajVZaUFaY2xkOC9qSitlQ0VF?=
 =?utf-8?B?b1NRY2MydmJpNlUrbVZ5UkpCNHFGc2tER3pXam5neG0zV2dOSXZrQk02Ynhr?=
 =?utf-8?B?VXFEdlQzNytHZnpHTnM5NWYraW5VNVdyL0dXaTFoaVF1S1BuMzhmNmcrZEM4?=
 =?utf-8?B?MytzNy9GcGJzTElSQ3RxTlh3Mnl0Rm5hUWg0ektibTNEYXFFNUtiK09hZzhq?=
 =?utf-8?B?K2dLWFlsWWdJSForNGgzdTgzMFllUTNsZm9aekdiMVUzcjRXRVRiZ04yWFlU?=
 =?utf-8?B?cng3dnRuRk5vcW0yekYrWEhDTHp1ZG5na1BVbGN2OW1mdGtnZDZXK2ozcG5a?=
 =?utf-8?B?dzdvRG9EWG1ySkVTa0Iwd3BmbTRxMktlVXVTQVdkMG5PQzRKY0RKM0ZaNkVk?=
 =?utf-8?B?YnhETXJVK0pNajBhT1RHTHFYRzNYRUYyNWcrS3ZPb2JlRkxQYjFjU3BrQ1Rp?=
 =?utf-8?B?bXdBUHc3TlNaQjVqMTQ4YTUxZG9LRFFTeEdPYldudS84UkFlUzNsZ0REQk05?=
 =?utf-8?B?cS9icXJSMGxrN3YwV2R6dk9TZ3pzckJicFNORURSUVZZZlErZ2pBUnBLamkv?=
 =?utf-8?B?L0JwYzF6cTBsa0xmakNhQkdyait1Q25mT3A2UVE0akN3NTh2aklQNEtSUDF3?=
 =?utf-8?B?bW1vMTFqTTVlbGwwZ21OenFqYzdPQzlKbzRaNHRjakIvSW44M3d2SmlhOEpx?=
 =?utf-8?B?T0VDdVBYRk1DZk1Va0NzZ3lOQTlzTnNBV3JlWjk4VHZjMk45enJ5ZE1lSXVG?=
 =?utf-8?B?ajFQeklDU202WHh6eWRIQzRXTnE3M0daYlI2ZzY4RUwybnF6czNOUlJFM2Y5?=
 =?utf-8?B?bVR0Mm0rV1cxdnZNZndQcW9wUEcyc1U5b3pGazFjVWFveTJYUjdady9ZeHBI?=
 =?utf-8?B?S245SVBJbEgybEhPRTlzQkdhUmp0eGRQRlZhSHQyYkpmZy82RHpzQkYyQ0hF?=
 =?utf-8?B?Q3FLaHlqUEJKQ1JaZTZaOFZBeER4ck12VzJ1SVRscG9XblhMaDdPQ1puQ3M3?=
 =?utf-8?B?R2J1a04rR2hvU1d0OFNLMTAwSnF0Qy9oM3dIR3o3aStvZE00M3NmeWtNOWZW?=
 =?utf-8?B?eEJsSlBQVWl5TFhzZy81RjY1L1pxeUEyS0UyeW5iSzRPK1dCRTZDQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TY0kucMMF7sv1gPRYX7LOswk7Cf/z3aN1QMOPQLSITzRjwDFQufPvVQQJDi4LGT13hBszzaHUFlTkf+nQBNpZUtQZi/OH3+oJz9j+3GBoBpKGBjshxPEeGnsKTKRw4+JdcafrRS6mGu3ykQDV8KGd4OPYrilUuTrq8C5WxOEqL6k1LqpCy4xWwkHU3wA8sl4QYR2Y6n/CsqUz+HQRzbIiqFw0I/7ydJuj8goGfAkR0C9iSeFgyjHTACSEqh2x6OPFip0l6318mufNl2EQkIplRqsctVX/0adDgrt+F19MAx03vGSQUWJf+BnZFnE3M3TRFM1u/P/0XGooW79bz2nZQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa107f9f-78d8-4463-ce0d-08de84cbc361
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 08:53:02.4072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocuGfIXiblsIvmnfI4eBSzVVB14I5p0NZBXc/MYkI9Opn5jV8UCQSG3a0OiHebYM8HOQ0YU4Cb4ET2Rb0kbGJkVLqvjkLBGPQnsTIRiNJeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5417

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gbW1jOiBkdC1iaW5kaW5nczogc2RoY2ktb2Yt
YXNwZWVkOiBBZGQgQVNUMjcwMA0KPiBmYWxsYmFjayBjb21wYXRpYmxlcw0KPiANCj4gT24gMTgv
MDMvMjAyNiAwOTowOSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDEvMl0gbW1jOiBkdC1iaW5kaW5nczogc2RoY2ktb2YtYXNwZWVkOiBBZGQNCj4gPj4gQVNU
MjcwMCBmYWxsYmFjayBjb21wYXRpYmxlcw0KPiA+Pg0KPiA+PiBPbiBUdWUsIE1hciAxNywgMjAy
NiBhdCAwMTo1Njo0MlBNICswODAwLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+PiBEZXNjcmliZSBB
U1QyNzAwIGFzIGNvbXBhdGlibGUgd2l0aCB0aGUgZXhpc3RpbmcgQVNUMjYwMCBTRA0KPiA+Pj4g
Y29udHJvbGxlciBhbmQgU0RIQ0kgYmluZGluZ3MgYnkgcmVxdWlyaW5nIGZhbGxiYWNrIGNvbXBh
dGlibGVzIGluIHRoZQ0KPiBkZXZpY2UgdHJlZS4NCj4gPj4+DQo+ID4+PiBBbHNvIHJlcXVpcmUg
YHJlc2V0c2Agb24gdGhlIEFTVDI3MDAgU0QgY29udHJvbGxlciBub2RlLg0KPiA+Pj4NCj4gPj4+
IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+
Pj4gLS0tDQo+ID4+PiBDaGFuZ2VzIGluIHYyOg0KPiA+Pj4gLSBhZGQgbWlzc2luZyBibGFuayBs
aW5lDQo+ID4+PiAtIG1vZGlmeSBhc3QyNzAwIGNvbXBhdGlibGUgaXRlbXMgY29uc3QNCj4gPj4N
Cj4gPj4gV2h5Pw0KPiA+Pg0KPiA+Pj4gLS0tDQo+ID4+PiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvbW1jL2FzcGVlZCxzZGhjaS55YW1sICAgICAgfCAzOQ0KPiA+PiArKysrKysrKysrKysrKysr
Ky0tLS0tDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvYXNwZWVkLHNkaGNpLnlhbWwNCj4gPj4+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hc3BlZWQsc2RoY2kueWFtbA0KPiA+Pj4gaW5kZXggZDI0
OTUwY2NlYTk1Li45YzhlMDY4OTY0YTEgMTAwNjQ0DQo+ID4+PiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2FzcGVlZCxzZGhjaS55YW1sDQo+ID4+PiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2FzcGVlZCxzZGhjaS55YW1sDQo+
ID4+PiBAQCAtMjIsMTAgKzIyLDE0IEBAIGRlc2NyaXB0aW9uOiB8Kw0KPiA+Pj4NCj4gPj4+ICBw
cm9wZXJ0aWVzOg0KPiA+Pj4gICAgY29tcGF0aWJsZToNCj4gPj4+IC0gICAgZW51bToNCj4gPj4+
IC0gICAgICAtIGFzcGVlZCxhc3QyNDAwLXNkLWNvbnRyb2xsZXINCj4gPj4+IC0gICAgICAtIGFz
cGVlZCxhc3QyNTAwLXNkLWNvbnRyb2xsZXINCj4gPj4+IC0gICAgICAtIGFzcGVlZCxhc3QyNjAw
LXNkLWNvbnRyb2xsZXINCj4gPj4+ICsgICAgb25lT2Y6DQo+ID4+PiArICAgICAgLSBjb25zdDog
YXNwZWVkLGFzdDI0MDAtc2QtY29udHJvbGxlcg0KPiA+Pj4gKyAgICAgIC0gY29uc3Q6IGFzcGVl
ZCxhc3QyNTAwLXNkLWNvbnRyb2xsZXINCj4gPj4+ICsgICAgICAtIGNvbnN0OiBhc3BlZWQsYXN0
MjYwMC1zZC1jb250cm9sbGVyDQo+ID4+DQo+ID4+IE5vLCBwcmV2aW91cyBjb2RlIHdhcyBjb3Jy
ZWN0Lg0KPiA+Pg0KPiA+PiBJcyB0aGlzIHNvbWUgbWljcm9zbG9wIExMTSBwcm9kdWN0PyBJIHF1
ZXN0aW9uZWQgc3R5bGUgbGFzdCB0aW1lIGFuZA0KPiA+PiBub3cgd2UgZ290IHJhbmRvbSBjaGFu
Z2VzIHdpdGhvdXQgZXhwbGFuYXRpb24uDQo+ID4+DQo+ID4+IFBsZWFzZSBjb25maXJtIC0gZGlk
IHlvdSB1c2UgYW55IExMTSBtaWNyb3Nsb3AgdG9vbHMgdG8gY3JlYXRlIHRoaXMgcGF0Y2g/DQo+
ID4gTm8gSSBjcmVhdGUgaXQgd2l0aCBCNC4gQW5kIGNvbW1pdCBlYWNoIGJ5IGVhY2gsIEkgZG9u
J3QgdXNlIExMTSB0byBwb3J0aW5nDQo+IHRoaXMuDQo+ID4NCj4gPj4gUGxlYXNlIGFsc28gY29u
ZmlybSAtIHdobyBpbnRlcm5hbGx5IHJldmlld2VkIHRoaXMgcGF0Y2ggYmVmb3JlIHBvc3Rpbmc/
DQo+ID4gSSBwb3J0IHRoaXMgYW5kIGRvIHRlc3QgaW4gbXkgc2lkZSBhbmQgY29uZmlybSBpdC4N
Cj4gPg0KPiA+DQo+ID4gSW4NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjAz
MTQtZmxhdC10b3Bhei1wZWFjb2NrLTQ0MGE5Y0BxdW9sbC8jDQo+ID4gdA0KPiA+IFlvdSByZXF1
ZXN0IGRyb3AgZHJpdmVyIGNvbXBhdGlibGU7DQo+ID4gQmFzZSBvbiB5b3VyIGluc3RydWN0aW9u
LCBTbyBJIGRvIG15IHN0dWR5IGluIExpbnV4Lg0KPiA+IFVzZSBmb2xsb3dpbmcgdG8gZG8gY29t
cGF0aWJsZS4gTm90IGFkZCBkcml2ZXIgY29tcGF0aWJsZSBzdHJpbmcuDQo+IA0KPiBSZXBsYWNp
bmcgZW51bSBpbnRvIGxpc3Qgb2YgY29uc3QgaXMgbm90IHJlbGF0ZWQvcmVsZXZhbnQgdG8gd2hh
dCB5b3Ugd2FudGVkIHRvDQo+IGFjaGlldmUuDQpUaGFua3MgeW91ciBmZWVkYmFjaywgSSBkbyBt
eSBob21ld29yay4gRG8geW91IG1lYW4gZm9sbG93aW5nIG1vZGlmeSA/DQoNCnByb3BlcnRpZXM6
DQogIGNvbXBhdGlibGU6DQogICAgb25lT2Y6DQphZGQgb25lT2YgS2VlcCBmb2xsb3dpbmcgZW51
bSANCiAgICAgIC0gZW51bToNCiAgICAgICAgICAtIGFzcGVlZCxhc3QyNDAwLXNkaGNpDQogICAg
ICAgICAgLSBhc3BlZWQsYXN0MjUwMC1zZGhjaQ0KICAgICAgICAgIC0gYXNwZWVkLGFzdDI2MDAt
c2RoY2kNCkFuZCBhZGQgZm9sbG93aW5nIGl0ZW1zIA0KICAgICAgLSBpdGVtczoNCiAgICAgICAg
ICAtIGNvbnN0OiBhc3BlZWQsYXN0MjcwMC1zZGhjaQ0KICAgICAgICAgIC0gY29uc3Q6IGFzcGVl
ZCxhc3QyNjAwLXNkaGNpDQoNCg==
