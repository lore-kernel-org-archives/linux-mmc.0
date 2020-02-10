Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB8CC2BA83
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 03:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA2D214DB
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 03:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pTjqE0E9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgBJDIQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 9 Feb 2020 22:08:16 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:6069
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbgBJDIQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 9 Feb 2020 22:08:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8A52S6vOhYcXTX2qCIOJSOXfgnqGyMHBVqZrL30k+3PV00JTjKgt4+ORXTvfL1niIdgUCNxUi2c8pZUy4ltMsinezDYjEMYVtMBR9CZzRDglrCO9xHIMCajMFTUUCvV+8BTfLVipEySZRX0hgWyjOiV1NtFlWtxBtYqrO//9j8aKup1issqHDvaKBsmBQ6PR4hdvfHiUqi8Bw3xQpAshwEf80VOeCvdLxozt2AAN2LWRxSwPc36b7PzCa3bKv17gGAaONf70+EDm4cy3Ww+t117UO23+gIhjEE3sdockPdpvxLHkSSvwMYGUQlCz/uwuLkjH3gKzvkbM9gUf4RJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9nj2fur+WnG54EuHUdh3BEMTAb9rIII2K9EuqpmPW8=;
 b=f6vusPkQHxFaoV73XMmnDMsdE59IomZbc3+3g/qzjjXE9YunFxXJJw8pfnzgtiXbGh9SwyAZ/36Vb9hRWF/j2xTjCW+JpywY/JVDDEKPPMtS5XFIatnesGdoiDpXVKLUjF8JYxRonGx3wtm6pd9JkzaCV2ldivwltCVlkNdUb7/ZX3MfgLRi84YrC/SMkzpx56e2DXzNwZsfZnsDqucSy+ZYAv2q/EjlPbyDVRNffvFAmQUnPP/pr66KogAU0Q5YPuYO6iA7QtjtBC5lPYyaZL/EKFADPHFJT+FSHBjp4P24t4eSVRxk6pDghMzZfvfWfcw5QtS5UMWTwSsxwNKsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9nj2fur+WnG54EuHUdh3BEMTAb9rIII2K9EuqpmPW8=;
 b=pTjqE0E9Zii5c9FaLKkSwtklebdoD3rhjgwVe+09rU9WkOe8Hb7s/hncX4cRXAwGw2cIkD2rVkk1qHL2C/i582L1DGwO+LjcSPJiiBiQirEOkqm1d+jzgd1ohFS3T3bTAnS1MHY9TR9gIQ0PE/wo3P97IxoV1bv8p0j+PDv8iFA=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB3037.eurprd04.prod.outlook.com (10.170.228.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Mon, 10 Feb 2020 03:08:11 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::d0c7:37d1:d835:a682]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::d0c7:37d1:d835:a682%7]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 03:08:11 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 09/14] doc: dt: fsl-imx-esdhc: add auto-cmd23-broken
 binding
Thread-Topic: [PATCH v2 09/14] doc: dt: fsl-imx-esdhc: add auto-cmd23-broken
 binding
Thread-Index: AQHVqdjTjLRtJqjPkketBWV+YO8JR6e0EGEAgAACMoCAYBQa4A==
Date:   Mon, 10 Feb 2020 03:08:11 +0000
Message-ID: <VI1PR04MB5040F88333696C1C0DD64B2390190@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <20191203130120.11511-1-haibo.chen@nxp.com>
 <20191203130120.11511-10-haibo.chen@nxp.com>
 <CACRpkdYN9rL9go68dyGgED0=atZMV7uAU3jfsT025e1NvB6brg@mail.gmail.com>
 <CACRpkdaU+KbKmKdB2bniGbG34qMD-EPbkBLG1x+ac24uzKrW9Q@mail.gmail.com>
