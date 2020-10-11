Return-Path: <SRS0=/DC9=DS=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D3FC433E7
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Oct 2020 09:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6BE2222E
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Oct 2020 09:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rVZMocGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgJKJKj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Oct 2020 05:10:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36151 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725844AbgJKJKi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Oct 2020 05:10:38 -0400
X-UUID: d61c3e3508fb4e9fb4cd181ef8bf2a1d-20201011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FJOgfvY4al0L4IQR6UiO50nZbl64VIr5PKyRW1Nf2KQ=;
        b=rVZMocGHODWn1zq1bhR7ydxDbWbhYCwFZMkySiSBr6ZgUpKwcq2oFWROqYmwtEOwYFekcOcJSd0AZDW9DxGmHMTXfni4Yv5pa5DGd5DW9nXOct3tFORNwVc5Pr8cN8dot+luIaRuNd+guMt8hHCj3LB0Is4rPDtwuiF4nt7Pp/k=;
X-UUID: d61c3e3508fb4e9fb4cd181ef8bf2a1d-20201011
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1493167410; Sun, 11 Oct 2020 17:10:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 11 Oct 2020 17:10:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 11 Oct 2020 17:10:31 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v4 0/4] Add mmc support for MT8192 SoC
Date:   Sun, 11 Oct 2020 17:10:26 +0800
Message-ID: <20201011091030.28547-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Q2hhbmdlIGluIHY0Og0KMSlkcm9wICJ2bW1jIiBhbmQgInZxbW1jIiBkZXNjaXB0aW9uIGluIG10
ay1zZC55YW1sDQoyKWFkZCB2bW1xL3ZxbW1jIHN1cHBsaWVzIGFuZCB0aGUgcGluY3RybHMgdG8g
cmVxdWlyZWQgcHJvcGVydGllcw0KMyljaGFuZ2UgZGJnIGxldmVsIGFuZCBleGl0IHRoaXMgZnVu
Y3Rpb24NCjQpdXNlIGRldm1fY2xrX2dldF9vcHRpb25hbCBpbnN0ZWFkIG9mIGRldm1fY2xrX2dl
dCBmdW5jdGlvbg0KNSlyZW1vdmUgZWxzZSBicmFuY2ggZm9yIHN5c19jbGtfY2cNCg0KQ2hhbmdl
IGluIHYzOg0KMSljaGFuZ2UgbWFpbnRhaW5lcnMgbmFtZSBpbiBtdGstc2QueWFtbA0KMiljaGFu
Z2UgImNvbXBhdGlibGUiIHByb3BlcnRpZXMgdG8gZW51bSB0eXBlIGFuZCBzb3J0IGl0DQozKWRy
b3AgdGhlc2UgcHJvcGVydGllczogInJlZyIgYW5kICJpbnRlcnJ1cHRzIg0KNClhZGQgIm1heEl0
ZW1zIiBjb25zdHJhaW50cyBvbiB0aGVzZSBwcm9wZXJ0aWVzOiAidm1tYy1zdXBwbHkiLCAidnFt
bWMtc3VwcGx5IiwNCiAgImFzc2lnbmVkLWNsb2NrcyIsICJhc3NpZ25lZC1jbG9jay1wYXJlbnRz
Ig0KNSlhZGQgIm1pbmltdW0iIGFuZCAibWF4aW11bSIgY29uc3RyYWludHMgb24gdGhlc2UgcHJv
cGVydGllczogIm1lZGlhdGVrLGhzNDAwLWNtZC1pbnQtZGVsYXkiLA0KICAibWVkaWF0ZWssbGF0
Y2gtY2siLCAiaHM0MDAtZHMtZGVsYXkiLCAibWVkaWF0ZWssaHMyMDAtY21kLWludC1kZWxheSIN
Cg0KQ2hhbmdlIGluIHYyOg0KQ29udmVydCBtdGstc2QgdG8ganNvbi1zY2hlbWENCg0KV2VuYmlu
IE1laSAoNCk6DQogIGR0LWJpbmRpbmdzOiBtbWM6IENvbnZlcnQgbXRrLXNkIHRvIGpzb24tc2No
ZW1hDQogIG1tYzogZHQtYmluZGluZ3M6IGFkZCBzdXBwb3J0IGZvciBNVDgxOTIgU29DDQogIGFy
bTY0OiBkdHM6IG10ODE5MjogYWRkIG1tYyBkZXZpY2Ugbm9kZQ0KICBtbWM6IG1lZGlhdGVrOiBB
ZGQgc3Vic3lzIGNsb2NrIGNvbnRyb2wgZm9yIE1UODE5MiBtc2RjDQotLS0NClRoaXMgcGF0Y2gg
ZGVwZW5kcyBvbg0KW3Y0LDEvM10gYXJtNjQ6IGR0czogQWRkIE1lZGlhdGVrIFNvQyBNVDgxOTIg
YW5kIGV2YWx1YXRpb24gYm9hcmQgZHRzIGFuZCBNYWtlZmlsZQ0KW3YzLDEvOV0gZHQtYmluZGlu
Z3M6IEFSTTogTWVkaWF0ZWs6IERvY3VtZW50IGJpbmRpbmdzIGZvciBNVDgxOTIgQlNQDQpbdjMs
Ni85XSBjbGs6IG1lZGlhdGVrOiBBZGQgZHQtYmluZGluZ3MgZm9yIE1UODE5MiBjbG9ja3MNClt2
Myw5LzldIGNsazogbWVkaWF0ZWs6IEFkZCBNVDgxOTIgY2xvY2sgc3VwcG9ydA0KW3YzLDEvM10g
ZHQtYmluZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIHBpbmN0cmwgZmlsZQ0KW3YzLDIvM10g
ZHQtYmluZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIGJpbmRpbmcgZG9jdW1lbnQNClt2Mywz
LzNdIHBpbmN0cmw6IGFkZCBwaW5jdHJsIGRyaXZlciBvbiBtdDgxOTINClt2MiwxLzRdIHNvYzog
bWVkaWF0ZWs6IHB3cmFwOiB1c2UgQklUKCkgbWFjcm8NClt2MiwyLzRdIHNvYzogbWVkaWF0ZWs6
IHB3cmFwOiBhZGQgYXJiaXRlciBjYXBhYmlsaXR5DQpbdjIsMy80XSBkdC1iaW5kaW5nczogbWVk
aWF0ZWs6IGFkZCBjb21wYXRpYmxlIGZvciBNVDY4NzMvODE5MiBwd3JhcA0KW3YyLDQvNF0gc29j
OiBtZWRpYXRlazogcHdyYXA6IGFkZCBwd3JhcCBkcml2ZXIgZm9yIE1UNjg3My84MTkyIFNvQ3MN
ClsyLzhdIGR0LWJpbmRpbmdzOiBtZmQ6IEFkZCBjb21wYXRpYmxlIGZvciB0aGUgTWVkaWFUZWsg
TVQ2MzU5IFBNSUMNClszLzhdIGR0LWJpbmRpbmdzOiByZWd1bGF0b3I6IEFkZCBkb2N1bWVudCBm
b3IgTVQ2MzU5IHJlZ3VsYXRvcg0KWzQvOF0gbWZkOiBBZGQgc3VwcG9ydCBmb3IgdGhlIE1lZGlh
VGVrIE1UNjM1OSBQTUlDDQpbNS84XSByZWd1bGF0b3I6IG10NjM1OTogQWRkIHN1cHBvcnQgZm9y
IE1UNjM1OSByZWd1bGF0b3INCls3LzhdIHJlZ3VsYXRvcjogbXQ2MzU5OiBBZGQgc3VwcG9ydCBm
b3IgTVQ2MzU5UCByZWd1bGF0b3INCls4LzhdIGFybTY0OiBkdHM6IG10NjM1OTogYWRkIFBNSUMg
TVQ2MzU5IHJlbGF0ZWQgbm9kZXMNCg0KUGxlYXNlIGFsc28gYWNjZXB0IHRoaXMgcGF0Y2ggdG9n
ZXRoZXIgd2l0aCBbMV1bMl1bM11bNF1bNV0NCnRvIGF2b2lkIGJ1aWxkIGFuZCBkdCBiaW5kaW5n
IGNoZWNrIGVycm9yLg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzMyNjIxDQpbMl0gaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zNDI1OTMNClsz
XSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlz
dC8/c2VyaWVzPTMzMDAxNw0KWzRdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzIyOTM3DQpbNV0gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zMjMxNzEN
Ci0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0ICAgICAgICB8ICA3
NSAtLS0tLS0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbCAgICAg
ICB8IDE3NCArKysrKysrKysrKysrKysrKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE5Mi1ldmIuZHRzICAgfCAgODkgKysrKysrKysrDQogYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxOTIuZHRzaSAgICAgIHwgIDM0ICsrKysNCiBkcml2ZXJzL21tYy9ob3N0L210
ay1zZC5jICAgICAgICAgICAgICAgICAgICAgfCAgODAgKysrKysrLS0NCiA1IGZpbGVzIGNoYW5n
ZWQsIDM1OSBpbnNlcnRpb25zKCspLCA5MyBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0DQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRr
LXNkLnlhbWwNCg0KLS0NCjIuMTguMA0K

