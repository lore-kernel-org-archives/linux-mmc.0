Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010031.outbound.protection.outlook.com [52.101.228.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807FD2737F8;
	Sat,  8 Aug 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198923; cv=fail; b=N3DOL1pjwDW03jbVNandkXzYCpgKV6/8ftERb8lQ+OofZjFBjrJVcAit4ooNKov0habehvwVRna+2tBzFSUJHw+Dd0QStsUzAdIEAl16uWbw5rgsCYK/DaTuD9tdsoWHnO/GoOgj5MZJ/awTJgAgTDFB8aKeIvq9TX4TZ948074=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198923; c=relaxed/simple;
	bh=pJBH5xAht05kr1bztfhW2Qr7J4t+YV0ONObVQ+X0hr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U4lScJpCMSdWJzresoiI08OxprDYN9GdVdWdOcvCTq2P0ReETT8UjPd7d4wXGlnb37XW8upcsJMS///4Nk0tJY4G4H7YYWu75UZ4FF3pHvCmd0vA1SoMPX86SC95z3UWnT+sYSvTVjf2vnXu7pX3CLWTtAVl7phCiTMAdVFG1H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=QCPPXmz+; arc=fail smtp.client-ip=52.101.228.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QCPPXmz+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVa8tJYC6LToQ6n44oNBVRc9FwzWGv5RBs7dWCi01jrqqHCr0OeUysxO31mpf0yNJWn13um0QWnG3PK8yZxVzjCkCQWsS7q4fK3hxKe9Ke7KVNFnvJBC7mZ0PPM2AMwbi0yS3GYI3H7SC+2s56180s1qEfGGZ57vLS62VTlLSdSbOW6kBQRC804BYylvdKbdMgTzuon8BtwZ08dNp/7c9o5voBDrLaH6MAsv7UKT5/iK49/9oH4ZsrI/pjJKWeBcqnDeKnHoQYPkoOvNKimvvji19aG34Wfqgo1OfnlKM62t3cqDTR0XLRrohMHmzBmcSUtXTyTX2thMMu2fzeTBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJBH5xAht05kr1bztfhW2Qr7J4t+YV0ONObVQ+X0hr0=;
 b=yOHLbYV92l3l0K7uJ0VhhAtiK9/S/Z3T0Agtk1+ob/3Q7hUnl2U9kjcBDi1/VSykjApAgPVGvZefmvOEAyJBI5HBjHFwuYf2in8Nolf9LlxfrsM3mFD2CgWHBrBoiFw+O9qIoB5Ldc1emhp0iwL4P0VtLMCa1d1sOpaE4DXsogw9J196G8Puug6QkIxxL8XQp63wdm4AltgiTCJpssQ4Q83VhuguIKm+s5edL+kJeU0I5k6io180cT+GspQ9MdbJDE/GRqEEN7GAbZAmL7zKpYNmFUEblNGiRsnwWly/0D6dnYf+J/s3trWVQczoDqEL0UhyqCI/7Je3e0aupO8ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJBH5xAht05kr1bztfhW2Qr7J4t+YV0ONObVQ+X0hr0=;
 b=QCPPXmz+C5V8jNODPAcswdKAaCeokvRtCv/GkmphvT5qpfJUXGPhdxw1MBLviUHxCo+T8bGy+YTFYJEVlVOg5OiZhv3myUpZODA+HrV9dy0pdUwRQtWYxOq2nGu4nftPRhgHTOKS7u9suNMf9OmLDgRjaLw9qO+lUp32NMba4W0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB9689.jpnprd01.prod.outlook.com (2603:1096:604:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 14:21:58 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 14:21:57 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, "biju.das.au" <biju.das.au@gmail.com>
CC: wsa+renesas <wsa+renesas@sang-engineering.com>, Ulf Hansson
	<ulfh@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v23 13/14] mmc: renesas_sdhi: Add RZ/G3L HS400 support
Thread-Topic: [PATCH v23 13/14] mmc: renesas_sdhi: Add RZ/G3L HS400 support
Thread-Index: AQHdIBcWfjjow0EjQkSIRddv1KS8ZraSoCQAgAGhHaA=
Date: Sat, 8 Aug 2026 14:21:57 +0000
Message-ID:
 <TY3PR01MB113469EB645EA5D76F49AB7D086D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
 <20260730113200.36456-14-biju.das.jz@bp.renesas.com>
 <CAMuHMdUkagUkD=HhfstYyazZdv25F6ab-ZM7k9T0=EQtfindvA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUkagUkD=HhfstYyazZdv25F6ab-ZM7k9T0=EQtfindvA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB9689:EE_
x-ms-office365-filtering-correlation-id: d61d69ba-9df1-4337-dd81-08def558679e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 ip1pPVxwNETEQoRLMvBNJm5q9+WCCYlA6WJRZBnC3A2fjET78cWbn6TzUvxKTpsamnbelA3uxfwU6GKZkfrJzr5poIhXRPpwcuJAlF1YtwbSXq4+AurrPkmP6nZBQR1uHC1Uma9bkBmTUYJcdjBhrGPsAvGHKX/U+hTdbcSvOF//Z3j9Qo7B3RMg3HrDZmF45ZvNMsEHbo7hjXp0WSS0rqQu5TYkrM+D1iRY1C3+Nc5xBlZQ2sGtio1xFk8XYckJYB5xs8jwkEtU5bIXA//lXYT6RhL8ZI5m5OM5EklqMRg0IJNG6ToKQlIYhyJptsiSO79ZA8O7vvmGYWpvGHU21gAvaRJSh4337DJsSk18Mf+K1vvrgrsaTp/fnuxw2C2gbNhQtsGsj6axs6iaUtisGDoxdmN+FqZOAXgQxQRIv89fuF/bAJLdzL5crI8uTsr1YGnXEB8wV28j6L0eZN7v3eEa2fu3fAGf1K8oUD5s12T8AAUMknsd3KU4uVfahj9HKDh9seg6bcC4vQ2G4I/8ipJsGyFIfmWTGTb7aUE0jzhbUpMagO1axsRpwB0Zn4/5aqvGP9GNT404DFd7IYK5JAELScNG62D/cI8WoLy6TDSr46g0UIQ7ubLSRiGJPQb9CzbwlOXjG6jEZOW4F6Qe3DUenvW7g6uHYb66mV8HmxmdQUCYUh6eUFOmEzemnVBuAt3m+Dw9AI5gDACQicVgJxQoEKmtxPEBluT/MXbFrSw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTFxL28xNURrVkFrNTlINXNpbTdIK2ZGMlBRYU5YWVBVVncwZzhsM0hpUGp4?=
 =?utf-8?B?SjR3ZFlRQlQvOE90bk9RTU9yWENRNC9oWlpnaHpmOGhZOVc4V2J1RldVUUtk?=
 =?utf-8?B?Y012Y3A2SEhMU3Q2VzF3aWhzUzJmVjR6RURqMzQrSEtFTFhCWW9Rd1k2YTUw?=
 =?utf-8?B?WWVGc2w4Uk9iYlZ0TGwyTnphTm1mUExXVlUvRkNKT1RxYVVOMFRYYTIrbnBR?=
 =?utf-8?B?cmRRMkZ0M1FSS2l2WnRVK2RMKzdWOGlhMHhjKzFNalFPTGRnK1doUWhzcllK?=
 =?utf-8?B?c2xtUTM1bHFkamdVS0lsTUZiOWpsUncwSjJad3hick0zUW5HL1Z5NjMxTjVN?=
 =?utf-8?B?Vk14b2dzTUZZS1BaRnBhOUkyL3BYVU0vZjllbktnWnJIWDVYVlVqODlFZ1ps?=
 =?utf-8?B?ME5wTW8zQ3JTNmM1UTUzemd0M2M1bHQrWVlqbk1HZ1p6cm5KQldVczJYcW9V?=
 =?utf-8?B?Rmp6S2c0S3ZhK1pVUGM4b05EZ21ZQkt6b1FWdjRQRGlPbmhtMUNKU0l1cnNt?=
 =?utf-8?B?UHdNQ2FZcnJuVktSakhBUjRsNlpFL1d4cW9MSDFFQ042NVBMQmdaTUZjdll1?=
 =?utf-8?B?ZWVDdkE2Z2plNm41YVVuaUhzSGdjZHZhMGttaERzODNDQXMwa2RGQ0xtSUxD?=
 =?utf-8?B?OFMrNHRLN201cEN2dGZHSnhmcGlkWGkzdFIzZzJlaU5vb1U3TElYYis4eWZ3?=
 =?utf-8?B?YWlPQ3hqeFdNcGdhc2hSSHNXN3Bvcjh4YmZBKzBXSjBkQUN1L2h6ZmZVeEZ6?=
 =?utf-8?B?dmh3RUJFY1d1OEhTV0ZmL2FFbUxDQlhOQm16eDBYcHdkaDdQd3JrYmFSaENB?=
 =?utf-8?B?OUZrSEI3OHZ6VFRYaE8reUl3VUJKaS8weWhuaXNLUWNJa2ozUmRnWVN1Tnly?=
 =?utf-8?B?bHhMWTEvazEvVURLQlpNaXhDWEFramF4UGlBSXNPVTNqVGc0cE9Qblc3cUxV?=
 =?utf-8?B?Q0graWlHRDUyOTRsUTZMNFoweXpWY08zaHkyUDd0WE9Zd2h6SHZ5czVtWmpy?=
 =?utf-8?B?NDBNM2tyM29MTDh1bE02S0g0RzhscW1jeGQ1MFRRUHNUYVVJTUNtUnNWWFB2?=
 =?utf-8?B?V0FqM0t3cFphY0YzWkUvaUNGSWZmYnN0WWxiOVBsZW11QmJ2RHRiVkZTeWFh?=
 =?utf-8?B?TzJIbGNCUXVsTnJjMHI2VW9sMzBYUjFzUnlXTGs3dDVyZUxSMTNIYW1kNlo3?=
 =?utf-8?B?RVRSZ2gxSzJrUjVYWjFNT1ZKbmlOeUpsWTBZbElCL0JvZmJ3Yk4xMUxCWFNv?=
 =?utf-8?B?M2twK29yVG1OeUR0MGQvclZEQ3JtMGZKVlpJcThtbVRXMXN2Qit1SnhjQVF5?=
 =?utf-8?B?bndKZ2hOSXcwT0dVZjRSUkFVM1dFS3ZBdGVGd1N1R2NqWlZ0RU5DODBxeUlJ?=
 =?utf-8?B?REhHYXZIM1RRVS9Lak1IWEZoR2Z5Sm5jeGFCOVV3VFBCTkloWDZNRnRZSDU3?=
 =?utf-8?B?ckxId0dsNDJqTFA3dCtKVjFQTWczMGx5NXAzWXFpcGRCSHI5TWlMUmJGZEIy?=
 =?utf-8?B?MnpUcVAxbldRQ2ZOQWJ1cmRubVpsMm1QYk9EQVplbFhMMjhCTXZROWorNG95?=
 =?utf-8?B?Qm1WN1lFTjBiSldqR3dLdkRnYUZ0bGtIOXNybjF3UW81dnoyN2RoTmJNbFFr?=
 =?utf-8?B?MnBqRGV0S00xY1ozVHB0azVSV2I2d08vdVhGeUNGek9qcGpBczVoaFVOQVda?=
 =?utf-8?B?VkhZOWxWU2dPQVRGSXppWGxaZ3YreTNTRHA4TDRqOWk2ZkwxWnNxZzFwU01C?=
 =?utf-8?B?VldKVzd3L2RMeEM4cVIyUHNEUUkzaEg5TndNYVp0MzliSG8rMlN1byt2OXdP?=
 =?utf-8?B?V3JjcmlzV1ZWalBodGU0Z1BZeDNpM3Z0eUp0VEsvNTBWM2NHWEVhK2MzaTdx?=
 =?utf-8?B?WmhUdlhmNTRIS2tEenFjMDJBbXE2bjdNMU5rNWlXeUF2dnoxcE4wcmNOMlVl?=
 =?utf-8?B?ZFlobngxcC9EZlhKSnU3SmY3N2VoSmdDaWxCWjlkajJmUjJrRmExRzhUeUdL?=
 =?utf-8?B?SmxEN2Fvck9Jazh0dGxodUVkbzJEM0w0YUp1dGF4dnhKWmVLd2l5ZGl0VGEr?=
 =?utf-8?B?d1d4bVR1a3VEWlhCUmlRUTdlc2RhRGVoc3FUTE81YUZpVlFCeFFkSGhiU0cy?=
 =?utf-8?B?Q2RCeEdyR3RIYW9BVVAzYmk4bWticlJDZHdkcUwzczQ5T1J6UEIxWjBKaXcx?=
 =?utf-8?B?TkZJVXpZSittRFhFUnFVVnFMYjV4TXFWeTljemsvcWdXUnNrTm5DWHg0dFVy?=
 =?utf-8?B?YkYyZlJCbHpCTmhQSjBOMHdnWmF4dUlobUdyUXJsL05xRTJkT1ZhcHVVbXd4?=
 =?utf-8?B?ekNpMWJObkk3MEdnV2YvaTIyL3NCb3AvTmtBTkFzbEUvT1ROQ3V0QT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d61d69ba-9df1-4337-dd81-08def558679e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2026 14:21:57.7217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Tz8fzk0juRj1OQxB7ks+jsoWxumM35ds2pILG1DSUkMb0YWpxHPWww9PHuDMeSA7gVc8+rWYjcBRV0b8q+cgJEta+h1HK/locAd0ui2EQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9689

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDA3IEF1Z3VzdCAyMDI2IDE0OjI1DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIzIDEzLzE0XSBtbWM6IHJlbmVzYXNfc2RoaTogQWRkIFJaL0czTCBIUzQwMCBzdXBwb3J0
DQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVGh1LCAzMCBKdWwgMjAyNiBhdCAxMzozMiwgQmlq
dSA8YmlqdS5kYXMuYXVAZ21haWwuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERhcyA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBBZGQgSFM0MDAgc3VwcG9ydCBmb3Ig
dGhlIFJaL0czTCBTb0MuDQo+ID4NCj4gPiBSWi9HM0wgbmVlZHMgYSBzZWNvbmQgSFM0MDAgZW5h
YmxlIHJlZ2lzdGVyLCBTRG1fU0NDX0hTNDAwTU9ERTINCj4gPiAob2Zmc2V0IDB4MDIwKSwgYWxv
bmdzaWRlIHRoZSBleGlzdGluZyBUTVBQT1JUMiBwYXRoLiBBZGQgYQ0KPiA+IFRNSU9fTU1DX0hT
NDAwTU9ERTIgZmxhZyAoYml0IDE2KSBmb3IgY29udHJvbGxlcnMgdGhhdCBuZWVkIGl0Lg0KPiA+
DQo+ID4gcmVuZXNhc19zZGhpX2hzNDAwX2NvbXBsZXRlKCkgbm93IGFsc28gc2V0cyBIUzQwMEVO
MiBpbiBIUzQwME1PREUyDQo+ID4gd2hlbiB0aGUgZmxhZyBpcyBzZXQsIGFuZCByZW5lc2FzX3Nk
aGlfcmVzZXRfaHM0MDBfbW9kZSgpIGNsZWFycyBpdCBvbg0KPiA+IGV4aXQuIEFkZCByZW5lc2Fz
X3NkaGlfc2V0X3RtcHBvcnQoKSB0byBtYXNrIG9mZiBvbmx5IHRoZSBsb3dlcg0KPiA+IDE2IGJp
dHMgKFRNUE9VVCkgb2YgVE1QUE9SVDIgd2hlbiB3cml0aW5nIGl0LCBwcmVzZXJ2aW5nIHRoZSB1
cHBlcg0KPiA+IGJpdHMgb24gY29udHJvbGxlcnMgd2l0aCBIUzQwME1PREUyLCBpbnN0ZWFkIG9m
IHRoZSBwcmV2aW91cw0KPiA+IHVuY29uZGl0aW9uYWwgemVybyB3cml0ZS4NCj4gPg0KPiA+IFJa
L0czTCBIUzQwMCBzdXBwb3J0cyBvbmx5IG9uZSBkaXZpZGVyIHZhbHVlLCBzbw0KPiA+IHJlbmVz
YXNfc2RoaV9zZXRfY2xvY2soKSBub3cgZm9yY2VzIHRoZSBjbG9jayB2YWx1ZSB0byAwIGJlZm9y
ZQ0KPiA+IG1hc2tpbmcgd2hlbiBIUzQwME1PREUyIGlzIHNldCBhbmQgdGhlIGludGVybmFsIGRp
dmlkZXIgaXNuJ3QNCj4gPiBjdXJyZW50bHkgZW5hYmxlZCwgcmVqZWN0aW5nIGFueSBvdGhlciBk
aXZpZGVyLiBUaGlzIGFsc28gY29tcGxldGVzDQo+ID4gcmVuZXNhc19zZGhpX2lzX2ludGVybmFs
X2RpdmlkZXJfZW5hYmxlZCgpIGZyb20gZWFybGllciBpbiB0aGUgc2VyaWVzLA0KPiA+IHdoaWNo
IG5vdyBhZGRpdGlvbmFsbHkgY2hlY2tzIHRoYXQgdGhlIGN1cnJlbnQgdGltaW5nIG1vZGUgaXMg
bm90DQo+ID4gTU1DX1RJTUlOR19NTUNfSFM0MDAgYmVmb3JlIHJlcG9ydGluZyB0aGUgaW50ZXJu
YWwgZGl2aWRlciBhcyBlbmFibGVkLg0KPiA+DQo+ID4gRW5hYmxlIFRNSU9fTU1DX0hTNDAwTU9E
RTIgaW4gb2ZfZGF0YV9yemczbCB0byBjb21wbGV0ZSBSWi9HM0wgSFM0MDANCj4gPiBzdXBwb3J0
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tPg0KPiA+IC0tLQ0KPiA+IHYyMi0+djIzOg0KPiA+ICAqIE5vIGNoYW5nZS4NCj4gPiB2
MjEtPnYyMjoNCj4gPiAgKiBVcGRhdGVkIGNvbW1pdCBkZXNjcmlwdGlvbg0KPiA+ICAqIEFkZGVk
IGEgcmVuZXNhc19zZGhpX3NldF90bXBwb3J0KCkgaGVscGVyIHRvIHNldCBkZWxheSB2YWx1ZXMu
DQo+ID4gICogQWRkZWQgYSBjaGVjayBpbiByZW5lc2FzX3NkaGlfaXNfaW50ZXJuYWxfZGl2aWRl
cl9lbmFibGVkKCkgdG8NCj4gPiAgICByZXR1cm4gZGlzYWJsZWQgc3RhdHVzIHdoZW4gaW4gSFM0
MDAgbW9kZS4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHVwZGF0ZSENCj4gDQo+ID4gLS0tIGEvZHJp
dmVycy9tbWMvaG9zdC9yZW5lc2FzX3NkaGlfY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMv
aG9zdC9yZW5lc2FzX3NkaGlfY29yZS5jDQo+IA0KPiA+IEBAIC0zNTUsNiArMzY2LDIyIEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBzZF9zY2Nfd3JpdGUzMihzdHJ1Y3QgdG1pb19tbWNfaG9zdCAqaG9z
dCwNCj4gPiAgICAgICAgIHdyaXRlbCh2YWwsIHByaXYtPnNjY19jdGwgKyAoYWRkciA8PCBob3N0
LT5idXNfc2hpZnQpKTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCByZW5lc2FzX3NkaGlfc2V0
X3RtcHBvcnQoc3RydWN0IHRtaW9fbW1jX2hvc3QgKmhvc3QsIHUzMg0KPiA+ICt0bXBwb3J0KSB7
DQo+ID4gKyAgICAgICBzdHJ1Y3QgcmVuZXNhc19zZGhpICpwcml2ID0gaG9zdF90b19wcml2KGhv
c3QpOw0KPiA+ICsgICAgICAgdTMyIHZhbDsNCj4gDQo+IHUzMiB2YWwgPSB0bXBwb3J0Ow0KDQpP
Sy4NCj4gDQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGhvc3QtPnBkYXRhLT5mbGFncyAmIFRNSU9f
TU1DX0hTNDAwTU9ERTIpIHsNCj4gPiArICAgICAgICAgICAgICAgdmFsID0gc2Rfc2NjX3JlYWQz
Mihob3N0LCBwcml2LCBTSF9NT0JJTEVfU0RISV9TQ0NfVE1QUE9SVDIpOw0KPiA+ICsgICAgICAg
ICAgICAgICB2YWwgJj0gfkdFTk1BU0soMTUsIDApOyAvKiBUTVBPVVQgTUFTSyAqLw0KPiANCj4g
QWRkIGEgI2RlZmluZSBmb3IgdGhpcyBtYWdpYyB2YWx1ZT8NCg0KV2lsbCBpbnRyb2R1Y2UgdGhl
IG1hY3JvIFNIX01PQklMRV9TREhJX1NDQ19UTVBQT1JUMl9UTVBPVVQNCg0KPiANCj4gdmFsIHw9
IHNkX3NjY19yZWFkMzIoLi4uKSAmIC4uLjsNCg0KT0suDQoNCj4gDQo+ID4gKyAgICAgICAgICAg
ICAgIHZhbCB8PSB0bXBwb3J0Ow0KPiA+ICsgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAg
ICAgICAgdmFsID0gdG1wcG9ydDsNCj4gPiArICAgICAgIH0NCj4gDQo+IEFuZCB0aGVuIHlvdSBj
YW4gZHJvcCB0aGVzZS4uLg0KDQpPSy4gV2lsbCBmaXggdGhpcyBpbiBuZXh0IHZlcnNpb24uDQoN
CkNoZWVycywNCkJpanUNCg0K
