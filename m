Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30343C3F2C6
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 23:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F342E24679
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 23:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y+LkSq/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCIXVN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:21:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55010 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726698AbgCIXVN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Mar 2020 19:21:13 -0400
X-UUID: 1624f9f01a604613bd62eb2b8e1aca56-20200310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/ML3Ledtqy4m3bKFwbFWPyytmDkR4UuhLn++0IipQ84=;
        b=Y+LkSq/54wUygpz2HTCRiMO68JO39kSH/LYYXlQpDe7OdiNW5lD1yis3agyiM1ms4CdW8712f4Mfla2EEo3pXxdSwU2v9RSoDQ029EtGsRqJHvIesuCUu6rpOEUcJCLXIRCVrQrKeB0kThjySKFWVtS8CZFjsbw41yUkpkVyxGk=;
X-UUID: 1624f9f01a604613bd62eb2b8e1aca56-20200310
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 720479230; Tue, 10 Mar 2020 07:21:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Mar 2020 07:19:53 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Mar 2020 07:18:21 +0800
Message-ID: <1583796065.23665.8.camel@mtkswgap22>
Subject: Re: [PATCH 1/4] [1/4] mmc: core: expose MMC_CAP2_CQE* to dt
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Pavel Machek" <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 10 Mar 2020 07:21:05 +0800
In-Reply-To: <CACRpkdauCe-zAcsO5q_79+Ux_a2=bktA5UqKjWs4XdBJZ3wWeg@mail.gmail.com>
References: <1581921111-24172-1-git-send-email-chun-hung.wu@mediatek.com>
         <1581921111-24172-2-git-send-email-chun-hung.wu@mediatek.com>
         <CACRpkdauCe-zAcsO5q_79+Ux_a2=bktA5UqKjWs4XdBJZ3wWeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTIxIGF0IDE1OjMzICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBPbiBNb24sIEZlYiAxNywgMjAyMCBhdCA3OjMyIEFNIENodW4tSHVuZyBXdSA8Y2h1bi1odW5n
Lnd1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEV4cG9zZSBNTUNfQ0FQMl9DUUUgYW5k
IE1NQ19DQVAyX0NRRV9EQ01EDQo+ID4gdG8gaG9zdC0+Y2FwczIgaWYNCj4gPiAxLiAic3VwcG9y
dHMtY3FlIiBpcyBkZWZpbmVkIGluIGR0IGFuZA0KPiA+IDIuICJkaXNhYmxlLWNxZS1kY21kIiBp
cyBub3QgZGVmaW5lZCBpbiBkdC4NCj4gPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3Jl
L2hvc3QuYyB8IDggKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvaG9zdC5jIGIvZHJpdmVy
cy9tbWMvY29yZS9ob3N0LmMNCj4gPiBpbmRleCAxMDViN2E3Li5lZmIwZGJlIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29y
ZS9ob3N0LmMNCj4gPiBAQCAtMzE5LDYgKzMxOSwxNCBAQCBpbnQgbW1jX29mX3BhcnNlKHN0cnVj
dCBtbWNfaG9zdCAqaG9zdCkNCj4gPiAgICAgICAgICAgICAgICAgaG9zdC0+Y2FwczIgfD0gTU1D
X0NBUDJfTk9fU0Q7DQo+ID4gICAgICAgICBpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChk
ZXYsICJuby1tbWMiKSkNCj4gPiAgICAgICAgICAgICAgICAgaG9zdC0+Y2FwczIgfD0gTU1DX0NB
UDJfTk9fTU1DOw0KPiA+ICsgICAgICAgaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2
LCAic3VwcG9ydHMtY3FlIikpDQo+ID4gKyAgICAgICAgICAgICAgIGhvc3QtPmNhcHMyIHw9IE1N
Q19DQVAyX0NRRTsNCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgdGhpcyBpcyBldmVuIGEg
RFQgcHJvcGVydHkgYXMgaXQgc2hvdWxkDQo+IGJlIGNsZWFyIGZyb20gdGhlIGhvc3RzIGNvbXBh
dGlibGUgd2hldGhlciBpdCBzdXBwb3J0cyBDUUUgb3INCj4gbm90LiBCdXQgaXQncyB0b28gbGF0
ZSB0byBkbyBhbnl0aGluZyBhYm91dCB0aGF0IEkgc3VwcG9zZSwgYW5kDQo+IEkganVzdCBhc3N1
bWUgdGhlcmUgaXMgc29tZXRoaW5nIEkgZG9uJ3QgdW5kZXJzdGFuZCBoZXJlLg0KInN1cHBvcnRz
LWNxZSIgYXMgbXkgdW5kZXJzdGFuZGluZyBpcyBsaWtlIEhTNDAwIEhTMjAwIGlzIGEgaG9zdA0K
Y2FwYWJpbGl0eS4NCj4gDQo+ID4gKyAgICAgICAvKiBNdXN0IGJlIGFmdGVyICJzdXBwb3J0cy1j
cWUiIGNoZWNrICovDQo+ID4gKyAgICAgICBpZiAoIWRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2wo
ZGV2LCAiZGlzYWJsZS1jcWUtZGNtZCIpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChob3N0
LT5jYXBzMiAmIE1NQ19DQVAyX0NRRSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBob3N0
LT5jYXBzMiB8PSBNTUNfQ0FQMl9DUUVfRENNRDsNCj4gPiArICAgICAgIH0NCj4gDQo+IFRoaXMg
aXMgdGhlIHJpZ2h0IHBsYWNlIHRvIGRvIHRoaXMgSSBzdXBwb3NlLiBEaXNhYmxpbmcgQ1FFDQo+
IHNlbGVjdGl2ZWx5IGlzIHNvbWV0aGluZyB5b3UgbWlnaHQgd2FubmEgZG8gZm9yIGRlYnVnZ2lu
Zy4NCj4gQWNrZWQtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4N
Cj4gDQo+IEkgc2VlIHRoYXQgc29tZSBkcml2ZXJzIGFyZSBhbHJlYWR5IHBhcnNpbmcgdGhpcyBE
VCBwcm9wZXJ0eQ0KPiBvbiB0aGVpciBvd24sIHNob3VsZCB3ZSBmb2xsb3cgdXAgd2l0aCBwYXRj
aGVzIHNvIHRoYXQgdGhlc2U6DQo+IA0KPiAkIGdpdCBncmVwICdzdXBwb3J0cy1jcWUnDQo+IGRy
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktYnJjbXN0Yi5jOiAgICAgICBpZg0KPiAoZGV2aWNlX3Byb3Bl
cnR5X3JlYWRfYm9vbCgmcGRldi0+ZGV2LCAic3VwcG9ydHMtY3FlIikpIHsNCj4gZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1tc20uYzogICBpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29sKG5vZGUsICJz
dXBwb3J0cy1jcWUiKSkNCj4gZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jOiBpZg0KPiAo
ZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChob3N0LT5tbWMtPnBhcmVudCwgInN1cHBvcnRzLWNx
ZSIpKQ0KPiANCj4gTWFrZSB1c2Ugb2YgdGhlIGNlbnRyYWwgcGFyc2luZyBpbnN0ZWFkPw0KSW4g
djQsIEkgd2lsbCByZW1vdmUgdGhlIHZlbmRvciBkcml2ZXIgZHQgc2V0dGluZyBhbmQgdXNlIGNl
bnRyYWwNCnBhcnNpbmcgaW5zdGVhZC4NCj4gDQo+IFlvdXJzLA0KPiBMaW51cyBXYWxsZWlqDQoN
Cg==

