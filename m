Return-Path: <SRS0=5vaz=BW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0721C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9B220774
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 13:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kLmhXN4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgHLNEg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:04:36 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:15991 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726404AbgHLNEg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2020 09:04:36 -0400
X-UUID: 62e8e19434fb43649ef0c4e501fd66a5-20200812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2D2otIxOT5Y9TE/5sGqjyAubG2N6RpU+rS+XIzBvd5M=;
        b=kLmhXN4/Tan9ZglFsXOgX+kzqXZbJbh+v1/7gyKF7l/4j5kW4PQ27hkyvmpyMat2x+aU1pszBdKY9ibRWOFfsqlZu3SDG2H5W0FiK2F7J3AeVxFx11JgdSEUjoXzMKraquRVIs6C/mtf8pOgLsthAVHSIhJKkU9jcCHl+t4Qp18=;
X-UUID: 62e8e19434fb43649ef0c4e501fd66a5-20200812
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 328971815; Wed, 12 Aug 2020 21:04:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Aug
 2020 21:04:25 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Aug 2020 21:04:25 +0800
Message-ID: <1597237413.10188.5.camel@mhfsdcap03>
Subject: Re: [PATCH 1/3] mmc: dt-bindings: Add resets/reset-names for
 Mediatek MMC bindings
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 12 Aug 2020 21:03:33 +0800
In-Reply-To: <6e667ff6f5a1aae51b89d00e9ec5bba29852f683.camel@pengutronix.de>
References: <20200812093726.10123-1-wenbin.mei@mediatek.com>
         <20200812093726.10123-2-wenbin.mei@mediatek.com>
         <6e667ff6f5a1aae51b89d00e9ec5bba29852f683.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 88374733FA49679322C5DF06B0A77BFCA1834A5593A73B49D5804FC216869C7B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KSSBoYXZlIGNoYW5nZWQgdGhpcyBpbiB2MiBwYXRjaC4N
Ck9uIFdlZCwgMjAyMC0wOC0xMiBhdCAxNDowMyArMDIwMCwgUGhpbGlwcCBaYWJlbCB3cm90ZToN
Cj4gT24gV2VkLCAyMDIwLTA4LTEyIGF0IDE3OjM3ICswODAwLCBXZW5iaW4gTWVpIHdyb3RlOg0K
PiA+IEFkZCBkZXNjcmlwdGlvbiBmb3IgcmVzZXRzL3Jlc2V0LW5hbWVzLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFdlbmJpbiBNZWkgPHdlbmJpbi5tZWlAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC50eHQg
fCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2Qu
dHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0DQo+
ID4gaW5kZXggOGE1MzJmNDQ1M2YyLi4zNWRhNzJkZTdhYWMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0DQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0DQo+ID4gQEAg
LTQ5LDYgKzQ5LDggQEAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiAgCQkgICAgIGVycm9yIGNh
dXNlZCBieSBzdG9wIGNsb2NrKGZpZm8gZnVsbCkNCj4gPiAgCQkgICAgIFZhbGlkIHJhbmdlID0g
WzA6MHg3XS4gaWYgbm90IHByZXNlbnQsIGRlZmF1bHQgdmFsdWUgaXMgMC4NCj4gPiAgCQkgICAg
IGFwcGxpZWQgdG8gY29tcGF0aWJsZSAibWVkaWF0ZWssbXQyNzAxLW1tYyIuDQo+ID4gKy0gcmVz
ZXRzOiBQaGFuZGxlIGFuZCByZXNldCBzcGVjaWZpZXIgcGFpciB0byBzb2Z0cmVzZXQgbGluZSBv
ZiBNU0RDIElQLg0KPiA+ICstIHJlc2V0LW5hbWVzOiBSZXNldCBuYW1lcyBmb3IgTVNEQy4NCj4g
DQo+IEkgdGhpbmsgdGhlIHJlc2V0LW5hbWVzIGRvY3VtZW50YXRpb24gc2hvdWxkIG1lbnRpb24g
dGhlIGFjdHVhbCB2YWx1ZQ0KPiB0aGUgZHJpdmVyIHNob3VsZCBsb29rIGZvciwgImhyc3QiLg0K
PiANCj4gcmVnYXJkcw0KPiBQaGlsaXBwDQoNCg==

