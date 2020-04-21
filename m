Return-Path: <SRS0=Yb6F=6F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7B1C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Apr 2020 07:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0402087E
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Apr 2020 07:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qQyRzcIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgDUHEh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:04:37 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:25837 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725940AbgDUHEh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Apr 2020 03:04:37 -0400
X-UUID: 98a514005bb64390b454a02f1a5b77fe-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NUYr9270NMzbhd1XCbptanlSHaINIQJqwQxsC0bp9ig=;
        b=qQyRzcIqZJQiYep7THGlYIwzTYdaY3ohbGzBWoQhoKmV9leWB3zwcOR6RYWq3OsrsdmEiBl+oYm36FsqJ1/OgFgyAZQTsaGvOQDysIYGCGLU6owgo9o14skNxpN6JTfaw6gnrcxETq/63OT2RAzJw8Qu5DGPBE56C66J9NnwURA=;
X-UUID: 98a514005bb64390b454a02f1a5b77fe-20200421
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 749383923; Tue, 21 Apr 2020 15:04:04 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Apr
 2020 15:04:03 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Apr 2020 15:04:02 +0800
Message-ID: <1587452609.19579.14.camel@mhfsdcap03>
Subject: Re: [PATCH 1/3] mmc: core: need do mmc_power_cycle in
 mmc_sdio_resend_if_cond
From:   "yong.mao@mediatek.com" <yong.mao@mediatek.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Tue, 21 Apr 2020 15:03:29 +0800
In-Reply-To: <20200420191518.GG199755@google.com>
References: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
         <1586835611-13857-2-git-send-email-yong.mao@mediatek.com>
         <20200420191518.GG199755@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4D8631C23FF72E8651899E91F592EA4CAD41B7629A83C7A9F5136694A8EFCF822000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDEyOjE1IC0wNzAwLCBNYXR0aGlhcyBLYWVobGNrZSB3cm90
ZToNCj4gSGksDQo+IA0KPiBPbiBUdWUsIEFwciAxNCwgMjAyMCBhdCAxMTo0MDowOUFNICswODAw
LCBZb25nIE1hbyB3cm90ZToNCj4gPiBGcm9tOiB5b25nIG1hbyA8eW9uZy5tYW9AbWVkaWF0ZWsu
Y29tPg0KPiA+IA0KPiA+IFdoZW4gbW1jX3NkaW9fcmVzbmVkX2lmX2NvbmQgaXMgaW52b2tlZCwg
aXQgaW5kaWNhdGVzIHRoZSBTRElPDQo+ID4gZGV2aWNlIGlzIG5vdCBpbiB0aGUgcmlnaHQgc3Rh
dGUuIEluIHRoaXMgY29uZGl0aW9uLCB0aGUgcHJldmlvdXMNCj4gPiBpbXBsZW1lbnRhdGlvbiBv
ZiBtbWNfc2Rpb19yZXNlbmRfaWZfY29uZCBjYW4ndCBtYWtlIHN1cmUgU0RJTw0KPiA+IGRldmlj
ZSBiZSBiYWNrIHRvIGlkbGUgc3RhdGUuIG1tY19wb3dlcl9jeWNsZSBjYW4gcmVzZXQgdGhlIFNE
SU8NCj4gPiBkZXZpY2UgYnkgSFcgYW5kIGFsc28gbWFrZSBzdXJlIFNESU8gZGV2aWNlIGVudGVy
IHRvIGlkbGUgc3RhdGUNCj4gPiBjb3JyZWN0bHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
WW9uZyBNYW8gPHlvbmcubWFvQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9t
bWMvY29yZS9zZGlvLmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jIGIvZHJpdmVy
cy9tbWMvY29yZS9zZGlvLmMNCj4gPiBpbmRleCBlYmIzODdhLi5hZGEwYTgwIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29y
ZS9zZGlvLmMNCj4gPiBAQCAtNTQ2LDYgKzU0Niw3IEBAIHN0YXRpYyBpbnQgbW1jX3NkaW9faW5p
dF91aHNfY2FyZChzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQpDQo+ID4gIHN0YXRpYyB2b2lkIG1tY19z
ZGlvX3Jlc2VuZF9pZl9jb25kKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwNCj4gPiAgCQkJCSAgICBz
dHJ1Y3QgbW1jX2NhcmQgKmNhcmQpDQo+ID4gIHsNCj4gPiArCW1tY19wb3dlcl9jeWNsZShob3N0
LCBob3N0LT5jYXJkLT5vY3IpOw0KPiANCj4gTXkgTU1DL1NESU8gYmFja2dyb3VuZCBpcyBsaW1p
dGVkLCBidXQgaXQgc2VlbXMgdGhpcyBpc24ndCBuZWVkZWQgZm9yIHRoZQ0KPiB2YXN0IG1ham9y
aXR5IG9mIFNESU8gZGV2aWNlcywgb3RoZXJ3aXNlIGl0IHByb2JhYmx5IHdvdWxkIGhhdmUgYmVl
biBhZGRlZA0KPiBlYXJsaWVyLiBJIHdvbmRlciBpZiBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIG1h
a2UgdGhlIHBvd2VyIGN5Y2xlDQo+IGNvbmRpdGlvbmFsIHRocm91Z2ggYSBxdWlyaywgdG8gbGlt
aXQgaXQgdG8gdGhlIGRldmljZXMgdGhhdCBuZWVkIGl0Lg0KPiANCgkNClRoYW5rcyBmb3IgeW91
ciBjb21tZW50Lg0KbW1jX3NkaW9fcmVzZW5kX2lmX2NvbmQgQVBJIGlzIG5vdCBmb3Igbm9ybWFs
IGluaXRpYWxpemF0aW9uIGZsb3csIGJ1dA0KZm9yIGVycm9yIGhhbmRsZSBmbG93LiBJZiBtbWNf
c2Rpb19yZXNlbmRfaWZfY29uZCBpcyBpbnZva2VkLCBpdA0KaW5kaWNhdGVzIHRoZXJlIGlzIHNv
bWV0aGluZyB3cm9uZyB3aXRoIHRoZSBTRElPIGRldmljZS4gSFcgcG93ZXIgY3ljbGUNCmlzIHRo
ZSBiYXNpYyBndWFyYW50ZWUgZm9yIGRldmljZSB0byBiYWNrIHRvIGlkbGUgc3RhdGUuDQpUaGVy
ZWZvcmUgdGhpcyBwYXRjaCB3aWxsIG5vdCBhZmZlY3QgdGhlIG5vcm1hbCBpbml0aWFsaXphdGlv
biBmb3IgdGhlIA0KdmFzdCBtYWpvcml0eSBvZiBTRElPIGRldmljZXMsIGJ1dCBpdCBpcyB2ZXJ5
IGhlbHBmdWwgZm9yIGVycm9yIGNhc2VzDQpmb3IgYWxsIFNESU8gZGV2aWNlcy4NCkluIG15IG9w
aW5pb24sIHdlIGRvbid0IG5lZWQgdGhhdCBxdWlyay4NCkNvdWxkIFVsZiBoZWxwIHRvIGdpdmUg
c29tZSBhZHZpc2VzIG9uIHRoaXM/DQpUaGFua3MuDQoNCj4gPiAgCXNkaW9fcmVzZXQoaG9zdCk7
DQo+ID4gIAltbWNfZ29faWRsZShob3N0KTsNCj4gPiAgCW1tY19zZW5kX2lmX2NvbmQoaG9zdCwg
aG9zdC0+b2NyX2F2YWlsKTsNCj4gPiAtLSANCj4gPiAxLjkuMQ0KDQo=

