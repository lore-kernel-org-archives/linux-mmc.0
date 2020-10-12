Return-Path: <SRS0=rM9+=DT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC232C2BB1B
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 02:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714232076C
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 02:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Sh+B/IEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgJLCnx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Oct 2020 22:43:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50793 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725882AbgJLCnx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Oct 2020 22:43:53 -0400
X-UUID: 30f442e0b9b24d0d9eabe19cf91e66b7-20201012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=OSDxyEzIpgPu+Ph9j5I04GUIFpS91KGLFoo9CkNcj+M=;
        b=Sh+B/IEcSRMl6fssMi9rm/95qqZlDHIz88H6KvaVSRB2Ce2aVn4dw2Adya4yxOu4mtjJw+7xigoNvr01IVUbVXrZ5cRIV+jnYgqAta8V1N7jf/LoxmMVlKvaYInQc63Pna1hIFPrI0g1L7clHEJTou+ks0HnfWYFyiFC9EOMO9I=;
X-UUID: 30f442e0b9b24d0d9eabe19cf91e66b7-20201012
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 348171208; Mon, 12 Oct 2020 10:43:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Oct 2020 10:43:47 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 10:43:47 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v5 0/4] Add mmc support for MT8192 SoC
Date:   Mon, 12 Oct 2020 10:43:41 +0800
Message-ID: <20201012024345.8361-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Q2hhbmdlIGluIHY1Og0KMSlyZW1vdmUgUmV2aWV3ZWQtYnkgdGFnDQoyKXVzZSBkZXZtX2Nsa19i
dWxrX2dldF9vcHRpb25hbCBpbnN0ZWFkIG9mIGRldm1fY2xrX2dldF9vcHRpb25hbA0KICBmb3Ig
YnVsayBjbGtzDQoNCkNoYW5nZSBpbiB2NDoNCjEpZHJvcCAidm1tYyIgYW5kICJ2cW1tYyIgZGVz
Y2lwdGlvbiBpbiBtdGstc2QueWFtbA0KMilhZGQgdm1tcS92cW1tYyBzdXBwbGllcyBhbmQgdGhl
IHBpbmN0cmxzIHRvIHJlcXVpcmVkIHByb3BlcnRpZXMNCjMpY2hhbmdlIGRiZyBsZXZlbCBhbmQg
ZXhpdCB0aGlzIGZ1bmN0aW9uDQo0KXVzZSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwgaW5zdGVhZCBv
ZiBkZXZtX2Nsa19nZXQgZnVuY3Rpb24NCjUpcmVtb3ZlIGVsc2UgYnJhbmNoIGZvciBzeXNfY2xr
X2NnDQoNCkNoYW5nZSBpbiB2MzoNCjEpY2hhbmdlIG1haW50YWluZXJzIG5hbWUgaW4gbXRrLXNk
LnlhbWwNCjIpY2hhbmdlICJjb21wYXRpYmxlIiBwcm9wZXJ0aWVzIHRvIGVudW0gdHlwZSBhbmQg
c29ydCBpdA0KMylkcm9wIHRoZXNlIHByb3BlcnRpZXM6ICJyZWciIGFuZCAiaW50ZXJydXB0cyIN
CjQpYWRkICJtYXhJdGVtcyIgY29uc3RyYWludHMgb24gdGhlc2UgcHJvcGVydGllczogInZtbWMt
c3VwcGx5IiwgInZxbW1jLXN1cHBseSIsDQogICJhc3NpZ25lZC1jbG9ja3MiLCAiYXNzaWduZWQt
Y2xvY2stcGFyZW50cyINCjUpYWRkICJtaW5pbXVtIiBhbmQgIm1heGltdW0iIGNvbnN0cmFpbnRz
IG9uIHRoZXNlIHByb3BlcnRpZXM6ICJtZWRpYXRlayxoczQwMC1jbWQtaW50LWRlbGF5IiwNCiAg
Im1lZGlhdGVrLGxhdGNoLWNrIiwgImhzNDAwLWRzLWRlbGF5IiwgIm1lZGlhdGVrLGhzMjAwLWNt
ZC1pbnQtZGVsYXkiDQoNCkNoYW5nZSBpbiB2MjoNCkNvbnZlcnQgbXRrLXNkIHRvIGpzb24tc2No
ZW1hDQoNCldlbmJpbiBNZWkgKDQpOg0KICBkdC1iaW5kaW5nczogbW1jOiBDb252ZXJ0IG10ay1z
ZCB0byBqc29uLXNjaGVtYQ0KICBtbWM6IGR0LWJpbmRpbmdzOiBhZGQgc3VwcG9ydCBmb3IgTVQ4
MTkyIFNvQw0KICBhcm02NDogZHRzOiBtdDgxOTI6IGFkZCBtbWMgZGV2aWNlIG5vZGUNCiAgbW1j
OiBtZWRpYXRlazogQWRkIHN1YnN5cyBjbG9jayBjb250cm9sIGZvciBNVDgxOTIgbXNkYw0KLS0t
DQpUaGlzIHBhdGNoIGRlcGVuZHMgb24NClt2NCwxLzNdIGFybTY0OiBkdHM6IEFkZCBNZWRpYXRl
ayBTb0MgTVQ4MTkyIGFuZCBldmFsdWF0aW9uIGJvYXJkIGR0cyBhbmQgTWFrZWZpbGUNClt2Mywx
LzldIGR0LWJpbmRpbmdzOiBBUk06IE1lZGlhdGVrOiBEb2N1bWVudCBiaW5kaW5ncyBmb3IgTVQ4
MTkyIEJTUA0KW3YzLDYvOV0gY2xrOiBtZWRpYXRlazogQWRkIGR0LWJpbmRpbmdzIGZvciBNVDgx
OTIgY2xvY2tzDQpbdjMsOS85XSBjbGs6IG1lZGlhdGVrOiBBZGQgTVQ4MTkyIGNsb2NrIHN1cHBv
cnQNClt2MywxLzNdIGR0LWJpbmRpbmdzOiBwaW5jdHJsOiBtdDgxOTI6IGFkZCBwaW5jdHJsIGZp
bGUNClt2MywyLzNdIGR0LWJpbmRpbmdzOiBwaW5jdHJsOiBtdDgxOTI6IGFkZCBiaW5kaW5nIGRv
Y3VtZW50DQpbdjMsMy8zXSBwaW5jdHJsOiBhZGQgcGluY3RybCBkcml2ZXIgb24gbXQ4MTkyDQpb
djIsMS80XSBzb2M6IG1lZGlhdGVrOiBwd3JhcDogdXNlIEJJVCgpIG1hY3JvDQpbdjIsMi80XSBz
b2M6IG1lZGlhdGVrOiBwd3JhcDogYWRkIGFyYml0ZXIgY2FwYWJpbGl0eQ0KW3YyLDMvNF0gZHQt
YmluZGluZ3M6IG1lZGlhdGVrOiBhZGQgY29tcGF0aWJsZSBmb3IgTVQ2ODczLzgxOTIgcHdyYXAN
Clt2Miw0LzRdIHNvYzogbWVkaWF0ZWs6IHB3cmFwOiBhZGQgcHdyYXAgZHJpdmVyIGZvciBNVDY4
NzMvODE5MiBTb0NzDQpbMi84XSBkdC1iaW5kaW5nczogbWZkOiBBZGQgY29tcGF0aWJsZSBmb3Ig
dGhlIE1lZGlhVGVrIE1UNjM1OSBQTUlDDQpbMy84XSBkdC1iaW5kaW5nczogcmVndWxhdG9yOiBB
ZGQgZG9jdW1lbnQgZm9yIE1UNjM1OSByZWd1bGF0b3INCls0LzhdIG1mZDogQWRkIHN1cHBvcnQg
Zm9yIHRoZSBNZWRpYVRlayBNVDYzNTkgUE1JQw0KWzUvOF0gcmVndWxhdG9yOiBtdDYzNTk6IEFk
ZCBzdXBwb3J0IGZvciBNVDYzNTkgcmVndWxhdG9yDQpbNy84XSByZWd1bGF0b3I6IG10NjM1OTog
QWRkIHN1cHBvcnQgZm9yIE1UNjM1OVAgcmVndWxhdG9yDQpbOC84XSBhcm02NDogZHRzOiBtdDYz
NTk6IGFkZCBQTUlDIE1UNjM1OSByZWxhdGVkIG5vZGVzDQoNClBsZWFzZSBhbHNvIGFjY2VwdCB0
aGlzIHBhdGNoIHRvZ2V0aGVyIHdpdGggWzFdWzJdWzNdWzRdWzVdDQp0byBhdm9pZCBidWlsZCBh
bmQgZHQgYmluZGluZyBjaGVjayBlcnJvci4NClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTMzMjYyMQ0KWzJdIGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJp
ZXM9MzQyNTkzDQpbM10gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4
LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zMzAwMTcNCls0XSBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTMyMjkzNw0KWzVdIGh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9z
ZXJpZXM9MzIzMTcxDQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnR4
dCAgICAgICAgfCAgNzUgLS0tLS0tLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRr
LXNkLnlhbWwgICAgICAgfCAxNzQgKysrKysrKysrKysrKysrKysrDQogYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDgxOTItZXZiLmR0cyAgIHwgIDg5ICsrKysrKysrKw0KIGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgICAgICB8ICAzNCArKysrDQogZHJpdmVy
cy9tbWMvaG9zdC9tdGstc2QuYyAgICAgICAgICAgICAgICAgICAgIHwgIDc0ICsrKysrKy0tDQog
NSBmaWxlcyBjaGFuZ2VkLCAzNTMgaW5zZXJ0aW9ucygrKSwgOTMgZGVsZXRpb25zKC0pDQogZGVs
ZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRr
LXNkLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbW1jL210ay1zZC55YW1sDQoNCi0tDQoyLjE4LjANCg0K

