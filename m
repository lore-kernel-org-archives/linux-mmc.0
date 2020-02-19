Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C2C34022
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 07:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30AC2176D
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 07:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dBN7gBu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgBSHhy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:37:54 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:26951
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbgBSHhy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 02:37:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfDtCJXBeuQF7pjetCKuPyRiXLGj1+H9JYZsB5wSZskA7EW2tjhnRwxOnhLK2a3faV5eDAi12lWt13T3prfS76u/hQ5sRplqlCKVRhGj/RRqOsHFsyLtapQIgfZtDi7CoxLqXPjB9nAHA7NruXGe6jUFBrwAyrboTn50AX3W3adHUgZhgsPKec0PZwmwtIxmBJHs0QBOSRhoi7Z4UORVV93+FaWC6+ostCnxF8ryJWgDkia3pfiErpgC8+c1y1AwlqJAiNd000sLWPL1voLL7Yik53/bC8xzXd/PIYabFMSQmYXVGkLpT9w+ukWyzes4zFBLvpo9VyORtmUHh467Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cuy1XX8UBFktkq2UsBxzI9AkHlXQzi+jfC6E6AuF58k=;
 b=Co/dT7T+EKplBQxU1SSE0L31+HXdsQ0Oc/eIjd/5yAb2IvvA6h1wwLgAMKz7KP5v1Cgzy+JtSy59Imd5Dmk4PfR5QaGBzShjekH7y6n+Q/3D4YYB+jC3N9csZbG7KZM7xm1BnMkM+W42uRq0tRrR3MfpbVsKQw2RJMW/+HlrZ4L1nimFAMs9rLBoUC7kN7IvvPL9zWnfD9sN3NKs5yxrJ+PudrHE+cxVACRQCNiej2awIGOM+zxx7FNJYKwvGLganWScZuR7YSKxThGX+VXUk/DgH+B88UfowxooQoE0UkoncANH7ode3ZlhVgOZbfusS1g0BgkkjmuRZU2s7DBxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cuy1XX8UBFktkq2UsBxzI9AkHlXQzi+jfC6E6AuF58k=;
 b=dBN7gBu0vv7CSKDZEyVRvolN9Ol7PaHMiqmPNV4EDwfhPbAC4XWYXVkkBrzMmHfn/+4nWcOVMeyjMaBjIA2zqQpCd6piqs6SkiI30uK0k+xBsW3exlKKYgAdECDxltj1Qv7Pan+lZWoxto7NL9PtHWsOJoiuvPobnFHDQJGjOR4=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB5005.eurprd04.prod.outlook.com (20.177.49.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 07:37:48 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::d0c7:37d1:d835:a682]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::d0c7:37d1:d835:a682%7]) with mapi id 15.20.2729.025; Wed, 19 Feb 2020
 07:37:48 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: RE: [PATCH v3 12/14] mmc: sdhci-esdhc-imx: restore pin state when
 resume back
Thread-Topic: [PATCH v3 12/14] mmc: sdhci-esdhc-imx: restore pin state when
 resume back
