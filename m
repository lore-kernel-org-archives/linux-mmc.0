Return-Path: <SRS0=cOhd=DH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DCCC4727F
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Sep 2020 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3F82184D
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Sep 2020 08:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gbfYzkJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgI3Ib2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Sep 2020 04:31:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32801 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725823AbgI3Ib2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2020 04:31:28 -0400
X-UUID: 235a20213fdc4e708afc987ed77037d0-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hes8CibldruT/l+L2FiBxJxCDWM1UPRlSBqFkvuoGiI=;
        b=gbfYzkJMemW8ahU46M+YHomUrelQN/H0Ax5eC/+3oTXUXv+qwyMPaXzFwSMPsZKu7ZNgGSgUXUF4+34nUkD81xdOrpziveFsd/sv5FdMmffa6v2aLWVx3CbtwogRjcHATwDT2ugoG2/KX5cCjpSqRchS0YWjW1XOtcWV73fc3yc=;
X-UUID: 235a20213fdc4e708afc987ed77037d0-20200930
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1647270136; Wed, 30 Sep 2020 16:31:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 16:31:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 16:31:20 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v3 0/4] Add mmc support for MT8192 SoC
Date:   Wed, 30 Sep 2020 16:31:16 +0800
Message-ID: <20200930083120.11971-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Q2hhbmdlIGluIHYzOg0KMSljaGFuZ2UgbWFpbnRhaW5lcnMgbmFtZSBpbiBtdGstc2QueWFtbA0K
MiljaGFuZ2UgImNvbXBhdGlibGUiIHByb3BlcnRpZXMgdG8gZW51bSB0eXBlIGFuZCBzb3J0IGl0
DQozKWRyb3AgdGhlc2UgcHJvcGVydGllczogInJlZyIgYW5kICJpbnRlcnJ1cHRzIg0KNClhZGQg
Im1heEl0ZW1zIiBjb25zdHJhaW50cyBvbiB0aGVzZSBwcm9wZXJ0aWVzOiAidm1tYy1zdXBwbHki
LCAidnFtbWMtc3VwcGx5IiwNCiAgImFzc2lnbmVkLWNsb2NrcyIsICJhc3NpZ25lZC1jbG9jay1w
YXJlbnRzIg0KNSlhZGQgIm1pbmltdW0iIGFuZCAibWF4aW11bSIgY29uc3RyYWludHMgb24gdGhl
c2UgcHJvcGVydGllczogIm1lZGlhdGVrLGhzNDAwLWNtZC1pbnQtZGVsYXkiLA0KICAibWVkaWF0
ZWssbGF0Y2gtY2siLCAiaHM0MDAtZHMtZGVsYXkiLCAibWVkaWF0ZWssaHMyMDAtY21kLWludC1k
ZWxheSINCg0KQ2hhbmdlIGluIHYyOg0KQ29udmVydCBtdGstc2QgdG8ganNvbi1zY2hlbWENCg0K
V2VuYmluIE1laSAoNCk6DQogIGR0LWJpbmRpbmdzOiBtbWM6IENvbnZlcnQgbXRrLXNkIHRvIGpz
b24tc2NoZW1hDQogIG1tYzogZHQtYmluZGluZ3M6IGFkZCBzdXBwb3J0IGZvciBNVDgxOTIgU29D
DQogIGFybTY0OiBkdHM6IG10ODE5MjogYWRkIG1tYyBkZXZpY2Ugbm9kZQ0KICBtbWM6IG1lZGlh
dGVrOiBBZGQgc3Vic3lzIGNsb2NrIGNvbnRyb2wgZm9yIE1UODE5MiBtc2RjDQotLS0NClRoaXMg
cGF0Y2ggZGVwZW5kcyBvbg0KW3Y0LDEvM10gYXJtNjQ6IGR0czogQWRkIE1lZGlhdGVrIFNvQyBN
VDgxOTIgYW5kIGV2YWx1YXRpb24gYm9hcmQgZHRzIGFuZCBNYWtlZmlsZQ0KW3YzLDEvOV0gZHQt
YmluZGluZ3M6IEFSTTogTWVkaWF0ZWs6IERvY3VtZW50IGJpbmRpbmdzIGZvciBNVDgxOTIgQlNQ
DQpbdjMsNi85XSBjbGs6IG1lZGlhdGVrOiBBZGQgZHQtYmluZGluZ3MgZm9yIE1UODE5MiBjbG9j
a3MNClt2Myw5LzldIGNsazogbWVkaWF0ZWs6IEFkZCBNVDgxOTIgY2xvY2sgc3VwcG9ydA0KW3Yz
LDEvM10gZHQtYmluZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIHBpbmN0cmwgZmlsZQ0KW3Yz
LDIvM10gZHQtYmluZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIGJpbmRpbmcgZG9jdW1lbnQN
Clt2MywzLzNdIHBpbmN0cmw6IGFkZCBwaW5jdHJsIGRyaXZlciBvbiBtdDgxOTINClt2MiwxLzRd
IHNvYzogbWVkaWF0ZWs6IHB3cmFwOiB1c2UgQklUKCkgbWFjcm8NClt2MiwyLzRdIHNvYzogbWVk
aWF0ZWs6IHB3cmFwOiBhZGQgYXJiaXRlciBjYXBhYmlsaXR5DQpbdjIsMy80XSBkdC1iaW5kaW5n
czogbWVkaWF0ZWs6IGFkZCBjb21wYXRpYmxlIGZvciBNVDY4NzMvODE5MiBwd3JhcA0KW3YyLDQv
NF0gc29jOiBtZWRpYXRlazogcHdyYXA6IGFkZCBwd3JhcCBkcml2ZXIgZm9yIE1UNjg3My84MTky
IFNvQ3MNClsyLzhdIGR0LWJpbmRpbmdzOiBtZmQ6IEFkZCBjb21wYXRpYmxlIGZvciB0aGUgTWVk
aWFUZWsgTVQ2MzU5IFBNSUMNClszLzhdIGR0LWJpbmRpbmdzOiByZWd1bGF0b3I6IEFkZCBkb2N1
bWVudCBmb3IgTVQ2MzU5IHJlZ3VsYXRvcg0KWzQvOF0gbWZkOiBBZGQgc3VwcG9ydCBmb3IgdGhl
IE1lZGlhVGVrIE1UNjM1OSBQTUlDDQpbNS84XSByZWd1bGF0b3I6IG10NjM1OTogQWRkIHN1cHBv
cnQgZm9yIE1UNjM1OSByZWd1bGF0b3INCls3LzhdIHJlZ3VsYXRvcjogbXQ2MzU5OiBBZGQgc3Vw
cG9ydCBmb3IgTVQ2MzU5UCByZWd1bGF0b3INCls4LzhdIGFybTY0OiBkdHM6IG10NjM1OTogYWRk
IFBNSUMgTVQ2MzU5IHJlbGF0ZWQgbm9kZXMNCg0KUGxlYXNlIGFsc28gYWNjZXB0IHRoaXMgcGF0
Y2ggdG9nZXRoZXIgd2l0aCBbMV1bMl1bM11bNF1bNV0NCnRvIGF2b2lkIGJ1aWxkIGFuZCBkdCBi
aW5kaW5nIGNoZWNrIGVycm9yLg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzMyNjIxDQpbMl0gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zNDI1
OTMNClszXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0
ZWsvbGlzdC8/c2VyaWVzPTMzMDAxNw0KWzRdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzIyOTM3DQpbNV0gaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0z
MjMxNzENCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0ICAgICAg
ICB8ICA3NSAtLS0tLS0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFt
bCAgICAgICB8IDE3OSArKysrKysrKysrKysrKysrKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE5Mi1ldmIuZHRzICAgfCAgODkgKysrKysrKysrDQogYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaSAgICAgIHwgIDM0ICsrKysNCiBkcml2ZXJzL21tYy9o
b3N0L210ay1zZC5jICAgICAgICAgICAgICAgICAgICAgfCAgNzcgKysrKysrLS0NCiA1IGZpbGVz
IGNoYW5nZWQsIDM2MSBpbnNlcnRpb25zKCspLCA5MyBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvbXRrLXNkLnlhbWwNCg0KLS0NCjIuMTguMA0KDQo=

