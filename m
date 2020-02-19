Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B97C34022
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 07:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778352176D
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 07:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSH3O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:29:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:62128 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgBSH3N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 02:29:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 23:29:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,459,1574150400"; 
   d="scan'208";a="434385239"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by fmsmga005.fm.intel.com with ESMTP; 18 Feb 2020 23:29:10 -0800
Received: from irsmsx156.ger.corp.intel.com (10.108.20.68) by
 irsmsx110.ger.corp.intel.com (163.33.3.25) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Feb 2020 07:29:09 +0000
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.31]) by
 IRSMSX156.ger.corp.intel.com ([169.254.3.182]) with mapi id 14.03.0439.000;
 Wed, 19 Feb 2020 07:29:09 +0000
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     BOUGH CHEN <haibo.chen@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: RE: [PATCH v3 12/14] mmc: sdhci-esdhc-imx: restore pin state when
 resume back
Thread-Topic: [PATCH v3 12/14] mmc: sdhci-esdhc-imx: restore pin state when
 resume back
Thread-Index: AQHV3+/doVr5y1XJH0a17B+i6ByogaggooYAgAGGmwCAAANTcA==
Date:   Wed, 19 Feb 2020 07:29:08 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C6FFB24@IRSMSX106.ger.corp.intel.com>
References: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
 <1581324597-31031-7-git-send-email-haibo.chen@nxp.com>
 <df1c1a87-24d4-008f-a9ee-3998bf75d5b6@intel.com>
 <VI1PR04MB50404888BEF9C4A2E19D9D4C90100@VI1PR04MB5040.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB50404888BEF9C4A2E19D9D4C90100@VI1PR04MB5040.eurprd04.prod.outlook.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjk0M2M5NmQtYTc1MS00MTIxLWE0MTMtNjYyNTY5MGE2NGI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiT0FGNWxLMnRYbnhUdlpSeTlkaENiclVvYzNQWFFJdHdVaFhGTG9qSmxaMUNJamdUMVZWXC9vTUtXZEZKdmswckcifQ==
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQk9VR0ggQ0hFTiA8aGFp
Ym8uY2hlbkBueHAuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDE5LCAyMDIwIDk6
MTYgQU0NCj4gVG86IEh1bnRlciwgQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc7DQo+IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51cy53YWxsZWlqQGxpbmFyby5v
cmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MyAxMi8xNF0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6
IHJlc3RvcmUgcGluIHN0YXRlIHdoZW4NCj4gcmVzdW1lIGJhY2sNCj4gDQo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBsaW51eC1tbWMtb3duZXJAdmdlci5rZXJuZWwu
b3JnDQo+ID4gPGxpbnV4LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBB
ZHJpYW4gSHVudGVyDQo+ID4gU2VudDogMjAyMOW5tDLmnIgxOOaXpSAxNTo1OA0KPiA+IFRvOiBC
T1VHSCBDSEVOIDxoYWliby5jaGVuQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0K
PiA+IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT47IGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZw0KPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMTIvMTRdIG1tYzogc2RoY2ktZXNkaGMtaW14OiByZXN0b3JlIHBpbiBzdGF0
ZQ0KPiA+IHdoZW4gcmVzdW1lIGJhY2sNCj4gPg0KPiA+IE9uIDEwLzAyLzIwIDEwOjQ5IGFtLCBo
YWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gPiBGcm9tOiBIYWlibyBDaGVuIDxoYWliby5j
aGVuQG54cC5jb20+DQo+ID4gPg0KPiA+ID4gSW4gc29tZSBsb3cgcG93ZXIgbW9kZSwgU29DIHdp
bGwgbG9zZSB0aGUgcGluIHN0YXRlLCBzbyBuZWVkIHRvDQo+ID4gPiByZXN0b3JlIHRoZSBwaW4g
c3RhdGUgd2hlbiByZXN1bWUgYmFjay4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYWli
byBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgMTIgKysrKysrKysrKystDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+ID4gYi9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gPiBpbmRleCAxMDYwOTdjYmQw
ZDQuLmRlZGMwNjdjZDBkZCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktZXNkaGMtaW14LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMt
aW14LmMNCj4gPiA+IEBAIC0xNzE3LDcgKzE3MTcsMTMgQEAgc3RhdGljIGludCBzZGhjaV9lc2Ro
Y19zdXNwZW5kKHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2KQ0KPiA+ID4gIAlpZiAoaG9zdC0+dHVu
aW5nX21vZGUgIT0gU0RIQ0lfVFVOSU5HX01PREVfMykNCj4gPiA+ICAJCW1tY19yZXR1bmVfbmVl
ZGVkKGhvc3QtPm1tYyk7DQo+ID4gPg0KPiA+ID4gLQlyZXR1cm4gc2RoY2lfc3VzcGVuZF9ob3N0
KGhvc3QpOw0KPiA+ID4gKwlyZXQgPSBzZGhjaV9zdXNwZW5kX2hvc3QoaG9zdCk7DQo+ID4gPiAr
CWlmICghcmV0KQ0KPiA+ID4gKwkJaWYgKHBpbmN0cmxfcG1fc2VsZWN0X3NsZWVwX3N0YXRlKGRl
dikpDQo+ID4gPiArCQkJZGV2X3dhcm4obW1jX2Rldihob3N0LT5tbWMpLA0KPiA+ID4gKwkJCSAi
JXMsIGZhaWxlZCB0byBzZWxlY3Qgc2xlZXAgcGluIHN0YXRlIVxuIiwgX19mdW5jX18pOw0KPiA+
DQo+ID4gSXQgbG9va3MgdG8gbWUgbGlrZSBwaW5jdHJsX3BtX3NlbGVjdF9zbGVlcF9zdGF0ZSgp
IHByaW50cyBhbiBlcnJvcg0KPiA+IGFueXdheSBpZiBpdCBmYWlscywgc28gdGhlIHdhcm5pbmcg
aGVyZSBpcyByZWR1bmRhbnQuDQo+IA0KPiBPa2F5LCB0aGFua3MgZm9yIHBvaW50IG91dCB0aGF0
IQ0KPiANCj4gPg0KPiA+IEFsc28gYSBjb21tZW50IGFib3V0IHdoeSBpdCBpcyBPSyB0byBpZ25v
cmUgYW4gZXJyb3IgY291bGQgYmUgYWRkZWQuDQo+IA0KPiBZZXMsIEkgd2lsbCBhZGQgYSBjb21t
ZW50IGxpa2UgYmVsb3csIHNob3VsZCBpdCBiZSBva2F5Pw0KDQpJIG1lYW50IHdoeSBpdCBpcyBv
ayB0byBpZ25vcmUgdGhlIHBpbmN0cmwgZXJyb3INCg0KPiANCj4gLyoNCj4gICogaGVyZSBpZ25v
cmUgdGhlIGVycm9yIHJldHVybiwgYmVjYXVzZSBjdXJyZW50IEFQSSBzZGhjaV9zdXNwZW5kX2hv
c3QNCj4gYWx3YXlzIHJldHVybiB6ZXJvLA0KPiAgKiBXaGVuIHRoZSBBUEkgc2RoY2lfc3VzcGVu
ZF9ob3N0IGNoYW5nZSB0aGUgcmV0dXJuIHBvbGljeSwgbmVlZCB0bw0KPiBjaGFuZ2UgYXQgaGVy
ZSB0b28uDQo+ICAqLw0KPiANCj4gQmVzdCBSZWdhcmRzDQo+IEJvdWdoIGNoZW4NCj4gPg0KPiA+
ID4gKw0KPiA+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAgc3RhdGlj
IGludCBzZGhjaV9lc2RoY19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KSBAQCAtMTcyNSw2DQo+
ID4gPiArMTczMSwxMCBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3Jlc3VtZShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ID4gPiAgCXN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo+ID4gPiAgCWludCByZXQ7DQo+ID4gPg0KPiA+ID4gKwlpZiAocGluY3RybF9w
bV9zZWxlY3RfZGVmYXVsdF9zdGF0ZShkZXYpKQ0KPiA+ID4gKwkJZGV2X3dhcm4obW1jX2Rldiho
b3N0LT5tbWMpLA0KPiA+ID4gKwkJICIlcywgZmFpbGVkIHRvIHNlbGVjdCBkZWZhdWx0IHBpbiBz
dGF0ZSFcbiIsIF9fZnVuY19fKTsNCj4gPg0KPiA+IFNhbWUgYXMgYWJvdmUNCj4gPg0KPiA+ID4g
Kw0KPiA+ID4gIAkvKiByZS1pbml0aWFsaXplIGh3IHN0YXRlIGluIGNhc2UgaXQncyBsb3N0IGlu
IGxvdyBwb3dlciBtb2RlICovDQo+ID4gPiAgCXNkaGNpX2VzZGhjX2lteF9od2luaXQoaG9zdCk7
DQo+ID4gPg0KPiA+ID4NCg0K
