Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41FEC34022
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 07:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9C7208C4
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 07:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLSEb5yP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgBSHRM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:17:12 -0500
Received: from mail-db8eur05on2075.outbound.protection.outlook.com ([40.107.20.75]:6107
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726634AbgBSHRL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 02:17:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6xIoy55nCkHCoSJ3+0oR9PIDsr01VgNqFuxrdGdcy85wTTQbkLOqb0mk+oWlzFRkGKcNo7pAKCqq1JyG1b8XZBDFj6Yt3X6ZY82jOp+V/gdyqX+W9F4sLeU6svKoFEO3P8vMbAnk+/pgjE7RRT0QHhOxHi90xnap3sCnNGjlc4x/e0D56ErJdKrBNMUZHC1EWTMVIRhSWTjd5GRG4Smf48TSIYsy+MKs4RBVdlpPF0iaJMLUHozpfjVO6au9iqL1KFzgE6dAM6hCcRg9Z11uO6Qa9+nR5iM4clZ6pqj6P1J+12YAciAT19ql8iwU/5Q3D1szKb/D8h9lhH0QO4R7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CzpOkfAiQmKGrdxmqu9idffsbn3SVZqICe5OwH9Vnc=;
 b=FYYPWpo1OXqkKfDoggiqJzZPg6FrGPtc6q51wbZQmNeQNgV5Mw39NQO+t9mhXeS7Uy2d83ay/1JcvBL29TxI6YjqmfoZOt1mOuShb0i2YCHM9M/rYfLx//WMl8Fy88W8SPFeOMP6fpc1cqyjvNNp6GR7Rbz+XJF0V+7j2se9hWSkWy3uwfcpjaFWklefXq718uoOcf8V0XBBAUOty5IwYI1uvDrdaQR8azT8i256iI+CUaZYf+fB+8X7YOPUrAuSFmAPrFEZ+nEldOoM8tl2HtT0WlvVyF2h0u9tdSVWhU3ZnRErASzP0bprDSYha1pK66+6TS80QwbwYVlmF70hLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CzpOkfAiQmKGrdxmqu9idffsbn3SVZqICe5OwH9Vnc=;
 b=WLSEb5yPRTZd4I8jC9bBjMnFBZIUKy/271uH7pQiGuptbMmRdmsybS8SHo/yxTJJseN0JTCHRbfJFXtze8+b2LO0nelKJkkx2GkStF0orjZ8HAM0/MY9qj5RsHrL3lcnreqePzT0KfkdUPO+YedSEolMJbqh/n0zmHtm4j0YVSs=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB3070.eurprd04.prod.outlook.com (10.170.226.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 07:16:28 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::d0c7:37d1:d835:a682]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::d0c7:37d1:d835:a682%7]) with mapi id 15.20.2729.025; Wed, 19 Feb 2020
 07:16:28 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: RE: [PATCH v3 12/14] mmc: sdhci-esdhc-imx: restore pin state when
 resume back
Thread-Topic: [PATCH v3 12/14] mmc: sdhci-esdhc-imx: restore pin state when
 resume back
Thread-Index: AQHV3+/b30nSiJHUb0OB5kCtwTsgLqggooYAgAGElQA=
Date:   Wed, 19 Feb 2020 07:16:28 +0000
Message-ID: <VI1PR04MB50404888BEF9C4A2E19D9D4C90100@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
 <1581324597-31031-7-git-send-email-haibo.chen@nxp.com>
 <df1c1a87-24d4-008f-a9ee-3998bf75d5b6@intel.com>
