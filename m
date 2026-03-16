Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022123.outbound.protection.outlook.com [52.101.126.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027EF7DA66;
	Mon, 16 Mar 2026 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773640299; cv=fail; b=a8j7IRaJcxlVKQPHpFR2bGI2PIDpAXvY7TwUsvJ0V/3fwn3X9vcvaY8gqjqtw2gUjUPjCohATJ8UBWaSJmSSWP1yjYzYgHurl9y/pTP4OXyToNllo70ZTVGXJ/8V3r2snSNkivAcyNiENzg4poPDjG+twHpd+WfW1hE4a+iTkkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773640299; c=relaxed/simple;
	bh=/OadVUYpxysa/fmMf1ff42cfh79RfaBFvMO/Lh+7iv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mx3TXVaD8xX1ZfmezF+gmlsg6Cr2QsMLCnlD+JugeDxGu9erLj9mE+Nk8Jm3FhffcURQD76f0jIA80eBifxCVoxjTUKDC11fXrIuE59+YaDBgtn395qCFtc8HdCkCOPuayc9A+uXeu4azYjoeIlThX6hjLTAwSS/223zWkOu/QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Uv3bw355; arc=fail smtp.client-ip=52.101.126.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Uv3bw355"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS0ShoAeHmkG3Gma16R8Y1uaiIdAx4f9t7PDEp8AYCdGJlxL3hKzEg1UG2aEnjoWcrfiB+dlevs2FM1xkqB3cxW6hXgRtkUoxVw+89swlc76SqWqilnfen7X3NkO6+B1jY8lONEAs3l1+qDZUQmrRrTN13d9ffZI8YLeV8CV470dAI0XHAzlj8NoeW8m5fm682Y05GOlDCtxPPklDXq877Hwi3ut5LIveuFQ109wOr5sD9cMygkJFbL/xbkycXqq/kVazXbkTWeG8mKav7NwN81R3YPygVrBCzvAvarjlCddD3ZF1D3BDcwOZUIOfi+6msUQgRPoIR6k5uvmidIgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OadVUYpxysa/fmMf1ff42cfh79RfaBFvMO/Lh+7iv4=;
 b=A374WoLe3hWcKwqTX6V4yCf9MH6lI6eBP78/hQcHQlrvT0bnl9mfoqA7X1+NVatkPO/2IWh3DuZRFA/0AQu5xaf8Z6Y7G2w9O7/NBtJ2gOnJuqNVw6MZpaQCnZ+jLqDjfrtfZ4ZNS2HkXb3rCLWIDhLP0oCa3qsKmVFqBFrFllVsksoIjCJK2RZtW6ds1ZZsfRXCuRjJfbYAROcLJz7PvQkCxjmiKNI0Jxv0tnqeA75qQIZvY3IZIc0fQKek1h5VF5mFzbI62JiCBwE9cvtiW9BCFTvj4x+WMmxOv8VeOJm4rnvX+r7LQdvP8KIjbedek8gHTl3+DFa19i5x9VNVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OadVUYpxysa/fmMf1ff42cfh79RfaBFvMO/Lh+7iv4=;
 b=Uv3bw355eNub3BopwafCn7giLAD6B514jKy9xIdYnsx8an5uPWSuobGnqdiEvbaTjBbe+I9PxMTEn3sRdpYXtaMj/5bdo21nE0iWaCU4n2Fpk96PY1baVsBI0NVEgv2OORP5yYQ3en/Uwz2XWzp3dX7VzTj4slDY3IichV8qheWrKtRk5JjIWjoBdM/nY2tuRkND0ulMqNLq54H/5z2brts+MElXMytN7Rxpuw5+IItcMgHPnd2DUze/l1b+lf0Y9/mOZJK0V9LH+ixTi5fZaMWIPa/jqsCS799MozdT5+JQgOAr4yO1Itpn8IRsQRtZzxvrKHXCmOOCR3aNLlT04Q==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SG2PR06MB5192.apcprd06.prod.outlook.com (2603:1096:4:1d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 05:51:33 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Mon, 16 Mar 2026
 05:51:33 +0000
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
Subject: RE: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
Thread-Topic: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
Thread-Index: AQHcsqoqa/wkH2eIMUucFBg3jcknirWt0/oAgALX16A=
Date: Mon, 16 Mar 2026 05:51:33 +0000
Message-ID:
 <TY2PPF5CB9A1BE642DFDE4862B40BBAA1DBF240A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
 <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>
 <20260314-flat-topaz-peacock-440a9c@quoll>
In-Reply-To: <20260314-flat-topaz-peacock-440a9c@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SG2PR06MB5192:EE_
x-ms-office365-filtering-correlation-id: 58bf9a1e-e183-4353-f553-08de8320146f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 4l0uOKNs5R3huA6C70xxzXI5WMj5S64msEnkNSHUXokY+jx0AHD5DPvviusiMEjwhru8m6ltGC83St0Fib3ojSNyNAnPn4KuUMHzqXNgY5b4QrF4xUjpBZlhW3lIL1bSB89Mz3lg5O8aDHxA6ZqrsPAXcQUubhLIU/8WjvvH9khATefAPTFi103BxVta1XDnD/omutzwCm/RW1yqb9EhGURLa160PzivC/fOlWHtEWHqYluGc4om3GJN9FxkqNqu0L7fdoJLrde09RSItncN9cwCfn454cn1DsRChVVSSK4jYRk1k7fmnyotm8tqSQcMpJkoQWOZxL2wqucYAaorw/HtP/RMAmjUhYF4oBXgGfKZwV75M7Y03220caIB5zJ89X5bXJ0/m8jpIJfJhrhGqdfyiCXNvO2LWYX5FrouO5BHROYEw0Rxt9uvevKXoPLTC+x96rwQRuNWhZjW96qznHqPR8NI+RRYHXB2NJ/7DbHBzNhcbxjL3bFxtv5TSnop3AMdR9ZSIMji+MS+Ix2pYGLnBJqMvO1cYplcG6TE3zvNuN7gbsuXpdgdWK6FKOSo/jfx51D+1OxH1hhZKLR36ldXHxxqlLh123u3fErWtek+dO7nKwpisNLSwpcw6t7A4z+t1x5TVpmTLnMt3lTvcFBDhxib99RWP3Z7sRW3qPmIt3qrn1twlD8IDTTV6kZ8vkR7MLMoqigh1/lDhj96z61QbPzS6yF+FTxMTlCwxdSsKo5b9ddbXUNSDQY5gXiKDMNI37ff+hafZkbxJ1i5KxKUl9sI3ypaVMFd4OEfMdk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjA5SXIvbVdVZjZpamRmamtHY0VpZklCNkhtb05RZ3k3S2FVWjJ6RHF2UnB5?=
 =?utf-8?B?UFpNTjF6dWthZ2pFK25HTkM3bnNEK3Z1aFBUK2piOFV2Y0x5WXh5SUkvRXg3?=
 =?utf-8?B?ZlJFREN5b2ZHODZLb085c3RNOUJYVERtanQycllqaHFUdjk0U0lLSm9kZm03?=
 =?utf-8?B?NGtQbXdFbkQyVWlXM3VKdVBaclgvRE85OXdqYWphNW5GZkF0VmxZSTFnOWRE?=
 =?utf-8?B?UGRoRWJnSmcxU0lzS1VUVm5YSWcyRnhITld5TXUza01udG9tQWlIakR0Mndp?=
 =?utf-8?B?NHdNWERqakM4eDdyNG9MeTdlcUl4cTJwcFlPYlNzLzJ6N3cvL2pGc1RqUW9P?=
 =?utf-8?B?SzVCemRZQ2ZhL0w1WGF6VnpKWjRiTktyWktLcTA5dWdsdkFWa1ZGYXRKMWZD?=
 =?utf-8?B?VU9WWWJiWjExTDZvQUlsNjVoa2tLTWRHSCs1bndoaEhURGJmdzVaZGdKTGVL?=
 =?utf-8?B?eC9VK0pkdHk1aTlUWnFneS9YY1JyamU4akxXcENYeUEyY0VvMFY0TWgxaWVn?=
 =?utf-8?B?bUtzMVZIazBrdnpJT1JzeTIxdjQ4MHErLzNBaXVlaDJOd3BDSk1VYkNJK2V0?=
 =?utf-8?B?QS9XM2R0WTE0SW83UStTYXNvOWsrRUtXNHQ4b25xZFMwekVsa0hxbm9MaU4y?=
 =?utf-8?B?Vjhubk9TcTRXaTNxY2s5UWZLbWpvamNaVXIvb0JKUGxGQWh5b3pDQmRiMzYy?=
 =?utf-8?B?MjNGdGJkMDAvdzB6eE5DUTl2VUxmU3h2L0VFajFvM0Jtd3FPVGRla1BwbHlO?=
 =?utf-8?B?NVBLSmpKN3FwcGlSRWMxYU4zMFlDM1hSK3hrZ29qZTBDYThqQUlLdFdKaXFD?=
 =?utf-8?B?anAzclprV1hZT3k5eE9kRHdOTnJtMCtWRDQrUFpxdnlvQnI5enNEUC9YTzRv?=
 =?utf-8?B?NnpHTU5FazdGQ0pGSU9OZElzS05PeUhzSC9wdll3Tmd5M3VNbWxEQXhQaENm?=
 =?utf-8?B?NUh2dGRGYThvOHQxYUk4RVorZFZ2SHB6MWxGV1hRYVdpR053RkVaSVZHQTBZ?=
 =?utf-8?B?aXl6VTF6T1pFZUlISVJuWG5KVEowSTJtRmRpd0o2a0d2WUF0ejNJV1hIb1oy?=
 =?utf-8?B?UllJdnN5bnhqWUdWYWJjcHNhcXRCWFl4dDF1ZXhHbWFxdkt1Wng5TG1YUS9E?=
 =?utf-8?B?NHBUcGVHSzdWWEdzTVUrZ3M5TjZDVTBJbVhHWnpCdGpYdlNWNWcyTFoxV01I?=
 =?utf-8?B?UU1sTlh5UDRiZUE5cXpTbE83b0lrL2VVMjhpQVUvTGI0c2xtV2MzRTUyM0dJ?=
 =?utf-8?B?bXQ5R0pIaStJMzlIMzJKaUhpUndqb1JBdWFGZURWVUxxd2FwamNTTzFMS0pn?=
 =?utf-8?B?Sk50b24zRkpyMS83cm15cUlpd0RONkxyY0hTSU5aK1oxTzlZalpRYTR1V2kr?=
 =?utf-8?B?KzFSWkRsbWpkbUtNbldJNEptWHZ3Qnhod05rSnBRRms3ZkNLU2xNTFlRc3A2?=
 =?utf-8?B?QmFnQm9WT0lZWjdrZWhkdnIyK3puTXFmVDg3R0ZzTXZPL1VyQmxqeUsveURK?=
 =?utf-8?B?eVZiNEM3VnVlUy9WYUJVT05QWlpPKzg1MnhyREtaWWlWRjludldzRHhYazFK?=
 =?utf-8?B?dFpSTVBhNW44SUVSNnNYZEMzd0VHSXYxWGNFeFp3eG8vbGs5clp2VFhTcHdk?=
 =?utf-8?B?bmJlalE0bEhrNDJRT2drMWNTK1Erb0RSS01WR1czWDFIcnZvKytVWVZLME1J?=
 =?utf-8?B?cHl4Q2NxdHV0Yk9pS2xBOElHc21wQzFMaHF6ZnVUMjV2eUNHdE1rdFVtSzk0?=
 =?utf-8?B?MlhnbmdPYWd6czk5WVhlc3lET2xmaG43TlJYZE8xdExjWW1PdnZEUHg1cGIy?=
 =?utf-8?B?c2NZUWgxZnJScWZwTk9haitYUXp4ekN6ZFp4ckVhalpORkgzTUg3MVZEb0Nq?=
 =?utf-8?B?SlIxR1oyZ3RGZXdia1NXbEF3eFpHd01LQmg2dWJiTmJWVER3TGpON0x1TXZD?=
 =?utf-8?B?RXVGZDkyUi91bTJtckpuQWF5dnlQejBmNWt2aGhWNTVscjhCZWhma00zbkdn?=
 =?utf-8?B?bmFUNkFEaGU0R3dqVjN3L2EyeTllaXpUZS9COFpnQWRSOHZqZXZrVDZ3d2lM?=
 =?utf-8?B?UVNDcEQwSWxYMFduclVPT3lzUVZhNWFka21SY2lLRHJ4bEQweXppTUhZRi9L?=
 =?utf-8?B?TExvQ3UxRWdwUXg5a2EwZEFCV0dLVkU0MncrTkNrWHRtd0NNK0NyWFNoZE11?=
 =?utf-8?B?TjRSbXpKRzZ1eW1nbEl1SW0vcHBiRytpZlp3Q1ErRTR6NVNSa3cxRW9nZzVl?=
 =?utf-8?B?QUM3YU02aWZuWDNqWjUxeVo1blJnYWQ5Qm1lN1RzandGMWR0cmV0bGYxaHZz?=
 =?utf-8?B?eU4wb2UzSVdncFQ0Z3dIYzg1MUhpOE5TQjFJakFoZ25uZlVJbjRkQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	OWXikPM8ovqULdbaaYp4LWz6UqJPQyhvyuL5gdraZFNqtahdtxtaSj120Z7TWZR00Wmt4cGS8nDzj7Xls6hnub1R742nviZb71s3Z7U9yvoguckkbcUfG6xJrl74JueOchFrLSjF67WX5FmP6aggAn/6WQVckNXiBiBgwYtGoao+wpoP//jGYCGXe+yKnSS4PR+HUzgx6L7je4iXyhdbmMfhmQuGSeikgFCEt07DsvIuH0y3MTUMv4h+XFaYs3oKlnv8k2UOl1EKnQlJVvXnyI6OuMAat58bJdNBPhfHcuZbpg3wrS4h0tdYx+6tCeJAQELeurvr0Yq2NZc32+piEg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bf9a1e-e183-4353-f553-08de8320146f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 05:51:33.8125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t65Une8PSjvCSvAff31/BxkGo7Sa2+aJhwWGBb3p4Pwt/f0Cv/e4QPS6Sylzm+I9EU3pqTlnlkwYh9fbsAOdAjdH1D2sgFLSSa62Ov5fwvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5192

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gbW1jOiBzZGhjaS1vZi1hc3BlZWQ6IEFkZCBhc3Qy
NzAwIHN1cHBvcnQNCj4gDQo+IE9uIEZyaSwgTWFyIDEzLCAyMDI2IGF0IDAxOjI3OjU3UE0gKzA4
MDAsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlIEFTVDI3MDAgU09D
IGluIHRoZSBzZCBjb250cm9sbGVyIGRyaXZlci4gQVNUMjcwMA0KPiA+IHNkIGNvbnRyb2xsZXIg
cmVxdWlyZXMgYW4gcmVzZXQgbGluZSwgc28gaG9vayB1cCB0aGUgb3B0aW9uYWwgcmVzZXQNCj4g
PiBjb250cm9sIGFuZCBkZWFzc2VydCBpdCBkdXJpbmcgcHJvYmUuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hc3BlZWQuYyB8IDExICsrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hc3BlZWQuYw0KPiA+IGIvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1vZi1hc3BlZWQuYw0KPiA+IGluZGV4IGNhOTdiMDE5OTZiMS4uOTFjMzYyNDVl
NTA2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXNwZWVkLmMN
Cj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFzcGVlZC5jDQo+ID4gQEAgLTUy
MCw2ICs1MjAsNyBAQCBzdGF0aWMgaW50IGFzcGVlZF9zZGNfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZQ0KPiA+ICpwZGV2KQ0KPiA+DQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqcGFyZW50LCAqY2hpbGQ7DQo+ID4gKwlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcmVzZXQ7DQo+
ID4gIAlzdHJ1Y3QgYXNwZWVkX3NkYyAqc2RjOw0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+IEBA
IC01MjksNiArNTMwLDE1IEBAIHN0YXRpYyBpbnQgYXNwZWVkX3NkY19wcm9iZShzdHJ1Y3QNCj4g
PiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4NCj4gPiAgCXNwaW5fbG9ja19pbml0KCZzZGMt
PmxvY2spOw0KPiA+DQo+ID4gKwlyZXNldCA9IHJlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4
Y2x1c2l2ZSgmcGRldi0+ZGV2LCBOVUxMKTsNCj4gPiArCWlmIChJU19FUlIocmVzZXQpKQ0KPiA+
ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsIFBUUl9FUlIocmVzZXQpLA0KPiA+
ICsJCQkJICAgICAidW5hYmxlIHRvIGFjcXVpcmUgcmVzZXRcbiIpOw0KPiA+ICsJcmV0ID0gcmVz
ZXRfY29udHJvbF9kZWFzc2VydChzZGMtPnJzdCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJl
dHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsIHJldCwNCj4gPiArCQkJCSAgICAgInJlc2V0
IGRlYXNzZXJ0IGZhaWxlZFxuIik7DQo+ID4gKw0KPiA+ICAJc2RjLT5jbGsgPSBkZXZtX2Nsa19n
ZXQoJnBkZXYtPmRldiwgTlVMTCk7DQo+ID4gIAlpZiAoSVNfRVJSKHNkYy0+Y2xrKSkNCj4gPiAg
CQlyZXR1cm4gUFRSX0VSUihzZGMtPmNsayk7DQo+ID4gQEAgLTU3Nyw2ICs1ODcsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiBhc3BlZWRfc2RjX29mX21hdGNoW10gPSB7
DQo+ID4gIAl7IC5jb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNDAwLXNkLWNvbnRyb2xsZXIiLCB9
LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjUwMC1zZC1jb250cm9sbGVyIiwg
fSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI2MDAtc2QtY29udHJvbGxlciIs
IH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLXNkLWNvbnRyb2xsZXIi
LCB9LA0KPiANCj4gU28gZGV2aWNlcyBhcmUgZnVsbHkgY29tcGF0aWJsZS4gWW91IG11c3QgZXhw
cmVzcyBpdCBpbiB0aGUgYmluZGluZ3MgYW5kIGRyb3ANCj4gdGhpcyBodW5rLg0KDQpUaGFua3Mg
dGhlIHJldmlldy4NCkRvIHlvdSBtZWFuIEkgbW9kaWZ5IHRoZSBiaW5kaW5nIHdpdGggZm9sbG93
aW5nLg0KcHJvcGVydGllczoNCiAgY29tcGF0aWJsZToNCiAgICBvbmVPZjoNCiAgICAgIC0gY29u
c3Q6IGFzcGVlZCxhc3QyNDAwLXNkLWNvbnRyb2xsZXINCiAgICAgIC0gY29uc3Q6IGFzcGVlZCxh
c3QyNTAwLXNkLWNvbnRyb2xsZXINCiAgICAgIC0gY29uc3Q6IGFzcGVlZCxhc3QyNjAwLXNkLWNv
bnRyb2xsZXINCiAgICAgIC0gaXRlbXM6DQogICAgICAgICAgLSBjb25zdDogYXNwZWVkLGFzdDI3
MDAtc2QtY29udHJvbGxlcg0KICAgICAgICAgIC0gY29uc3Q6IGFzcGVlZCxhc3QyNjAwLXNkLWNv
bnRyb2xsZXINCg0KQW5kIHN0aWxsIGtlZXAgdGhpcyANCmlmOg0KICBwcm9wZXJ0aWVzOg0KICAg
IGNvbXBhdGlibGU6DQogICAgICBjb250YWluczoNCiAgICAgICAgY29uc3Q6IGFzcGVlZCxhc3Qy
NzAwLXNkLWNvbnRyb2xsZXINCnRoZW46DQogIHJlcXVpcmVkOg0KICAgIC0gcmVzZXRzDQplbHNl
Og0KICBwcm9wZXJ0aWVzOg0KICAgIHJlc2V0czogZmFsc2UNCg0KYWxzbyB0aGUgY2hpbGQgDQpw
YXR0ZXJuUHJvcGVydGllczoNCiAgIl5zZGhjaUBbMC05YS1mXSskIjoNCiAgICB0eXBlOiBvYmpl
Y3QNCiAgICAkcmVmOiBzZGhjaS1jb21tb24ueWFtbA0KICAgIHVuZXZhbHVhdGVkUHJvcGVydGll
czogZmFsc2UNCg0KICAgIHByb3BlcnRpZXM6DQogICAgICBjb21wYXRpYmxlOg0KICAgICAgICBv
bmVPZjoNCiAgICAgICAgICAtIGNvbnN0OiBhc3BlZWQsYXN0MjQwMC1zZGhjaQ0KICAgICAgICAg
IC0gY29uc3Q6IGFzcGVlZCxhc3QyNTAwLXNkaGNpDQogICAgICAgICAgLSBjb25zdDogYXNwZWVk
LGFzdDI2MDAtc2RoY2kNCiAgICAgICAgICAtIGl0ZW1zOg0KICAgICAgICAgICAgICAtIGNvbnN0
OiBhc3BlZWQsYXN0MjcwMC1zZGhjaQ0KICAgICAgICAgICAgICAtIGNvbnN0OiBhc3BlZWQsYXN0
MjYwMC1zZGhjaQ0KDQpUaGVuIG15IGR0cyB3aWxsIGJlIGZvbGxvd2luZz8NCg0Kc2RjQC4uLiB7
DQogICAgICAgIGNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI3MDAtc2QtY29udHJvbGxlciIsDQog
ICAgICAgICAgICAgICAgICAgICAiYXNwZWVkLGFzdDI2MDAtc2QtY29udHJvbGxlciI7DQogICAg
ICAgIHJlc2V0cyA9IDwuLi4+Ow0KICAgICAgICAuLi4NCiAgICAgICAgc2RoY2kwOiBzZGhjaUAx
MDAgew0KICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI3MDAtc2RoY2ki
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYXNwZWVkLGFzdDI2MDAtc2RoY2kiOw0K
ICAgICAgICAgICAgICAgIC4uLg0KICAgICAgICB9Ow0KDQogICAgICAgIHNkaGNpMTogc2RoY2lA
MjAwIHsNCiAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLXNkaGNp
IiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImFzcGVlZCxhc3QyNjAwLXNkaGNpIjsN
CiAgICAgICAgICAgICAgICAuLi4NCiAgICAgICAgfTsNCn07DQoNCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQoNCg==
