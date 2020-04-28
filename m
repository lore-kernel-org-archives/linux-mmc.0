Return-Path: <SRS0=tofm=6M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30CBC83000
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 09:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAF820663
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 09:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B20eOiTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgD1J2V (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:28:21 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:13345 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727052AbgD1J2U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Apr 2020 05:28:20 -0400
X-UUID: 4a60755f4a87498cac1ad9f5b1dafff0-20200428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=m3Ksv+ksgjGvXF0pXLMlpIAwkf0dzAHmcRs39NPBbsk=;
        b=B20eOiTh7l/29srMJjLhvV6XU6dgavF3w0G5qapIRMzTQERJSWLXte/kGX19TPu/goL6PaCf7AHznx0QVxyIeSgqbT45LX3rChPq6vEVyB9bS9Rd/VaAToJ3TVslxM5LKvd+tiBhtlPazL2156Yd0Q/+9usO3eRk207zoAz0/XM=;
X-UUID: 4a60755f4a87498cac1ad9f5b1dafff0-20200428
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2093172434; Tue, 28 Apr 2020 17:28:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 28 Apr
 2020 17:28:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Apr 2020 17:28:04 +0800
Message-ID: <1588066038.30914.28.camel@mhfsdcap03>
Subject: Re: [PATCH 1/3] mmc: core: need do mmc_power_cycle in
 mmc_sdio_resend_if_cond
From:   "yong.mao@mediatek.com" <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <mka@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Tue, 28 Apr 2020 17:27:18 +0800
In-Reply-To: <CAPDyKFo40tBpowmWN3gxH8b=jMmCK8O5ALNQ7y6XZ5AosX=GUA@mail.gmail.com>
References: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
         <1586835611-13857-2-git-send-email-yong.mao@mediatek.com>
         <CAPDyKFo40tBpowmWN3gxH8b=jMmCK8O5ALNQ7y6XZ5AosX=GUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BAFC90E4F4919F58F4A0398CAB2A7E72863110198F1657AD58274E69C3418E782000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMDQtMjQgYXQgMTI6MDkgKzAyMDAsIFVsZiBIYW5zc29uIHdyb3RlOg0K
PiBPbiBUdWUsIDE0IEFwciAyMDIwIGF0IDA1OjQwLCBZb25nIE1hbyA8eW9uZy5tYW9AbWVkaWF0
ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IHlvbmcgbWFvIDx5b25nLm1hb0BtZWRpYXRl
ay5jb20+DQo+ID4NCj4gPiBXaGVuIG1tY19zZGlvX3Jlc25lZF9pZl9jb25kIGlzIGludm9rZWQs
IGl0IGluZGljYXRlcyB0aGUgU0RJTw0KPiA+IGRldmljZSBpcyBub3QgaW4gdGhlIHJpZ2h0IHN0
YXRlLiBJbiB0aGlzIGNvbmRpdGlvbiwgdGhlIHByZXZpb3VzDQo+ID4gaW1wbGVtZW50YXRpb24g
b2YgbW1jX3NkaW9fcmVzZW5kX2lmX2NvbmQgY2FuJ3QgbWFrZSBzdXJlIFNESU8NCj4gPiBkZXZp
Y2UgYmUgYmFjayB0byBpZGxlIHN0YXRlLiBtbWNfcG93ZXJfY3ljbGUgY2FuIHJlc2V0IHRoZSBT
RElPDQo+ID4gZGV2aWNlIGJ5IEhXIGFuZCBhbHNvIG1ha2Ugc3VyZSBTRElPIGRldmljZSBlbnRl
ciB0byBpZGxlIHN0YXRlDQo+ID4gY29ycmVjdGx5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
WW9uZyBNYW8gPHlvbmcubWFvQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9t
bWMvY29yZS9zZGlvLmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgYi9kcml2ZXJz
L21tYy9jb3JlL3NkaW8uYw0KPiA+IGluZGV4IGViYjM4N2EuLmFkYTBhODAgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3Jl
L3NkaW8uYw0KPiA+IEBAIC01NDYsNiArNTQ2LDcgQEAgc3RhdGljIGludCBtbWNfc2Rpb19pbml0
X3Voc19jYXJkKHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkNCj4gPiAgc3RhdGljIHZvaWQgbW1jX3Nk
aW9fcmVzZW5kX2lmX2NvbmQoc3RydWN0IG1tY19ob3N0ICpob3N0LA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkNCj4gPiAgew0K
PiA+ICsgICAgICAgbW1jX3Bvd2VyX2N5Y2xlKGhvc3QsIGhvc3QtPmNhcmQtPm9jcik7DQo+IA0K
PiBUaGlzIGxvb2tzIHdyb25nIHRvIG1lLiBtbWNfc2Rpb19yZXNlbmRfaWZfY29uZCgpIGlzIGNh
bGxlZCBmcm9tIHR3byBwbGFjZXMuDQo+IA0KPiAxLiBJbiB0aGUgY2FzZSB3aGVuIG1tY19zZXRf
dWhzX3ZvbHRhZ2UoKSBmYWlscyBpbg0KPiBtbWNfc2Rpb19pbml0X2NhcmQoKSwgd2hpY2ggbWVh
bnMgYSBjYWxsIHRvIG1tY19wb3dlcl9jeWNsZSgpIGhhcw0KPiBhbHJlYWR5IGJlZW4gZG9uZS4N
Cj4gDQogIFRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KICBZZXMuIEl0IGlzIHJpZ2h0IHRoYXQg
bW1jX3Bvd2VyX2N5Y2xlKCkgaGFzIGFscmVhZHkgYmVlbiBkb25lIHdoZW4NCiAgbW1jX3NkaW9f
cmVzZW5kX2lmX2NvbmQoKSBpcyBjYWxsZWQuIEluIG5vcm1hbCByZS1pbml0aWFsaXphdGlvbiBj
YXNlLCANCiAgdGhpcyBtbWNfcG93ZXJfY3ljbGUoKSAoY3VycmVudGx5IGluIDEuOHYgdm9sdGFn
ZSBhbmQgMjA4TWh6IGNsb2NrKSANCiAgY2FuIG1ha2UgU0RJTyBkZXZpY2UgcmVhbGx5IGJhY2sg
dG8gaWRsZSBzdGF0ZS4gVW5mb3J0dW5hdGVseSwgaW4gc29tZQ0KICBzcGVjaWFsIFNESU8gZGV2
aWNlLCBpdCB3aWxsIGVudGVyIHRvIHVuc3RhYmxlIHN0YXRlLg0KDQogIEF0IHRoaXMgdW5zdGFi
bGUgc3RhdGUsIGRldmljZSBtYXkga2VlcCBkYXRhMCBhbHdheXMgbG93IGFmdGVyIHJlY2Vpdmlu
ZyBDTUQxMS4NCiAgQW5kIHRoZW4gZXZlcnkgb3RoZXIgU0RJTyBDTUQgY2FuJ3QgYmUgc2VudCB0
byBkZXZpY2UgYW55IG1vcmUgZHVlIHRvIGNhcmQgDQogIGlzIGJ1c3koZGF0YTAgaXMgbG93KS4g
VGhlcmVmb3JlLCBwcmV2aW91cyBpbXBsZW1lbnRhdGlvbiBjYW4ndCBzYXZlIHRoZSANCiAgZGV2
aWNlLiBBdCB0aGlzIHRpbWUsIG1tY19wb3dlcl9jeWNsZSgpIG1heSBiZSB0aGUgZmluYWwgc29s
dXRpb24gdG8gbWFrZSANCiAgc3VyZSBTRElPIGRldmljZSBjYW4gYmFjayB0byBpZGxlIHN0YXRl
IGNvcnJlY3RseS4NCg0KPiAyLiBXZW4gc2Rpb19yZWFkX2NjY3IoKSBmYWlscyBhbmQgd2hlbiB3
ZSBkZWNpZGUgdG8gcmV0cnkgdGhlIFVIUy1JDQo+IHZvbHRhZ2Ugc3dpdGNoLiBUaGVuIHBlcmhh
cHMgaXQgY291bGQgbWFrZSBzZW5zZSB0byBydW4gYSBwb3dlciBjeWNsZS4NCj4gQnV0IGlmIHNv
LCB3ZSBiZXR0ZXIgZG8gaXQgb25seSBmb3IgdGhhdCBwYXRoLg0KPiANCj4gSSB3aWxsIGNvbnRp
bnVlIHRvIGxvb2sgYSBiaXQsIGFzIEkgdGhpbmsgdGhlcmUgYXJlIHJlYWxseSBtb3JlIGlzc3Vl
cw0KPiB0aGF0IHdlIG1heSB3YW50IHRvIGxvb2sgaW50byB3aGlsZSBsb29raW5nIGF0IHRoaXMg
cGllY2Ugb2YgY29kZS4NCj4gSG93ZXZlciwgYWxsb3cgbWUgc29tZSBtb3JlIHRpbWUgYmVmb3Jl
IEkgY2FuIHByb3ZpZGUgc29tZSBtb3JlIGlkZWFzDQo+IG9mIGhvdyB0byBtb3ZlIGZvcndhcmQu
DQogIEluIHRoZSBhY3R1YWwgcHJvamVjdCwgd2UgZG8gZW5jb3VudGVyIG1hbnkgcmVsYXRpdmUg
aXNzdWVzIGFib3V0IHJlLWluaXRpYWxpemVkIGNhcmQuDQogIFRoZSBmb2xsb3dpbmcgdHdvIGNh
dGVnb3JpZXMgYXJlIHRoZSBtb3N0IGNvbW1vbiBpc3N1ZSB3ZSBtZXQgYmVmb3JlLg0KICBBLiB0
aGUgU0RJTyBjYXJkIGlzIGluaXRpYWxpemVkIGJ5IFVIUy1JIG1vZGUgYXQgdGhlIGZpcnN0IHRp
bWUsIGJ1dCB3aWxsIGJlIA0KICAgICByZS1pbml0aWFsaXplZCBieSBIaWdoIFNwZWVkIG1vZGUg
YXQgdGhlIHNlY29uZCB0aW1lLg0KICAgICA9PT4gQWxsIHRoaXMgdHlwZSBvZiBpc3N1ZXMgaXMg
cmVsYXRpdmUgd2l0aCBTMThBIGluIHJlc3BvbnNlIG9mIENNRDUuDQoJIEFuZCBtb3N0IG9mIHRo
ZSBpc3N1ZXMgYXJlIHJlbGF0ZWQgdG8gdGhlIGludGVydmFsIGJldHdlZW4gcG93ZXJpbmcgb2Zm
IGFuZCANCiAgICAgICAgIHBvd2VyaW5nIG9uIGNhcmQuDQogIEIuIElmIHRoZXJlIGlzIHNvbWV0
aGluZyB3cm9uZyBpbiB0aGUgZmxvdyBvZiB2b2x0YWdlIHN3aXRjaChhZnRlciBDTUQxMSksIGNh
cmQgd2lsbA0KICAgICBhbHdheXMga2VlcCBhbGwgZGF0YSBwaW5zIHRvIGxvdy4gQW5kIHRoZW4g
aXQgaGFuZ3MgdXAgYmVjYXVzZSBkYXRhMCBpcyBhbHdheXMgbG93Lg0KICBIb3BlIHRoaXMgaW5m
b3JtYXRpb24gd2lsbCBiZSBoZWxwZnVsIGZvciB5b3UuDQogIA0KICBBbnl3YXksIHdlIHdpbGwg
d2FpdCBmb3IgeW91ciBhZHZpc2VzLiANCj4gDQo+ID4gICAgICAgICBzZGlvX3Jlc2V0KGhvc3Qp
Ow0KPiA+ICAgICAgICAgbW1jX2dvX2lkbGUoaG9zdCk7DQo+ID4gICAgICAgICBtbWNfc2VuZF9p
Zl9jb25kKGhvc3QsIGhvc3QtPm9jcl9hdmFpbCk7DQo+ID4gLS0NCj4gPiAxLjkuMQ0KPiANCj4g
S2luZCByZWdhcmRzDQo+IFVmZmUNCg0KDQoNCg==