In-Reply-To: <df1c1a87-24d4-008f-a9ee-3998bf75d5b6@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [223.106.0.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2702ef00-2b36-4463-5217-08d7b50ba359
x-ms-traffictypediagnostic: VI1PR04MB3070:|VI1PR04MB3070:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3070C27AF312C1B0B7B6122C90100@VI1PR04MB3070.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(66946007)(4326008)(66446008)(478600001)(186003)(66476007)(64756008)(7696005)(81156014)(86362001)(76116006)(53546011)(33656002)(52536014)(6506007)(81166006)(66556008)(316002)(5660300002)(8676002)(8936002)(26005)(110136005)(55016002)(71200400001)(2906002)(9686003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3070;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWqvC4nvo9qU55a62e0XSesIUEUQLCM+TVyF5VelTnOGmfufCeYJijt5Eh2ygt6At+a7tD0GEW3nKLjSSvU2lveVAC1XOSCSyQXsQT7/v6dmHWXMHjOrvq27N3YpRStUhMm4mmpQprSIRw1AoS/Z1x7nGhgWBCwYFN0X691R0zVXKuXuVw67E1c2Wvx6hCXtKAS7BouaDd+XUgyR+mScLmZAKF+JJ3/+58Yt6PTVCaF+HCgp5BJafi7yltVJbzbkRmJjAmA4Yxjit391JROQdSGg6hO9mrRcGJ9FzO77M17235QMtlP3W0org0e7w54f3dkuMbEQmM/aXO0zbBw/XPKnFToNNzp8+UcK9n7oM3ZDRA9ft5CFauiI1fnQMZl05bXCpxyrQ6wfRIGCI6vA3cKkQo7nv8AbrkTEaDwvDncz/mi4cN+QDBs7TvZD7nAJ
x-ms-exchange-antispam-messagedata: nvPbTagw5K9nz+EME2oQ+rQlelbX+h17x/zNcDtIvthERk1/9lS6UOypIb7cWXJlr4VfHaR5p3KdjVD3SGj0INcL7M6bqAKli8AgJ6FLxg9l7nsZsEf6S3m4TzhT1teJ9NSNVFYMKd2LhEtZJSIQrA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2702ef00-2b36-4463-5217-08d7b50ba359
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 07:16:28.5062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EG1+7UoMAPZX28Hlr7Sk/COKJFu6dG40sD2i38y3avdnBi9ZK5olPXslyt5QJXletFTEM6Tm09a8h+avC9xSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3070
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1tbWMtb3duZXJAdmdl
ci5rZXJuZWwub3JnDQo+IDxsaW51eC1tbWMtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhh
bGYgT2YgQWRyaWFuIEh1bnRlcg0KPiBTZW50OiAyMDIw5bm0MuaciDE45pelIDE1OjU4DQo+IFRv
OiBCT1VHSCBDSEVOIDxoYWliby5jaGVuQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
Ow0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsgbGludXMud2FsbGVpakBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgMTIvMTRdIG1tYzogc2RoY2ktZXNkaGMtaW14OiByZXN0b3JlIHBpbiBzdGF0ZSB3
aGVuDQo+IHJlc3VtZSBiYWNrDQo+IA0KPiBPbiAxMC8wMi8yMCAxMDo0OSBhbSwgaGFpYm8uY2hl
bkBueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNv
bT4NCj4gPg0KPiA+IEluIHNvbWUgbG93IHBvd2VyIG1vZGUsIFNvQyB3aWxsIGxvc2UgdGhlIHBp
biBzdGF0ZSwgc28gbmVlZCB0bw0KPiA+IHJlc3RvcmUgdGhlIHBpbiBzdGF0ZSB3aGVuIHJlc3Vt
ZSBiYWNrLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5j
IHwgMTIgKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1lc2RoYy1pbXguYw0KPiA+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
Yw0KPiA+IGluZGV4IDEwNjA5N2NiZDBkNC4uZGVkYzA2N2NkMGRkIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiArKysgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gQEAgLTE3MTcsNyArMTcxNywxMyBAQCBzdGF0
aWMgaW50IHNkaGNpX2VzZGhjX3N1c3BlbmQoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiA+ICAJ
aWYgKGhvc3QtPnR1bmluZ19tb2RlICE9IFNESENJX1RVTklOR19NT0RFXzMpDQo+ID4gIAkJbW1j
X3JldHVuZV9uZWVkZWQoaG9zdC0+bW1jKTsNCj4gPg0KPiA+IC0JcmV0dXJuIHNkaGNpX3N1c3Bl
bmRfaG9zdChob3N0KTsNCj4gPiArCXJldCA9IHNkaGNpX3N1c3BlbmRfaG9zdChob3N0KTsNCj4g
PiArCWlmICghcmV0KQ0KPiA+ICsJCWlmIChwaW5jdHJsX3BtX3NlbGVjdF9zbGVlcF9zdGF0ZShk
ZXYpKQ0KPiA+ICsJCQlkZXZfd2FybihtbWNfZGV2KGhvc3QtPm1tYyksDQo+ID4gKwkJCSAiJXMs
IGZhaWxlZCB0byBzZWxlY3Qgc2xlZXAgcGluIHN0YXRlIVxuIiwgX19mdW5jX18pOw0KPiANCj4g
SXQgbG9va3MgdG8gbWUgbGlrZSBwaW5jdHJsX3BtX3NlbGVjdF9zbGVlcF9zdGF0ZSgpIHByaW50
cyBhbiBlcnJvciBhbnl3YXkgaWYNCj4gaXQgZmFpbHMsIHNvIHRoZSB3YXJuaW5nIGhlcmUgaXMg
cmVkdW5kYW50Lg0KDQpPa2F5LCB0aGFua3MgZm9yIHBvaW50IG91dCB0aGF0IQ0KDQo+IA0KPiBB
bHNvIGEgY29tbWVudCBhYm91dCB3aHkgaXQgaXMgT0sgdG8gaWdub3JlIGFuIGVycm9yIGNvdWxk
IGJlIGFkZGVkLg0KDQpZZXMsIEkgd2lsbCBhZGQgYSBjb21tZW50IGxpa2UgYmVsb3csIHNob3Vs
ZCBpdCBiZSBva2F5Pw0KDQovKg0KICogaGVyZSBpZ25vcmUgdGhlIGVycm9yIHJldHVybiwgYmVj
YXVzZSBjdXJyZW50IEFQSSBzZGhjaV9zdXNwZW5kX2hvc3QgYWx3YXlzIHJldHVybiB6ZXJvLA0K
ICogV2hlbiB0aGUgQVBJIHNkaGNpX3N1c3BlbmRfaG9zdCBjaGFuZ2UgdGhlIHJldHVybiBwb2xp
Y3ksIG5lZWQgdG8gY2hhbmdlIGF0IGhlcmUgdG9vLg0KICovDQoNCkJlc3QgUmVnYXJkcw0KQm91
Z2ggY2hlbg0KPiANCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAg
c3RhdGljIGludCBzZGhjaV9lc2RoY19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KSBAQCAtMTcy
NSw2ICsxNzMxLDEwDQo+ID4gQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19yZXN1bWUoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiA+ICAJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gPiAgCWludCByZXQ7DQo+ID4NCj4gPiArCWlmIChwaW5jdHJsX3BtX3Nl
bGVjdF9kZWZhdWx0X3N0YXRlKGRldikpDQo+ID4gKwkJZGV2X3dhcm4obW1jX2Rldihob3N0LT5t
bWMpLA0KPiA+ICsJCSAiJXMsIGZhaWxlZCB0byBzZWxlY3QgZGVmYXVsdCBwaW4gc3RhdGUhXG4i
LCBfX2Z1bmNfXyk7DQo+IA0KPiBTYW1lIGFzIGFib3ZlDQo+IA0KPiA+ICsNCj4gPiAgCS8qIHJl
LWluaXRpYWxpemUgaHcgc3RhdGUgaW4gY2FzZSBpdCdzIGxvc3QgaW4gbG93IHBvd2VyIG1vZGUg
Ki8NCj4gPiAgCXNkaGNpX2VzZGhjX2lteF9od2luaXQoaG9zdCk7DQo+ID4NCj4gPg0KDQo=
