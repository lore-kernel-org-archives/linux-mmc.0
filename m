Return-Path: <SRS0=MzOG=D3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C866AC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Oct 2020 02:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF44223BF
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Oct 2020 02:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SAASiFD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390905AbgJTCzn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:55:43 -0400
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:40673
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729210AbgJTCzn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Oct 2020 22:55:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1ZVYdnTHFAI5+R41q/E7ix4MxZTnw2GbaZit6smaMLjoKDQva7KhuzTnWSI2sPiQY5xEB8mQUVlfUUvsW8IP0cB7g7/3K5ssD1JB6qWPjmXPibTKhriWbQ39MczylAO2ySBrrih0wRDW/iYFxSgn0fx665lmm4c9p3H5hMbUPW5hppDN0rrS157McrI4RKOk3s0s2k1ZgqfOyGaWVdgjtHA6Ckl+X6ChPhq+edlNN//Cf0BZjLdr8vLbH4mAwoI3Gcw9tcCxJwHuWJPMVQp7inJXQDR/TLg6PHou/aPCto24iAb7eO4J0QM8jcE+Nwem8G0tjQx3K2U+kt6HRK/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd21KIhxRp+u0NAHmB3TdrPMTOC99OtvDSUFPOcW5Ks=;
 b=AXdlSh2oJhB8xdB92WSXkM2lTHIIPKwheCh3XYPj0Oy2Cl4ivUGsiYt1UWNtetIcwE8rnYUxt0LfPMZ1dEVvvGv4h4O0DoqI2NunweAsoNCjLOQeTdfqoi4TLVAWXzXr2ojtqqrzITtp6t93Np8QtOi0XJbmDXSZX5PAJIcFWU9b9SO51HwpdbwCggB6FS77clc+u/mPWXXFbjB5uVrS++pl2bYhTrE3sxgUEv+j99gLeIOC5lKxL5QcGJxbCvXbVbBHvSYpOmraZT0VyjBCrQBv1eBPVHrWy2Yn4E1yujpaoxGrgUAUve6nnYtHT4+EuEp90F/1EpeVYJalcPkXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd21KIhxRp+u0NAHmB3TdrPMTOC99OtvDSUFPOcW5Ks=;
 b=SAASiFD/Hv8PAVIm4J42PUzLcluxQbda9LVkERlt1/3Q8zzWM6w7IXrv110pA3Rf7UN+KzN+7s2KnNEc+ZlpGBbbOQ1EoL9XcP76XAdqp0Aq2KfOgnAdmYZDYPmkeTp8dRB938/+3L3boBhavhDlF9BPdHHKatXRCLqhv7uwzmY=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB4662.eurprd04.prod.outlook.com (2603:10a6:20b:1b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 20 Oct
 2020 02:55:37 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 02:55:37 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc: sdhci-of-esdhc: make sure delay chain locked for
 HS400
Thread-Topic: [PATCH] mmc: sdhci-of-esdhc: make sure delay chain locked for
 HS400
Thread-Index: AQHWo3WxvkaOGuE2PkGj4gQFVm1qUqmZ8DCAgAXhp9A=
Date:   Tue, 20 Oct 2020 02:55:37 +0000
Message-ID: <AM7PR04MB6885B199937D8905145E98D6F81F0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201016042559.25618-1-yangbo.lu@nxp.com>
 <ce17988b-3d52-948c-e2c0-c61c573b4d98@intel.com>
In-Reply-To: <ce17988b-3d52-948c-e2c0-c61c573b4d98@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c2199c6-9ec0-4944-23d9-08d874a39f2e
x-ms-traffictypediagnostic: AM6PR04MB4662:
x-microsoft-antispam-prvs: <AM6PR04MB46623ACEE30381F3447E2A53F81F0@AM6PR04MB4662.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3pN83wyaAzph04Lz/RkPRj3+Hz8DRNHEvwSQC/awCgFUWCVHDXT5j/tAv2xKiCsbCum7BmnXZOPVuj+cYt5ES2oWP9KZQHnqamx9PjbHavK6e7eJsPUdt5scJwXm+gJhOgVa28C0B2rqCtylqXblF6FJ9HB3upUs86Suwsc3kJR8tpKO1O2fp6QPPuFuP2QemiswDIuDsQwFzFaQPgBSZjrU1y+N2rTsVWhsXKVsTpZ8YZAA6qT3W8kNt1TTxkgZyis+rJ/ptlFuOiTD3mDBzzHw326k2uhQuyCiJ+SDE5FaBgmRsca1y0Zh3XwLcgJy0ewSAkUh+zu3wLc4pzdS8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(53546011)(83380400001)(110136005)(26005)(186003)(66476007)(86362001)(316002)(7696005)(66946007)(64756008)(66446008)(8936002)(66556008)(76116006)(8676002)(2906002)(4326008)(52536014)(6506007)(55016002)(9686003)(33656002)(71200400001)(5660300002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6OEbmm5A+9mX9yvrm0x/FdYUrGtEjn7TwW5y2o8OmMSNSVI80PQxk2ZIEnVngHaj/xoLsgOuyQOc1wahM+vGfeb59zQ50d/eG52sU35urQXT5eRx1M0bULS0RBx8+gJ8ZbFsJkm4fs1QMMTCKnm6CzxSj/d+TzH0qBqEfIcdMWQpKUpBwhqJLQS68qibFYHzjtdOUciN/fUEmcOXJot03mA3zNlVEA9cL5mbZycRYo6amm6ZMpYDle+1QZIjJ269yx2158utV8QpkjGyRIofv9LF4nL5G8hgdT1qzDuBtNsQQTWNVC7uYyfbJK/2mYENTAK0J1GdtCfgNxk+g4wJZJPq6RCnzkWCSGs78mKY+9yfa0xZ2ss9a7zB2x4k8fMizg2IWCLZwa1jc4q9w1wM1mNs/907jCgmCmrmidubOnKTBP90tihjn6EMtNrcPPlLyxkgk4ndrDbA27n8yoc49Cil8ibks/UIjTspYqQqlgYZAjBqSrjaYs6LBT2OurxFkmAkByH9MKuUHQxqu3Z3V1SUcNPtLYizqU5GI2TTJCUCe4EfHSePK7TaUh+dv02xsN4On1w3kGVg/NroAmBkFbr7Zgnp58SGoqMGzhsG1bLDY4t2OlpmdrROcD9nwKT2DYHvfCuJpBtA75wVcLObyQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2199c6-9ec0-4944-23d9-08d874a39f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 02:55:37.0564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQEQfSYbbSpBKtvYhknzCc2OHzTdrxxHgkmG+LU+cJm0pHVzHRS9390PLqjpIlf+SFz5/WRaQkAWrp0TCTdlgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4662
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgQWRyaWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFkcmlh
biBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9i
ZXIgMTYsIDIwMjAgNTowNiBQTQ0KPiBUbzogWS5iLiBMdSA8eWFuZ2JvLmx1QG54cC5jb20+OyBs
aW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25A
bGluYXJvLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW1jOiBzZGhjaS1vZi1lc2RoYzog
bWFrZSBzdXJlIGRlbGF5IGNoYWluIGxvY2tlZCBmb3INCj4gSFM0MDANCj4gDQo+IE9uIDE2LzEw
LzIwIDc6MjUgYW0sIFlhbmdibyBMdSB3cm90ZToNCj4gPiBGb3IgZU1NQyBIUzQwMCBtb2RlIGlu
aXRpYWxpemF0aW9uLCB0aGUgRExMIHJlc2V0IGlzIGEgcmVxdWlyZWQgc3RlcA0KPiA+IGlmIERM
TCBpcyBlbmFibGVkIHRvIHVzZSBwcmV2aW91c2x5LCBsaWtlIGluIGJvb3Rsb2FkZXIuDQo+ID4g
VGhpcyBzdGVwIGhhcyBub3QgYmVlbiBkb2N1bWVudGVkIGluIHJlZmVyZW5jZSBtYW51YWwsIGJ1
dCB0aGUgUk0gd2lsbA0KPiA+IGJlIGZpeGVkIHNvb25lciBvciBsYXRlci4NCj4gPg0KPiA+IFRo
aXMgcGF0Y2ggaXMgdG8gYWRkIHRoZSBzdGVwIG9mIERMTCByZXNldCwgYW5kIG1ha2Ugc3VyZSBk
ZWxheSBjaGFpbg0KPiA+IGxvY2tlZCBmb3IgSFM0MDAuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBZYW5nYm8gTHUgPHlhbmdiby5sdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLWVzZGhjLmggICAgfCAgMiArKw0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLW9mLWVzZGhjLmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy5oDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2Ro
Yy5oDQo+ID4gaW5kZXggYTMwNzk2ZS4uNmRlMDJmMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLWVzZGhjLmgNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LWVzZGhjLmgNCj4gPiBAQCAtNSw2ICs1LDcgQEANCj4gPiAgICogQ29weXJpZ2h0IChjKSAyMDA3
IEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuDQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAw
OSBNb250YVZpc3RhIFNvZnR3YXJlLCBJbmMuDQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAxMCBQ
ZW5ndXRyb25peCBlLksuDQo+ID4gKyAqIENvcHlyaWdodCAyMDIwIE5YUA0KPiA+ICAgKiAgIEF1
dGhvcjogV29sZnJhbSBTYW5nIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+DQo+ID4gICAqLw0KPiA+
DQo+ID4gQEAgLTg4LDYgKzg5LDcgQEANCj4gPiAgLyogRExMIENvbmZpZyAwIFJlZ2lzdGVyICov
DQo+ID4gICNkZWZpbmUgRVNESENfRExMQ0ZHMAkJCTB4MTYwDQo+ID4gICNkZWZpbmUgRVNESENf
RExMX0VOQUJMRQkJMHg4MDAwMDAwMA0KPiA+ICsjZGVmaW5lIEVTREhDX0RMTF9SRVNFVAkJCTB4
NDAwMDAwMDANCj4gPiAgI2RlZmluZSBFU0RIQ19ETExfRlJFUV9TRUwJCTB4MDgwMDAwMDANCj4g
Pg0KPiA+ICAvKiBETEwgQ29uZmlnIDEgUmVnaXN0ZXIgKi8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1vZi1lc2RoYy5jDQo+ID4gaW5kZXggMGI0NWVmZi4uYTM5ZmY4NiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gPiArKysgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gPiBAQCAtNCw2ICs0LDcgQEANCj4gPiAgICoNCj4g
PiAgICogQ29weXJpZ2h0IChjKSAyMDA3LCAyMDEwLCAyMDEyIEZyZWVzY2FsZSBTZW1pY29uZHVj
dG9yLCBJbmMuDQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAwOSBNb250YVZpc3RhIFNvZnR3YXJl
LCBJbmMuDQo+ID4gKyAqIENvcHlyaWdodCAyMDIwIE5YUA0KPiA+ICAgKg0KPiA+ICAgKiBBdXRo
b3JzOiBYaWFvYm8gWGllIDxYLlhpZUBmcmVlc2NhbGUuY29tPg0KPiA+ICAgKgkgICAgQW50b24g
Vm9yb250c292IDxhdm9yb250c292QHJ1Lm12aXN0YS5jb20+DQo+ID4gQEAgLTc0Myw2ICs3NDQs
MjkgQEAgc3RhdGljIHZvaWQgZXNkaGNfb2Zfc2V0X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0DQo+
ICpob3N0LCB1bnNpZ25lZCBpbnQgY2xvY2spDQo+ID4gIAkJaWYgKGhvc3QtPm1tYy0+YWN0dWFs
X2Nsb2NrID09IE1NQ19IUzIwMF9NQVhfRFRSKQ0KPiA+ICAJCQl0ZW1wIHw9IEVTREhDX0RMTF9G
UkVRX1NFTDsNCj4gPiAgCQlzZGhjaV93cml0ZWwoaG9zdCwgdGVtcCwgRVNESENfRExMQ0ZHMCk7
DQo+ID4gKw0KPiA+ICsJCXRlbXAgfD0gRVNESENfRExMX1JFU0VUOw0KPiA+ICsJCXNkaGNpX3dy
aXRlbChob3N0LCB0ZW1wLCBFU0RIQ19ETExDRkcwKTsNCj4gPiArCQl1ZGVsYXkoMSk7DQo+ID4g
KwkJdGVtcCAmPSB+RVNESENfRExMX1JFU0VUOw0KPiA+ICsJCXNkaGNpX3dyaXRlbChob3N0LCB0
ZW1wLCBFU0RIQ19ETExDRkcwKTsNCj4gPiArDQo+ID4gKwkJLyogV2FpdCBtYXggMjAgbXMgKi8N
Cj4gPiArCQl0aW1lb3V0ID0ga3RpbWVfYWRkX21zKGt0aW1lX2dldCgpLCAyMCk7DQo+ID4gKwkJ
d2hpbGUgKDEpIHsNCj4gPiArCQkJYm9vbCB0aW1lZG91dCA9IGt0aW1lX2FmdGVyKGt0aW1lX2dl
dCgpLCB0aW1lb3V0KTsNCj4gPiArDQo+ID4gKwkJCWlmIChzZGhjaV9yZWFkbChob3N0LCBFU0RI
Q19ETExTVEFUMCkgJg0KPiA+ICsJCQkgICAgRVNESENfRExMX1NUU19TTFZfTE9DSykNCj4gPiAr
CQkJCWJyZWFrOw0KPiA+ICsJCQlpZiAodGltZWRvdXQpIHsNCj4gPiArCQkJCXByX2VycigiJXM6
IHRpbWVvdXQgZm9yIGRlbGF5IGNoYWluIGxvY2suXG4iLA0KPiA+ICsJCQkJCW1tY19ob3N0bmFt
ZShob3N0LT5tbWMpKTsNCj4gPiArCQkJCWJyZWFrOw0KPiA+ICsJCQl9DQo+ID4gKwkJCXVzbGVl
cF9yYW5nZSgxMCwgMjApOw0KPiA+ICsJCX0NCj4gDQo+IEl0IGlzIHBvc3NpYmxlIG5vdyB0byBk
byB0aGVzZSBsb29wcyB1c2luZyByZWFkX3BvbGxfdGltZW91dA0KPiBlLmcuIHNvbWV0aGluZyBs
aWtlIHRoaXM6DQo+IA0KPiAJaWYgKHJlYWRfcG9sbF90aW1lb3V0KHNkaGNpX3JlYWRsLCB0ZW1w
LCB0ZW1wICYNCj4gRVNESENfRExMX1NUU19TTFZfTE9DSywNCj4gCQkJICAgICAgMTAsIDIwMDAw
LCBmYWxzZSwgaG9zdCwgRVNESENfRExMU1RBVDApKQ0KPiAJCXByX2VycigiJXM6IHRpbWVvdXQg
Zm9yIGRlbGF5IGNoYWluIGxvY2suXG4iLA0KPiAJCSAgICAgICBtbWNfaG9zdG5hbWUoaG9zdC0+
bW1jKSk7DQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2guDQpJIHNlbnQgb3V0IHYyIGNvbnZlcnRpbmcg
dG8gdXNlIGl0Lg0KDQo+IA0KPiANCj4gDQo+ID4gKw0KPiA+ICAJCXRlbXAgPSBzZGhjaV9yZWFk
bChob3N0LCBFU0RIQ19UQkNUTCk7DQo+ID4gIAkJc2RoY2lfd3JpdGVsKGhvc3QsIHRlbXAgfCBF
U0RIQ19IUzQwMF9XTkRXX0FESlVTVCwNCj4gRVNESENfVEJDVEwpOw0KPiA+DQo+ID4NCg0K