Thread-Index: AQHV3+/b30nSiJHUb0OB5kCtwTsgLqggooYAgAGElQCAAAWQAIAAAEnw
Date:   Wed, 19 Feb 2020 07:37:48 +0000
Message-ID: <VI1PR04MB504033CAD028EBE1784E997390100@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
 <1581324597-31031-7-git-send-email-haibo.chen@nxp.com>
 <df1c1a87-24d4-008f-a9ee-3998bf75d5b6@intel.com>
 <VI1PR04MB50404888BEF9C4A2E19D9D4C90100@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <363DA0ED52042842948283D2FC38E4649C6FFB24@IRSMSX106.ger.corp.intel.com>
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C6FFB24@IRSMSX106.ger.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [223.106.0.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 013bdfc5-0a78-4a12-3a6b-08d7b50e9e1b
x-ms-traffictypediagnostic: VI1PR04MB5005:|VI1PR04MB5005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB50056E07487B93CC0F765F9B90100@VI1PR04MB5005.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(52536014)(66946007)(66476007)(2906002)(8676002)(8936002)(81166006)(4326008)(186003)(81156014)(76116006)(6506007)(53546011)(7696005)(86362001)(66556008)(64756008)(66446008)(26005)(71200400001)(5660300002)(316002)(54906003)(55016002)(33656002)(478600001)(110136005)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5005;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KutaC3Ppjx4WAxohYVKobAjitTWWvwvuH5LykEuUoTYQ2+GWlEy52rWbGMRIwzE6HP5P7GrJyvNWlHLOfc6xgQ4xTK2h3NP/9ql4iA3Wfrpr8CQbPd7gPjGgiUB2Wcv2U7SmJCxX0XM83aVi0Hhtq6cxA2jRoppOqPsSCYi8f3aeEjtKBV4AcdxkwGCX15dLEXfBqWpHeZQiyPhd6ogn6eVN93/siULyrrdL70fKpCPiXRqc9JA+WCwtxwQfpWnQBkJHwjM2XGQ8m1ejJg6GuZ14OFU87h6JKlp0g+/zHXEXLtLtYPJQF3cmMZKyK2SOZJCdL57M5dMTW9he51zPKkftTOa8ekuKoOA5FAa6hs48QWLvEbH++npjdDtCeZntWB00XobG2z02h1nU/iqFtf0X8G0v0SaEzCkDv0gtjJmHn4t/KeY9XTjKbRrr4EFt
x-ms-exchange-antispam-messagedata: ipwu2BCzmqduAVdS04ZoLsfBMrpogv0iwo79KtJQVD88NYK/1Fjx5SCQIqwroLxJEk1kh6p30LBNn4QZcdVIfrqMbaaw6v64v07KsuQzCAROCx2lu3VwlSGM2Vm8FCK6IDXASgCsG8lTuVcfRGMFWA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013bdfc5-0a78-4a12-3a6b-08d7b50e9e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 07:37:48.1579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAUCXP2h5afjQ98SCFphRQgKjVeezfS7hXFf0s4KcYzUzbExrEspXKt/0mmlZEzMAheBrrBD6JmlCY9Z2jLdog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5005
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIdW50ZXIsIEFkcmlhbiA8YWRy
aWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IDIwMjDlubQy5pyIMTnml6UgMTU6MjkNCj4g
VG86IEJPVUdIIENIRU4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5v
cmc7DQo+IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGlu
dXgtaW14QG54cC5jb20+OyBsaW51cy53YWxsZWlqQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUkU6
IFtQQVRDSCB2MyAxMi8xNF0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6IHJlc3RvcmUgcGluIHN0YXRl
IHdoZW4NCj4gcmVzdW1lIGJhY2sNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+IEZyb206IEJPVUdIIENIRU4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiBT
ZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDE5LCAyMDIwIDk6MTYgQU0NCj4gPiBUbzogSHVudGVy
LCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9y
ZzsNCj4gPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+OyBsaW51cy53YWxsZWlqQGxpbmFyby5vcmcNCj4gPiBTdWJqZWN0
OiBSRTogW1BBVENIIHYzIDEyLzE0XSBtbWM6IHNkaGNpLWVzZGhjLWlteDogcmVzdG9yZSBwaW4g
c3RhdGUNCj4gPiB3aGVuIHJlc3VtZSBiYWNrDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBsaW51eC1tbWMtb3duZXJAdmdlci5rZXJuZWwub3JnDQo+
ID4gPiA8bGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIEFkcmlh
biBIdW50ZXINCj4gPiA+IFNlbnQ6IDIwMjDlubQy5pyIMTjml6UgMTU6NTgNCj4gPiA+IFRvOiBC
T1VHSCBDSEVOIDxoYWliby5jaGVuQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0K
PiA+ID4gbGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gQ2M6IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+OyBsaW51cy53YWxsZWlqQGxpbmFyby5vcmcNCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgMTIvMTRdIG1tYzogc2RoY2ktZXNkaGMtaW14OiByZXN0b3JlIHBp
bg0KPiA+ID4gc3RhdGUgd2hlbiByZXN1bWUgYmFjaw0KPiA+ID4NCj4gPiA+IE9uIDEwLzAyLzIw
IDEwOjQ5IGFtLCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gPiA+IEZyb206IEhhaWJv
IENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gSW4gc29tZSBsb3cg
cG93ZXIgbW9kZSwgU29DIHdpbGwgbG9zZSB0aGUgcGluIHN0YXRlLCBzbyBuZWVkIHRvDQo+ID4g
PiA+IHJlc3RvcmUgdGhlIHBpbiBzdGF0ZSB3aGVuIHJlc3VtZSBiYWNrLg0KPiA+ID4gPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4g
PiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDEy
ICsrKysrKysrKysrLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiA+ID4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LWVzZGhjLWlteC5jDQo+ID4gPiA+IGluZGV4IDEwNjA5N2NiZDBkNC4uZGVkYzA2N2NkMGRkIDEw
MDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiA+ID4g
QEAgLTE3MTcsNyArMTcxNywxMyBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3N1c3BlbmQoc3Ry
dWN0DQo+ID4gPiA+IGRldmljZQ0KPiA+ID4gKmRldikNCj4gPiA+ID4gIAlpZiAoaG9zdC0+dHVu
aW5nX21vZGUgIT0gU0RIQ0lfVFVOSU5HX01PREVfMykNCj4gPiA+ID4gIAkJbW1jX3JldHVuZV9u
ZWVkZWQoaG9zdC0+bW1jKTsNCj4gPiA+ID4NCj4gPiA+ID4gLQlyZXR1cm4gc2RoY2lfc3VzcGVu
ZF9ob3N0KGhvc3QpOw0KPiA+ID4gPiArCXJldCA9IHNkaGNpX3N1c3BlbmRfaG9zdChob3N0KTsN
Cj4gPiA+ID4gKwlpZiAoIXJldCkNCj4gPiA+ID4gKwkJaWYgKHBpbmN0cmxfcG1fc2VsZWN0X3Ns
ZWVwX3N0YXRlKGRldikpDQo+ID4gPiA+ICsJCQlkZXZfd2FybihtbWNfZGV2KGhvc3QtPm1tYyks
DQo+ID4gPiA+ICsJCQkgIiVzLCBmYWlsZWQgdG8gc2VsZWN0IHNsZWVwIHBpbiBzdGF0ZSFcbiIs
IF9fZnVuY19fKTsNCj4gPiA+DQo+ID4gPiBJdCBsb29rcyB0byBtZSBsaWtlIHBpbmN0cmxfcG1f
c2VsZWN0X3NsZWVwX3N0YXRlKCkgcHJpbnRzIGFuIGVycm9yDQo+ID4gPiBhbnl3YXkgaWYgaXQg
ZmFpbHMsIHNvIHRoZSB3YXJuaW5nIGhlcmUgaXMgcmVkdW5kYW50Lg0KPiA+DQo+ID4gT2theSwg
dGhhbmtzIGZvciBwb2ludCBvdXQgdGhhdCENCj4gPg0KPiA+ID4NCj4gPiA+IEFsc28gYSBjb21t
ZW50IGFib3V0IHdoeSBpdCBpcyBPSyB0byBpZ25vcmUgYW4gZXJyb3IgY291bGQgYmUgYWRkZWQu
DQo+ID4NCj4gPiBZZXMsIEkgd2lsbCBhZGQgYSBjb21tZW50IGxpa2UgYmVsb3csIHNob3VsZCBp
dCBiZSBva2F5Pw0KPiANCj4gSSBtZWFudCB3aHkgaXQgaXMgb2sgdG8gaWdub3JlIHRoZSBwaW5j
dHJsIGVycm9yDQoNCk9rYXksIEkga25vdyB5b3VyIHBvaW50LiANClNvIEkgdGhpbmsgdGhpcyBw
YXRjaCBjYW4gY2hhbmdlIGxpa2UgYmVsb3c6DQoNCmluZGV4IDc4NjMwNTMwOWViMC4uYjM4Yjlk
N2YwYTBkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0K
KysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KQEAgLTE3MzEsNyArMTcz
MSwxMSBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2
KQ0KICAgICAgICBpZiAoaG9zdC0+dHVuaW5nX21vZGUgIT0gU0RIQ0lfVFVOSU5HX01PREVfMykN
CiAgICAgICAgICAgICAgICBtbWNfcmV0dW5lX25lZWRlZChob3N0LT5tbWMpOw0KDQotICAgICAg
IHJldHVybiBzZGhjaV9zdXNwZW5kX2hvc3QoaG9zdCk7DQorICAgICAgIHJldCA9IHNkaGNpX3N1
c3BlbmRfaG9zdChob3N0KTsNCisgICAgICAgaWYgKCFyZXQpDQorICAgICAgICAgICAgICAgcmV0
dXJuIHBpbmN0cmxfcG1fc2VsZWN0X3NsZWVwX3N0YXRlKGRldik7DQorDQorICAgICAgIHJldHVy
biByZXQ7DQogfQ0KDQogc3RhdGljIGludCBzZGhjaV9lc2RoY19yZXN1bWUoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KQEAgLTE3MzksNiArMTc0MywxMCBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3Jl
c3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogICAgICAgIHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQogICAgICAgIGludCByZXQ7DQoNCisgICAgICAgcmV0
ID0gcGluY3RybF9wbV9zZWxlY3RfZGVmYXVsdF9zdGF0ZShkZXYpOw0KKyAgICAgICBpZiAocmV0
KQ0KKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQorDQogICAgICAgIC8qIHJlLWluaXRpYWxp
emUgaHcgc3RhdGUgaW4gY2FzZSBpdCdzIGxvc3QgaW4gbG93IHBvd2VyIG1vZGUgKi8NCiAgICAg
ICAgc2RoY2lfZXNkaGNfaW14X2h3aW5pdChob3N0KTsNCg0KPiANCj4gPg0KPiA+IC8qDQo+ID4g
ICogaGVyZSBpZ25vcmUgdGhlIGVycm9yIHJldHVybiwgYmVjYXVzZSBjdXJyZW50IEFQSQ0KPiA+
IHNkaGNpX3N1c3BlbmRfaG9zdCBhbHdheXMgcmV0dXJuIHplcm8sDQo+ID4gICogV2hlbiB0aGUg
QVBJIHNkaGNpX3N1c3BlbmRfaG9zdCBjaGFuZ2UgdGhlIHJldHVybiBwb2xpY3ksIG5lZWQgdG8N
Cj4gPiBjaGFuZ2UgYXQgaGVyZSB0b28uDQo+ID4gICovDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMN
Cj4gPiBCb3VnaCBjaGVuDQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmV0dXJuIHJldDsN
Cj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfcmVz
dW1lKHN0cnVjdCBkZXZpY2UgKmRldikgQEAgLTE3MjUsNg0KPiA+ID4gPiArMTczMSwxMCBAQCBz
dGF0aWMgaW50IHNkaGNpX2VzZGhjX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiA+
ICAJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiA+
ID4gIAlpbnQgcmV0Ow0KPiA+ID4gPg0KPiA+ID4gPiArCWlmIChwaW5jdHJsX3BtX3NlbGVjdF9k
ZWZhdWx0X3N0YXRlKGRldikpDQo+ID4gPiA+ICsJCWRldl93YXJuKG1tY19kZXYoaG9zdC0+bW1j
KSwNCj4gPiA+ID4gKwkJICIlcywgZmFpbGVkIHRvIHNlbGVjdCBkZWZhdWx0IHBpbiBzdGF0ZSFc
biIsIF9fZnVuY19fKTsNCj4gPiA+DQo+ID4gPiBTYW1lIGFzIGFib3ZlDQo+ID4gPg0KPiA+ID4g
PiArDQo+ID4gPiA+ICAJLyogcmUtaW5pdGlhbGl6ZSBodyBzdGF0ZSBpbiBjYXNlIGl0J3MgbG9z
dCBpbiBsb3cgcG93ZXIgbW9kZSAqLw0KPiA+ID4gPiAgCXNkaGNpX2VzZGhjX2lteF9od2luaXQo
aG9zdCk7DQo+ID4gPiA+DQo+ID4gPiA+DQoNCg==
