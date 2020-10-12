Return-Path: <SRS0=rM9+=DT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504BDC433E7
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 12:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B16920776
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 12:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YDuk1WHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgJLMp7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Oct 2020 08:45:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46673 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729733AbgJLMp6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2020 08:45:58 -0400
X-UUID: c701436ef012482f9eedc4f0fd1ba681-20201012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=04YPlHKLW/FPbgrfhbiPqc7oTc3GnG7sxOP4Toy7S3o=;
        b=YDuk1WHkxHao/W+SW9aM49GMgyIkL+JfEGqx+umCVMTYck/ihO8HyfCeBHXgjezfqBZrmWE6CnEt1tM56jjXOUv7E72Xzqt6RzUDVW3FDam2aOEUhPv+blH1h1h+3JvAea/q6BFRsx7zKV8EumsQg++RF9WjnwXxulaegINMTfk=;
X-UUID: c701436ef012482f9eedc4f0fd1ba681-20201012
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1967331073; Mon, 12 Oct 2020 20:45:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Oct 2020 20:45:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 20:45:48 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v6 0/4] Add mmc support for MT8192 SoC
Date:   Mon, 12 Oct 2020 20:45:43 +0800
Message-ID: <20201012124547.16649-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Q2hhbmdlIGluIHY2Og0KMSl1c2UgZGV2bV9jbGtfZ2V0IGZ1bmN0aW9uIGZvciByZXF1aXJlZCBj
bG9ja3MNCg0KQ2hhbmdlIGluIHY1Og0KMSlyZW1vdmUgUmV2aWV3ZWQtYnkgdGFnDQoyKXVzZSBk
ZXZtX2Nsa19idWxrX2dldF9vcHRpb25hbCBpbnN0ZWFkIG9mIGRldm1fY2xrX2dldF9vcHRpb25h
bA0KICBmb3IgYnVsayBjbGtzDQoNCkNoYW5nZSBpbiB2NDoNCjEpZHJvcCAidm1tYyIgYW5kICJ2
cW1tYyIgZGVzY2lwdGlvbiBpbiBtdGstc2QueWFtbA0KMilhZGQgdm1tcS92cW1tYyBzdXBwbGll
cyBhbmQgdGhlIHBpbmN0cmxzIHRvIHJlcXVpcmVkIHByb3BlcnRpZXMNCjMpY2hhbmdlIGRiZyBs
ZXZlbCBhbmQgZXhpdCB0aGlzIGZ1bmN0aW9uDQo0KXVzZSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwg
aW5zdGVhZCBvZiBkZXZtX2Nsa19nZXQgZnVuY3Rpb24NCjUpcmVtb3ZlIGVsc2UgYnJhbmNoIGZv
ciBzeXNfY2xrX2NnDQoNCkNoYW5nZSBpbiB2MzoNCjEpY2hhbmdlIG1haW50YWluZXJzIG5hbWUg
aW4gbXRrLXNkLnlhbWwNCjIpY2hhbmdlICJjb21wYXRpYmxlIiBwcm9wZXJ0aWVzIHRvIGVudW0g
dHlwZSBhbmQgc29ydCBpdA0KMylkcm9wIHRoZXNlIHByb3BlcnRpZXM6ICJyZWciIGFuZCAiaW50
ZXJydXB0cyINCjQpYWRkICJtYXhJdGVtcyIgY29uc3RyYWludHMgb24gdGhlc2UgcHJvcGVydGll
czogInZtbWMtc3VwcGx5IiwgInZxbW1jLXN1cHBseSIsDQogICJhc3NpZ25lZC1jbG9ja3MiLCAi
YXNzaWduZWQtY2xvY2stcGFyZW50cyINCjUpYWRkICJtaW5pbXVtIiBhbmQgIm1heGltdW0iIGNv
bnN0cmFpbnRzIG9uIHRoZXNlIHByb3BlcnRpZXM6ICJtZWRpYXRlayxoczQwMC1jbWQtaW50LWRl
bGF5IiwNCiAgIm1lZGlhdGVrLGxhdGNoLWNrIiwgImhzNDAwLWRzLWRlbGF5IiwgIm1lZGlhdGVr
LGhzMjAwLWNtZC1pbnQtZGVsYXkiDQoNCkNoYW5nZSBpbiB2MjoNCkNvbnZlcnQgbXRrLXNkIHRv
IGpzb24tc2NoZW1hDQoNCldlbmJpbiBNZWkgKDQpOg0KICBkdC1iaW5kaW5nczogbW1jOiBDb252
ZXJ0IG10ay1zZCB0byBqc29uLXNjaGVtYQ0KICBtbWM6IGR0LWJpbmRpbmdzOiBhZGQgc3VwcG9y
dCBmb3IgTVQ4MTkyIFNvQw0KICBhcm02NDogZHRzOiBtdDgxOTI6IGFkZCBtbWMgZGV2aWNlIG5v
ZGUNCiAgbW1jOiBtZWRpYXRlazogQWRkIHN1YnN5cyBjbG9jayBjb250cm9sIGZvciBNVDgxOTIg
bXNkYw0KLS0tDQpUaGlzIHBhdGNoIGRlcGVuZHMgb24NClt2NCwxLzNdIGFybTY0OiBkdHM6IEFk
ZCBNZWRpYXRlayBTb0MgTVQ4MTkyIGFuZCBldmFsdWF0aW9uIGJvYXJkIGR0cyBhbmQgTWFrZWZp
bGUNClt2MywxLzldIGR0LWJpbmRpbmdzOiBBUk06IE1lZGlhdGVrOiBEb2N1bWVudCBiaW5kaW5n
cyBmb3IgTVQ4MTkyIEJTUA0KW3YzLDYvOV0gY2xrOiBtZWRpYXRlazogQWRkIGR0LWJpbmRpbmdz
IGZvciBNVDgxOTIgY2xvY2tzDQpbdjMsOS85XSBjbGs6IG1lZGlhdGVrOiBBZGQgTVQ4MTkyIGNs
b2NrIHN1cHBvcnQNClt2MywxLzNdIGR0LWJpbmRpbmdzOiBwaW5jdHJsOiBtdDgxOTI6IGFkZCBw
aW5jdHJsIGZpbGUNClt2MywyLzNdIGR0LWJpbmRpbmdzOiBwaW5jdHJsOiBtdDgxOTI6IGFkZCBi
aW5kaW5nIGRvY3VtZW50DQpbdjMsMy8zXSBwaW5jdHJsOiBhZGQgcGluY3RybCBkcml2ZXIgb24g
bXQ4MTkyDQpbdjIsMS80XSBzb2M6IG1lZGlhdGVrOiBwd3JhcDogdXNlIEJJVCgpIG1hY3JvDQpb
djIsMi80XSBzb2M6IG1lZGlhdGVrOiBwd3JhcDogYWRkIGFyYml0ZXIgY2FwYWJpbGl0eQ0KW3Yy
LDMvNF0gZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBhZGQgY29tcGF0aWJsZSBmb3IgTVQ2ODczLzgx
OTIgcHdyYXANClt2Miw0LzRdIHNvYzogbWVkaWF0ZWs6IHB3cmFwOiBhZGQgcHdyYXAgZHJpdmVy
IGZvciBNVDY4NzMvODE5MiBTb0NzDQpbMi84XSBkdC1iaW5kaW5nczogbWZkOiBBZGQgY29tcGF0
aWJsZSBmb3IgdGhlIE1lZGlhVGVrIE1UNjM1OSBQTUlDDQpbMy84XSBkdC1iaW5kaW5nczogcmVn
dWxhdG9yOiBBZGQgZG9jdW1lbnQgZm9yIE1UNjM1OSByZWd1bGF0b3INCls0LzhdIG1mZDogQWRk
IHN1cHBvcnQgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTkgUE1JQw0KWzUvOF0gcmVndWxhdG9yOiBt
dDYzNTk6IEFkZCBzdXBwb3J0IGZvciBNVDYzNTkgcmVndWxhdG9yDQpbNy84XSByZWd1bGF0b3I6
IG10NjM1OTogQWRkIHN1cHBvcnQgZm9yIE1UNjM1OVAgcmVndWxhdG9yDQpbOC84XSBhcm02NDog
ZHRzOiBtdDYzNTk6IGFkZCBQTUlDIE1UNjM1OSByZWxhdGVkIG5vZGVzDQoNClBsZWFzZSBhbHNv
IGFjY2VwdCB0aGlzIHBhdGNoIHRvZ2V0aGVyIHdpdGggWzFdWzJdWzNdWzRdWzVdDQp0byBhdm9p
ZCBidWlsZCBhbmQgZHQgYmluZGluZyBjaGVjayBlcnJvci4NClsxXSBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTMzMjYyMQ0K
WzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9s
aXN0Lz9zZXJpZXM9MzQyNTkzDQpbM10gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zMzAwMTcNCls0XSBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTMyMjkz
Nw0KWzVdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRl
ay9saXN0Lz9zZXJpZXM9MzIzMTcxDQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMv
bXRrLXNkLnR4dCAgICAgICAgfCAgNzUgLS0tLS0tLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9tbWMvbXRrLXNkLnlhbWwgICAgICAgfCAxNzQgKysrKysrKysrKysrKysrKysrDQogYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTItZXZiLmR0cyAgIHwgIDg5ICsrKysrKysrKw0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgICAgICB8ICAzNCArKysr
DQogZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyAgICAgICAgICAgICAgICAgICAgIHwgIDc0ICsr
KysrKy0tDQogNSBmaWxlcyBjaGFuZ2VkLCAzNTMgaW5zZXJ0aW9ucygrKSwgOTMgZGVsZXRpb25z
KC0pDQogZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tbWMvbXRrLXNkLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQoNCi0tDQoyLjE4LjANCg0K

