Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E7AC00523
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 09:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133ED206DA
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 09:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qghB0xft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgAHJh1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:37:27 -0500
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:5351
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbgAHJh1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Jan 2020 04:37:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQer6+c84SaIu4O7/8MVvVApgKqiQuwa7F44Fv3iBvYVRLR8cWwrzvHaXtN5XnauP1EKlXTRHJEaBDTREN1GFsXNMSEtEW/LEZ2tgQfrFFLGkvTjCngLk22LBqnorFFK5Kub7+PVmb2NN6owME1LuKDQebb5rHSPTXIimdZpZ1MZL50uFoSFWCGn2LKa1r5YUE5u24AAfMe53pMMIUGQOd/sagbhx3gPfNMDmdZ1wqi9wxBbTElyYwxRHJts5OKWiaqvHlRa5iMp5VTnC+pawt82329ln90PwmegtNtZ/zQkwS3dzEJOd9kzOJDdKfuT4Kk0O9KisbHKpnmvvZk6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJx1MVaXSaUYsBhmneRBp8SLXdOLaMz6OduYL5sZXEg=;
 b=g90LzoV4d4M1CpkxQFnugg2cul5jMGyZ/b9hCcEwnqSM0ma1I+X3YC81t1AHfZzt8X6k3CRiW9maMTK3CKCprrLy14FvgHWPFSZQHn7NPRY69FdmN3eJRqR34KdNi9JrbuRoiehcIrvQ0OMw5HeLCk46+VPWq8oyzjTQ3p5E9pRUpKU7dm67l/xvD74WBgOJ940lfbrlD0ZLcsecGoQ1VhxgQzzGq3djdAoLkqHhP/wpv/ACoJcmHLzj9kki3i+JzLjtzmGIguocxZGoCNbuXH5GnI7+HTK/OUC9ZOcvE0/rMAKax7k+sUUJo83ZIg2ngsQqfaDYCI3gGwBozWsJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJx1MVaXSaUYsBhmneRBp8SLXdOLaMz6OduYL5sZXEg=;
 b=qghB0xftegqsr88tA6z4QCS18bkkleZu2a+duFWMz9Oye4Sm5PjjsOmJ+nR15cxE1lL9ryJrTX0kadNv2wP6Ap9LzizGdHnlxONyng+CbHar8fPUWOAt822a//vcptnJZguAOQGBujlthqQddSExBeLYLLvdraG3BNwkSeHKDLM=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (10.141.174.88) by
 AM7PR04MB7190.eurprd04.prod.outlook.com (52.135.56.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 09:37:22 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::8a5:3800:3341:c064]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::8a5:3800:3341:c064%7]) with mapi id 15.20.2623.008; Wed, 8 Jan 2020
 09:37:22 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sachin Miglani <sachin.miglani@nxp.com>
Subject: RE: [PATCH] mmc: sdhci: fix up CMD12 sending
Thread-Topic: [PATCH] mmc: sdhci: fix up CMD12 sending
Thread-Index: AQHVmt010K5vWAAIEUqaLh2zVaVaTaezSTGAgC2GowA=
Date:   Wed, 8 Jan 2020 09:37:22 +0000
Message-ID: <AM7PR04MB68856B9D41A5867AB39D37F2F83E0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20191114111814.35199-1-yangbo.lu@nxp.com>
 <CAPDyKFqfMzv1hFzPzS7w5BVHyXybu--7p11wHYa8WTQAVB7r4g@mail.gmail.com>