In-Reply-To: <CACRpkdaU+KbKmKdB2bniGbG34qMD-EPbkBLG1x+ac24uzKrW9Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36d069ae-c56d-487b-4301-08d7add67636
x-ms-traffictypediagnostic: VI1PR04MB3037:|VI1PR04MB3037:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3037252107D67F97ECA2CFF590190@VI1PR04MB3037.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(199004)(189003)(6916009)(478600001)(8936002)(7696005)(53546011)(66556008)(81156014)(8676002)(76116006)(81166006)(6506007)(5660300002)(186003)(66476007)(66946007)(52536014)(33656002)(2906002)(54906003)(86362001)(9686003)(71200400001)(64756008)(55016002)(4326008)(26005)(316002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3037;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EuOK6E/o2jgVG3fW1za/SUjZRWKPhmgrh3CYLCuom9zhEBRRAPQab2GJiPic7Q5TUdov8QZ0TKA6aI4iKraFSnAEUiJzPd2AYhtdET/YcPP7fk2OhNpAdu5lGTnbxj/AVmdCWgM87aF4Ft6gvnZhrnPvvBegx0YsxhU//iXG/ZDSO3aS1lMVNLiwZ/NhcfHyy+ZHyvuZH3d6/vw6GgR/7MjD/GEewyEYVhM2G/KWdipWlq8ochTIKLknO5JpRluf0gBbIP7RecPk8fmiijguF2Q5mrSBRWqgemsPvBIwYzCF6KSbXfBbRaFk6jjsAIspv/wjwzw6P67NB6SKC+Wv1cKqi90kncrlqKhri+sOL7yZOSg6KDwc7mCLs+Lf5eUKCK4udMK9FDbNlw7BYfAw9zHYXAxt3XnE5TsIhbiT6eMrTs9PlLHcL7A2NDNoERA1
x-ms-exchange-antispam-messagedata: t7RHhhoGcnJ8qhgSR4PljqGjGOS+8RM0BL819eb730qKZ1jcVSapOqvDAVEf/SbBBt44T9VLvwWY0+2d6Gqz3z134FY0ZpZK4EWs33ouHcN5ButAPv1gOYTv62zlojCMxYYMw6iR3IxWAFUYOayhww==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d069ae-c56d-487b-4301-08d7add67636
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 03:08:11.3778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uD2M7FUEJ3Z/EZSZtod8L2lfCzdrM5FWKy+I/ta0m1uDPmWDoq8a8wbIqodUei0KOsWAHXYkwIfayg3tNFu75g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3037
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMTnlubQxMuaciDEx5pelIDc6NDANCj4g
VG86IEJPVUdIIENIRU4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IHVsZi5oYW5zc29uQGxp
bmFyby5vcmc7IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwub3Jn
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5j
b20+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
MDkvMTRdIGRvYzogZHQ6IGZzbC1pbXgtZXNkaGM6IGFkZA0KPiBhdXRvLWNtZDIzLWJyb2tlbiBi
aW5kaW5nDQo+IA0KPiBPbiBXZWQsIERlYyAxMSwgMjAxOSBhdCAxMjozMiBBTSBMaW51cyBXYWxs
ZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgRGVj
IDMsIDIwMTkgYXQgMTo1NCBQTSBCT1VHSCBDSEVOIDxoYWliby5jaGVuQG54cC5jb20+DQo+IHdy
b3RlOg0KPiA+DQo+ID4gPiArLSBzZGhjaSxhdXRvLWNtZDIzLWJyb2tlbjogZGlzYWJsZSB0aGUg
QUNNRDIzIGZ1bmN0aW9uIG9mIFVTREhDLg0KPiA+ID4gKyAgVGhpcyBpcyByZXF1aXJlZCBmb3Ig
ZU1NQyBvbiBpbXg2cXBkbC9pbXg2c3gvaW14N2Qgd2hlbiBpdCB1c2UNCj4gPiA+ICtBRE1BIG1v
ZGUuIEJlY2F1c2UNCj4gPiA+ICsgIGZvciB0aGVzZSBTb0MsIGl0IGRvIG5vdCBzdXBwb3J0IHRo
ZSBBQ01EMjMgY29tcGxldGVseSwgb25seSB0YWtlDQo+ID4gPiArdGhlIDE2IGJpdCBibG9jaw0K
PiA+ID4gKyAgY291bnQgZnJvbSB0aGUgMHg0IHJlZ2lzdGVyIChCTEtfQVRUKSBhcyBhcmd1bWVu
dCBmb3IgdGhlIEFDTUQyMywNCj4gPiA+ICt0aGUgdXBwZXIgMTYgYml0DQo+ID4gPiArICBvZiB0
aGUgQ01EMjMncyBhcmd1bWVudCBpcyBpZ25vcmVkLiBUaGlzIHdpbGwgaW1wYWN0IHRoZSByZWxp
YWJsZQ0KPiA+ID4gK3dyaXRlIG9wZXJhdGlvbg0KPiA+ID4gKyAgYW5kIHRoZSBSUE1CIGJsb2Nr
IHdyaXRlIG9wZXJhdGlvbiwgYmVjYXVzZSB0aGVzZSBvcGVyYXRpb25zIG5lZWQNCj4gPiA+ICt0
byBzZXQgdGhlIGJpdCAzMQ0KPiA+ID4gKyAgb2YgdGhlIENNRDIzJ3MgYXJndW1lbnQuIFNETUEg
bW9kZSB3aWxsIGRlZmF1bHQgZGlzYWJsZSB0aGUNCj4gPiA+ICtBQ01EMjMgbW9kZS4gU0QgY2Fy
ZCBkbw0KPiA+ID4gKyAgbm90IGhhcyB0aGlzIGxpbWl0YXRpb24gb24gdGhlc2UgU29Dcy4NCj4g
Pg0KPiA+IFRoaXMgbG9va3Mgd2VpcmQuDQo+ID4NCj4gPiBJcyB0aGUgYnVnIGluIHRoZSAqaG9z
dCBjb250cm9sbGVyKiBvciBpbiAqdGhlIGNhcmQqPw0KPiA+DQo+ID4gSXQgbG9va3MgbGlrZSB0
aGUgY2FyZC4NCj4gDQo+IEFmdGVyIGxvb2tpbmcgYXQgdGhlIG5leHQgcGF0Y2ggaXQgbG9va3Mg
bGlrZSB0aGUgaG9zdCBjb250cm9sbGVyLg0KPiANCj4gSW4gdGhhdCBjYXNlIHRoZSBjb21wYXRp
YmxlLXN0cmluZyBzaG91bGQgaW5kaWNhdGUgd2hhdCB2ZXJzaW9uIG9mIHRoZSBJUCB5b3UNCj4g
YXJlIHVzaW5nIGFuZCBpZiBpdCBoYXMgdGhpcyBidWcuDQo+IA0KPiBObyBzcGVjaWFsIGZsYWdz
IG5lZWRlZCBmb3IgdGhhdC4NCg0KSGkgTGludXMsDQoNClllcywgdGhpcyBpcyBob3N0IElQIGxp
bWl0YXRpb24uIEkgZGlkIGNvbnNpZGVyIHRoZSBtZXRob2QgYXMgeW91IHN1Z2dlc3RlZCwgdXNl
IGNvbXBhdGlibGUtc3RyaW5nIHRvIGRpc3Rpbmd1aXNoLiBCdXQgdGhlbiBJIG5vdGljZSB0aGF0
IHRoaXMgaG9zdCBsaW1pdGF0aW9uIG9ubHkgaW1wYWN0IHRoZSBlTU1DIGRldmljZSBmb3IgUlBN
QiByZWxpYWJsZSB3cml0ZSwgZm9yIFNEIGNhcmQsIGl0IGRvIG5vdCBzdXBwb3J0IHRoaXMgbW9k
ZSwgc28gdGhpcyBoYXJkd2FyZSBsaW1pdGF0aW9uIGRvIG5vdCBpbXBhY3QgZm9yIHNkIGNhcmQu
DQpUaGlzIGlzIHdoeSBJIHVzZSAic2RoY2ksYXV0by1jbWQyMy1icm9rZW4iIGluIGRldmljZXRy
ZWUsIG9ubHkgdGhlIGVtbWMgZGV2aWNlIG5lZWQgdG8gY29udGFpbiB0aGlzIGluIGR0cyBmaWxl
Lg0KDQpJIGRvdWJsZSBjaGVjayB0aGlzIGlzc3VlLCBzaW5jZSB0aGlzIGF1dG8tY21kMjMgd2ls
bCBub3QgaW1wYWN0IHRoZSBzZCBwZXJmb3JtYW5jZSwgYW5kIGl0IGlzIHRoZSBob3N0IElQIGxp
bWl0YXRpb24sIEkgd2lsbCBjaG9zZSB0byBhY2NlcHQgeW91ciBzdWdnZXN0aW9uLCB3aWxsIHNl
bmQgYSBuZXcgcGF0Y2guDQoNClRoYW5rcywNCg0KQm91Z2ggQ2hlbg0KDQoNCj4gDQo+IFlvdXJz
LA0KPiBMaW51cyBXYWxsZWlqDQo=
