Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CFBC10F29
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA2124676
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 23:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bYRxQJGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgCIXN1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:13:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12534 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726698AbgCIXN1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Mar 2020 19:13:27 -0400
X-UUID: c5945c5d6e914d9d90309112c014e37c-20200310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yigWAdDzv9r+S5GMZO74ScT7GTvj1to3DrOUWOXQiqM=;
        b=bYRxQJGTor2cEyu0b4p68KvVEIKPbHe8SD0eq3FIKH4z6YdS/Ng60zRmPUlXs9vqfeI5fxhuQbrnOEr3gbag8M1V91cbhNKmU2h0yxoe33RiN22bn/BMMjC/2hVHRCDeTaXlPntKmXOyQCixQovtPYMt84BukjEiFRorHdggwSQ=;
X-UUID: c5945c5d6e914d9d90309112c014e37c-20200310
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1993803255; Tue, 10 Mar 2020 07:13:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Mar 2020 07:12:07 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Mar 2020 07:10:36 +0800
Message-ID: <1583795599.23665.4.camel@mtkswgap22>
Subject: Re: [PATCH v3 1/4] mmc: core: expose MMC_CAP2_CQE* to dt
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
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 10 Mar 2020 07:13:19 +0800
In-Reply-To: <CAPDyKFpyah+oA-GtXNmdkrhwnGN_syU1JqRHn-9gk=HK0fV8EQ@mail.gmail.com>
References: <1581922564-24914-1-git-send-email-chun-hung.wu@mediatek.com>
         <1581922564-24914-2-git-send-email-chun-hung.wu@mediatek.com>
         <CAPDyKFpyah+oA-GtXNmdkrhwnGN_syU1JqRHn-9gk=HK0fV8EQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTA0IGF0IDE0OjA0ICswMTAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gTW9uLCAxNyBGZWIgMjAyMCBhdCAwNzo1NiwgQ2h1bi1IdW5nIFd1IDxjaHVuLWh1bmcud3VA
bWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IEV4cG9zZSBNTUNfQ0FQMl9DUUUgYW5kIE1N
Q19DQVAyX0NRRV9EQ01EDQo+ID4gdG8gaG9zdC0+Y2FwczIgaWYNCj4gPiAxLiAic3VwcG9ydHMt
Y3FlIiBpcyBkZWZpbmVkIGluIGR0IGFuZA0KPiA+IDIuICJkaXNhYmxlLWNxZS1kY21kIiBpcyBu
b3QgZGVmaW5lZCBpbiBkdC4NCj4gDQo+IEJvdGggb2YgdGhlc2UgRFQgcHJvcGVydGllcyBhcmUg
ZGVmaW5lZCBhcyBjb21tb24gbW1jIERUIHByb3BlcnRpZXMsDQo+IHNvIHRoZSBhYm92ZSBpc24n
dCByZWFsbHkgY29ycmVjdC4gUGxlYXNlIGNsYXJpZnkgdGhpcy4NClllcywgdGhlIHByb3BlcnRp
ZXMgaXMgY29tbW9uLiBCdXQgSSB0aGluayB0aGUgInN1cHBvcnRzLWNxZSIgb3INCiJkaXNhYmxl
LWNxZS1kY21kIiBpcyBkZWZpbmVkIGluIHZlbmRvcidzIG1tYyBkdCwgbm90IGNvbW1vbiBtbWMg
ZHQ/DQpEb24ndCBrbm93IHdoYXQncyB3cm9uZyB3aXRoIHRoZSBhYm92ZSBkZXNjcmlwdGlvbiwg
YW55IHN1Z2dlc3Rpb24/DQo+IA0KPiBNb3Jlb3ZlciwgSSBzdWdnZXN0IHRvIHVwZGF0ZSBjb21t
aXQgbWVzc2FnZSBoZWFkZXIgaW50byAibW1jOiBjb3JlOg0KPiBFeHRlbmQgbW1jX29mX3BhcnNl
KCkgdG8gcGFyc2UgQ1FFIGJpbmRpbmdzIiwgYXMgSSB0aGluayBpdCBiZXR0ZXINCj4gZGVzY3Jp
YmVzIHRoZSBjaGFuZ2UuDQpUaGFua3MsIEkgdGhpbmsgdGhlIGNvbW1pdCBtZXNzYWdlIHlvdSBw
cm92aWRlIGlzIGJldHRlciwgd2lsbCBjaGFuZ2UgaXQNCmluIHY0Lg0KPiANCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IENodW4tSHVuZyBXdSA8Y2h1bi1odW5nLnd1QG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9ob3N0LmMgfCA4ICsrKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9jb3JlL2hvc3QuYyBiL2RyaXZlcnMvbW1jL2NvcmUvaG9zdC5jDQo+ID4gaW5kZXgg
MTA1YjdhNy4uZWZiMGRiZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2hvc3Qu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvaG9zdC5jDQo+ID4gQEAgLTMxOSw2ICszMTks
MTQgQEAgaW50IG1tY19vZl9wYXJzZShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQo+ID4gICAgICAg
ICAgICAgICAgIGhvc3QtPmNhcHMyIHw9IE1NQ19DQVAyX05PX1NEOw0KPiA+ICAgICAgICAgaWYg
KGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LCAibm8tbW1jIikpDQo+ID4gICAgICAgICAg
ICAgICAgIGhvc3QtPmNhcHMyIHw9IE1NQ19DQVAyX05PX01NQzsNCj4gPiArICAgICAgIGlmIChk
ZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwgInN1cHBvcnRzLWNxZSIpKQ0KPiA+ICsgICAg
ICAgICAgICAgICBob3N0LT5jYXBzMiB8PSBNTUNfQ0FQMl9DUUU7DQo+ID4gKw0KPiA+ICsgICAg
ICAgLyogTXVzdCBiZSBhZnRlciAic3VwcG9ydHMtY3FlIiBjaGVjayAqLw0KPiA+ICsgICAgICAg
aWYgKCFkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwgImRpc2FibGUtY3FlLWRjbWQiKSkg
ew0KPiA+ICsgICAgICAgICAgICAgICBpZiAoaG9zdC0+Y2FwczIgJiBNTUNfQ0FQMl9DUUUpDQo+
IA0KPiBEb2VzIGl0IHJlYWxseSBkb2Vzbid0IG1hdHRlciBpZiB3ZSBzZXQgdGhpcyBjYXAsIGV2
ZW4gaWYgTU1DX0NBUDJfQ1FFDQo+IGlzbid0IHNldD8gWW91IGNhbiBwcm9iYWJseSBza2lwIHRo
ZSBjaGVjayBhYm92ZS4NCldpbGwgcmVtb3ZlIE1NQ19DQVAyX0NRRSBjaGVjayBoZXJlLg0KPiAN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBob3N0LT5jYXBzMiB8PSBNTUNfQ0FQMl9DUUVf
RENNRDsNCj4gPiArICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgLyogTXVzdCBiZSBhZnRlciAi
bm9uLXJlbW92YWJsZSIgY2hlY2sgKi8NCj4gPiAgICAgICAgIGlmIChkZXZpY2VfcHJvcGVydHlf
cmVhZF91MzIoZGV2LCAiZml4ZWQtZW1tYy1kcml2ZXItdHlwZSIsICZkcnZfdHlwZSkgPT0gMCkg
ew0KPiA+IC0tDQo+ID4gMS45LjENCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQoNCg==

