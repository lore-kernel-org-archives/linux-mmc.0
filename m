Return-Path: <SRS0=xq36=CY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A44C43461
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA509214F1
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mRWJ9u/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIOGNp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 02:13:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60935 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbgIOGNX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 02:13:23 -0400
X-UUID: 61a54eaa15114ee4a38fa7e6543d8208-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hDwwvEKbQNKWFsUY6/pT152QsMoq9kreFwlKpG3Sd6o=;
        b=mRWJ9u/W1Nr9nefrC8hJivdEUw4G/MKEzNyfkvsKglbUNCdERT0vH0dBi4qOlHMJi169qRvIkbwzm9HhPFk2Z/d7V4dNNHZQ/yRGadzKZbyWKGU8vW34CZK4OIEiptoTxhMPEskakJjoPM9451VP0RA9O6T4YNX0aSEsBYS8zAE=;
X-UUID: 61a54eaa15114ee4a38fa7e6543d8208-20200915
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1287823956; Tue, 15 Sep 2020 14:13:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Sep 2020 14:13:19 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 14:13:18 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [RESEND 0/3] Add mmc support for MT8192 SoC
Date:   Tue, 15 Sep 2020 14:11:07 +0800
Message-ID: <20200915061110.25833-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

V2VuYmluIE1laSAoMyk6DQogIG1tYzogZHQtYmluZGluZ3M6IGFkZCBzdXBwb3J0IGZvciBNVDgx
OTIgU29DDQogIGFybTY0OiBkdHM6IG10ODE5MjogYWRkIG1tYyBkZXZpY2Ugbm9kZQ0KICBtbWM6
IG1lZGlhdGVrOiBBZGQgc3Vic3lzIGNsb2NrIGNvbnRyb2wgZm9yIE1UODE5MiBtc2RjDQotLS0N
ClRoaXMgcGF0Y2ggZGVwZW5kcyBvbg0KW3Y0LDEvM10gYXJtNjQ6IGR0czogQWRkIE1lZGlhdGVr
IFNvQyBNVDgxOTIgYW5kIGV2YWx1YXRpb24gYm9hcmQgZHRzIGFuZCBNYWtlZmlsZQ0KW3YzLDEv
OV0gZHQtYmluZGluZ3M6IEFSTTogTWVkaWF0ZWs6IERvY3VtZW50IGJpbmRpbmdzIGZvciBNVDgx
OTIgQlNQDQpbdjMsNi85XSBjbGs6IG1lZGlhdGVrOiBBZGQgZHQtYmluZGluZ3MgZm9yIE1UODE5
MiBjbG9ja3MNClt2Myw5LzldIGNsazogbWVkaWF0ZWs6IEFkZCBNVDgxOTIgY2xvY2sgc3VwcG9y
dA0KW3YzLDEvM10gZHQtYmluZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIHBpbmN0cmwgZmls
ZQ0KW3YzLDIvM10gZHQtYmluZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIGJpbmRpbmcgZG9j
dW1lbnQNClt2MywzLzNdIHBpbmN0cmw6IGFkZCBwaW5jdHJsIGRyaXZlciBvbiBtdDgxOTINClt2
MiwxLzRdIHNvYzogbWVkaWF0ZWs6IHB3cmFwOiB1c2UgQklUKCkgbWFjcm8NClt2MiwyLzRdIHNv
YzogbWVkaWF0ZWs6IHB3cmFwOiBhZGQgYXJiaXRlciBjYXBhYmlsaXR5DQpbdjIsMy80XSBkdC1i
aW5kaW5nczogbWVkaWF0ZWs6IGFkZCBjb21wYXRpYmxlIGZvciBNVDY4NzMvODE5MiBwd3JhcA0K
W3YyLDQvNF0gc29jOiBtZWRpYXRlazogcHdyYXA6IGFkZCBwd3JhcCBkcml2ZXIgZm9yIE1UNjg3
My84MTkyIFNvQ3MNClsyLzhdIGR0LWJpbmRpbmdzOiBtZmQ6IEFkZCBjb21wYXRpYmxlIGZvciB0
aGUgTWVkaWFUZWsgTVQ2MzU5IFBNSUMNClszLzhdIGR0LWJpbmRpbmdzOiByZWd1bGF0b3I6IEFk
ZCBkb2N1bWVudCBmb3IgTVQ2MzU5IHJlZ3VsYXRvcg0KWzQvOF0gbWZkOiBBZGQgc3VwcG9ydCBm
b3IgdGhlIE1lZGlhVGVrIE1UNjM1OSBQTUlDDQpbNS84XSByZWd1bGF0b3I6IG10NjM1OTogQWRk
IHN1cHBvcnQgZm9yIE1UNjM1OSByZWd1bGF0b3INCls3LzhdIHJlZ3VsYXRvcjogbXQ2MzU5OiBB
ZGQgc3VwcG9ydCBmb3IgTVQ2MzU5UCByZWd1bGF0b3INCls4LzhdIGFybTY0OiBkdHM6IG10NjM1
OTogYWRkIFBNSUMgTVQ2MzU5IHJlbGF0ZWQgbm9kZXMNCg0KUGxlYXNlIGFsc28gYWNjZXB0IHRo
aXMgcGF0Y2ggdG9nZXRoZXIgd2l0aCBbMV1bMl1bM11bNF1bNV0NCnRvIGF2b2lkIGJ1aWxkIGFu
ZCBkdCBiaW5kaW5nIGNoZWNrIGVycm9yLg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzMyNjIxDQpbMl0gaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmll
cz0zNDI1OTMNClszXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgt
bWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTMzMDAxNw0KWzRdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzIyOTM3DQpbNV0gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nl
cmllcz0zMjMxNzENCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0
ICAgICAgICB8ICA2ICstDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTItZXZi
LmR0cyAgIHwgODkgKysrKysrKysrKysrKysrKysrKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTkyLmR0c2kgICAgICB8IDM0ICsrKysrKysNCiBkcml2ZXJzL21tYy9ob3N0L210
ay1zZC5jICAgICAgICAgICAgICAgICAgICAgfCA3NyArKysrKysrKysrKystLS0tDQogNCBmaWxl
cyBjaGFuZ2VkLCAxODcgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQoNCi0tDQoyLjE4
LjANCg0K

