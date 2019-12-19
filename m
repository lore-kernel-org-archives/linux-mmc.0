Return-Path: <SRS0=Rhqe=2J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6051C43603
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 03:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7822068F
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 03:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i+Qo20zN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLSD1C (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:27:02 -0500
Received: from mail-eopbgr140082.outbound.protection.outlook.com ([40.107.14.82]:30702
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbfLSD1C (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Dec 2019 22:27:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGYlj+RvJ5j12lA/VbCsLS7z5N6IjQzEnlnOiSKYCfW2nvPi7Elzc3WaNaXpsaGdkKnM5c4zubt1uLI6AHZp0MoHjJe1HZB5pCljK9lH+4nalxS6M+tg+KPjenhUIylDknPwJewHrR+qutp3n5U0mgr2IDmRmPkEQr20/8rwEzkMqNytuwf0afmPurhwMFytyae2hiu3tE6st1R3jSwsOPHFo/HF5dapZ+W9NjloqEYweNCufsPGe3RRXMRp3G/CmoprBv1hAmF18JWBLBk2YoMjgNd5Gkva4Ttx1MAMxGjrfkhMdqeJPRd4EHSmjRUfZYrv24Iearxs26GCXxD1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9v6bMVXqvcA3e03PuoviPRYfPbzt/XjABiUIwEXYj8=;
 b=MBoyhC0hb7Jo4qpHaKCfcO9LhnOviZ32CLk2OUUKqa+XIC9yKeKX/tkpdh3F9cMafMELeCvQrpTIizbkmP2QXpWX4c7x/U74uhGb0Ug4e8k0GSCb5XCfsWYmJ8steEERsmVgg0TifZmF8I7MTcrA1SLcCLEHXEwIDFDAnAIGGXeYTFz73aRqtjCoWDMA3+3OiFyLIltYxjPZYEeTHw5FMn+sWuF5ccVqHC0OTKoQRbVdmZEx/4+d6p8xi1IVV/33UVZsxI9QGw8/XZObODqjVnhUyO/BbGwpo6aBnL3uF7bpzLV7+99y93GMruB4kOzMS+Dp7OBTAejVIL0shF503g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9v6bMVXqvcA3e03PuoviPRYfPbzt/XjABiUIwEXYj8=;
 b=i+Qo20zNAnoIHjppjkyGsa7hvmNum2DDga9Oj42shV0wv2uCnEvMkNdzTvwIxX3xIVEbAlQtLPDDvUhRDipLrfevXnq9i2pZFMg6Saee1kZc37nuPCioaIWh7WZGB+U6IOCvHtgphVFGF/f3cEw3iq6YvIM5VL/uralox02AbeY=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2301.eurprd04.prod.outlook.com (10.169.136.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 03:26:57 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::b9ca:8e9c:39e6:8d5f]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::b9ca:8e9c:39e6:8d5f%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 03:26:56 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: RE: [PATCH] mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add
 erratum A-009204 support"
Thread-Topic: [PATCH] mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add
 erratum A-009204 support"
Thread-Index: AQHVqoCABaJ1BuI1sE61NsTvop9txKezKcoAgAzSbQCAAOaWUA==
Date:   Thu, 19 Dec 2019 03:26:56 +0000
Message-ID: <VI1PR0401MB223731C93D143EB8EAA45724F8520@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20191204085447.27491-1-linux@rasmusvillemoes.dk>
 <CAPDyKFqyU1nyVUsuAPC8ZDCm88JOq45aywDM7AqR9vfr0k90jw@mail.gmail.com>
 <CAPDyKFq4fGTek1Y0rgbdrBsvVjUFAVPh=7VLrb-yDFZOh6RuSw@mail.gmail.com>
In-Reply-To: <CAPDyKFq4fGTek1Y0rgbdrBsvVjUFAVPh=7VLrb-yDFZOh6RuSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9fcbb84-4305-47dc-e73a-08d784334d19
x-ms-traffictypediagnostic: VI1PR0401MB2301:|VI1PR0401MB2301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2301B788274116EA757DE542F8520@VI1PR0401MB2301.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(199004)(189003)(13464003)(54906003)(33656002)(2906002)(9686003)(55016002)(316002)(86362001)(7696005)(52536014)(64756008)(66446008)(66556008)(66476007)(71200400001)(6916009)(186003)(5660300002)(81166006)(8936002)(4326008)(66946007)(26005)(8676002)(76116006)(81156014)(6506007)(53546011)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2301;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9QpkGH+YUBq3dg+bH4VmS40HRCREFPXHM0KYoIvEjpQC1Bg4H5qppszMAbKWLkj4khO+/luwY0b76nDvjmI7MmDlFb03kvM3msxeajs4Ae3Nlz9FXFXVkJwMNGfKqr+n94YxpayekXohmoMYuYMToGv2tzHaykVVDmqgVh9CoodCOXXmiwLUPRX23ItInKb/BCMplBgt0DFrYD9ynBoL/aHb49QyQhqYAcTNfxqfrnnJcdImS/tNxW1ILP0nxIncRSVJftjOzo3ht6rzTTvHl6zwUK3Pxpp6i/nycZrouhGcgTF6oLWiRuYuHt8X3L+QKzWf4WT6x3E1bbKPkBy7KDZd0NAVrN4xHSW8Lz5Nl0FNo0h26LUYy8sWuQR+1L1boPB4tGnFVOEODvQjb58zLHUTsXoNXL2EoRCxAZRK7+RWygNHRd8sP5tZTQ/LqQ6x7PcESZ1+rHxQfZMPRzdPp8aRnaqjiCIOw/qdpuz6oIyUTljBS+y4qzcN1XD3dAa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fcbb84-4305-47dc-e73a-08d784334d19
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 03:26:56.7416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+osb6THAlT1wPonW29vA6KDgPmGD/gMeDJiHnoHocLMZWXjxQ90pfVOJWMQJ/03ZToIPuvCXyojQWdVTYTuLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2301
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1tbWMtb3duZXJAdmdl
ci5rZXJuZWwub3JnIDxsaW51eC1tbWMtb3duZXJAdmdlci5rZXJuZWwub3JnPg0KPiBPbiBCZWhh
bGYgT2YgVWxmIEhhbnNzb24NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxOCwgMjAxOSA5
OjQwIFBNDQo+IFRvOiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPjsgWS5iLiBMdSA8eWFu
Z2JvLmx1QG54cC5jb20+DQo+IENjOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVs
LmNvbT47IFJhc211cyBWaWxsZW1vZXMNCj4gPGxpbnV4QHJhc211c3ZpbGxlbW9lcy5kaz47IGxp
bnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IExpbnV4IEtlcm5lbA0KPiBNYWlsaW5nIExpc3QgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzog
c2RoY2ktb2YtZXNkaGM6IFJldmVydCAibW1jOiBzZGhjaS1vZi1lc2RoYzogYWRkDQo+IGVycmF0
dW0gQS0wMDkyMDQgc3VwcG9ydCINCj4gDQo+IFlpbmJvLCBZYW5nYm8NCj4gDQo+IE9uIFR1ZSwg
MTAgRGVjIDIwMTkgYXQgMTA6NTEsIFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
PiB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgNCBEZWMgMjAxOSBhdCAwOTo1NCwgUmFzbXVzIFZp
bGxlbW9lcw0KPiA8bGludXhAcmFzbXVzdmlsbGVtb2VzLmRrPiB3cm90ZToNCj4gPiA+DQo+ID4g
PiBUaGlzIHJldmVydHMgY29tbWl0IDVkZDE5NTUyMjU2MjU0MmJjNmViZTZlN2JkNDc4OTBkOGI3
Y2E5M2MuDQo+ID4gPg0KPiA+ID4gRmlyc3QsIHRoZSBmaXggc2VlbXMgdG8gYmUgcGxhaW4gd3Jv
bmcsIHNpbmNlIHRoZSBlcnJhdHVtIHN1Z2dlc3RzDQo+ID4gPiB3YWl0aW5nIDVtcyBiZWZvcmUg
c2V0dGluZyBzZXR0aW5nIFNZU0NUTFtSU1REXSwgYnV0IHRoaXMgbXNsZWVwKCkNCj4gPiA+IGhh
cHBlbnMgYWZ0ZXIgdGhlIGNhbGwgb2Ygc2RoY2lfcmVzZXQoKSB3aGljaCBpcyB3aGVyZSB0aGF0
IGJpdCBnZXRzDQo+ID4gPiBzZXQgKGlmIFNESENJX1JFU0VUX0RBVEEgaXMgaW4gbWFzaykuDQo+
ID4gPg0KPiA+ID4gU2Vjb25kLCB3YWxraW5nIHRoZSB3aG9sZSBkZXZpY2UgdHJlZSB0byBmaWd1
cmUgb3V0IGlmIHNvbWUgbm9kZSBoYXMgYQ0KPiA+ID4gImZzbCxwMjAyMC1lc2RoYyIgY29tcGF0
aWJsZSBzdHJpbmcgaXMgaHVnZWx5IGV4cGVuc2l2ZSAtIGFib3V0IDcwIHRvDQo+ID4gPiAxMDAg
dXMgb24gb3VyIG1wYzgzMDkgYm9hcmQuIFdhbGtpbmcgdGhlIGRldmljZSB0cmVlIGlzIGRvbmUg
dW5kZXIgYQ0KPiA+ID4gcmF3X3NwaW5fbG9jaywgc28gdGhpcyBpcyBvYnZpb3VzbHkgcmVhbGx5
IGJhZCBvbiBhbiAtcnQgc3lzdGVtLCBhbmQgYQ0KPiA+ID4gd2FzdGUgb2YgdGltZSBvbiBhbGwu
DQo+ID4gPg0KPiA+ID4gSW4gZmFjdCwgc2luY2UgZXNkaGNfcmVzZXQoKSBzZWVtcyB0byBnZXQg
Y2FsbGVkIGFyb3VuZCAxMDAgdGltZXMgcGVyDQo+ID4gPiBzZWNvbmQsIHRoYXQgbXBjODMwOSBu
b3cgc3BlbmRzIDAuOCUgb2YgaXRzIHRpbWUgZGV0ZXJtaW5pbmcgdGhhdA0KPiA+ID4gaXQgaXMg
bm90IGEgcDIwMjAuIFdoZXRoZXIgdGhvc2UgMTAwIGNhbGxzL3MgYXJlIG5vcm1hbCBvciBkdWUg
dG8gc29tZQ0KPiA+ID4gb3RoZXIgYnVnIG9yIG1pc2NvbmZpZ3VyYXRpb24sIHJlZ3VsYXJseSBo
aXR0aW5nIGEgMTAwIHVzDQo+ID4gPiBub24tcHJlZW1wdGlibGUgd2luZG93IGlzIHVuYWNjZXB0
YWJsZS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSYXNtdXMgVmlsbGVtb2VzIDxsaW51
eEByYXNtdXN2aWxsZW1vZXMuZGs+DQo+ID4NCj4gPiBBcHBsaWVkIGZvciBmaXhlcyBhbmQgYnkg
YWRkaW5nIGEgc3RhYmxlIHRhZywgdGhhbmtzIQ0KPiANCj4gSnVzdCB3YW50ZWQgdG8gaGlnaGxp
Z2h0LCB0aGF0ICRzdWJqZWN0IHBhdGNoIGhhcyBiZWVuIGFwcGxpZWQgZm9yDQo+IGZpeGVzLCB3
aGljaCBtZWFucyB3ZSBuZWVkIGEgbmV3IGZpeCB0aGUgZXJyYXRhIEEtMDA5MjA0Lg0KPiANCj4g
UmFzbXVzIGtpbmQgb2YgYWxyZWFkeSBoaW50ZWQgb24gaG93IHRoaXMgY291bGQgYmUgZml4ZWQg
aW4gYSBiZXR0ZXINCj4gd2F5LCBob3BlIHRoaXMgaGVscHMuDQo+IA0KDQpTb3JyeSBVZmZlLCBJ
IG1pc3NlZCB0aGUgcGF0Y2ggc2luY2UgbXkgbmFtZSB3YXNuJ3QgaW4gVE8vQ0MgbGlzdC4NCkkg
aGF2ZSBzZW50IG91dCBhIHBhdGNoIGZvciByZS1pbXBsZW1lbnRhdGlvbi4NCg0KVGhhbmtzIQ0K
DQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo+IA0KPiA+ID4gLS0tDQo+ID4gPg0KPiA+ID4gVGhl
IGVycmF0YSBzaGVldCBmb3IgbXBjODMwOSBhbHNvIG1lbnRpb25zIEEtMDA5MjA0LCBzbyBJJ20g
bm90IGF0IGFsbA0KPiA+ID4gb3Bwb3NlZCB0byBoYXZpbmcgYSBmaXggZm9yIHRoYXQuIEJ1dCBp
dCBuZWVkcyB0byBiZSBkb25lIHByb3Blcmx5DQo+ID4gPiB3aXRob3V0IGNhdXNpbmcgYSBodWdl
IHBlcmZvcm1hbmNlIG9yIGxhdGVuY3kgaW1wYWN0LiBXZSBzaG91bGQNCj4gPiA+IHByb2JhYmx5
IGp1c3QgYWRkIGEgYml0IHRvIHN0cnVjdCBzZGhjaV9lc2RoYyB3aGljaCBnZXRzIGluaXRpYWxp
emVkDQo+ID4gPiBpbiBlc2RoY19pbml0Lg0KPiA+ID4NCj4gPiA+ICBkcml2ZXJzL21tYy9ob3N0
L3NkaGNpLW9mLWVzZGhjLmMgfCAzIC0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0
aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LW9mLWVzZGhjLmMNCj4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gPiA+
IGluZGV4IDVjY2EzZmE0NjEwYi4uN2Y4N2E5MGJmNTZhIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+ID4gPiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gPiA+IEBAIC03NjQsOSArNzY0LDYgQEAgc3RhdGljIHZv
aWQgZXNkaGNfcmVzZXQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHU4DQo+IG1hc2spDQo+ID4g
PiAgICAgICAgIHNkaGNpX3dyaXRlbChob3N0LCBob3N0LT5pZXIsIFNESENJX0lOVF9FTkFCTEUp
Ow0KPiA+ID4gICAgICAgICBzZGhjaV93cml0ZWwoaG9zdCwgaG9zdC0+aWVyLCBTREhDSV9TSUdO
QUxfRU5BQkxFKTsNCj4gPiA+DQo+ID4gPiAtICAgICAgIGlmIChvZl9maW5kX2NvbXBhdGlibGVf
bm9kZShOVUxMLCBOVUxMLCAiZnNsLHAyMDIwLWVzZGhjIikpDQo+ID4gPiAtICAgICAgICAgICAg
ICAgbWRlbGF5KDUpOw0KPiA+ID4gLQ0KPiA+ID4gICAgICAgICBpZiAobWFzayAmIFNESENJX1JF
U0VUX0FMTCkgew0KPiA+ID4gICAgICAgICAgICAgICAgIHZhbCA9IHNkaGNpX3JlYWRsKGhvc3Qs
IEVTREhDX1RCQ1RMKTsNCj4gPiA+ICAgICAgICAgICAgICAgICB2YWwgJj0gfkVTREhDX1RCX0VO
Ow0KPiA+ID4gLS0NCj4gPiA+IDIuMjMuMA0KPiA+ID4NCg==
