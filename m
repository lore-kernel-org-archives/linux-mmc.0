Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B493C9EFB;
	Wed, 11 Mar 2026 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220752; cv=fail; b=X3M14ArsT1LrwxorBuZjWbAuYvpRusguPOv/R3+We+T+UCuz2cL/J63wc53czzorHLCDFTiPLxatxasrU6NogjKZ5Edpv8DIjn0/NMc06YAIe7w78aBSeY1LH5LAXGmp7mOv4J7m1pzHY+kU4u/xoxs4Ue3pUDFa3YC2FuJk6xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220752; c=relaxed/simple;
	bh=0QG9zn9xpKe8a+oY9DByleyi888S2O3w0z+pi3P10CA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ipJR1Xc/Ik8Q1/OzVRyw1ZDubyy8EV222KktmI42KViI92TYocCj3ybvjN96MOyAlCkE2jFOVN5sUZST0gFMpWvx8JRB0cGDap6lvgJnI4ORcph/VCH3P/lnu2BEZqmxCP+htacks3XO+c6Gf8F2ZelYu5AUq8nwALp5ChASZnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IyWsth3V; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IyWsth3V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tupXhugIemD0JJeWfQMKuDk4+hW6UtUrApXoXZNa6m62/BZLMaFIIfELiWUUA8z7Tvm4cXnAUbkOA58IzjM8/1AwRaITF1GzcBOCcvbaGw2c857vo8cXLGUJRuWF+uTKbthCUjR50yueqq1awMq+mQeevcV89i7PdGLYgqjX/4ynqxF+sGwwLVJNNx6zrkxSeueBcmeWdK2OikxYoqsksrl8NHVFNRfYepviYmdXmfcAsLc7jxVba7AEaqxmBiEbPY/+CHJrFz0K8xdkSe4uy4d4mYRKFg21hPzc3RCQNDc+JPS4ZwtbDbmgLBQ95ErzLsFxI+SMNvoF+tQKPbBmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QG9zn9xpKe8a+oY9DByleyi888S2O3w0z+pi3P10CA=;
 b=asweXlmjdlxls74a0DvA9g1cBGOloLv91IThEsjRnLXbMurqRacxosBqdextZasZCOwc9w0gvAWHvBF7KdRyW/B1oQLtsudH9G+iUHF84aLL1OwHDPBPxFeBah5j9Hb7RtwfHS+HbWn9K3lS12lBmcHl3WCsx3HPSXNfYmH89jrw1md2Ok68tZqfrhmOx+76xxIooomtvebXPYzHbfqDgjL2Ai+ggAex+d6MPj9QZOCMKIO6ZJQpRCbam5RGCWu2mgfEhkJWugLTVTRb2Eb1IIGcqa1kMHZTULOETzSmgJj9onqZIzA/yC8sR804mHBgiQ8GJ9/o95z74cOWeTuq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QG9zn9xpKe8a+oY9DByleyi888S2O3w0z+pi3P10CA=;
 b=IyWsth3V+6/bHPn6vyl1+LGGds2GueMg0z78Dw3ro34o5z+vjN+1Ja4le04JPrqjtzUd89tr/7oGMoMtYaf3skmqo3yiyOlsxzLAH6jz96Oe1PcjOVSlRPhp8R8DlAez/pjCkbh+4MSUyojBh1jA8pBkZik9TQx1TWPuxkz6dn4FPRNHMkW3GMy/TTOS3iHaedIoEGZjBAo91fjeIdtwwu6Esvuo+Qf4+vJjgcDJGiWkacWQhQZH3sOo10SDvmhGE+m7CbGnYTZrirkg5PGdF6/3NClgEbXm++TUjN/or79bjb2OJmoYlrbYS8e6s/u+aHcGoMs88cgyQZUChZuCVQ==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DU7PR04MB11164.eurprd04.prod.outlook.com (2603:10a6:10:5b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 09:19:04 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9678.023; Wed, 11 Mar 2026
 09:19:04 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, Bough Chen <haibo.chen@nxp.com>
CC: Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 1/4] mmc: sdhci: fix timing selection for
 1-bit bus width
Thread-Topic: [EXT] Re: [PATCH v2 1/4] mmc: sdhci: fix timing selection for
 1-bit bus width