In-Reply-To: <CAPDyKFqfMzv1hFzPzS7w5BVHyXybu--7p11wHYa8WTQAVB7r4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a6ade84-18bf-4036-2fe5-08d7941e5cf9
x-ms-traffictypediagnostic: AM7PR04MB7190:|AM7PR04MB7190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB71904AC7A5C6A76A3D2C9D55F83E0@AM7PR04MB7190.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(13464003)(199004)(189003)(2906002)(316002)(55016002)(8676002)(9686003)(33656002)(81156014)(81166006)(8936002)(110136005)(54906003)(71200400001)(76116006)(478600001)(66556008)(66446008)(64756008)(7696005)(66476007)(86362001)(26005)(52536014)(5660300002)(186003)(4326008)(66946007)(53546011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB7190;H:AM7PR04MB6885.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3oQfIHtZNZMSeoGhtAWyPXADwLpbkD1Fkyp+92T9JadlXrB3tBnf7G1kOOCHlbZjgizlKF64UfVJgl6ee8Wfxs3Zh0ivcyukOFvxF3U49hq9sgdV1L0BmlaH2CLCMR5CMXml9rNjvc2JyVhjCxFoxePpvOhs+PO6H0tl5qmuwhLzytqFjflO2Ysvnkua5D7V0xbcffktkizvzAdzr624kYHhk53i1mMwqkvRcVOjy3vm/Qy9Ssq08mzHWjoDU5OSO0MsKKB/cx9FXxPkj6e2sbgmv9bQC8Rv1jFdlR5GczoHkYqRYWHWz3dwckz1NZeWP73J+R/ooV0axqN4X4XqUnqWWbjIbtoXnoYMBuqylIp9ZwEeSKQ2JgUEd5+91LzVhBFRUDdIK4DTyvWvtYQGY2nCe0YeXBQ0N3jTK/srs8Cx+K9zpJNnDmcQ5kSDnQTCzhnRAPfKXPYzl1BQ3i6oX7xHeg7/TvoDPqhwaHfQQTU6zZBsRMCCycgy/lxmcQ1m
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6ade84-18bf-4036-2fe5-08d7941e5cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 09:37:22.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbVoilPCjKzUn/Rvqv/PXmhL72w/hLRkYhuwqR10BO52Wz/kZBDFzG7vUu+HwzvAJCSwrA5zUxbcmLyhLnhcyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7190
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWZmZSBhbmQgQWRyaWFuLA0KDQpCYWNrIGFnYWluIG9uIHRoaXMgdG9waWMuIEFjdHVhbGx5
IHdlIGFyZSB0cnlpbmcgdG8gbWFrZSB0aGUgZXJyb3IgcmVjb3Zlcnkgd29yayBhZnRlciBkYXRh
IGVycm9yIG9mIENNRDE4IGluIGxpbnV4LTQuMTQuDQpXaXRoIHRoaXMgcGF0Y2gsIHdoZW4gQ01E
MTggZGF0YSBlcnJvciBnb3QsIG1hbnVhbCBDTUQxMiB3b3VsZCBiZSBzZW50LiBBbmQgdGhlbiB3
ZW50IGludG8gbW1jX2Jsa19jbWRfcmVjb3ZlcnkoKS4gKFNob3VsZCBiZSBtbWNfYmxrX21xX3J3
X3JlY292ZXJ5KCkgaW4gbGF0ZXN0IGxpbnV4LTUuNS1yYzIuKQ0KSW4gbW1jX2Jsa19jbWRfcmVj
b3ZlcnkoKSwgcmUtdHVuaW5nIHdvdWxkIGZhaWwgYmVmb3JlIHNlbmRpbmcgQ01EMTMgb24gb3Vy
IHNwZWNpZmljIGJvYXJkLg0KVGhpcyBtYXkgYmUgc29tZSBpc3N1ZSByZWxhdGVkIHRvIHNwZWNp
ZmljIGVNTUMgY2FyZCB3ZSBhcmUgaW52ZXN0aWdhdGluZy4NCg0KVGhlIGFib3ZlIGlzIGp1c3Qg
YmFja2dyb3VuZCBpbnRyb2R1Y3Rpb24sIGFuZCB5b3UgbWF5IG5vdCBjYXJlIGFib3V0IHRoYXQ6
KQ0KSSdkIGxpa2UgdG8gaGF2ZSBzb21lIHF1ZXJpZXMgb24gQ01EMTIgdXNhZ2UgaW4gTU1DIGRy
aXZlci4NCjEuIEl0IHNlZW1zIENNRDEyIGlzIGFsd2F5cyBub3QgdXNpbmcgQUJPUlQgdHlwZSBm
b3Igc2VuZGluZyBpbiBzZGhjaS5jLiBUaGUgU0RIQ0lfQ01EX0FCT1JUQ01EIGhhc24ndCBiZWVu
IHVzZWQuIElzIHRoaXMgaXNzdWU/DQoyLiBJbiBibG9jay5jLCBDTUQxMiB1c2VzIFIxIHJlc3Bv
bnNlIGZvciBkYXRhIHJlYWRpbmcgYW5kIFIxQiByZXNwb25zZSBmb3Igd3JpdGluZy4gSXMgaXQg
b2sgdG8gdXNlIFIxIHJlc3BvbnNlIGZvciBTRD8gVGhlIFNEIHNwZWMgbWVudGlvbnMgb25seSBS
MUIgcmVzcG9uc2UgZm9yIENNRDEyLg0KDQpBcHByZWNpYXRlIHlvdXIgaGVscHMuDQpUaGFua3Mu
DQoNCkJlc3QgcmVnYXJkcywNCllhbmdibyBMdQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50
OiBUdWVzZGF5LCBEZWNlbWJlciAxMCwgMjAxOSA1OjUyIFBNDQo+IFRvOiBZLmIuIEx1IDx5YW5n
Ym8ubHVAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IEFkcmlhbiBI
dW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBt
bWM6IHNkaGNpOiBmaXggdXAgQ01EMTIgc2VuZGluZw0KPiANCj4gT24gVGh1LCAxNCBOb3YgMjAx
OSBhdCAxMjoxOCwgWWFuZ2JvIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBUaGUgU1RPUCBjb21tYW5kIGlzIGRpc2FibGVkIGZvciBtdWx0aXBsZSBibG9ja3Mgci93IGNv
bW1hbmRzDQo+ID4gd2l0aCBhdXRvIENNRDEyLCB3aGVuIHN0YXJ0IHRvIHNlbmQuIEhvd2V2ZXIs
IGlmIHRoZXJlIGlzIGRhdGENCj4gPiBlcnJvciwgc29mdHdhcmUgc3RpbGwgbmVlZHMgdG8gc2Vu
ZCBDTUQxMiBhY2NvcmRpbmcgdG8gU0Qgc3BlYy4NCj4gPiBUaGlzIHBhdGNoIGlzIHRvIGFsbG93
IHNvZnR3YXJlIENNRDEyIHNlbmRpbmcgZm9yIHRoaXMgY2FzZS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFlhbmdibyBMdSA8eWFuZ2JvLmx1QG54cC5jb20+DQo+IA0KPiBBcHBsaWVkIGZvciBu
ZXh0LCB0aGFua3MhDQo+IA0KPiBMZXQncyBzZWUgaG93IHRoaW5ncyBnbywgdGhlbiB3ZSBjYW4g
ZGVjaWRlIHdoZXRoZXIgdG8gYWRkIHN0YWJsZSB0YWcgYXMgd2VsbC4NCj4gDQo+IEtpbmQgcmVn
YXJkcw0KPiBVZmZlDQo+IA0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS5jIHwgMTcgKysrLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jDQo+ID4gaW5kZXggMDlj
ZGJlOC4uMzA0MWMzOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMN
Cj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMNCj4gPiBAQCAtMTMyNiwxMiArMTMy
NiwxMiBAQCBzdGF0aWMgdm9pZCBzZGhjaV9maW5pc2hfZGF0YShzdHJ1Y3Qgc2RoY2lfaG9zdA0K
PiAqaG9zdCkNCj4gPg0KPiA+ICAgICAgICAgLyoNCj4gPiAgICAgICAgICAqIE5lZWQgdG8gc2Vu
ZCBDTUQxMiBpZiAtDQo+ID4gLSAgICAgICAgKiBhKSBvcGVuLWVuZGVkIG11bHRpYmxvY2sgdHJh
bnNmZXIgKG5vIENNRDIzKQ0KPiA+ICsgICAgICAgICogYSkgb3Blbi1lbmRlZCBtdWx0aWJsb2Nr
IHRyYW5zZmVyIG5vdCB1c2luZyBhdXRvIENNRDEyIChubw0KPiBDTUQyMykNCj4gPiAgICAgICAg
ICAqIGIpIGVycm9yIGluIG11bHRpYmxvY2sgdHJhbnNmZXINCj4gPiAgICAgICAgICAqLw0KPiA+
ICAgICAgICAgaWYgKGRhdGEtPnN0b3AgJiYNCj4gPiAtICAgICAgICAgICAoZGF0YS0+ZXJyb3Ig
fHwNCj4gPiAtICAgICAgICAgICAgIWRhdGEtPm1ycS0+c2JjKSkgew0KPiA+ICsgICAgICAgICAg
ICgoIWRhdGEtPm1ycS0+c2JjICYmICFzZGhjaV9hdXRvX2NtZDEyKGhvc3QsIGRhdGEtPm1ycSkp
IHx8DQo+ID4gKyAgICAgICAgICAgIGRhdGEtPmVycm9yKSkgew0KPiA+ICAgICAgICAgICAgICAg
ICAvKg0KPiA+ICAgICAgICAgICAgICAgICAgKiAnY2FwX2NtZF9kdXJpbmdfdGZyJyByZXF1ZXN0
IG11c3Qgbm90IHVzZSB0aGUNCj4gY29tbWFuZCBsaW5lDQo+ID4gICAgICAgICAgICAgICAgICAq
IGFmdGVyIG1tY19jb21tYW5kX2RvbmUoKSBoYXMgYmVlbiBjYWxsZWQuIEl0IGlzDQo+IHVwcGVy
IGxheWVyJ3MNCj4gPiBAQCAtMTgyNSwxNyArMTgyNSw2IEBAIHZvaWQgc2RoY2lfcmVxdWVzdChz
dHJ1Y3QgbW1jX2hvc3QgKm1tYywNCj4gc3RydWN0IG1tY19yZXF1ZXN0ICptcnEpDQo+ID4NCj4g
PiAgICAgICAgIHNkaGNpX2xlZF9hY3RpdmF0ZShob3N0KTsNCj4gPg0KPiA+IC0gICAgICAgLyoN
Cj4gPiAtICAgICAgICAqIEVuc3VyZSB3ZSBkb24ndCBzZW5kIHRoZSBTVE9QIGZvciBub24tU0VU
X0JMT0NLX0NPVU5URUQNCj4gPiAtICAgICAgICAqIHJlcXVlc3RzIGlmIEF1dG8tQ01EMTIgaXMg
ZW5hYmxlZC4NCj4gPiAtICAgICAgICAqLw0KPiA+IC0gICAgICAgaWYgKHNkaGNpX2F1dG9fY21k
MTIoaG9zdCwgbXJxKSkgew0KPiA+IC0gICAgICAgICAgICAgICBpZiAobXJxLT5zdG9wKSB7DQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgbXJxLT5kYXRhLT5zdG9wID0gTlVMTDsNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICBtcnEtPnN0b3AgPSBOVUxMOw0KPiA+IC0gICAgICAgICAg
ICAgICB9DQo+ID4gLSAgICAgICB9DQo+ID4gLQ0KPiA+ICAgICAgICAgaWYgKCFwcmVzZW50IHx8
IGhvc3QtPmZsYWdzICYgU0RIQ0lfREVWSUNFX0RFQUQpIHsNCj4gPiAgICAgICAgICAgICAgICAg
bXJxLT5jbWQtPmVycm9yID0gLUVOT01FRElVTTsNCj4gPiAgICAgICAgICAgICAgICAgc2RoY2lf
ZmluaXNoX21ycShob3N0LCBtcnEpOw0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0K
