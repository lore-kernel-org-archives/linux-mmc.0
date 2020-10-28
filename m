Return-Path: <SRS0=xPu9=EE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21635C55179
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Oct 2020 00:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B275C206DC
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Oct 2020 00:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rhfFNiT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgJ1W3L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:29:11 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:46562
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387512AbgJ1W3K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBrvsNBbDunEy79/0NCyMRHrA1T+q8nWWwaYcPC4wNK4Hn+Wt8pMVovCS8CO/AWnaUbHLbjKRyjTaxNXF03AZXnypUDK0Wtr0gvQ2sC9cQArn+2D9mJsVY8ugEAEylTq7zHkzYZwLtnLbDLsnw2Fe/yPdMcCWgXFJ2ieLjC8ScEjN1wVBRjbHz3oSx/F5fHywf0BzkI3kCV800eQJCzesaW1guZpmWhDfomcJRXJZpA5C7+Iv3Zj29m2ODeFhSdGIZQ3HVwMDLcuqKBJvqBBJtKMDNZtOmZrIBxQiinFx2yH2ouabVuP2Xl+aco1BhNPkYZ4jErByOMiVStiApEX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmT9UJAah6Tlj+TTKJGEK5KNuzkzkSjufsatXI0cm3Q=;
 b=Dpr1C6TRPtP3At1UI/vqDus9T5aKV3ssSEwC3GXH7JA2R2elqn0y7t50HoMvk8vHk1Zba+uJ47dJEvCwA40kgBzbIltjNPYunqbU4TSKo0sUkhxk5tdu+VMNakefG9KLZEHpI/tiREZRwKnHAZ6oiuHvdA+y4aE5Ne0wcUegUlujs6l9UK7vnIucPNwt6dIw/fUcT6Ku+wUErRcaJx3CPs3EB3d7nxDC89Gd+ZGqC+FiPZQixtJ5ne+uoWrDs/nMS85D6bDQztc1WOeudbFyKaBaXnm7+XZ24JRC5HRgM3VnZtRWqxNlPFZUpCmAK/manMWp60yuwfEfDyb5vfGRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmT9UJAah6Tlj+TTKJGEK5KNuzkzkSjufsatXI0cm3Q=;
 b=rhfFNiT5hvR4PGb5tFRBVONwoO1kGrR8JFwPpU1Q4iiZ9qxn2GRxWtlkV34+BA4osEnBJX4Iw5XGn7gz3PZzn80iy4U2Gjua2+K5qiYAwE658RxQ9QLWmAx8kCZOOmvX2MG4R1yvuH71np+jDnEniAAaK0pfcA/OAzCaTzr6xqw=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB6406.eurprd04.prod.outlook.com (2603:10a6:20b:f2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 08:56:45 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 08:56:45 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [v3] mmc: sdhci-of-esdhc: make sure delay chain locked for HS400
Thread-Topic: [v3] mmc: sdhci-of-esdhc: make sure delay chain locked for HS400
Thread-Index: AQHWprnaERgm9uIRMk6Ldy3x07rxZ6mrgGeAgAFBAWA=
Date:   Wed, 28 Oct 2020 08:56:45 +0000
Message-ID: <AM7PR04MB68858DD7249012E2B53E365FF8170@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201020081116.20918-1-yangbo.lu@nxp.com>
 <CAPDyKFoOPmqPhk7+-kNo6WQejS-GFPvbJcap3fXeJknb6spWiA@mail.gmail.com>
In-Reply-To: <CAPDyKFoOPmqPhk7+-kNo6WQejS-GFPvbJcap3fXeJknb6spWiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92504fb5-8e50-4c29-9b52-08d87b1f65e1
x-ms-traffictypediagnostic: AM6PR04MB6406:
x-microsoft-antispam-prvs: <AM6PR04MB6406F9549809AC36DE2FB04EF8170@AM6PR04MB6406.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hc+BQbGRtg1SX8xI9TqaUR6BB0veHru5Uqq1/wOYrRFuRSk9R7KNtjO8o8Po5CaFTDWEOLtrdKjOVNlVfdUx90PywIZhCeL2H6DYwxl4slk0ED//KP2vkdgVg4tsaK4n6ZkX61lOfPiLFRI4Uk5MpI4yWz7a8LUEsB2wRii+I6iy2FQv641jLh2NgvheGw4pbQ4mPHxxQPfxCmiB5MkTV8VFtNZLChDMM/WnCtnSnUcKjbqFJY9k+wMmh2Q7d4xi88T+grWsBj7sd63ThAWwOu913CkycbUzS42byjocph+Ydz3LzRf6ft6zBEN1/2xvA3HcpFyYaJ6D9FyVYrPRZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(6916009)(66476007)(66556008)(64756008)(66446008)(186003)(52536014)(71200400001)(76116006)(26005)(66946007)(316002)(2906002)(8676002)(83380400001)(8936002)(33656002)(9686003)(55016002)(53546011)(54906003)(86362001)(6506007)(478600001)(5660300002)(4326008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TcCkBmaNzxWGa2BmgLhoaeqo2PWz74EeaUS39TnTtqzk0IJYUhgfFJD8qd0nlHkhZSpHHBZCB3bIqmiU9CNziNKX6mBwtimNxCZv2QTa2UOy1WUL0Bt5CXMVOq5TqqqEbV1dEgZRnZCL3DutjyHoW2Y9lInWl4x928UTWAZydGEBI3LibbqO9jKpyZwAMxeHLUJcIFa2YJvA0jqLlekMBy+8eY0Nmf8grbsZ99aCRplT1JW1vIl96JRhGAYgP6+4zhIE9CfoPRQEZ+11D4UXQgyFtAkUarfjdeFXJlVODJQhPHrnb1njWHmi4b8BF8lUyPHNg+Ni1otPOguu82koENGjFdIjnciOA5B09K9lSKZgehRWR810hex4R1NuE23zXcKtdXbdGfF7GKuyDLQTKKcZOD/96RDvcoc7xf02+gO5AIqvehuSqaQMGNmYfAstQFhIguQV0tplLZ7Rhl2GfoRlKlkCrjl1wdQw/WRtfsENoSzWn+huLe3UM7KHm81GrRMEdiItL769YeHf/CUamt9c40ZQkIZkV6WTRc7Hj4YVUJ6zxT21K4sqEROOQpkk2ofer1Nuu0L1PSi+6MizKJPvyjEqmJfvDujLDpWwIB+UtWjsgs86u7LtR0GahR4NQ2BvAfJcC6JJbutYjQ8C7g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92504fb5-8e50-4c29-9b52-08d87b1f65e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 08:56:45.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Svc53Ra4/GSR2rkPQz1nFv1sdQGrVDEm53UdxCsZNEIA0JL4KtjmLA2vPhVQTn8xbjghEMJgZwpMqWS/xbzKFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6406
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWZmZSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFu
c3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAy
NywgMjAyMCA5OjQyIFBNDQo+IFRvOiBZLmIuIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4NCj4gQ2M6
IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW3YzXSBtbWM6IHNkaGNpLW9mLWVzZGhjOiBtYWtl
IHN1cmUgZGVsYXkgY2hhaW4gbG9ja2VkIGZvciBIUzQwMA0KPiANCj4gT24gVHVlLCAyMCBPY3Qg
MjAyMCBhdCAxMDoyMCwgWWFuZ2JvIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBGb3IgZU1NQyBIUzQwMCBtb2RlIGluaXRpYWxpemF0aW9uLCB0aGUgRExMIHJlc2V0IGlz
IGEgcmVxdWlyZWQgc3RlcA0KPiA+IGlmIERMTCBpcyBlbmFibGVkIHRvIHVzZSBwcmV2aW91c2x5
LCBsaWtlIGluIGJvb3Rsb2FkZXIuDQo+ID4gVGhpcyBzdGVwIGhhcyBub3QgYmVlbiBkb2N1bWVu
dGVkIGluIHJlZmVyZW5jZSBtYW51YWwsIGJ1dCB0aGUgUk0gd2lsbA0KPiA+IGJlIGZpeGVkIHNv
b25lciBvciBsYXRlci4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaXMgdG8gYWRkIHRoZSBzdGVwIG9m
IERMTCByZXNldCwgYW5kIG1ha2Ugc3VyZSBkZWxheSBjaGFpbg0KPiA+IGxvY2tlZCBmb3IgSFM0
MDAuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5nYm8gTHUgPHlhbmdiby5sdUBueHAuY29t
Pg0KPiANCj4gQXBwbGllZCBmb3IgbmV4dCAocGxlYXNlIHRlbGwgaWYgeW91IHRoaW5rIHRoaXMg
ZGVzZXJ2ZXMgdG8gYmUgdGFnZ2VkDQo+IGZvciBzdGFibGUpLCB0aGFua3MhDQoNClRoYW5rcyEN
ClBsZWFzZSBoZWxwIHRvIHRhZyBmb3Igc3RhYmxlLiBUaGUgbGF0ZXN0IHUtYm9vdCBqdXN0IHN1
cHBvcnRpbmcgZVNESEMgSFM0MDAsIG1heSBjYXVzZSBrZXJuZWwgSFM0MDAgaXNzdWUgd2l0aG91
dCB0aGlzIHBhdGNoLg0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPiANCj4gDQo+IA0K
PiA+IC0tLQ0KPiA+IENoYW5nZXMgZm9yIHYyOg0KPiA+ICAgICAgICAgLSBDb252ZXJ0ZWQgdG8g
dXNlIHJlYWRfcG9sbF90aW1lb3V0Lg0KPiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+ICAgICAgICAg
LSBJbmNsdWRlZCBpb3BvbGwuaC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1lc2RoYy5oICAgIHwgIDIgKysNCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2Ro
Yy5jIHwgMTcgKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1l
c2RoYy5oDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy5oDQo+ID4gaW5kZXggYTMw
Nzk2ZS4uNmRlMDJmMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVz
ZGhjLmgNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLmgNCj4gPiBAQCAt
NSw2ICs1LDcgQEANCj4gPiAgICogQ29weXJpZ2h0IChjKSAyMDA3IEZyZWVzY2FsZSBTZW1pY29u
ZHVjdG9yLCBJbmMuDQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAwOSBNb250YVZpc3RhIFNvZnR3
YXJlLCBJbmMuDQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAxMCBQZW5ndXRyb25peCBlLksuDQo+
ID4gKyAqIENvcHlyaWdodCAyMDIwIE5YUA0KPiA+ICAgKiAgIEF1dGhvcjogV29sZnJhbSBTYW5n
IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+DQo+ID4gICAqLw0KPiA+DQo+ID4gQEAgLTg4LDYgKzg5
LDcgQEANCj4gPiAgLyogRExMIENvbmZpZyAwIFJlZ2lzdGVyICovDQo+ID4gICNkZWZpbmUgRVNE
SENfRExMQ0ZHMCAgICAgICAgICAgICAgICAgIDB4MTYwDQo+ID4gICNkZWZpbmUgRVNESENfRExM
X0VOQUJMRSAgICAgICAgICAgICAgIDB4ODAwMDAwMDANCj4gPiArI2RlZmluZSBFU0RIQ19ETExf
UkVTRVQgICAgICAgICAgICAgICAgICAgICAgICAweDQwMDAwMDAwDQo+ID4gICNkZWZpbmUgRVNE
SENfRExMX0ZSRVFfU0VMICAgICAgICAgICAgIDB4MDgwMDAwMDANCj4gPg0KPiA+ICAvKiBETEwg
Q29uZmlnIDEgUmVnaXN0ZXIgKi8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1vZi1lc2RoYy5jDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+
ID4gaW5kZXggMGI0NWVmZi4uOTBlNjA4NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9m
LWVzZGhjLmMNCj4gPiBAQCAtNCw2ICs0LDcgQEANCj4gPiAgICoNCj4gPiAgICogQ29weXJpZ2h0
IChjKSAyMDA3LCAyMDEwLCAyMDEyIEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuDQo+ID4g
ICAqIENvcHlyaWdodCAoYykgMjAwOSBNb250YVZpc3RhIFNvZnR3YXJlLCBJbmMuDQo+ID4gKyAq
IENvcHlyaWdodCAyMDIwIE5YUA0KPiA+ICAgKg0KPiA+ICAgKiBBdXRob3JzOiBYaWFvYm8gWGll
IDxYLlhpZUBmcmVlc2NhbGUuY29tPg0KPiA+ICAgKiAgICAgICAgIEFudG9uIFZvcm9udHNvdiA8
YXZvcm9udHNvdkBydS5tdmlzdGEuY29tPg0KPiA+IEBAIC0xOSw2ICsyMCw3IEBADQo+ID4gICNp
bmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2t0aW1lLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW9w
b2xsLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tbWMvaG9zdC5oPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvbW1jL21tYy5oPg0KPiA+ICAjaW5jbHVkZSAic2RoY2ktcGx0Zm0uaCINCj4gPiBAQCAt
NzQzLDYgKzc0NSwyMSBAQCBzdGF0aWMgdm9pZCBlc2RoY19vZl9zZXRfY2xvY2soc3RydWN0IHNk
aGNpX2hvc3QNCj4gKmhvc3QsIHVuc2lnbmVkIGludCBjbG9jaykNCj4gPiAgICAgICAgICAgICAg
ICAgaWYgKGhvc3QtPm1tYy0+YWN0dWFsX2Nsb2NrID09IE1NQ19IUzIwMF9NQVhfRFRSKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIHRlbXAgfD0gRVNESENfRExMX0ZSRVFfU0VMOw0KPiA+
ICAgICAgICAgICAgICAgICBzZGhjaV93cml0ZWwoaG9zdCwgdGVtcCwgRVNESENfRExMQ0ZHMCk7
DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICB0ZW1wIHw9IEVTREhDX0RMTF9SRVNFVDsNCj4g
PiArICAgICAgICAgICAgICAgc2RoY2lfd3JpdGVsKGhvc3QsIHRlbXAsIEVTREhDX0RMTENGRzAp
Ow0KPiA+ICsgICAgICAgICAgICAgICB1ZGVsYXkoMSk7DQo+ID4gKyAgICAgICAgICAgICAgIHRl
bXAgJj0gfkVTREhDX0RMTF9SRVNFVDsNCj4gPiArICAgICAgICAgICAgICAgc2RoY2lfd3JpdGVs
KGhvc3QsIHRlbXAsIEVTREhDX0RMTENGRzApOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAg
LyogV2FpdCBtYXggMjAgbXMgKi8NCj4gPiArICAgICAgICAgICAgICAgaWYgKHJlYWRfcG9sbF90
aW1lb3V0KHNkaGNpX3JlYWRsLCB0ZW1wLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdGVtcCAmDQo+IEVTREhDX0RMTF9TVFNfU0xWX0xPQ0ssDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxMCwgMjAwMDAsIGZhbHNlLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaG9zdCwgRVNESENfRExMU1RBVDAp
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiJXM6IHRpbWVvdXQgZm9yIGRl
bGF5IGNoYWluIGxvY2suXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBt
bWNfaG9zdG5hbWUoaG9zdC0+bW1jKSk7DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICB0ZW1w
ID0gc2RoY2lfcmVhZGwoaG9zdCwgRVNESENfVEJDVEwpOw0KPiA+ICAgICAgICAgICAgICAgICBz
ZGhjaV93cml0ZWwoaG9zdCwgdGVtcCB8DQo+IEVTREhDX0hTNDAwX1dORFdfQURKVVNULCBFU0RI
Q19UQkNUTCk7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4NCg==
