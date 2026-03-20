Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022126.outbound.protection.outlook.com [52.101.126.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192A284693;
	Fri, 20 Mar 2026 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996368; cv=fail; b=GQuJ4fF94ttBSNDu5hXJAp2o+cjcveS5U/8L1Zxt19bTfudHeZ+AdAIo3d0MXQdj7Un+qMfA3a1CyXYQjPKqWzKTA4rBTE6R+0husLY5xXSRL+IxJWU33nTGeurWRKQZhbStRzfiFP2R5oMRgFJAl63kEjmwAyCRdasnhC3eWdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996368; c=relaxed/simple;
	bh=aGxRlgPrgq4RKQA69stDqD/FhTs29ya9kpoxczY6RBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T/Lb5u7bhl5LvAdFuQjsRcHj+Hf6Ks+YzeZtZngO9OXbEXf0Iu84PGsGwzO8fW4DdRtsBi7ZctNUGnoRk6OYkjzx2L8Axlz6tx2xXgAeDnhylFOdd58nK21MW7lJ0bYeJjHzdI6gzYgrXxRF35BwbokQjRMsgOFHJjdWmon1wPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=V2zT26MT; arc=fail smtp.client-ip=52.101.126.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="V2zT26MT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRoXBahwGTZuqFQSkn+qB93art8fhB2xe2BmtjVG8hLvzRZDmhDZldLADtk07cLjbc623hFMD+GL77MT3nN32azAart1KbxkF88FJZkKB+hIZ0WogGvTbI84OCdQnyRYdChL/t/L9xaX7355q1Y5WKXbdw+2bpIrcUdEGHIl/E8dw2Jj8Yu6lBCnTFIGMheXwKDBJq9MjK59bOgLQbcKIqaru66m0rslGCV/S7M93gPwpDqHhwowgnOMVXE1/TcZz3RwTbYZdrMjGqL4waYS2HgnXK52yyYBaL8+5qREog0ngd9ryc6pnop6yrslNz85UTYNYJ36Hxbs8COVzCkhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGxRlgPrgq4RKQA69stDqD/FhTs29ya9kpoxczY6RBE=;
 b=VTl0YF2nuGhlqt2Qbf7+17z4P7Aown9pE7n0iecIzAtVFjBnW4qjalcM3ZgNSNIcfP69l2Oe+iLEds9G+eUCvYo7DDNniz5h/m0/jYGELzdS2uqFJysBKrLFDXLGCcW/Vif/7hN2rJC0HPtmgbEEW9tcO5WZ+/AWXEE1l2hGdNj30p2JiNq5eV0Ee87xr8wMklifa5xLJK7AmT4H9e5sSQM5ZrTRBKX+rl/xFTa78mZpXLDqX0G4wEUKOAcJNbZoeoqHxnlUkZQkWyjuiEF+0MuoTmy5xUXLbAAvLnH45oVOY0+/Bub9b6/olomqizN7IrNBT6AF9YEm9yq7fmJFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGxRlgPrgq4RKQA69stDqD/FhTs29ya9kpoxczY6RBE=;
 b=V2zT26MTtWTaDvFmAkdfOuEsQZYH6KZqmVMDcrRXk+KcKJ9v/1gbPlCn50LzpvEzUXJccHcQLYDNhuyJmY2HEBbTa0Aybcw6SAxDoFh+fJc0CENRBS1akSQ/35WK9XMk8OoNMaqlOS8AQBz/L0wsFP+SpXd9rgjRJlR30f/XRlx5f/Zkm4t9QXmiYKFTTky0kperBwt7eLBVWphdTe34f9OxN4kFuN9UWOTYcYb7bVvWXIzhKikJPzfvHLKquWqvaNA76wzLFBD8QOfF8dAwOkKx/Vh9AHhxe/91k67qUaVvXDqFqAlslR42K1YyNBqQLHl7O+EnrALOzZuebb/lfw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYZPR06MB6769.apcprd06.prod.outlook.com (2603:1096:400:453::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 08:46:03 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Fri, 20 Mar 2026
 08:46:02 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Krzysztof Kozlowski
	<krzk@kernel.org>
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
Thread-Index: AQHctdLYEgta6oUwokG3QEh/PPkOl7Wz7V8AgAAA4JCAAAUVgIAABEVwgAMoGrA=
Date: Fri, 20 Mar 2026 08:46:02 +0000
Message-ID:
 <TY2PPF5CB9A1BE63A0E8E056E322866B6F0F24CA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260317-sdhci-v2-0-39b1f063061b@aspeedtech.com>
 <20260317-sdhci-v2-1-39b1f063061b@aspeedtech.com>
 <20260318-abiding-sloppy-poodle-efd3e5@quoll>
 <TY2PPF5CB9A1BE666DEF10944BBA2A2256BF24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <f46bf4fb-b6e5-4238-9c23-c435c4b8e275@kernel.org>
 <TY2PPF5CB9A1BE6E474E78EED4F320F2B30F24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
In-Reply-To:
 <TY2PPF5CB9A1BE6E474E78EED4F320F2B30F24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYZPR06MB6769:EE_
x-ms-office365-filtering-correlation-id: 92039189-a384-49d1-da47-08de865d1e21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 XclLH5fJ1oTCS37mf2RdTfhyLn4nF70cBn5V7WunfDzLsdCndYz88RBD9VCUDe+4QS+N2TQkSXLT3OxhD0Jpowa6w92OdIdEdbdDVHsbx9qTd6E3HPvcRKgPR9+SeMXlz+6d8KXMUWooeDz+Oy7kMZnp+ldOP3L2Op1K2gGfCINc8RRW91Vjq9VF2KeO4Ln64+4v3WQSY7DsT+TfdQzu1NqGScpkguq4j7PNTmdRZyPlUIynPlocc8Zq5rl0vfdSRgXMy5CKhWv3zYWN6e9mVAjlOqrJecwg/B/txGKFMOvM22LtAIlCP68aRip0js7U5I6lmkTsyxngfauegAixUQIhNukJ6yl2qrbJ5VDTgJikuuDC4uYYLojVf6WN+HdBkO/z8Xf2o8EGqG3VLGEckP+g2qWzYDowwWhaJk8dpN0LgDGJU9RkBnzklf8c4zUpKOTlmLdSULxlakDXVSJaQWJYqIEvm3SdUs+qba8R/Mmgca9rJt6tIexpBdxK4EO3xpLxLSnQPCk0KYlSD1kJsKSMxhEZEBWeIVVykoQUkfHQPEyGUPS+lhRfxtNiQs5PTc+dxoZBZeGua6itXQChagxT5V/Meba32QFvvjFuMxrrSpWGf8qVLyYRI9BpwuFLYfp5VYCb+58n3rGcVleNhlMRYwkrFvf/tLrOYfn1hdt7xkotB7BdO1GMukbcI/k4UyV741v3e2JcdsPAiKCyPTd7X239muGNy87MjLFP7p8rU27BtkDsAFCJTCKRjAaW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXlhaGg3N1kray80VUtYUmNsS3NEVGFGRG1oY2lpWXp2NTZDd2t2Wi82amll?=
 =?utf-8?B?WWU1ekFORzFhbEt2RjRidDNCSzdjMzM4c3dHQ3l1NDhXU3dJaElvNFE0NlBG?=
 =?utf-8?B?SUVRU3JlZVRhdGlFZHMzQ3pONFA2OGlZT3o1aHpIRnJKMndHNVhnUmRDYm9N?=
 =?utf-8?B?aU9zMVh4TkFzRUY0UDRiU3BGK2Y5TVF5VHNmVzRLRkdabkNwQnU1M0IzUHdy?=
 =?utf-8?B?bGtDeWo5c0hwaWdiMCt2RFNvU2FqV21OUjNxOGFiQmVRV0tYMVdxQnRwa3Fy?=
 =?utf-8?B?RE9qV0l6SGp6K1FnMFhmMmM3MGVBSTVSMnU5RjQ5NWJxRVNRWHJmK2JVZW9J?=
 =?utf-8?B?b1N0Z2VYK25oRzlNTUNLSUNTQTFvWWZKcWRLalBLa3VGTGZVMnp1cW9wOUpi?=
 =?utf-8?B?QW5yWk5qS2U5Zk0veVV0dWtmY05XUHNUQXl6bDZMRmEyc05ZSDJ5WmdCNlRC?=
 =?utf-8?B?bVNLb3VvczRkbm9BL0dVeHJjdjloUEIrZC82OENkSHQzL2M0cFlIa1NJcHBY?=
 =?utf-8?B?Y2JUMERWclQ2VmxrRTJxaVYveGdueVJ3TUZ1dyt5UTJDSy8xVW9ucEIvN0JM?=
 =?utf-8?B?T2sxZTdzTUVicEw2Q0YyTExteVhVcENPdmV3Yzl2SGQ4VmY3TW9SWkhQS0R5?=
 =?utf-8?B?NWYwT3YzaG9UYjcvTnJUcC9PYmpZWEt2ZjJvR3kyc01ZZXhhdW42Sk1RUzU4?=
 =?utf-8?B?bWJGdENibnU2aHVBdTlrZGFEUGl6T1VFYWdzRmZZY3ZnRVFZQ2toRHpjSGha?=
 =?utf-8?B?Ui9BKzhoSUFINnJXcWdNMDBhZDVDd3ZmMXcwSzRCamtTdjh5SlNLRjh1Ump3?=
 =?utf-8?B?Y2ZnTTR0d3gvSkpyem5ieHM1eXRETTI2dGFoZUx2R3c1U3lLa0VkYVhpbytB?=
 =?utf-8?B?OThkTXA1Qm1FNTEvUC9BSVU0OG5nemNJMEFBNmY2Q0QwbDM5Z09NN3NhNGti?=
 =?utf-8?B?bVdNMEExOU9ncWlWcis2WEQ3MW1FSDlqYzhCVnhOeGZId2FvT1lBZFNUTkdW?=
 =?utf-8?B?dWRpQS9rRFNtMHJFeWV0YW5mU1d0WXlGUkdlUFZWMnpLY3M1OUlCT3F2NlJh?=
 =?utf-8?B?VklGbmtZZlZqVExzUHZrc0NyR3hvLzNWcnpRTThKRXhFQWFxOElSS1RuT0hB?=
 =?utf-8?B?OURiQVd0NUNOK01Jc1hmR2pjYmRrcGp3aFJjRVZsT1kzeXBWWjJoQk9sTUhR?=
 =?utf-8?B?UzhRZUt4Q0RZT3pDWmtIZkNmb2JuVmtuWkxHejVTaDV2TFFiUTlmL1J1bW1u?=
 =?utf-8?B?UWNoVVQvcW5OZ1Z0QWFSaDA3eEZ4MjV5UHl2N1R0LzZybmhURnRwOTRTRnQx?=
 =?utf-8?B?ZnJpR2orV3lteXFydFBORDJXMzBQb2F1bGpFd3N5S29ZMnB4UEZGUEVmcEZE?=
 =?utf-8?B?TENycTdDUjZ6YVFsbDdXRGxVblN1Mm9mNUlBQjV3VmJMRGdWa0NsaG5XWFhZ?=
 =?utf-8?B?Y25WT1duVlJpYjJqMm9RZzhQcTI2djNZWWFENWlSL0NFb3ZhRThrMmdqMmpF?=
 =?utf-8?B?b2VzeERPUEdzTVlxVGNaVW5CMnNzYjMvL21manlqZnpLcGNCeEFoVW1Yc0xQ?=
 =?utf-8?B?RzRGKzkrUzRJSkRybXZqaTNHeHl2N1R2ZDJET0ZIUDl3R0lySlpORHJwc2tF?=
 =?utf-8?B?MVZJazJGV0NLS1hRcFZZdG5JbFdBc3hvbUdET043cStWenVRWVIrSnVOTmQ3?=
 =?utf-8?B?SWdRT1VKMVF3WFRuZHI3cGVIQW1CKzArQzZYY0x3T3hzWXlCOVZsaXJpY3lq?=
 =?utf-8?B?bElBMGViYVBlaEl1YTJEejBLc2E3b3hhVUYvbHc5MmdJcktwQlN2MDRqYmJq?=
 =?utf-8?B?MEVrWkUrNVdYbElTNTI3SjR2VGlCT0doTXZOeWczZmk2WGNVdXh0R1h3WWwy?=
 =?utf-8?B?S0V6cTQ2TldKbURlOFdZcGdBb0g0SHpXdWdnNHU3Y3hCaTF2UXFEZ0pkNzRo?=
 =?utf-8?B?MVJXRThXSC9ZbDNBc0k4bXB3RHlPMUl5VUxrT2pUdG9UbDBPOU1MWUM1cXM1?=
 =?utf-8?B?K1ZhcGw3eVU3S0NZYUF3SnZTcjJzOUJzV3M1aVBWYUczSjVOK2JTUzNBVlVa?=
 =?utf-8?B?NnZRQmpTbkZSdmttY0pVWWtvYUo3YlB6dk0zVi9tWGl6eFozcUxRRXZONE5r?=
 =?utf-8?B?RkNrRFovTndXTWtGR3dwVWdnVEs4Vm1DVncyR0lnNThqbmVzNHIrYmxmQS8y?=
 =?utf-8?B?Rm04YUZzUjJJN0dwb1pKV2xzQVB2OGF4YUM3clh4a29DWkgzVFR4ckFja3Ew?=
 =?utf-8?B?bVJrVlJrcnZSaFpFWTNEdHB4MWFaTDIwVzlvb3crSnY4NTl4M2Fjd1A3T2U3?=
 =?utf-8?B?UzlJREVSMlZRVUFUWThTMFlGZyt3bElnbXkxakdvQTc3ci9lNG1xZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VVGM0ffF5iT7BgjJK7m3aV7+A8heZo/Q/lBEDzAEhB/2hyOaR5OiR4aF1jHb+V185q25k869BhGB/WUKP85GtsPoh4TjIcNaqSHhhDHd+geMvNTZTpa1wFyM9+F3rq5xsYyLyxrYuSAnHtgJH3LyTOgJrM2jjZzcnr+S3c5KshGuGYM9U/wDyzw/Nnbzmr+H5emZj/ZRfItqgnYNGLAPzGraKEoG8CW6gGVvna++hKECeP0641o5E3su6KTQom3iUvi1fBQotB1TTloSHr0mMQctBFSYhYXgAqNImxdsDIPkCivo3UCFY13S2IT99xZx6lAiskkAwvqAwUJXOwhL2Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92039189-a384-49d1-da47-08de865d1e21
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 08:46:02.8690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wAn7BHwb38qmjdh2r5WrkkasdT7vzOxt/VVoGJL180qYYeZZ/OzTD26zCzIIMew8x0s+lpwf5pQk1Colb4oUnRzREkFxQXZRjF9aVDxPEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6769

PiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDEvMl0gbW1jOiBkdC1iaW5kaW5nczogc2RoY2ktb2Yt
YXNwZWVkOiBBZGQgQVNUMjcwMA0KPiBmYWxsYmFjayBjb21wYXRpYmxlcw0KPiANCj4gPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gbW1jOiBkdC1iaW5kaW5nczogc2RoY2ktb2YtYXNwZWVk
OiBBZGQNCj4gPiBBU1QyNzAwIGZhbGxiYWNrIGNvbXBhdGlibGVzDQo+ID4NCj4gPiBPbiAxOC8w
My8yMDI2IDA5OjA5LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAxLzJdIG1tYzogZHQtYmluZGluZ3M6IHNkaGNpLW9mLWFzcGVlZDogQWRkDQo+ID4gPj4g
QVNUMjcwMCBmYWxsYmFjayBjb21wYXRpYmxlcw0KPiA+ID4+DQo+ID4gPj4gT24gVHVlLCBNYXIg
MTcsIDIwMjYgYXQgMDE6NTY6NDJQTSArMDgwMCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+ID4+PiBE
ZXNjcmliZSBBU1QyNzAwIGFzIGNvbXBhdGlibGUgd2l0aCB0aGUgZXhpc3RpbmcgQVNUMjYwMCBT
RA0KPiA+ID4+PiBjb250cm9sbGVyIGFuZCBTREhDSSBiaW5kaW5ncyBieSByZXF1aXJpbmcgZmFs
bGJhY2sgY29tcGF0aWJsZXMgaW4NCj4gPiA+Pj4gdGhlDQo+ID4gZGV2aWNlIHRyZWUuDQo+ID4g
Pj4+DQo+ID4gPj4+IEFsc28gcmVxdWlyZSBgcmVzZXRzYCBvbiB0aGUgQVNUMjcwMCBTRCBjb250
cm9sbGVyIG5vZGUuDQo+ID4gPj4+DQo+ID4gPj4+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8
cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+ID4+PiAtLS0NCj4gPiA+Pj4gQ2hhbmdlcyBp
biB2MjoNCj4gPiA+Pj4gLSBhZGQgbWlzc2luZyBibGFuayBsaW5lDQo+ID4gPj4+IC0gbW9kaWZ5
IGFzdDI3MDAgY29tcGF0aWJsZSBpdGVtcyBjb25zdA0KPiA+ID4+DQo+ID4gPj4gV2h5Pw0KPiA+
ID4+DQo+ID4gPj4+IC0tLQ0KPiA+ID4+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2Fz
cGVlZCxzZGhjaS55YW1sICAgICAgfCAzOQ0KPiA+ID4+ICsrKysrKysrKysrKysrKysrLS0tLS0N
Cj4gPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KPiA+ID4+Pg0KPiA+ID4+PiBkaWZmIC0tZ2l0DQo+ID4gPj4+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hc3BlZWQsc2RoY2kueWFtbA0KPiA+ID4+PiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXNwZWVkLHNkaGNpLnlhbWwNCj4gPiA+
Pj4gaW5kZXggZDI0OTUwY2NlYTk1Li45YzhlMDY4OTY0YTEgMTAwNjQ0DQo+ID4gPj4+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXNwZWVkLHNkaGNpLnlhbWwN
Cj4gPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hc3Bl
ZWQsc2RoY2kueWFtbA0KPiA+ID4+PiBAQCAtMjIsMTAgKzIyLDE0IEBAIGRlc2NyaXB0aW9uOiB8
Kw0KPiA+ID4+Pg0KPiA+ID4+PiAgcHJvcGVydGllczoNCj4gPiA+Pj4gICAgY29tcGF0aWJsZToN
Cj4gPiA+Pj4gLSAgICBlbnVtOg0KPiA+ID4+PiAtICAgICAgLSBhc3BlZWQsYXN0MjQwMC1zZC1j
b250cm9sbGVyDQo+ID4gPj4+IC0gICAgICAtIGFzcGVlZCxhc3QyNTAwLXNkLWNvbnRyb2xsZXIN
Cj4gPiA+Pj4gLSAgICAgIC0gYXNwZWVkLGFzdDI2MDAtc2QtY29udHJvbGxlcg0KPiA+ID4+PiAr
ICAgIG9uZU9mOg0KPiA+ID4+PiArICAgICAgLSBjb25zdDogYXNwZWVkLGFzdDI0MDAtc2QtY29u
dHJvbGxlcg0KPiA+ID4+PiArICAgICAgLSBjb25zdDogYXNwZWVkLGFzdDI1MDAtc2QtY29udHJv
bGxlcg0KPiA+ID4+PiArICAgICAgLSBjb25zdDogYXNwZWVkLGFzdDI2MDAtc2QtY29udHJvbGxl
cg0KPiA+ID4+DQo+ID4gPj4gTm8sIHByZXZpb3VzIGNvZGUgd2FzIGNvcnJlY3QuDQo+ID4gPj4N
Cj4gPiA+PiBJcyB0aGlzIHNvbWUgbWljcm9zbG9wIExMTSBwcm9kdWN0PyBJIHF1ZXN0aW9uZWQg
c3R5bGUgbGFzdCB0aW1lDQo+ID4gPj4gYW5kIG5vdyB3ZSBnb3QgcmFuZG9tIGNoYW5nZXMgd2l0
aG91dCBleHBsYW5hdGlvbi4NCj4gPiA+Pg0KPiA+ID4+IFBsZWFzZSBjb25maXJtIC0gZGlkIHlv
dSB1c2UgYW55IExMTSBtaWNyb3Nsb3AgdG9vbHMgdG8gY3JlYXRlIHRoaXMgcGF0Y2g/DQo+ID4g
PiBObyBJIGNyZWF0ZSBpdCB3aXRoIEI0LiBBbmQgY29tbWl0IGVhY2ggYnkgZWFjaCwgSSBkb24n
dCB1c2UgTExNIHRvDQo+ID4gPiBwb3J0aW5nDQo+ID4gdGhpcy4NCj4gPiA+DQo+ID4gPj4gUGxl
YXNlIGFsc28gY29uZmlybSAtIHdobyBpbnRlcm5hbGx5IHJldmlld2VkIHRoaXMgcGF0Y2ggYmVm
b3JlIHBvc3Rpbmc/DQo+ID4gPiBJIHBvcnQgdGhpcyBhbmQgZG8gdGVzdCBpbiBteSBzaWRlIGFu
ZCBjb25maXJtIGl0Lg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBJbg0KPiA+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjYwMzE0LWZsYXQtdG9wYXotcGVhY29jay00NDBhOWNAcXVvbGwN
Cj4gPiA+IC8jDQo+ID4gPiB0DQo+ID4gPiBZb3UgcmVxdWVzdCBkcm9wIGRyaXZlciBjb21wYXRp
YmxlOw0KPiA+ID4gQmFzZSBvbiB5b3VyIGluc3RydWN0aW9uLCBTbyBJIGRvIG15IHN0dWR5IGlu
IExpbnV4Lg0KPiA+ID4gVXNlIGZvbGxvd2luZyB0byBkbyBjb21wYXRpYmxlLiBOb3QgYWRkIGRy
aXZlciBjb21wYXRpYmxlIHN0cmluZy4NCj4gPg0KPiA+IFJlcGxhY2luZyBlbnVtIGludG8gbGlz
dCBvZiBjb25zdCBpcyBub3QgcmVsYXRlZC9yZWxldmFudCB0byB3aGF0IHlvdQ0KPiA+IHdhbnRl
ZCB0byBhY2hpZXZlLg0KPiBUaGFua3MgeW91ciBmZWVkYmFjaywgSSBkbyBteSBob21ld29yay4g
RG8geW91IG1lYW4gZm9sbG93aW5nIG1vZGlmeSA/DQo+IA0KPiBwcm9wZXJ0aWVzOg0KPiAgIGNv
bXBhdGlibGU6DQo+ICAgICBvbmVPZjoNCj4gYWRkIG9uZU9mIEtlZXAgZm9sbG93aW5nIGVudW0N
Cj4gICAgICAgLSBlbnVtOg0KPiAgICAgICAgICAgLSBhc3BlZWQsYXN0MjQwMC1zZGhjaQ0KPiAg
ICAgICAgICAgLSBhc3BlZWQsYXN0MjUwMC1zZGhjaQ0KPiAgICAgICAgICAgLSBhc3BlZWQsYXN0
MjYwMC1zZGhjaQ0KPiBBbmQgYWRkIGZvbGxvd2luZyBpdGVtcw0KPiAgICAgICAtIGl0ZW1zOg0K
PiAgICAgICAgICAgLSBjb25zdDogYXNwZWVkLGFzdDI3MDAtc2RoY2kNCj4gICAgICAgICAgIC0g
Y29uc3Q6IGFzcGVlZCxhc3QyNjAwLXNkaGNpDQpIZWxsbyBLcnp5c3p0b2YsDQpJIHJldmlldyBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9s
aW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZXhhbXBsZS1z
Y2hlbWEueWFtbD9oPXY3LjAtcmMxDQpJIHdpbGwgZG8gZm9sbG93aW5nIG1vZGlmeQ0KLSAgICBl
bnVtOg0KLSAgICAgIC0gYXNwZWVkLGFzdDI0MDAtc2QtY29udHJvbGxlcg0KLSAgICAgIC0gYXNw
ZWVkLGFzdDI1MDAtc2QtY29udHJvbGxlcg0KLSAgICAgIC0gYXNwZWVkLGFzdDI2MDAtc2QtY29u
dHJvbGxlcg0KKyAgICBvbmVPZjoNCisgICAgICAtIGl0ZW1zOg0KKyAgICAgICAgICAtIGVudW06
DQorICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNDAwLXNkLWNvbnRyb2xsZXINCisgICAgICAg
ICAgICAgIC0gYXNwZWVkLGFzdDI1MDAtc2QtY29udHJvbGxlcg0KKyAgICAgICAgICAgICAgLSBh
c3BlZWQsYXN0MjYwMC1zZC1jb250cm9sbGVyDQorICAgICAgLSBpdGVtczoNCisgICAgICAgICAg
LSBjb25zdDogYXNwZWVkLGFzdDI3MDAtc2QtY29udHJvbGxlcg0KKyAgICAgICAgICAtIGNvbnN0
OiBhc3BlZWQsYXN0MjYwMC1zZC1jb250cm9sbGVyDQorDQpUaGFua3MgdGhlIHJldmlldy4gDQo=
