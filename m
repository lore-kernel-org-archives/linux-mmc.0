Return-Path: <SRS0=DFdp=DV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8A5C43457
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 03:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801E6221FF
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 03:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r1mc4EDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgJNDI4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 23:08:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40284 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729258AbgJNDI4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2020 23:08:56 -0400
X-UUID: 7e7f51a598f44e028ec368430013eb28-20201014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nEv/nfQEf7Kv7V9kivAP7rJMl1OjvecHjq9vDRJ/g7Q=;
        b=r1mc4EDVt5a/Z1MV9iIItpFbFqecrZZg+A5jn9jL1qT3nV/rgRIWJ0QL0TTtsad5zkhVzBXY0Lb9eez23ccmA2ZdDzIeSFWLBGxj0XxUcQeESXo+2ZbvcwtLTcw/EzZ+yznVAe0bYMSslErzznYBG6XzuMU8YcU0pIpFQKFi7T8=;
X-UUID: 7e7f51a598f44e028ec368430013eb28-20201014
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1734856836; Wed, 14 Oct 2020 11:08:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Oct 2020 11:08:47 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Oct 2020 11:08:47 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v7 0/4] Add mmc support for MT8192 SoC
Date:   Wed, 14 Oct 2020 11:08:42 +0800
Message-ID: <20201014030846.12428-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Q2hhbmdlIGluIHY3Og0KMSlhZGQgInVuZXZhbHVhdGVkUHJvcGVydGllcyIgaW4gbXRrLXNkLnlh
bWwNCjIpYWRkIFJldmlld2VkLWJ5IHRhZw0KDQpDaGFuZ2UgaW4gdjY6DQoxKXVzZSBkZXZtX2Ns
a19nZXQgZnVuY3Rpb24gZm9yIHJlcXVpcmVkIGNsb2Nrcw0KDQpDaGFuZ2UgaW4gdjU6DQoxKXJl
bW92ZSBSZXZpZXdlZC1ieSB0YWcNCjIpdXNlIGRldm1fY2xrX2J1bGtfZ2V0X29wdGlvbmFsIGlu
c3RlYWQgb2YgZGV2bV9jbGtfZ2V0X29wdGlvbmFsDQogIGZvciBidWxrIGNsa3MNCg0KQ2hhbmdl
IGluIHY0Og0KMSlkcm9wICJ2bW1jIiBhbmQgInZxbW1jIiBkZXNjaXB0aW9uIGluIG10ay1zZC55
YW1sDQoyKWFkZCB2bW1xL3ZxbW1jIHN1cHBsaWVzIGFuZCB0aGUgcGluY3RybHMgdG8gcmVxdWly
ZWQgcHJvcGVydGllcw0KMyljaGFuZ2UgZGJnIGxldmVsIGFuZCBleGl0IHRoaXMgZnVuY3Rpb24N
CjQpdXNlIGRldm1fY2xrX2dldF9vcHRpb25hbCBpbnN0ZWFkIG9mIGRldm1fY2xrX2dldCBmdW5j
dGlvbg0KNSlyZW1vdmUgZWxzZSBicmFuY2ggZm9yIHN5c19jbGtfY2cNCg0KQ2hhbmdlIGluIHYz
Og0KMSljaGFuZ2UgbWFpbnRhaW5lcnMgbmFtZSBpbiBtdGstc2QueWFtbA0KMiljaGFuZ2UgImNv
bXBhdGlibGUiIHByb3BlcnRpZXMgdG8gZW51bSB0eXBlIGFuZCBzb3J0IGl0DQozKWRyb3AgdGhl
c2UgcHJvcGVydGllczogInJlZyIgYW5kICJpbnRlcnJ1cHRzIg0KNClhZGQgIm1heEl0ZW1zIiBj
b25zdHJhaW50cyBvbiB0aGVzZSBwcm9wZXJ0aWVzOiAidm1tYy1zdXBwbHkiLCAidnFtbWMtc3Vw
cGx5IiwNCiAgImFzc2lnbmVkLWNsb2NrcyIsICJhc3NpZ25lZC1jbG9jay1wYXJlbnRzIg0KNSlh
ZGQgIm1pbmltdW0iIGFuZCAibWF4aW11bSIgY29uc3RyYWludHMgb24gdGhlc2UgcHJvcGVydGll
czogIm1lZGlhdGVrLGhzNDAwLWNtZC1pbnQtZGVsYXkiLA0KICAibWVkaWF0ZWssbGF0Y2gtY2si
LCAiaHM0MDAtZHMtZGVsYXkiLCAibWVkaWF0ZWssaHMyMDAtY21kLWludC1kZWxheSINCg0KQ2hh
bmdlIGluIHYyOg0KQ29udmVydCBtdGstc2QgdG8ganNvbi1zY2hlbWENCg0KV2VuYmluIE1laSAo
NCk6DQogIGR0LWJpbmRpbmdzOiBtbWM6IENvbnZlcnQgbXRrLXNkIHRvIGpzb24tc2NoZW1hDQog
IG1tYzogZHQtYmluZGluZ3M6IGFkZCBzdXBwb3J0IGZvciBNVDgxOTIgU29DDQogIGFybTY0OiBk
dHM6IG10ODE5MjogYWRkIG1tYyBkZXZpY2Ugbm9kZQ0KICBtbWM6IG1lZGlhdGVrOiBBZGQgc3Vi
c3lzIGNsb2NrIGNvbnRyb2wgZm9yIE1UODE5MiBtc2RjDQotLS0NClRoaXMgcGF0Y2ggZGVwZW5k
cyBvbg0KW3Y0LDEvM10gYXJtNjQ6IGR0czogQWRkIE1lZGlhdGVrIFNvQyBNVDgxOTIgYW5kIGV2
YWx1YXRpb24gYm9hcmQgZHRzIGFuZCBNYWtlZmlsZQ0KW3YzLDEvOV0gZHQtYmluZGluZ3M6IEFS
TTogTWVkaWF0ZWs6IERvY3VtZW50IGJpbmRpbmdzIGZvciBNVDgxOTIgQlNQDQpbdjMsNi85XSBj
bGs6IG1lZGlhdGVrOiBBZGQgZHQtYmluZGluZ3MgZm9yIE1UODE5MiBjbG9ja3MNClt2Myw5Lzld
IGNsazogbWVkaWF0ZWs6IEFkZCBNVDgxOTIgY2xvY2sgc3VwcG9ydA0KW3YzLDEvM10gZHQtYmlu
ZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIHBpbmN0cmwgZmlsZQ0KW3YzLDIvM10gZHQtYmlu
ZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIGJpbmRpbmcgZG9jdW1lbnQNClt2MywzLzNdIHBp
bmN0cmw6IGFkZCBwaW5jdHJsIGRyaXZlciBvbiBtdDgxOTINClt2MiwxLzRdIHNvYzogbWVkaWF0
ZWs6IHB3cmFwOiB1c2UgQklUKCkgbWFjcm8NClt2MiwyLzRdIHNvYzogbWVkaWF0ZWs6IHB3cmFw
OiBhZGQgYXJiaXRlciBjYXBhYmlsaXR5DQpbdjIsMy80XSBkdC1iaW5kaW5nczogbWVkaWF0ZWs6
IGFkZCBjb21wYXRpYmxlIGZvciBNVDY4NzMvODE5MiBwd3JhcA0KW3YyLDQvNF0gc29jOiBtZWRp
YXRlazogcHdyYXA6IGFkZCBwd3JhcCBkcml2ZXIgZm9yIE1UNjg3My84MTkyIFNvQ3MNClsyLzhd
IGR0LWJpbmRpbmdzOiBtZmQ6IEFkZCBjb21wYXRpYmxlIGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU5
IFBNSUMNClszLzhdIGR0LWJpbmRpbmdzOiByZWd1bGF0b3I6IEFkZCBkb2N1bWVudCBmb3IgTVQ2
MzU5IHJlZ3VsYXRvcg0KWzQvOF0gbWZkOiBBZGQgc3VwcG9ydCBmb3IgdGhlIE1lZGlhVGVrIE1U
NjM1OSBQTUlDDQpbNS84XSByZWd1bGF0b3I6IG10NjM1OTogQWRkIHN1cHBvcnQgZm9yIE1UNjM1
OSByZWd1bGF0b3INCls3LzhdIHJlZ3VsYXRvcjogbXQ2MzU5OiBBZGQgc3VwcG9ydCBmb3IgTVQ2
MzU5UCByZWd1bGF0b3INCls4LzhdIGFybTY0OiBkdHM6IG10NjM1OTogYWRkIFBNSUMgTVQ2MzU5
IHJlbGF0ZWQgbm9kZXMNCg0KUGxlYXNlIGFsc28gYWNjZXB0IHRoaXMgcGF0Y2ggdG9nZXRoZXIg
d2l0aCBbMV1bMl1bM11bNF1bNV0NCnRvIGF2b2lkIGJ1aWxkIGFuZCBkdCBiaW5kaW5nIGNoZWNr
IGVycm9yLg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1t
ZWRpYXRlay9saXN0Lz9zZXJpZXM9MzMyNjIxDQpbMl0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zNDI1OTMNClszXSBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2Vy
aWVzPTMzMDAxNw0KWzRdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzIyOTM3DQpbNV0gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zMjMxNzENCi0tLQ0K
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0ICAgICAgICB8ICA3NSAtLS0t
LS0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbCAgICAgICB8IDE3
NiArKysrKysrKysrKysrKysrKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5
Mi1ldmIuZHRzICAgfCAgODkgKysrKysrKysrDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxOTIuZHRzaSAgICAgIHwgIDM0ICsrKysNCiBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5j
ICAgICAgICAgICAgICAgICAgICAgfCAgNzQgKysrKysrLS0NCiA1IGZpbGVzIGNoYW5nZWQsIDM1
NSBpbnNlcnRpb25zKCspLCA5MyBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0DQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlh
bWwNCg0KLS0NCjIuMTguMA0KDQo=

