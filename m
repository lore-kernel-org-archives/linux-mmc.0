Return-Path: <SRS0=xq36=CY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C1C2D0E0
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EA9206B2
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UDw6mJW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgIOGAw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 02:00:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53796 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726145AbgIOGAu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 02:00:50 -0400
X-UUID: 131ba829433f47828098d18645ce00a5-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=X8Z5QB7G03Bfi4YPnNUVk/455t8rUc87yOD3C0YOlFc=;
        b=UDw6mJW3/6WPLLn2MutNScXMexqbsbxpIj3VpjBsE8P1AI9mZAtgbSArRiYlYCDZr8pR5ffQV2Ee4Ruz6QvR2YDRE/4O6zP1+kVRQKQeD6kpmPhT8u5rRBBsqbbAJqO5S4KXYuZwk+7ubxi1czczW6ZPIcalkIGvF4q+meBq46A=;
X-UUID: 131ba829433f47828098d18645ce00a5-20200915
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1500331392; Tue, 15 Sep 2020 14:00:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Sep 2020 14:00:42 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 14:00:42 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 0/3] Add mmc support for MT8192 SoC
Date:   Tue, 15 Sep 2020 13:58:32 +0800
Message-ID: <20200915055835.25590-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQpXZW5iaW4gTWVpICgzKToNCiAgbW1jOiBkdC1iaW5kaW5nczogYWRkIHN1cHBvcnQgZm9yIE1U
ODE5MiBTb0MNCiAgYXJtNjQ6IGR0czogbXQ4MTkyOiBhZGQgbW1jIGRldmljZSBub2RlDQogIG1t
YzogbWVkaWF0ZWs6IEFkZCBzdWJzeXMgY2xvY2sgY29udHJvbCBmb3IgTVQ4MTkyIG1zZGMNCi0t
LQ0KVGhpcyBwYXRjaCBkZXBlbmRzIG9uDQpbdjQsMS8zXSBhcm02NDogZHRzOiBBZGQgTWVkaWF0
ZWsgU29DIE1UODE5MiBhbmQgZXZhbHVhdGlvbiBib2FyZCBkdHMgYW5kIE1ha2VmaWxlDQpbdjMs
MS85XSBkdC1iaW5kaW5nczogQVJNOiBNZWRpYXRlazogRG9jdW1lbnQgYmluZGluZ3MgZm9yIE1U
ODE5MiBCU1ANClt2Myw2LzldIGNsazogbWVkaWF0ZWs6IEFkZCBkdC1iaW5kaW5ncyBmb3IgTVQ4
MTkyIGNsb2Nrcw0KW3YzLDkvOV0gY2xrOiBtZWRpYXRlazogQWRkIE1UODE5MiBjbG9jayBzdXBw
b3J0DQpbdjMsMS8zXSBkdC1iaW5kaW5nczogcGluY3RybDogbXQ4MTkyOiBhZGQgcGluY3RybCBm
aWxlDQpbdjMsMi8zXSBkdC1iaW5kaW5nczogcGluY3RybDogbXQ4MTkyOiBhZGQgYmluZGluZyBk
b2N1bWVudA0KW3YzLDMvM10gcGluY3RybDogYWRkIHBpbmN0cmwgZHJpdmVyIG9uIG10ODE5Mg0K
W3YyLDEvNF0gc29jOiBtZWRpYXRlazogcHdyYXA6IHVzZSBCSVQoKSBtYWNybw0KW3YyLDIvNF0g
c29jOiBtZWRpYXRlazogcHdyYXA6IGFkZCBhcmJpdGVyIGNhcGFiaWxpdHkNClt2MiwzLzRdIGR0
LWJpbmRpbmdzOiBtZWRpYXRlazogYWRkIGNvbXBhdGlibGUgZm9yIE1UNjg3My84MTkyIHB3cmFw
DQpbdjIsNC80XSBzb2M6IG1lZGlhdGVrOiBwd3JhcDogYWRkIHB3cmFwIGRyaXZlciBmb3IgTVQ2
ODczLzgxOTIgU29Dcw0KWzIvOF0gZHQtYmluZGluZ3M6IG1mZDogQWRkIGNvbXBhdGlibGUgZm9y
IHRoZSBNZWRpYVRlayBNVDYzNTkgUE1JQw0KWzMvOF0gZHQtYmluZGluZ3M6IHJlZ3VsYXRvcjog
QWRkIGRvY3VtZW50IGZvciBNVDYzNTkgcmVndWxhdG9yDQpbNC84XSBtZmQ6IEFkZCBzdXBwb3J0
IGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU5IFBNSUMNCls1LzhdIHJlZ3VsYXRvcjogbXQ2MzU5OiBB
ZGQgc3VwcG9ydCBmb3IgTVQ2MzU5IHJlZ3VsYXRvcg0KWzcvOF0gcmVndWxhdG9yOiBtdDYzNTk6
IEFkZCBzdXBwb3J0IGZvciBNVDYzNTlQIHJlZ3VsYXRvcg0KWzgvOF0gYXJtNjQ6IGR0czogbXQ2
MzU5OiBhZGQgUE1JQyBNVDYzNTkgcmVsYXRlZCBub2Rlcw0KDQpQbGVhc2UgYWxzbyBhY2NlcHQg
dGhpcyBwYXRjaCB0b2dldGhlciB3aXRoIFsxXVsyXVszXVs0XVs1XQ0KdG8gYXZvaWQgYnVpbGQg
YW5kIGR0IGJpbmRpbmcgY2hlY2sgZXJyb3IuDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zMzI2MjENClsyXSBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2Vy
aWVzPTM0MjU5Mw0KWzNdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzMwMDE3DQpbNF0gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zMjI5MzcNCls1XSBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/
c2VyaWVzPTMyMzE3MQ0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC50
eHQgICAgICAgIHwgIDYgKy0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi1l
dmIuZHRzICAgfCA4OSArKysrKysrKysrKysrKysrKysrDQogYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxOTIuZHRzaSAgICAgIHwgMzQgKysrKysrKw0KIGRyaXZlcnMvbW1jL2hvc3Qv
bXRrLXNkLmMgICAgICAgICAgICAgICAgICAgICB8IDc3ICsrKysrKysrKysrKy0tLS0NCiA0IGZp
bGVzIGNoYW5nZWQsIDE4NyBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCg0KLS0NCjIu
MTguMA0KDQo=

