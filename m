Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBB1C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 08:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D73207DF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 08:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sbCK+waY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHUIIx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:08:53 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:51169
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbgHUIIv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Aug 2020 04:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7L+oKmEBgbOLRhSfGARlNvj/iz+PFV+D3oj0y93QSnkkmTrCg2SJt9fC1oKHhWe0Xctj19c74KUTAWFRAw1VB/24nlyza8DDT0TSMs1VGcPAjjx5FhBe1e+xo7vcZSoLYi3f3jU+IZNX9GSnLj+qqj75VdF7+6FwblGWuBRAKpSvaqDnsorMUTP5+FjNMpFbiilcRltX4J64FEL8k3xIGn/w7dbWhk2kLwVUHXQlN4aXtfTUih4DXtKZjVxoWW5+Vq4GCV4qFNgmLgXANYRykBScnEIt9F5sGikn3PLky0u81uI+w8vRiWXE1Fvqy9LpxBsAapDPX4YZ2qTn1QB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eae91YwhwLFzO2KFZIQu4EF4/t6BrFGYMhhDVr6ce3Q=;
 b=lPh6kj4fRI1RStVaa/ODQBpxxnZTiNyrCiGHasDcwAe48RWKyidtEEBzKWIQcc/Z+lDsrPcyG75G/V1ewFP8oU10rDfSjBYVuN0rKxF03zhIyLaJyrJ17VkhsL7yiOXgUWdoQdWdU/Ti4TpK6K5yhomZqyLHKPFlVVg0u+bvTM/qUFJyDYV0hZR3mQ/TA6bm56tQCFNRRYvSDE6UbgVDnq28zKMFwnccbd1TyVXPh9gwo7zsfslyrX/Nsh88L+tL91bChTrmM9OUxtzXbjJdNnWwDy9+arW2p95zogPBpD2liQk5lHwjO3kQogcdGcrg8nApEiA0oK7PIKNWeJ7XyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eae91YwhwLFzO2KFZIQu4EF4/t6BrFGYMhhDVr6ce3Q=;
 b=sbCK+waYgqZcZVo0SlFfScEACCNjct77IXx1Vdfc/y0TzSPL+mhfOyxWI7NVLvkDkekZeNZtxep+Zq8IgDNdbFhDPIWagqLaq8oP6dnJRg7u2aQN9Um57XppwQ2mdNPPuvF3KwshmiXktjh2OrRlQFcuWupr6h6H+maRzQeaorc=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB4224.eurprd04.prod.outlook.com (2603:10a6:803:49::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 08:08:47 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::f858:cc14:2a9f:e8ed]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::f858:cc14:2a9f:e8ed%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 08:08:47 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        Doug Anderson <dianders@chromium.org>,
        =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
Subject: RE: [PATCH v2] mmc: sdio: add a delay to call sdio_irq_work when sdio
 bus resume
Thread-Topic: [PATCH v2] mmc: sdio: add a delay to call sdio_irq_work when
 sdio bus resume
Thread-Index: AQHWdhtg+SELfflIKkqkLaHzsqwd4qlCNcSAgAABs5A=
Date:   Fri, 21 Aug 2020 08:08:47 +0000
Message-ID: <VI1PR04MB5294EC56C2DFF20BE8A7C811905B0@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1597835959-22402-1-git-send-email-haibo.chen@nxp.com>
 <CAPDyKFqd_0VV2cO_weC6QJ-aNAG0witOwWfsWqeoaryDNQS1hA@mail.gmail.com>
