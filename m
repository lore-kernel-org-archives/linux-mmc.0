Return-Path: <SRS0=bNNl=ED=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D985EC4363A
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Oct 2020 22:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B83424724
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Oct 2020 22:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NTALTr15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgJ1WJ3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:09:29 -0400
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:22662
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730276AbgJ1WJ0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 28 Oct 2020 18:09:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hArJU/7DeXrsXvD+C73B7C0NK/4/rKgiRi4MlE3PlH7lXmysrhDhhFqTsPkmTayPkLgncmrg9LoaqBaxf1DXmAVhvZeLUDzMtPA4ucVk1sO4laRwR6JzB9POnsmhiL+4hInKm+UslCbofEGSleHI1CJ/RMF9sTCWb4F+CwL+7OUcH5oTORUtf/Vh5fi6RFsCecNs7IsHiqAWVrbteWkYdug+FGScWL0c5Di55w/70gmVdLhocEKCCAmPxFnvOvlXI98QQrqVYuO2vkbTPqAMgFf+iaBsfFmnjGDlpvGKKEWWuqDwD2ocaXa0TmAPdETy1YV3L+Yt0ZibutbcgArzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSLJk2gJK1ZN3i2UtCaCceQ6+PLUPY/z+9HB0DH2zLY=;
 b=Du4jSYJy3rHYpY+Nwjy9YZmhDVWxBocvyzkFuvuZ1/mtdXl/5a1+9uRQJV+WBtD/Z26QUl+yN0oUtUw4Vo+4GBu82cL5YWcJ+6ws9AP0jJq5hap7utJJ50J2z9L73uhs2avYoPGvu0RdkaJhYELBXKWYgsrONKfS00bUtr7+kwbu8jbxL6BYjWKLCc4S1T66JMs3uZdxVnF7ZVi7kPUuk1HxtxxWC9Xm1fw8GSB6ghY15xNxH3L5jrog6SXWQ0IdKF76Rllcxb79ldvcsZY5kljN9TV02WjGndRUlNhrIlvUEfTziNk3RpXBx3jwYtFJ2ZP1hK4s1lMEE1S7o4USwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSLJk2gJK1ZN3i2UtCaCceQ6+PLUPY/z+9HB0DH2zLY=;
 b=NTALTr15q7WR3m+puQbH3UIMpck4IvN3cqlVHgiT3LCtfxJN9fk8HCNa3Kbc/4ysruFgc8dtRcbABo49yVam6oEeNzo+Rokbsjosjfijytgb3HqYSRSuVc0i0DtX8NBlHQZadb+wKgz2uhnQChxJ1fRvVECDYnQHVFHctlymVSI=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB6328.eurprd04.prod.outlook.com (2603:10a6:20b:b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 28 Oct
 2020 10:36:13 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 10:36:13 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [v3] mmc: sdhci-of-esdhc: make sure delay chain locked for HS400
Thread-Topic: [v3] mmc: sdhci-of-esdhc: make sure delay chain locked for HS400
Thread-Index: AQHWprnaERgm9uIRMk6Ldy3x07rxZ6mrgGeAgAFBAWCAABk2AIAABB+Q
Date:   Wed, 28 Oct 2020 10:36:13 +0000
Message-ID: <AM7PR04MB68850947DD9FF8109CBDD504F8170@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201020081116.20918-1-yangbo.lu@nxp.com>
 <CAPDyKFoOPmqPhk7+-kNo6WQejS-GFPvbJcap3fXeJknb6spWiA@mail.gmail.com>
 <AM7PR04MB68858DD7249012E2B53E365FF8170@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <CAPDyKFrgcobAo_Qmt_aoSfmYErj=r3emb4_zwVSUnhMcFJnTLg@mail.gmail.com>
In-Reply-To: <CAPDyKFrgcobAo_Qmt_aoSfmYErj=r3emb4_zwVSUnhMcFJnTLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bab6ce99-7f99-4fb0-8831-08d87b2d4aff
x-ms-traffictypediagnostic: AM6PR04MB6328:
x-microsoft-antispam-prvs: <AM6PR04MB6328CDF7968BF8ED13C243C1F8170@AM6PR04MB6328.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qTji85AYO1HaiB573JspEye08opdjq+HgQrTzL6J9Gtlzp/DxIoysF49ZOIRT+nG1hjsLVx2QnaMSrgn5Mempv6inczG2CMg8rmKU2kmT/E6Fz06KW9WWnf4zfCO+LlHZeTYEGdxIMltunpIX6vagsRmDW0ys65wC1MFfJTpFbbLDqc1A2ygm9NizlYbT2pPS5qPq+WVJzQ+9BE1iKPTaIoq3VEcL422lE3WtcDXWPnbBAI3nLYZwMuZxMVBPQaLoP7tN8hm4yqkjX/TevWYBSA0/BeWvmJiWw2/50C3d6VwY6YZJqm9Rs30b3SUd7LAxQV9u+t0V/lHwBgRMnuy/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66446008)(66556008)(66476007)(4326008)(5660300002)(52536014)(64756008)(33656002)(86362001)(8676002)(6916009)(83380400001)(53546011)(316002)(6506007)(71200400001)(26005)(186003)(7696005)(76116006)(8936002)(2906002)(55016002)(66946007)(54906003)(478600001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mXArpJ60jI1phvGviORABQtyyiPzmEqVk/L/uVIv9Vn7oeBTvW4itioYsw1ZBsBdeHqdPDB/Hc4OtgnmjoD6eF/5JPi+R9QRH+Cfi2eFve1Yc2LqSb7ezHeAMVoZWm6zqxOg6K486+W8r4O+JzY9YrQEBqaH6E2Q5ytC7zeVO6QE6f8JB283vrQb35E0YzOV6epkmJ7qGBcRnrZj9if6Lfx/qLCOPAgqWMkKhemwKaDPX37UGAKswx5TfHDOHX+uXHgImq3nMPuBtovvYLlxLJzpDO+DgM6ku81GIYif8pTwR2W52zfUseudYjoMbFxP0QFe1opDgHq6TXNyaxM7hmzWz3lYBE5aPtjhTC+YEFZpfPIN3FFEai2+rrhhLCdrFz2NOp/CHmWcXTwLkQapMPzPEWzLaw35X1GLPTK13Xyv33IHrFgzYixskdASC/PY5mQZrMsUlPlbxP/S58FguQ1tlmTqwJTCemZlpYOI8m6wmVK7MSvVCcjfYwsx6nkiyjhqxBVczvErYGVDebxtEATCgTdcXGgoActyWh1m7rpmy642Tdu5Wz0wAvR7yUiXZCRfjfyAQV4OSDfiMKnPRDy3Hlhf5KpaTtQvMc8vVmSF4wef63Myy6gBoYke8nxkMEusrAyWOAuWlvZJ9dTxhA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab6ce99-7f99-4fb0-8831-08d87b2d4aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 10:36:13.3735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljh+3omAGUd8AMEMywiQTe2q1Q8YUB0Kohx4HvZEbIw7tBk33K7d2Ebz6Pgjhbd/XzCCeruhNdaZ+ACcKZ/nzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6328
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI4LCAyMDIwIDY6
MjEgUE0NCj4gVG86IFkuYi4gTHUgPHlhbmdiby5sdUBueHAuY29tPg0KPiBDYzogbGludXgtbW1j
QHZnZXIua2VybmVsLm9yZzsgQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbdjNdIG1tYzogc2RoY2ktb2YtZXNkaGM6IG1ha2Ugc3VyZSBkZWxh
eSBjaGFpbiBsb2NrZWQgZm9yIEhTNDAwDQo+IA0KPiBPbiBXZWQsIDI4IE9jdCAyMDIwIGF0IDA5
OjU2LCBZLmIuIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBVZmZl
LA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogVWxm
IEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDI3LCAyMDIwIDk6NDIgUE0NCj4gPiA+IFRvOiBZLmIuIEx1IDx5YW5nYm8ubHVAbnhw
LmNvbT4NCj4gPiA+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBBZHJpYW4gSHVudGVy
IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbdjNdIG1tYzog
c2RoY2ktb2YtZXNkaGM6IG1ha2Ugc3VyZSBkZWxheSBjaGFpbiBsb2NrZWQgZm9yDQo+IEhTNDAw
DQo+ID4gPg0KPiA+ID4gT24gVHVlLCAyMCBPY3QgMjAyMCBhdCAxMDoyMCwgWWFuZ2JvIEx1IDx5
YW5nYm8ubHVAbnhwLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEZvciBlTU1DIEhTNDAw
IG1vZGUgaW5pdGlhbGl6YXRpb24sIHRoZSBETEwgcmVzZXQgaXMgYSByZXF1aXJlZCBzdGVwDQo+
ID4gPiA+IGlmIERMTCBpcyBlbmFibGVkIHRvIHVzZSBwcmV2aW91c2x5LCBsaWtlIGluIGJvb3Rs
b2FkZXIuDQo+ID4gPiA+IFRoaXMgc3RlcCBoYXMgbm90IGJlZW4gZG9jdW1lbnRlZCBpbiByZWZl
cmVuY2UgbWFudWFsLCBidXQgdGhlIFJNIHdpbGwNCj4gPiA+ID4gYmUgZml4ZWQgc29vbmVyIG9y
IGxhdGVyLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIGlzIHRvIGFkZCB0aGUgc3RlcCBv
ZiBETEwgcmVzZXQsIGFuZCBtYWtlIHN1cmUgZGVsYXkgY2hhaW4NCj4gPiA+ID4gbG9ja2VkIGZv
ciBIUzQwMC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWWFuZ2JvIEx1IDx5YW5n
Ym8ubHVAbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBBcHBsaWVkIGZvciBuZXh0IChwbGVhc2UgdGVs
bCBpZiB5b3UgdGhpbmsgdGhpcyBkZXNlcnZlcyB0byBiZSB0YWdnZWQNCj4gPiA+IGZvciBzdGFi
bGUpLCB0aGFua3MhDQo+ID4NCj4gPiBUaGFua3MhDQo+ID4gUGxlYXNlIGhlbHAgdG8gdGFnIGZv
ciBzdGFibGUuIFRoZSBsYXRlc3QgdS1ib290IGp1c3Qgc3VwcG9ydGluZyBlU0RIQyBIUzQwMCwN
Cj4gbWF5IGNhdXNlIGtlcm5lbCBIUzQwMCBpc3N1ZSB3aXRob3V0IHRoaXMgcGF0Y2guDQo+IA0K
PiBJIGhhdmUgYWRkZWQgYSBzdGFibGUgYW5kIGEgZml4ZXMgdGFnLiBBZGRpdGlvbmFsbHkgSSBo
YXZlIG1vdmVkIHRoZQ0KPiBwYXRjaCB0byBteSBmaXhlcyBicmFuY2guDQo+IA0KPiBQbGVhc2Ug
aGF2ZSBhIGxvb2sgaW4gbXkgZ2l0IHRvIG1ha2Ugc3VyZSBpdCBsb29rcyBnb29kIHRvIHlvdS4N
Cg0KVGhhbmsgeW91IFVmZmUuIEl0IGxvb2tzIGZpbmUuDQoNCj4gDQo+IFsuLi5dDQo+IA0KPiBL
aW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
