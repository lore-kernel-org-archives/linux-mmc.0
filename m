Return-Path: <SRS0=5vaz=BW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC855C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 11:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2142065C
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 11:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nRKpy3VZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHLL6J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Aug 2020 07:58:09 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:4362 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727050AbgHLL6I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2020 07:58:08 -0400
X-UUID: 067306e7df5f4aab882d06df14bf470a-20200812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=D6lfhIK0juhubU0dZSLfqofcrBNMDDsBIY7w5I1uBv4=;
        b=nRKpy3VZDSoVi4nWSZxdi0nOaZzDOu3eon/6GKkSILA938TjEfYHJDixHbzAoEgzxAGbM6D5Gdp0yB+7/h7dwhhu9kyxCRt6f0x1YJYOT/Dcx8MDtyPE6JyZX5MzUYVeqB/0lMrsh8z/PSQxMGVXXVYfrUU5Pyusq2wS5zIICrs=;
X-UUID: 067306e7df5f4aab882d06df14bf470a-20200812
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 539316086; Wed, 12 Aug 2020 19:57:59 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Aug
 2020 19:57:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Aug 2020 19:57:58 +0800
Message-ID: <1597233424.10188.4.camel@mhfsdcap03>
Subject: Re: Aw: [PATCH 2/3] arm64: dts: mt7622: add reset node for mmc
 device
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <stable@vger.kernel.org>
Date:   Wed, 12 Aug 2020 19:57:04 +0800
In-Reply-To: <trinity-a4a4e709-ca8d-4867-8f90-d0ddbfca05cb-1597228420620@3c-app-gmx-bap56>
References: <20200812093726.10123-1-wenbin.mei@mediatek.com>
         <20200812093726.10123-3-wenbin.mei@mediatek.com>
         <trinity-a4a4e709-ca8d-4867-8f90-d0ddbfca05cb-1597228420620@3c-app-gmx-bap56>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B32ACDD6AC6B4D175228B6D78D1775133AD378FB68C06E1E2B072AAC9B9554922000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KSSB3aWxsIGFkZCB0aGlzIGluIHRoZSBuZXh0IHZlcnNp
b24uDQpPbiBXZWQsIDIwMjAtMDgtMTIgYXQgMTI6MzMgKzAyMDAsIEZyYW5rIFd1bmRlcmxpY2gg
d3JvdGU6DQo+ID4gR2VzZW5kZXQ6IE1pdHR3b2NoLCAxMi4gQXVndXN0IDIwMjAgdW0gMTE6Mzcg
VWhyDQo+ID4gVm9uOiAiV2VuYmluIE1laSIgPHdlbmJpbi5tZWlAbWVkaWF0ZWsuY29tPg0KPiA+
IEJldHJlZmY6IFtQQVRDSCAzLzNdIG1tYzogbWVkaWF0ZWs6IGFkZCBvcHRpb25hbCBtb2R1bGUg
cmVzZXQgcHJvcGVydHkNCj4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIGEgb3B0aW9uYWwgcmVzZXQg
bWFuYWdlbWVudCBmb3IgbXNkYy4NCj4gPiBTb21ldGltZXMgdGhlIGJvb3Rsb2FkZXIgZG9lcyBu
b3QgYnJpbmcgbXNkYyByZWdpc3Rlcg0KPiA+IHRvIGRlZmF1bHQgc3RhdGUsIHNvIG5lZWQgcmVz
ZXQgdGhlIG1zZGMgY29udHJvbGxlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbmJpbiBN
ZWkgPHdlbmJpbi5tZWlAbWVkaWF0ZWsuY29tPg0KPiANCj4gVGhhbmtzIGZvciBwb3N0aW5nIHRo
ZSBmaXggdG8gTWFpbmxpbmUNCj4gc2FtZSBhcyAzLzMsIGR0cy1wYXRjaCBpcyBhbHNvIG5lZWRl
ZCBmb3IgZml4aW5nIGVNTUMtSXNzdWUgb24gUjY0DQo+IA0KPiBGaXhlczogOTY2NTgwYWQyMzZl
ICgibW1jOiBtZWRpYXRlazogYWRkIHN1cHBvcnQgZm9yIE1UNzYyMiBTb0MiKQ0KPiBUZXN0ZWQt
Qnk6IEZyYW5rIFd1bmRlcmxpY2ggPGZyYW5rLXdAcHVibGljLWZpbGVzLmRlPg0KPiANCj4gYW5k
IGl0IG5lZWRzIHRvIGJlIGZpeGVkIGF0IGxlYXN0IGZvciA1LjQrLCBzbyBhZGRpbmcgc3RhYmxl
LUNDDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KDQo=

