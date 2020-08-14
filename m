Return-Path: <SRS0=tY5E=BY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A7CC433E3
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Aug 2020 01:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4278020838
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Aug 2020 01:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m22omvMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHNBHN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:07:13 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:63989 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726578AbgHNBHN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Aug 2020 21:07:13 -0400
X-UUID: 2aec9d0462b540bba304e8f40e82407f-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Qe393WeyTwpJe6c+m7yD4MABNjEKDyOFUs589c8xpVc=;
        b=m22omvMNlQcaTfLekQRUp2pDHJiZJKV990PLTFjzvq7GJFMhoiMxS3Df6L3t+lq1cS8+6kABz7Gb4C7alcQrKiuLXfkZ7XAiy7NI7ZcaLugjArqhbh5UyRAmkzEik7SJlkGRUU0+SqgJBRBx+kKYiDNdE+K0BIdCQcV+kiXkBlw=;
X-UUID: 2aec9d0462b540bba304e8f40e82407f-20200814
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1793749347; Fri, 14 Aug 2020 09:07:04 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 Aug
 2020 09:06:59 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 09:07:01 +0800
Message-ID: <1597367164.5891.6.camel@mhfsdcap03>
Subject: Re: [v4,0/3] mmc: mediatek: add optional reset property mmc:
 mediatek: add optional module reset property arm64: dts: mt7622: add reset
 node for mmc device Documentation/devicetree/bindings/mmc/mtk-sd.txt | 2 ++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 ++ drivers/mmc/host/mtk-sd.c |
 13 +++++++++++++ 3 files changed, 17 insertions(+)
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Fri, 14 Aug 2020 09:06:04 +0800
In-Reply-To: <195c7bfc-38e4-8d5e-af79-cc3f00b552a4@gmail.com>
References: <20200813090618.28009-1-wenbin.mei@mediatek.com>
         <195c7bfc-38e4-8d5e-af79-cc3f00b552a4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 34F81C7A311781AC5641DD657E0C145749994F76CA7B06A56DF2404E414FD9C52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

U29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlLCB0aGVyZSBpcyBubyBjaGFuZ2VzIGJldHdlZW4g
VjMgYW5kIFY0LCBWMw0KaXMgd3Jvbmcgd2l0aCBteSBzdWJqZWN0IGxpbmUsIGFuZCBWNCBmaXgg
aXQuDQpPbiBUaHUsIDIwMjAtMDgtMTMgYXQgMTU6NTQgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIg
d3JvdGU6DQo+IEl0IHdvdWxkIGJlIGdvb2QgdG8gcHJvdmlkZSBhIGxpc3Qgb2YgdGhlIGNoYW5n
ZXMsIHNvIHRoYXQgb25lIGNhbiBlYXNpbHkgDQo+IHVuZGVyc3RhbmQgd2hhdCdzIHRoZSBkaWZm
ZXJlbmNlIGJldHdlZW4gdjMgYW5kIHY0LiBPbiBhIHF1aWNrIGdsaW1wc2UgSSBkaWRuJ3QgDQo+
IHNlZSBhbnkgY2hhbmdlcy4NCj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo+IA0KPiBPbiAx
My8wOC8yMDIwIDExOjA2LCBXZW5iaW4gTWVpIHdyb3RlOg0KPiA+IC0tDQo+ID4gMi4xOC4wDQo+
ID4gDQoNCg==