In-Reply-To: <CAPDyKFqd_0VV2cO_weC6QJ-aNAG0witOwWfsWqeoaryDNQS1hA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5f0d45e-82fb-41dd-1a1f-08d845a96e6e
x-ms-traffictypediagnostic: VI1PR04MB4224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB422419002CD64F3D5D381BBB905B0@VI1PR04MB4224.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wYA30AZtJJI7jF/x/uBd8kmu6Njv6QfM5wfsBoKej7/KG5hhywPiBa7+2h2lI6MQ5y5mxd3Zh1BY4WFnLvTr9HhEWn/1KB8yiAVHyAxdkGS/uRCFIK3ifNVQlYwJrvM7gKVmKFDTgyeA1WubPPtZYUyVARChT10zelAcbNuXtqvRQtNBG+m4C8dKc63Rr2X3FMZP8OYtNxLxMW0lvn0losb0FnadwYdV9n8R/r2e6Va4QS6L9A80ooD/XRxC//9JUBhErkV++if1OZ0z3xrjL1rJRu6NiMlAgm6wSYoez3lMVJPo5NuP6c9cIkUhY36BQSlNhJfIulq8OqaRHJLxJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(6916009)(5660300002)(66476007)(316002)(66946007)(66446008)(2906002)(83380400001)(33656002)(76116006)(54906003)(66556008)(52536014)(64756008)(66574015)(478600001)(8936002)(8676002)(71200400001)(7696005)(9686003)(55016002)(26005)(186003)(53546011)(86362001)(6506007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cH/xIlAhureASrs7aN5xq0v0D92B1RXJl9cAkNUuiGkThWcK+bzoKOF49nhfbXVoJcNZ4RgEJj6IWJ+Zrp8eO/OTDMw4vtLIMwsLIMKucVYrS4G/YwiaQGVGsFvnd5HuvS8tQfP67GXRc/hq7CZKMuK0M15Ax6FLxQ4iux87+8vIj/m5H4BslzbzYeypzaF6aXmqelNuSPdvviLk5jy7Sn7lIKEyaOXeWPZJBazIt1htZjNdrGnz2r4iUrccgIxGEXfXRS1KI9vSJ72DDznDirl+KlEML0d4vqTyEklVxMLUcWUoDLPV3O7g6QM4jIMsw87V/wpzn0rR54W8D0UeNJekBVSiOm6HfOEOm/L1NO2D9lM6bGVtVurag9F4YHYUA7XKa54MhPMbc2y7ERQjYCs3yIr3Sxv6YtywQLUAxoRWQ42uBr0lQ9bG6n2/LhXlYCSmuo+t1I7/tnLb/CgBt+s58RTxekhAhjl5QgZy0MLYihsQG4CCJbrH6uHH7VkJPc94o7ppvsc/SczlKGekJHh023784yhTQbZze/R4kHa0W709NbMUNkaxEYbx+2TC8dPDhSMNGYwJO0GuTOw+sWPgu7EtidntM8F0XKly7BzW3XKILXtalZs67zsICaiUymDrrpNxsB6RH1ldH9oSXA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f0d45e-82fb-41dd-1a1f-08d845a96e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 08:08:47.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mBLGdXeZWY+FXHJcj1QJUZHqkzItChT7jFmGzSl7Nb9WmRWZifkqWCzz0G4HGOVhNfZJEK17M4kd/NS5TOadw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiBbbWFpbHRv
OnVsZi5oYW5zc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IDIwMjDlubQ45pyIMjHml6UgMTU6NTkN
Cj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IEFkcmlhbiBIdW50
ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsN
Cj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IE1hdHRoaWFzIEthZWhsY2tlIDxt
a2FAY2hyb21pdW0ub3JnPjsNCj4gaHV5dWUyQHl1bG9uZy5jb207IERvdWcgQW5kZXJzb24gPGRp
YW5kZXJzQGNocm9taXVtLm9yZz47IFBhbGkgUm9ow6FyDQo+IDxwYWxpQGtlcm5lbC5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIG1tYzogc2RpbzogYWRkIGEgZGVsYXkgdG8gY2FsbCBz
ZGlvX2lycV93b3JrIHdoZW4gc2Rpbw0KPiBidXMgcmVzdW1lDQo+IA0KPiBPbiBXZWQsIDE5IEF1
ZyAyMDIwIGF0IDEzOjI0LCA8aGFpYm8uY2hlbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZy
b206IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPg0KPiA+IEZpbmQgdGhpcyBp
c3N1ZSBvbiBpLk1YN0Qtc2RiIGJvYXJkIHdpdGggYnJvYWRjb20gc2RpbyB3aWZpLg0KPiA+IFdo
ZW4gc3lzdGVtIHJlc3VtZSwgc29tZXRpbWVzIHRoaXMgd2lmaSBtZWV0IHRoZSB0dW5pbmcgZmFp
bCBpc3N1ZS4NCj4gPiBBbGwgdHVuaW5nIGNvbW1hbmQgZ2V0IGNvbW1hbmQgdGltZW91dCBlcnJv
ci4gVGhpcyBpcyBiZWNhdXNlDQo+ID4gc2Rpb19pcnFfd29yayBvbiBzeXN0ZW1fd3Egd2FzIGV4
ZWN1dGVkIGJlZm9yZSB0aGUgYnJvYWRjb20gd2lmaQ0KPiA+IGRyaXZlciByZXN1bWUuIER1ZSB0
byBicm9hZGNvbSB3aWZpIGRyaXZlciBzZXQgdGhlIHdpZmkgaW4gU2xlZXAgc2F0ZQ0KPiA+IGlu
IHN5c3RlbSBzdXNwZW5kLCBuZWVkIHRvIHNldCB0aGUgd2lmaSB0byBXYWtlIHN0YXRlIGZpcnN0
LiBTbyBuZWVkDQo+ID4gdG8gbWFrZSBzdXJlIHdpZmkgZHJpdmVyIHJlc3VtZSBmaXJzdCwgdGhl
biBkbyB0aGUgc2Rpb19pcnFfd29yay4NCj4gPg0KPiA+IEZpeGVzOiA1MTEzMzg1MGJjZTIgKCJt
bWM6IGNvcmU6IEZpeHVwIHByb2Nlc3Npbmcgb2YgU0RJTyBJUlFzIGR1cmluZw0KPiA+IHN5c3Rl
bSBzdXNwZW5kL3Jlc3VtZSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8u
Y2hlbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL3NkaW8uYyB8IDIg
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgYi9kcml2ZXJzL21t
Yy9jb3JlL3NkaW8uYyBpbmRleA0KPiA+IDdiNDA1NTNkMzkzNC4uMTAxNjMyNjE3ZjY5IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jDQo+ID4gKysrIGIvZHJpdmVycy9t
bWMvY29yZS9zZGlvLmMNCj4gPiBAQCAtMTA0Nyw3ICsxMDQ3LDcgQEAgc3RhdGljIGludCBtbWNf
c2Rpb19yZXN1bWUoc3RydWN0IG1tY19ob3N0DQo+ICpob3N0KQ0KPiA+ICAgICAgICAgICAgICAg
ICBpZiAoIShob3N0LT5jYXBzMiAmIE1NQ19DQVAyX1NESU9fSVJRX05PVEhSRUFEKSkNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICB3YWtlX3VwX3Byb2Nlc3MoaG9zdC0+c2Rpb19pcnFfdGhy
ZWFkKTsNCj4gPiAgICAgICAgICAgICAgICAgZWxzZSBpZiAoaG9zdC0+Y2FwcyAmIE1NQ19DQVBf
U0RJT19JUlEpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcXVldWVfZGVsYXllZF93b3Jr
KHN5c3RlbV93cSwNCj4gJmhvc3QtPnNkaW9faXJxX3dvcmssIDApOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHF1ZXVlX2RlbGF5ZWRfd29yayhzeXN0ZW1fd3EsDQo+ID4gKyAmaG9zdC0+
c2Rpb19pcnFfd29yaywgMSk7DQo+IA0KPiBUaGlzIGxvb2tzIGZyYWdpbGUsIGFzIHRoZXJlIGlz
IHJlYWxseSBubyBndWFyYW50ZWUgdGhhdCB0aGUgV2lGaSBkcml2ZXIgaXMNCj4gcmVzdW1lZCBw
cmlvciB0byB0aGUgU0RJTyBpcnEgd29yayBiZWluZyBleGVjdXRlZC4NCg0KWWVzLCBhZ3JlZS4N
Cg0KPiANCj4gSW5zdGVhZCwgaXQgbG9va3MgbGlrZSB5b3Ugc2hvdWxkbid0IGtlZXAgdGhlIFNE
SU8gaXJxcyBlbmFibGVkIGR1cmluZyBzeXN0ZW0NCj4gc3VzcGVuZCwgYmVjYXVzZSB0aG9zZSBh
cmVuJ3Qgc3lzdGVtIHdha2V1cCBjYXBhYmxlLiBDb3JyZWN0Pw0KPiANCj4gSW4gb3RoZXIgd29y
ZHMsIEkgdGhpbmsgdGhlIFdpRmkgZHJpdmVyIHNob3VsZCBjYWxsIHNkaW9fcmVsZWFzZV9pcnEo
KSBpbiB0aGUNCj4gLT5zdXNwZW5kKCkgY2FsbGJhY2sgYW5kIHNkaW9fY2xhaW1faXJxKCkgaW4g
dGhlIC0+cmVzdW1lKCkgY2FsbGJhY2suDQoNCkxldCBtZSBkb3VibGUgY2hlY2sgdGhlIFdJRkkg
ZHJpdmVyLiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uIQ0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJv
IENoZW4NCj4gDQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgb3V0Og0KPiA+IC0tDQo+ID4gMi4x
Ny4xDQo+ID4NCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
