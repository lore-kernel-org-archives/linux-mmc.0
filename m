Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010013.outbound.protection.outlook.com [52.101.228.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD1B640;
	Sat,  8 Aug 2026 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786202494; cv=fail; b=Zm0BA6pLhzEFacRYBhbwjWBT0TojTnEGGVBis4+SYmlzH11zGJfqtAjYKdGB/xUQMbiUjCDUnZioqvpK4GVc99KdI4PyxljfyHqGpOzHQ6f7DRa1W3H/8JAL8GQic7ZkjIgtZbAahif/g+VDpV9DQwEUUXpwBBK+5hHRQQFFV2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786202494; c=relaxed/simple;
	bh=xrN+XDGL0+aT7I2fEbm2uXU+HmaFSlArmaPF32+O3sc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ke2mN+PeEXnsVsiVl5Ef2M+2eqlqir7fCCqjv44TtVhdFsOYQGqCczEh1Pwn/UUQMcUpp46isEyGYhTj/g20yWXXWmwr6+Qs+tKTNM1qcKHt5poCy6FBJb9Sl3O7BuHChoISc3pV7PPl3lMvxf0CM0nmxVhIZF1ed/VgBddUDq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=nzqw/RYK; arc=fail smtp.client-ip=52.101.228.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="nzqw/RYK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz2I1HFuB6lWkR2K2b0GniOO8l7r+oGm+ysUQSxOb4rH6IwWBj31pfdrt1/McDzHsQU2E9FyUJ1Yr+lGYzAj/1ICiFEZh1y50VuW7w7uFzgAg6flid8JbZKtLLEjnS320C4TXb1ZqJfOZBuamWbwWNW/hRW9tQnGbWCKRsMkRBoq1xizPi//ZDNHsJdtcysBhCoFyje1PIFKoeS0G+WwJr8Un7VEzqdFOVbbxcPfF+H/csFYRYU2u9V7GC2GrLNCH5AuOtg7OlUbkWfEPwLyGnE6RieIdybEuoklp1jREF1JoH35uwZ7ll+ZvqJLNWCLqntAc6v4teF4Jy75gJf42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrN+XDGL0+aT7I2fEbm2uXU+HmaFSlArmaPF32+O3sc=;
 b=i3yYF1C8JjjU3m6dW1KNvd/0aax3JOqgIPCMq8dqcZkCHoILgCDVwv/Lo6/ULi4oE7uezYRQFMxfGKgDR6tEbYlpgE6Zey6U1BIsEZGm+quHeqQg4g0I1ahdshMiP+CAbp7mXwylBJuO8gdb6LWAqFCcF/u9cmfRjRuNZdk4iRrMX840RTcCDH4UsVRTC0uq8aaucNF2XzqO93FoikfxpR4t3a+IQy0GEsCwz1AYyHAZt/cFo2/F++EivwjPm6w9XPn7dVIJHjVehbKHk1TzE8Fc6IIsomio34UIVjWPAJbewNo8DIaL9QgqUySX5mq14CQCZl2ZHUoxMF9jUGVwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrN+XDGL0+aT7I2fEbm2uXU+HmaFSlArmaPF32+O3sc=;
 b=nzqw/RYKlMxCWrwWY7PKk90wtTj9Z8yMpuWqWRbwHiUx68q766nfphS8XisXebQUnqr2iHKyta4r+Jqbtmb06b1ZdGWZJxn89CRpK4bqVxuxiuHopjzd6SizE7isAxO15qndSCri+n6L+QpBvldHOVWaKtsvQDjW3Yum5RAxCcQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY6PR01MB17917.jpnprd01.prod.outlook.com (2603:1096:405:347::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 15:21:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 15:21:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, "biju.das.au" <biju.das.au@gmail.com>
CC: wsa+renesas <wsa+renesas@sang-engineering.com>, Ulf Hansson
	<ulfh@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v23 05/14] mmc: renesas_sdhi: Make clock divider mask
 configurable
Thread-Topic: [PATCH v23 05/14] mmc: renesas_sdhi: Make clock divider mask
 configurable
Thread-Index: AQHdIBcSWjc4ixp24EuhO9P3hcto0LaSnboAgAGp1MA=
Date: Sat, 8 Aug 2026 15:21:29 +0000
Message-ID:
 <TY3PR01MB113463AB187EBEEF2CD2C2A2986D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
 <20260730113200.36456-6-biju.das.jz@bp.renesas.com>
 <CAMuHMdXAFX1bji7Q+OAmDRYmQ8Gezxhf2RsrBOV34AXLOBgLPw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXAFX1bji7Q+OAmDRYmQ8Gezxhf2RsrBOV34AXLOBgLPw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY6PR01MB17917:EE_
x-ms-office365-filtering-correlation-id: 2fdc506a-e8b5-4e00-3be2-08def560b86e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|4143699003|56012099006|10067099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 xXDIJYhRDhAGQrVibicYu/scsCw43/KGhl80uPShnXRHgWzesMgyvVrd3lMGj12qhziZjQWYAxo+DwuzLXBQi1KOgAPH7Fkx7/n28smt6UqjSl12BI+9Cwn7wT77r4MxAGLl8pk07nDBWh40PIP1f1WxOC9U29PSbzRueEJCQnEjPOMrs1rvHLbZwR9meLcWDpo1/4mLksJkbPVg16F7SIvpnN5lCk7GN8JcfPVGZ7hexFGWexKw81s0oKG2dw9AlWsgUk7lZ1ejq0VIA4fK1OxE4Kt6wfd7bsd2pSN10nMbxzmj6S3ie7XO6xQgFU67N+/YIlXvD5920McmWDGRdrpveLh0brrKX8xJrRf+6cvYY6MKeHDMZ4yvnRzyuFg4LtIR1Tb4FTTLa8ToaPJ5G+mxe92aTPocBbqqmzj1FqqNDCqVKIC6fExFXyDEybvgkIraS+giF2YS1ae3YM4JNPZJHl042LZezCmBDYICTbqfgOtAu9eAD9ckxzFSZIJfGrcTyAXLh9PwmgX+rnwBPH0VCr5tB9nv5F/rKPbTiTcweBmenQmOQrWRshRQYs5CDwQ61Q71o3krGhheYjhJQHCY4F6wLCLJImsuXmhx/F++z0IUcBe2TtaM8ponO6lPVGf558K9i/8gK1udNl8a0gInsqt/oxIin/kwSrtQv56gisb8Hx0uJN4AnlCzytc5FGytmniNCfjuU7GmIQgwrn2obJMerLpP3VlOa4KgFEw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFdER3p6QUg2b0lFajE1SlBQMVRkTTM4S25kR2M5ZU53emtHUTJoL21rUzNH?=
 =?utf-8?B?N0krYVRQeW9UaXBVdzFTU3FudXppb3NieU4wZnVkTmlRN2NkYlhKMGh6aGRH?=
 =?utf-8?B?TVY4UXdCTGVZSGlCZzVqTlYyMG9TM3JyeGg1SnlZK2V1QzVMaTcvcVJVa0Ji?=
 =?utf-8?B?VldXYXUxU2ZHM3JDdER5K2VLQlpNYkJRWjVBMWFqTy9KWlRlUTQvUWhIc0lR?=
 =?utf-8?B?REVNeEFGNjh6ZTZnRk1KS3p5bXkwd0xLZzlTOEgycDEzVmdPMzhwZW83NXJZ?=
 =?utf-8?B?aXJaL3IvR0tHNitRRGYxMFVNRmsxaWVnelVsQlcwOTBnUEREeG5nMTYyWUk3?=
 =?utf-8?B?RzBQQmV4K2RzRE1UTXRFc29sWVpaclJaNW9EM0VvcTFHcDhhek9GeXhaVUpT?=
 =?utf-8?B?cCtJWDZqTWJHcC9KbVd3bG0rWkhEekYrYm0vck8vSE5CdCtsNzBIU1NxT1Bw?=
 =?utf-8?B?Z1hxZzdnRnUwYmxOMXNWWlJpM1JFSk5ZemVveDRBL24xc1N5dlA3ai9KbExC?=
 =?utf-8?B?MU1JY1Jsenk3S2NVUUo4R1VjKzYyRDhvR3Q4cEk3VUFwU25MVDdnOElQMDRT?=
 =?utf-8?B?aDdkajNxWHlkRGo5b1BGVDkvVUFlWmRIcXl1OHFTdlZlRGx0NS9mTitwNmZW?=
 =?utf-8?B?ckNGbms3ZmphaGhtVzY4QmF0VmFUUnYrYjFaeUJkcHpPeCtVTkxZYTZSZWYz?=
 =?utf-8?B?bGE1cXhzL3hWUzM3TnMyUlY4SFpDRFQwcWdvRFhnL3J1Sm1NVDVzZHdRanND?=
 =?utf-8?B?aE9nZFpPenZWL1NMVEQyK04yWlF2ckNrMkROQ3V0NWVhRXhtZlEyUE1jRlJm?=
 =?utf-8?B?VGRCdjNTemZJRDc0a0JsYnJ3Tkl0US8zb2FWNytDMmQxa08xNkRZMVVmRVlG?=
 =?utf-8?B?U0J6c1ZNMzkwS0FLM2Y4a3lwU1JGTGFFcElPaWVKcXM5OEs0cFp4ZkdxV05S?=
 =?utf-8?B?Y0d0TEJXc0ZxVzZPcVB3NEtXMGdXblJDSEZTTThBeFNkbFNwSC83SitBakF5?=
 =?utf-8?B?ZlY0Njg0MFhnSXZZTWJNM2ZHRzRwQ0FJTklFcnFORkJsV2N0SVh6RjkvWTd0?=
 =?utf-8?B?MytLZnozWGJPbFY5Yk96VE0rZGtIcnFLV04zclU2bzZncU1jc09waVRJZmxk?=
 =?utf-8?B?MktZak9KWVdOc3pEV1AxZTR6emhDem5TTVJTUjhlOGN0VGJHaXRUL1pQakNI?=
 =?utf-8?B?OE5ER29nTlQ4NlRVQXN4VExFdWJ4a0w0RzQwNkJMTnhNUmZ3bTVXM292Nm1B?=
 =?utf-8?B?UHYxYlBLZGRMbzhFcWNVTmo0MTRLSmdIRGRnUVBCSnhZWnJ5Smt4M0tSeW1E?=
 =?utf-8?B?aEN3ZmJoNmZOa0c1Tkk0Y2l3MjFKMnlRRURiSUlOZTE3b2FmRFVzSnVZNlZP?=
 =?utf-8?B?UXBuSzAvdGg3TGdnUUFFc2I3SFVMczhuenR6MjY1MGZCYmtYd1hjRGUyNTdN?=
 =?utf-8?B?bm55MEZMR0RhblVDZGtMWmc4SWMvTHpqVlpDVXBmQm9zdE1VVVdBUzVqQ2ZU?=
 =?utf-8?B?TnhkenZYeUU3ZXVIc25CUzE2N0dLeWpmblUyZS9uT1dkY2RqSENodU9UUmtM?=
 =?utf-8?B?S1duemMvZFZGd3gxdFp3WDB1Q0JUSzYvSVVGT3BBUVlvd1JVVDNvTllEcFBY?=
 =?utf-8?B?UXBhZDFlbmNnQk8wMitpL3hyWnM2M3Z6SkU0OHFKYUEwWlF6S1ZnU1owNEdp?=
 =?utf-8?B?RUVBdWxtejFtUGxSQmpnV1NNUlJuUXF4SG9FeUVKNW1tc0ZqMzdiUWlVaWFz?=
 =?utf-8?B?SWp0eE85R3hLYW5Cd0FFd2txTi80aGpaSzJ2L2Q0dWlESXFFeGc3cUk0bGhQ?=
 =?utf-8?B?eDhvYmFPb1dCYW5NTWtocmFWVmtmdit3UTF6WWhnZXA2d0tlTGsxcXZOTFBs?=
 =?utf-8?B?OTBOL2M1Q3BiUFBUL1NHeThCWW4wb3RqbFZ3WWIxZlFwZDRzODRRY3I2Umg5?=
 =?utf-8?B?dmhldmcrd2lJdlhhenIydHYwdXpCWGxOSlB5WFhvVGRSM25sUXpEUXpHbkZX?=
 =?utf-8?B?M3U0VjA2cDN4YVZ1cVNtWHluemk3TWJQMlh5Wk42aVd0TWpLMVI0ODg4ZHlB?=
 =?utf-8?B?TjJjZ1hmVXN5WWp2eGFNTTZWUWpmN2lzdGljWjlEcGJwRVJtaUpoUDNyeThZ?=
 =?utf-8?B?YW0xWVRmV0JqZWdqcldEaEc5dmxzYzhqZFRPNFo4Nm1PcCszL3FBTUdQMTk0?=
 =?utf-8?B?VHVJa3pSaDJINmtaSjF3akp0a2hIblZBd29lSG1HK2NQUVc3Z2xXTjlOamhC?=
 =?utf-8?B?OUtleGtDZXRBNlY4V0NiVTl6RG5TV0piRWZrZmxaaXdodnVQaDFUUVBlUUJK?=
 =?utf-8?B?RzhaL0FhaFpwRFVUN0RremZUc2pPck9yRjZuWFVQY3dmYUVMTzJ5UT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdc506a-e8b5-4e00-3be2-08def560b86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2026 15:21:29.2961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxZlkqzscNTg+kv+z+z72Zq+3uu+nXlZiVg0bw91ii9QoIzyUGKN608WSA5ACT0SXDpzZKCOz3Icl8pkVcROuHvcsa6zf3brAPFSXvL3xaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17917

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDA3IEF1Z3VzdCAyMDI2IDE0OjE2DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIzIDA1LzE0XSBtbWM6IHJlbmVzYXNfc2RoaTogTWFrZSBjbG9jayBkaXZpZGVyIG1hc2sg
Y29uZmlndXJhYmxlDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVGh1LCAzMCBKdWwgMjAyNiBh
dCAxMzozMiwgQmlqdSA8YmlqdS5kYXMuYXVAZ21haWwuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBBZGQgYSBjbGtf
ZGl2X21hc2sgZmllbGQgdG8gcmVuZXNhc19zZGhpX29mX2RhdGEgYW5kIHRtaW9fbW1jX2RhdGEg
c28NCj4gPiBlYWNoIFNvQyBjYW4gc3BlY2lmeSBpdHMgb3duIGRpdmlkZXIgbWFzayBpbnN0ZWFk
IG9mIHRoZSBoYXJkY29kZWQNCj4gPiBDTEtfQ1RMX0RJVl9NQVNLIHVzZWQgaW4gcmVuZXNhc19z
ZGhpX3NldF9jbG9jaygpLg0KPiA+DQo+ID4gRGVmYXVsdCB0byBHRU5NQVNLKDcsIDApIGF0IHBy
b2JlIHRpbWUgd2hlbiB1bnNldCwgYW5kIHBvcHVsYXRlIGFsbA0KPiA+IGV4aXN0aW5nIGludGVy
bmFsL3N5cyBETUFDIG9mX2RhdGEgdGFibGVzIHdpdGggdGhpcyB2YWx1ZSB0byBrZWVwDQo+ID4g
Y3VycmVudCBTb0NzIHVuYWZmZWN0ZWQuIFRoaXMgbGV0cyBSWi9HM0wsIHdoaWNoIGhhcyBhIHdp
ZGVyIGRpdmlkZXINCj4gPiBmaWVsZCwgcmV1c2UgdGhlIHNhbWUgY2xvY2stc2V0dGluZyBjb2Rl
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tPg0KPiA+IC0tLQ0KPiA+ICAqIEFzc2lnbmVkIG9mX2RhdGEtPmNsa19kaXZfbWFzayBp
biByZW5lc2FzX3NkaGlfcHJvYmUoKS4NCj4gPiB2MjEtPnYyMjoNCj4gPiAgKiBVcGRhdGVkIGNv
bW1pdCBkZXNjcmlwdGlvbi4NCj4gPiAgKiBBZGRlZCBjbGtfZGl2X21hc2sgdG8gb2ZfZGVmYXVs
dF9jZmcgYW5kIG9mX3JjYXJfZ2VuMl9jb21wYXRpYmxlLg0KPiANCj4gVGhhbmtzIGZvciB0aGUg
dXBkYXRlIQ0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2RoaS5oDQo+
ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9yZW5lc2FzX3NkaGkuaA0KPiA+IEBAIC00MSw2ICs0
MSw3IEBAIHN0cnVjdCByZW5lc2FzX3NkaGlfb2ZfZGF0YSB7DQo+ID4gICAgICAgICB1bnNpZ25l
ZCBsb25nIHNkaGlfZmxhZ3M7DQo+ID4gICAgICAgICB1NjQgY2xrX21hc2s7DQo+ID4gICAgICAg
ICBpbnQgbWF4X2RpdmlkZXI7DQo+ID4gKyAgICAgICB1MTYgY2xrX2Rpdl9tYXNrOw0KPiA+ICB9
Ow0KPiA+DQo+ID4gICNkZWZpbmUgU0RISV9DQUxJQl9UQUJMRV9NQVggMzINCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvaG9zdC9yZW5lc2FzX3NkaGlfY29yZS5jDQo+ID4gYi9kcml2ZXJz
L21tYy9ob3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMNCj4gPiBpbmRleCBkODkzYTI2M2U3NzAuLjVk
Y2JiNDMxZTFlMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2Ro
aV9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMN
Cj4gPiBAQCAtMjI0LDcgKzIyNCw3IEBAIHN0YXRpYyB2b2lkIHJlbmVzYXNfc2RoaV9zZXRfY2xv
Y2soc3RydWN0IHRtaW9fbW1jX2hvc3QgKmhvc3QsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgY2xrICY9IH4weGZmOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICBjbG9jayA9
IGNsayAmIENMS19DVExfRElWX01BU0s7DQo+ID4gKyAgICAgICBjbG9jayA9IGNsayAmIGhvc3Qt
PnBkYXRhLT5jbGtfZGl2X21hc2s7DQo+ID4gICAgICAgICBpZiAoY2xvY2sgIT0gQ0xLX0NUTF9E
SVZfTUFTSykNCj4gDQo+IFRoaXMgc3RyaWtlcyBtZSBhcyBhIGJpdCBvZGQ7IHNob3VsZCBDTEtf
Q1RMX0RJVl9NQVNLIGJlIGNoYW5nZWQgdG8NCj4gaG9zdC0+cGRhdGEtPmNsa19kaXZfbWFzayBp
biB0aGUgY2hlY2ssIHRvbz8NCg0KTm8sIHRoaXMgaXMgdGhlIHZhbHVlIGZvciAxOjEgb3B0aW9u
Lg0KDQogICAgWyAgICAyLjY0ODA1MF0gIyMjIyMjIyMjIyNjbGsvY2xvY2sgNDAwMGZmL2ZmDQoN
CmlmIHdlIGRvLCAoY2xvY2sgIT0gaG9zdC0+cGRhdGEtPmNsa19kaXZfbWFzaykgdGhlbg0KdGhl
IGNoZWNrIHdpbGwgYWx3YXlzIHRydWUgZm9yIFJaL0czTChHRU5NQVNLKDksMCkpIGFuZA0KaXQg
bmV2ZXIgc2V0IDE6MSBkaXZpZGVyIHZhbHVlLiANCg0KVGhlIDE6MSBkaXZpZGVyIHZhbHVlczoN
Cg0KTm9uLVJaL0czTCwgaXQgaXMgMTExMSAxMTExYg0KRm9yIFJaL0czTCwgaXQgaXMgMDAgMTEx
MSAxMTExYg0KDQo+IA0KPiA+ICAgICAgICAgICAgICAgICBob3N0LT5tbWMtPmFjdHVhbF9jbG9j
ayAvPSAoMSA8PCAoZmZzKGNsb2NrKSArIDEpKTsNCj4gPg0KPiA+IEBAIC0xMTM4LDYgKzExMzgs
NyBAQCBpbnQgcmVuZXNhc19zZGhpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYs
DQo+ID4gICAgICAgICAgICAgICAgIG1tY19kYXRhLT5tYXhfc2VncyA9IG9mX2RhdGEtPm1heF9z
ZWdzOw0KPiA+ICAgICAgICAgICAgICAgICBtbWNfZGF0YS0+Y2xrX21hc2sgPSBvZl9kYXRhLT5j
bGtfbWFzazsNCj4gPiAgICAgICAgICAgICAgICAgbW1jX2RhdGEtPm1heF9kaXZpZGVyID0gb2Zf
ZGF0YS0+bWF4X2RpdmlkZXI7DQo+ID4gKyAgICAgICAgICAgICAgIG1tY19kYXRhLT5jbGtfZGl2
X21hc2sgPSBvZl9kYXRhLT5jbGtfZGl2X21hc2s7DQo+ID4gICAgICAgICAgICAgICAgIGRtYV9w
cml2LT5kbWFfYnVzd2lkdGggPSBvZl9kYXRhLT5kbWFfYnVzd2lkdGg7DQo+ID4gICAgICAgICAg
ICAgICAgIGhvc3QtPmJ1c19zaGlmdCA9IG9mX2RhdGEtPmJ1c19zaGlmdDsNCj4gPiAgICAgICAg
ICAgICAgICAgLyogRmFsbGJhY2sgZm9yIG9sZCBEVHMgKi8gQEAgLTExODYsNiArMTE4Nyw5IEBA
IGludA0KPiA+IHJlbmVzYXNfc2RoaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
LA0KPiA+ICAgICAgICAgaWYgKCFtbWNfZGF0YS0+bWF4X2RpdmlkZXIpDQo+ID4gICAgICAgICAg
ICAgICAgIG1tY19kYXRhLT5tYXhfZGl2aWRlciA9IFNESElfTUFYX0RJVklERVJfREVGQVVMVDsN
Cj4gPg0KPiA+ICsgICAgICAgaWYgKCFtbWNfZGF0YS0+Y2xrX2Rpdl9tYXNrKQ0KPiA+ICsgICAg
ICAgICAgICAgICBtbWNfZGF0YS0+Y2xrX2Rpdl9tYXNrID0gR0VOTUFTSyg3LCAwKTsNCj4gDQo+
IENMS19DVExfRElWX01BU0ssIHBlcmhhcHM/DQoNCkFncmVlZC4NCg0KQ2hlZXJzLA0KQmlqdQ0K
DQo=
