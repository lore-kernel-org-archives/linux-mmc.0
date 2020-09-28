Return-Path: <SRS0=Afy4=DF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C0AC4741F
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 13:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB692074A
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 13:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HvKeEfGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1NMH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Sep 2020 09:12:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58431 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726406AbgI1NMH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 09:12:07 -0400
X-UUID: cc9ed33b293a4a838e9619e13d966e25-20200928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DtzmUqahNr9vlnFcH4gqWuTWGefpuIcJc/bsggr42oY=;
        b=HvKeEfGOz1iBh+8MqCmHBCX4FKeEF9yAl+Vv9xh4MNbQ/5kcXRjuUqOFRSJZIt5+uh9+wnbxfeb07nMhEyeYvKEhfB4s0AHXWNHdRRXILjzsYt5wAHE8WPwcbLoqWXVFJUzN5ZvyUspmbXN3YsoWUGMl5/gqfLLRQkE8CL8Ryyg=;
X-UUID: cc9ed33b293a4a838e9619e13d966e25-20200928
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2016316891; Mon, 28 Sep 2020 21:12:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Sep 2020 21:11:59 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Sep 2020 21:11:59 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH v2 2/4] mmc: dt-bindings: add support for MT8192 SoC
Date:   Mon, 28 Sep 2020 21:09:16 +0800
Message-ID: <20200928130918.32326-3-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200928130918.32326-1-wenbin.mei@mediatek.com>
References: <20200928130918.32326-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

TVQ4MTkyIG1tYyBob3N0IGlwIGlzIGNvbXBhdGlibGUgd2l0aCBNVDgxODMuDQpBZGQgc3VwcG9y
dCBmb3IgdGhpcy4NCg0KU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRp
YXRlay5jb20+DQpSZXZpZXdlZC1ieTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5v
cmc+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55
YW1sIHwgMTUgKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9tdGstc2QueWFtbA0KaW5kZXggMmQ1YWIxNDExY2Q1Li5mMTJhNDRmM2U2YzQg
MTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1z
ZC55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1z
ZC55YW1sDQpAQCAtMTgsNiArMTgsOSBAQCBwcm9wZXJ0aWVzOg0KICAgICAgIC0gY29uc3Q6IG1l
ZGlhdGVrLG10ODEzNS1tbWMNCiAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxNzMtbW1jDQog
ICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTgzLW1tYw0KKyAgICAgIC0gaXRlbXM6DQorICAg
ICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxOTItbW1jDQorICAgICAgICAtIGNvbnN0OiBtZWRp
YXRlayxtdDgxODMtbW1jDQogICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4NTE2LW1tYw0KICAg
ICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10Njc3OS1tbWMNCiAgICAgICAtIGNvbnN0OiBtZWRpYXRl
ayxtdDI3MDEtbW1jDQpAQCAtNDMsMjEgKzQ2LDI5IEBAIHByb3BlcnRpZXM6DQogICAgIGRlc2Ny
aXB0aW9uOg0KICAgICAgIFNob3VsZCBjb250YWluIHBoYW5kbGUgZm9yIHRoZSBjbG9jayBmZWVk
aW5nIHRoZSBNTUMgY29udHJvbGxlci4NCiAgICAgbWluSXRlbXM6IDINCi0gICAgbWF4SXRlbXM6
IDQNCisgICAgbWF4SXRlbXM6IDgNCiAgICAgaXRlbXM6DQogICAgICAgLSBkZXNjcmlwdGlvbjog
c291cmNlIGNsb2NrIChyZXF1aXJlZCkuDQogICAgICAgLSBkZXNjcmlwdGlvbjogSENMSyB3aGlj
aCB1c2VkIGZvciBob3N0IChyZXF1aXJlZCkuDQogICAgICAgLSBkZXNjcmlwdGlvbjogaW5kZXBl
bmRlbnQgc291cmNlIGNsb2NrIGdhdGUgKHJlcXVpcmVkIGZvciBNVDI3MTIpLg0KICAgICAgIC0g
ZGVzY3JpcHRpb246IGJ1cyBjbG9jayB1c2VkIGZvciBpbnRlcm5hbCByZWdpc3RlciBhY2Nlc3Mg
KHJlcXVpcmVkIGZvciBNVDI3MTIgTVNEQzAvMykuDQorICAgICAgLSBkZXNjcmlwdGlvbjogbXNk
YyBzdWJzeXMgY2xvY2sgZ2F0ZSAocmVxdWlyZWQgZm9yIE1UODE5MikuDQorICAgICAgLSBkZXNj
cmlwdGlvbjogcGVyaXBoZXJhbCBidXMgY2xvY2sgZ2F0ZSAocmVxdWlyZWQgZm9yIE1UODE5Miku
DQorICAgICAgLSBkZXNjcmlwdGlvbjogQVhJIGJ1cyBjbG9jayBnYXRlIChyZXF1aXJlZCBmb3Ig
TVQ4MTkyKS4NCisgICAgICAtIGRlc2NyaXB0aW9uOiBBSEIgYnVzIGNsb2NrIGdhdGUgKHJlcXVp
cmVkIGZvciBNVDgxOTIpLg0KIA0KICAgY2xvY2stbmFtZXM6DQogICAgIG1pbkl0ZW1zOiAyDQot
ICAgIG1heEl0ZW1zOiA0DQorICAgIG1heEl0ZW1zOiA4DQogICAgIGl0ZW1zOg0KICAgICAgIC0g
Y29uc3Q6IHNvdXJjZQ0KICAgICAgIC0gY29uc3Q6IGhjbGsNCiAgICAgICAtIGNvbnN0OiBzb3Vy
Y2VfY2cNCiAgICAgICAtIGNvbnN0OiBidXNfY2xrDQorICAgICAgLSBjb25zdDogc3lzX2NnDQor
ICAgICAgLSBjb25zdDogcGNsa19jZw0KKyAgICAgIC0gY29uc3Q6IGF4aV9jZw0KKyAgICAgIC0g
Y29uc3Q6IGFoYl9jZw0KIA0KICAgcGluY3RybC1uYW1lczoNCiAgICAgaXRlbXM6DQotLSANCjIu
MTguMA0K

