Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47613C35247
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 00:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8622166E
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 00:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fsToL9Vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBDAoU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:44:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:30771 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726928AbgBDAoU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Feb 2020 19:44:20 -0500
X-UUID: 1a1ab3d8e5a645109859a7adbcd181ea-20200204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5GT0W0D4fp1R9e9GcyJmXd1HEmQL0ETrvY40fzATcrY=;
        b=fsToL9ViJWcZIICJM27OSDhjNoyoImIJQbMjTeHViMESeY6WIzQhavCKcknZyTi8PCVd8zzUydDg6B1nIZgCvnB+d+t9ilhp1AuRPVw0/JAHXczEyfDpdrav7QwXJTk0i7Qk2gnxLNZgCXwd2iXmWtA43ZuGsEmYEKZ1/da68Is=;
X-UUID: 1a1ab3d8e5a645109859a7adbcd181ea-20200204
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1633236549; Tue, 04 Feb 2020 08:44:15 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 4 Feb 2020 08:43:34 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Feb 2020 08:44:29 +0800
Message-ID: <1580777053.4621.1.camel@mtkswgap22>
Subject: Re: [PATCH 1/3] [1/3] mmc: core: expose MMC_CAP2_CQE* to dt
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 4 Feb 2020 08:44:13 +0800
In-Reply-To: <CAPDyKFropF-au2OTgyRL8-sO0MKXs3GtZGMqYpWpsKHtfdtpyw@mail.gmail.com>
References: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
         <CAPDyKFropF-au2OTgyRL8-sO0MKXs3GtZGMqYpWpsKHtfdtpyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmV2aWV3ICwgd2lsbCByZW1vdmUgdGhlIHRhZyBpbiB2MiBkcml2ZXIu
DQoNCk9uIE1vbiwgMjAxOS0xMS0xMSBhdCAxNDowNCArMDEwMCwgVWxmIEhhbnNzb24gd3JvdGU6
DQo+IE9uIEZyaSwgMSBOb3YgMjAxOSBhdCAwNzo0MywgQ2h1bi1IdW5nIFd1IDxjaHVuLWh1bmcu
d3VAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IEV4cG9zZSBNTUNfQ0FQMl9DUUUgYW5k
IE1NQ19DQVAyX0NRRV9EQ01EDQo+ID4gdG8gaG9zdC0+Y2FwczIgaWYNCj4gPiAxLiAic3VwcG9y
dHMtY3FlIiBpcyBkZWZpbmVkIGluIGR0IGFuZA0KPiA+IDIuICJkaXNhYmxlLWNxZS1kY21kIiBp
cyBub3QgZGVmaW5lZCBpbiBkdC4NCj4gPg0KPiA+IENoYW5nZS1JZDogSTNkMTcyZTZiY2ZhYzM0
NTIwYzM5MzJhNmY4ZGYyZTIwZjJjMGQwNWINCj4gPiBDUi1JZDoNCj4gPiBGZWF0dXJlOg0KPiAN
Cj4gUmVtb3ZlIHRoZXNlIHRhZ3MgcGxlYXNlLg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVu
LUh1bmcgV3UgPGNodW4taHVuZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvbW1jL2NvcmUvaG9zdC5jIHwgOCArKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9ob3N0
LmMgYi9kcml2ZXJzL21tYy9jb3JlL2hvc3QuYw0KPiA+IGluZGV4IDEwNWI3YTcuLmVmYjBkYmUg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9ob3N0LmMNCj4gPiArKysgYi9kcml2
ZXJzL21tYy9jb3JlL2hvc3QuYw0KPiA+IEBAIC0zMTksNiArMzE5LDE0IEBAIGludCBtbWNfb2Zf
cGFyc2Uoc3RydWN0IG1tY19ob3N0ICpob3N0KQ0KPiA+ICAgICAgICAgICAgICAgICBob3N0LT5j
YXBzMiB8PSBNTUNfQ0FQMl9OT19TRDsNCj4gPiAgICAgICAgIGlmIChkZXZpY2VfcHJvcGVydHlf
cmVhZF9ib29sKGRldiwgIm5vLW1tYyIpKQ0KPiA+ICAgICAgICAgICAgICAgICBob3N0LT5jYXBz
MiB8PSBNTUNfQ0FQMl9OT19NTUM7DQo+ID4gKyAgICAgICBpZiAoZGV2aWNlX3Byb3BlcnR5X3Jl
YWRfYm9vbChkZXYsICJzdXBwb3J0cy1jcWUiKSkNCj4gPiArICAgICAgICAgICAgICAgaG9zdC0+
Y2FwczIgfD0gTU1DX0NBUDJfQ1FFOw0KPiA+ICsNCj4gPiArICAgICAgIC8qIE11c3QgYmUgYWZ0
ZXIgInN1cHBvcnRzLWNxZSIgY2hlY2sgKi8NCj4gPiArICAgICAgIGlmICghZGV2aWNlX3Byb3Bl
cnR5X3JlYWRfYm9vbChkZXYsICJkaXNhYmxlLWNxZS1kY21kIikpIHsNCj4gPiArICAgICAgICAg
ICAgICAgaWYgKGhvc3QtPmNhcHMyICYgTU1DX0NBUDJfQ1FFKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGhvc3QtPmNhcHMyIHw9IE1NQ19DQVAyX0NRRV9EQ01EOw0KPiA+ICsgICAgICAg
fQ0KPiA+DQo+ID4gICAgICAgICAvKiBNdXN0IGJlIGFmdGVyICJub24tcmVtb3ZhYmxlIiBjaGVj
ayAqLw0KPiA+ICAgICAgICAgaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJmaXhl
ZC1lbW1jLWRyaXZlci10eXBlIiwgJmRydl90eXBlKSA9PSAwKSB7DQo+ID4gLS0NCj4gPiAxLjku
MQ0KPiA+DQo+IA0KPiBPdGhlcndpc2UsIHRoaXMgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IEtp
bmQgcmVnYXJkcw0KPiBVZmZlDQoNCg==