Thread-Index: AQHcqvs6IKlnWZxcU0qBD4kS4V70+bWpFlwAgAADcuA=
Date: Wed, 11 Mar 2026 09:19:04 +0000
Message-ID:
 <DU2PR04MB856755F3BF98BE7E9165997BED47A@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20260303105006.989339-1-ziniu.wang_1@nxp.com>
 <20260303105006.989339-2-ziniu.wang_1@nxp.com>
 <4ff711d8-cb4f-4ef9-b357-3fbfea5124a4@intel.com>
In-Reply-To: <4ff711d8-cb4f-4ef9-b357-3fbfea5124a4@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|DU7PR04MB11164:EE_
x-ms-office365-filtering-correlation-id: 1acb73e7-9289-482a-ae9e-08de7f4f3d85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 U15eocB30V/wxLNPkZA1Zk8ftwthzePnXAM464/2tKmrFDEcpAtedKok9cZdxKQXl++x5tCBaLZLoA6XE9EXiruV457in6Nxlxdl9zi7/6r1OnI779nepqCDnauuArd3EJGctQHYvJl7DIjSs2dV81iPdITOgDF5+R6ASlaDM8kVy+/VV9rpTwgwo9g686p65X0U6fSC4Wj4TuZ2QLK7BJVjhh/1dL8jD1pYPfgjIPyKpYWJd8T/SA/JD8/iHcuvA3jX0Tq7PAbkLU67ZFCk7YNhfOifrre4zKa1/3fVBJmS6elqe9vfxLv5nqA0O/ZIo82CicJdkFEHiCqacS2Nau5DFSkU5e/fh72d5Di02rUDN4dlivBfRe/vao9eIY4m+NKcwSfBV7TYR49K2lZG8KFj5hqxe+s2AO/V4BO2PzXE7M9Grwvda+qm28p0KpOGfdxmpDSgo+EWLqDhc72Zo2dl1pxz3ljDcbOvWdsyS9mpUsctwZl8oEHUkmdNj/5l/AOkL+yM9tNJ5/bhTHdTcX/WjxfcUHFo6zwbFkmIsfj3CQINpWesLTr5eXv3Fad1kWoqkUkK52ITENtpv3mp9hKVu5WupPLAkP3TrSI8wbh8zh4zKTNpKevUl0hXmLWvYONOo9GacFRbqEZp0f48ZN7Ml9VSm99aZcKPb1/nEYQwhB8ODK4aqwjyqp4kHWYdSfwwQGoDX90TK6S/IlV+BQdOaMEFesq1pf5dPagvtmbIcrE+ObeCZm7sHBEjN6yGlcyRuskHE14DtSRNBNaYjb70zEz8G+GCxALnaNXqPdg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXNPYkphLzlxQ3hmU0Y0V2ZBcWlUMGV0TDY2SVhzN0FDc2VQRUZsYktjQlRi?=
 =?utf-8?B?VGJNWWRoM3BPRGN5d2N0VDNWN0pONXNvUjZ3VVZBYVRxR2MyMTdpNHRxNkor?=
 =?utf-8?B?YWNpOVFsa05tSTBrczdaUlVZZU81d0hoMmFhZUVEMDhvRTJ3UTVBb0FFOXRV?=
 =?utf-8?B?aEt6Y2pIWlZGTVRieTZJTHhkbHhkN2hFbU03YVp0MDVvaUtndlZxQUdZemFl?=
 =?utf-8?B?UEdMd1VJRi9sZXE1RGpuVUx4cmxnTFBHcXU1eTh5eHUwd2k0RTJJeVNVM25S?=
 =?utf-8?B?eUh3ejB2TU1jOUM4UTZNalh6dW9UNlhWbmFzd2RxUkorZU9ERjdVdXBaamd1?=
 =?utf-8?B?MHhja2JWOEgzd3QwRDJWeUNzSXJ3MXM3NURpV3pNanh0Nlo4RmpPVW8vK0ho?=
 =?utf-8?B?QjZyYnA0RlNIVkJoVE1sUFMvU3E0QWJJckNIRmZwTENBaERLSkV4anJqSytx?=
 =?utf-8?B?S0c3L3F0R1ozbGpIOXRBL0FOa2N0R2ZFUjVqeEhpVkxvWjdLSWc4Ym81NkNJ?=
 =?utf-8?B?K1dVemYyMjBXckFNRGdtU3dBUjhUdWZVQUFVZk9ib1NTb040dDVXaC8zZGtY?=
 =?utf-8?B?ZWpZNzJROU9XdkVXV1RQVld2SWsySHB5dXhJdWhhUEE5TlRzdjJ4TjhlRlpj?=
 =?utf-8?B?M04yRFZ1OWExZ2p4elNHL3FxNUNsdVRhQUJrTUNVNElOVDhSRVJ2dmxOMFpM?=
 =?utf-8?B?YW1qcjZ6clNNK1BqOGllVGo1YWFtSzk2NGRCcFVXb2EwTXdod2xLemFJQ1FQ?=
 =?utf-8?B?NTQrYXI5NEJ5ejQ5MWhHMmYxUTAxeTRWaVVaSEdiSlBZejcyUytKK2crdlVI?=
 =?utf-8?B?ZWErUHVVRkVFNk1HMXFvUzdxNk1nL3VmWUdiWUZVSGpFaTloYVhTYTdlSEcz?=
 =?utf-8?B?ZVZkUFkyL09icENUQ2VCa2J5UkE0bFpGRk9CZDc4WGlMNkU5dHNpTmw0Y3V3?=
 =?utf-8?B?ZHN3MjVQa3ZFZlRTWTFaYXNDakVpQ0plQk1oMXdsZVB1TmNkRk1FM0xIZk5N?=
 =?utf-8?B?RHpnL0lHUUVrNnNNTlUrajZSUmlGQ0NGdEdNVDY2SUswaisrNlpnSUFrZ0lN?=
 =?utf-8?B?azBBWE9UVW5rSi9DdjdiTGIxam1ubjFJOWM0QzJjQUw3YjcybVRsaEl1RFox?=
 =?utf-8?B?SFJCTHFzNkdYeDlvUm9ScWlJY3g1ekVBSGYyRUVFQnJvUjBXM282VmFvTHhi?=
 =?utf-8?B?TUw1WG41Y2xXdXErU0lhc0c2ZXl2ZkNVUXg0eVUxc1FpR2pNc1NtcTMvZFZ3?=
 =?utf-8?B?cHplR083bjRwYkowYVhJWUhwTGtjR3pPbHBJeTE2bVJZc1o1ZlB6L3p4cy9C?=
 =?utf-8?B?MzdwNEZJdjFDYmdHYWJ4VW91UWE5QWNYUjF3MnBRSVlvNkZyVzd0Z294Q2pY?=
 =?utf-8?B?MHZZUURYdFpJMmtsNnZFUXdDci96ZUhkT3czUTdBVmNVM1pacHJwcm5QWTdT?=
 =?utf-8?B?UTRrWmtpUlZGRWk3REZKRXlBSEdlQUZtR2xqTGFpZEkydzVvRlA0RUh0TFJX?=
 =?utf-8?B?TTZnc0lGYkNWa1ZTV3EzUU1SOWM0TFk3U2NCV3JkTmZ5R0k5d3gvcVh4VkFl?=
 =?utf-8?B?QTRlbWZtUVZqRUtlTjR0MlBhMVNnUDNNckdITGswNXNtVFlMMCtncVZqeE9M?=
 =?utf-8?B?U1RvNU1BMlpUMGNiWVFqUDlCc05IMklPY3dNWVBZZS84ZlN4ZkZBaU9qK0Ix?=
 =?utf-8?B?WjJkRW1sVjlFWTNHTzVDTlMzQzl1ODcwTWE3cHBlblE4cENCQjhjTHVoekNw?=
 =?utf-8?B?eEVObks1blNZMnRaS3o4dnNWTXZGaUFlUEM4Y1g3aDZFN3ZkeWt5NGFscW94?=
 =?utf-8?B?SlVLTEs2dHJhU0pyZXB4WStCY0NJb3RRNzdpUFRzOFRmdFRvMFRMR2RYanpa?=
 =?utf-8?B?SzN5QlRlRlI5RFhLZncwYnFHTlNNdUJHajRDcWhOZkE2bFRmekxxQ2haSDNE?=
 =?utf-8?B?UVJUNkphZVVjd0Vpb3NENVhJWFNCM29RbVBrcTFUeXhjQVNyZEJlWGU3YXZD?=
 =?utf-8?B?dy9DZGV5TkR5N3ZyM1VVK2EySkF0bUlTOEl6R3g5OGdXSWxLbUNmOWVabld5?=
 =?utf-8?B?Wk01K2RCTDJCMEo5R2xTMVRocTV2NGJ3S2xUeERtR2twR0xaSGc2NFpMcFU5?=
 =?utf-8?B?cXRwUnlhWFc3a1FkTUxKcmdVVzRQbVp1WXl4QTFpU2tnMHdTb1ZQdVZMMTFw?=
 =?utf-8?B?YmU3YnU5ck1hRWJUV3FpbVoyTzYwVmNpQjhmcjVWc0VRdHMyc1NROE1URDBl?=
 =?utf-8?B?amtGVnIrS25UcUZ6T1hBQjBVZFZHL3E3QThXN2xaTERBV1M3Tk9xUi9UWXM1?=
 =?utf-8?Q?n9ALLkcchjCRsLWVYG?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acb73e7-9289-482a-ae9e-08de7f4f3d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:19:04.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRO5owOHsdox+MQbHgdbT5m9T+j2+md1y+a4zchVUhKRJb7XHvVCtbDcYEdO9uvYYVn/XRnOI4qJ/pb4HbcppQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11164

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTEsIDIw
MjYgNTowNSBQTQ0KPiBUbzogTHVrZSBXYW5nIDx6aW5pdS53YW5nXzFAbnhwLmNvbT47IHVsZi5o
YW5zc29uQGxpbmFyby5vcmc7IEJvdWdoDQo+IENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4g
Q2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsN
Cj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGlteEBsaXN0cy5s
aW51eC5kZXY7IGxpbnV4LQ0KPiBtbWNAdmdlci5rZXJuZWwub3JnOyBkbC1TMzIgPFMzMkBueHAu
Y29tPjsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYyIDEvNF0g
bW1jOiBzZGhjaTogZml4IHRpbWluZyBzZWxlY3Rpb24gZm9yIDEtYml0DQo+IGJ1cyB3aWR0aA0K
PiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2Fy
ZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4g
ZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWls
JyBidXR0b24NCj4gDQo+IA0KPiBPbiAwMy8wMy8yMDI2IDEyOjUwLCB6aW5pdS53YW5nXzFAbnhw
LmNvbSB3cm90ZToNCj4gPiBGcm9tOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0K
PiA+DQo+ID4gV2hlbiAxLWJpdCBidXMgd2lkdGggaXMgdXNlZCB3aXRoIEhTMjAwL0hTNDAwIGNh
cGFiaWxpdGllcyBzZXQsDQo+ID4gbW1jX3NlbGVjdF9oczIwMCgpIHJldHVybnMgMCB3aXRob3V0
IGFjdHVhbGx5IHN3aXRjaGluZy4gVGhpcw0KPiA+IGNhdXNlcyBtbWNfc2VsZWN0X3RpbWluZygp
IHRvIHNraXAgbW1jX3NlbGVjdF9ocygpLCBsZWF2aW5nIGVNTUMNCj4gPiBpbiBsZWdhY3kgbW9k
ZSAoMjZNSHopIGluc3RlYWQgb2YgSGlnaCBTcGVlZCBTRFIgKDUyTUh6KS4NCj4gPg0KPiA+IFBl
ciBKRURFQyBlTU1DIHNwZWMgc2VjdGlvbiA1LjMuMiwgMS1iaXQgbW9kZSBzdXBwb3J0cyBIaWdo
IFNwZWVkDQo+ID4gU0RSLiBEcm9wIGluY29tcGF0aWJsZSBIUzIwMC9IUzQwMC9VSFMvRERSIGNh
cHMgZWFybHkgc28gdGltaW5nDQo+ID4gc2VsZWN0aW9uIGZhbGxzIHRocm91Z2ggdG8gbW1jX3Nl
bGVjdF9ocygpIGNvcnJlY3RseS4NCj4gPg0KPiANCj4gRml4ZXM6IGYyMTE5ZGY2Yjc2NDYgKCJt
bWM6IHNkOiBhZGQgc3VwcG9ydCBmb3Igc2lnbmFsIHZvbHRhZ2Ugc3dpdGNoDQo+IHByb2NlZHVy
ZSIpDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyB8IDggKysrKysrKy0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2kuYw0KPiA+IGluZGV4IGIxYTNjZDU3NGM4NC4uM2UxNjNmMTRhNjQwIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2kuYw0KPiA+IEBAIC00NTM5LDggKzQ1MzksMTQgQEAgaW50IHNkaGNpX3Nl
dHVwX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpDQo+ID4gICAgICAgICogdGhlaXIgcGxh
dGZvcm0gY29kZSBiZWZvcmUgY2FsbGluZyBzZGhjaV9hZGRfaG9zdCgpLCBhbmQgd2UNCj4gPiAg
ICAgICAgKiB3b24ndCBhc3N1bWUgOC1iaXQgd2lkdGggZm9yIGhvc3RzIHdpdGhvdXQgdGhhdCBD
QVAuDQo+ID4gICAgICAgICovDQo+ID4gLSAgICAgaWYgKCEoaG9zdC0+cXVpcmtzICYgU0RIQ0lf
UVVJUktfRk9SQ0VfMV9CSVRfREFUQSkpDQo+ID4gKyAgICAgaWYgKGhvc3QtPnF1aXJrcyAmIFNE
SENJX1FVSVJLX0ZPUkNFXzFfQklUX0RBVEEpIHsNCj4gPiArICAgICAgICAgICAgIGhvc3QtPmNh
cHMxICY9IH4oU0RIQ0lfU1VQUE9SVF9TRFIxMDQgfA0KPiBTREhDSV9TVVBQT1JUX1NEUjUwIHwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0RIQ0lfU1VQUE9SVF9ERFI1MCB8
IFNESENJX1NVUFBPUlRfSFM0MDApOw0KPiANCj4gU0RIQ0lfU1VQUE9SVF9IUzQwMCBpcyBub24t
c3RhbmRhcmQuICBIZW5jZSB0aGUgY2hlY2sgZm9yDQo+IFNESENJX1FVSVJLMl9DQVBTX0JJVDYz
X0ZPUl9IUzQwMCBpcyBuZWVkZWQ6DQoNCkdvdCBpdCwgdGhhbmtzIGZvciB0aGUgZXhwbGFuYXRp
b24uIEknbGwga2VlcCB0aGUgY2hlY2sgaW4gdjMuDQoNCj4gDQo+ICAgICAgICAgICAgICAgICBo
b3N0LT5jYXBzMSAmPSB+KFNESENJX1NVUFBPUlRfU0RSMTA0IHwNCj4gU0RIQ0lfU1VQUE9SVF9T
RFI1MCB8IFNESENJX1NVUFBPUlRfRERSNTApOw0KPiAgICAgICAgICAgICAgICAgaWYgKGhvc3Qt
PnF1aXJrczIgJiBTREhDSV9RVUlSSzJfQ0FQU19CSVQ2M19GT1JfSFM0MDApDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGhvc3QtPmNhcHMxICY9IH5TREhDSV9TVVBQT1JUX0hTNDAwOw0KPiAN
Cj4gPiArICAgICAgICAgICAgIG1tYy0+Y2FwczIgJj0gfihNTUNfQ0FQMl9IUzIwMCB8IE1NQ19D
QVAyX0hTNDAwIHwNCj4gTU1DX0NBUDJfSFM0MDBfRVMpOw0KPiA+ICsgICAgICAgICAgICAgbW1j
LT5jYXBzICY9IH4oTU1DX0NBUF9ERFIgfCBNTUNfQ0FQX1VIUyk7DQo+ID4gKyAgICAgfSBlbHNl
IHsNCj4gPiAgICAgICAgICAgICAgIG1tYy0+Y2FwcyB8PSBNTUNfQ0FQXzRfQklUX0RBVEE7DQo+
ID4gKyAgICAgfQ0KPiA+DQo+ID4gICAgICAgaWYgKGhvc3QtPnF1aXJrczIgJiBTREhDSV9RVUlS
SzJfSE9TVF9OT19DTUQyMykNCj4gPiAgICAgICAgICAgICAgIG1tYy0+Y2FwcyAmPSB+TU1DX0NB
UF9DTUQyMzsNCg0K
