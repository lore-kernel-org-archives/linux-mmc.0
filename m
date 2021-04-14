Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF07C433ED
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 08:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1E8613C4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 08:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhDNIZV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:25:21 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41105 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229467AbhDNIZV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 04:25:21 -0400
X-UUID: c3ba8ec3ed374db38e39633b6f6dbafd-20210414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wiZl8hHI+dzLmoVVwH3ncIL4BmeHx0LIVwIlGC9uQiw=;
        b=XTM+pbbQ4ESZDafcr24C/QDYrtb1JnWbTwwUUWlJ5w7j+hkyWWYgar5cC9uYu1pryWoSyHNsgbdk8Gnu9mFDX8exYYsuVc6fiFYsGD7q06cOY/GDMs7MCZV55mkF+hMGF4gC6XUWquHsetMU0ANpNC49bkdwoW0RoP64bRIpW9E=;
X-UUID: c3ba8ec3ed374db38e39633b6f6dbafd-20210414
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1895344168; Wed, 14 Apr 2021 16:24:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 16:24:53 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 16:24:52 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Peng Zhou <Peng.Zhou@mediatek.com>
Subject: [PATCH RESEND v3 3/3] dt-bingdings: mmc: Mediatek: add ICE clock
Date:   Wed, 14 Apr 2021 16:09:56 +0800
Message-ID: <20210414080951.2800-4-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210414080951.2800-1-peng.zhou@mediatek.com>
References: <20210414080951.2800-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-TM-SNTS-SMTP: A9A59D6F075130F10FE9B5C495CC462ACF027733EB31CA42EA52051E8E8359CE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogUGVuZyBaaG91IDxQZW5nLlpob3VAbWVkaWF0ZWsuY29tPg0KDQpEb2N1bWVudCB0aGUg
YmluZGluZyBmb3IgY3J5cHRvIGNsb2NrIG9mIHRoZSBJbmxpbmUgQ3J5cHRvIEVuZ2luZSAoSUNF
KQ0Kb24gTWVkaWF0ZWsgU29Dcy4NCg0KU2lnbmVkLW9mZi1ieTogUGVuZyBaaG91IDxQZW5nLlpo
b3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21tYy9tdGstc2QueWFtbCB8IDYgKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbW1jL210ay1zZC55YW1sDQppbmRleCAwMTYzMGIwZWNlYTcuLmE4MWMxNGM4ODkw
NiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRr
LXNkLnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRr
LXNkLnlhbWwNCkBAIC0zNyw3ICszNyw3IEBAIHByb3BlcnRpZXM6DQogICAgIGRlc2NyaXB0aW9u
Og0KICAgICAgIFNob3VsZCBjb250YWluIHBoYW5kbGUgZm9yIHRoZSBjbG9jayBmZWVkaW5nIHRo
ZSBNTUMgY29udHJvbGxlci4NCiAgICAgbWluSXRlbXM6IDINCi0gICAgbWF4SXRlbXM6IDgNCisg
ICAgbWF4SXRlbXM6IDkNCiAgICAgaXRlbXM6DQogICAgICAgLSBkZXNjcmlwdGlvbjogc291cmNl
IGNsb2NrIChyZXF1aXJlZCkuDQogICAgICAgLSBkZXNjcmlwdGlvbjogSENMSyB3aGljaCB1c2Vk
IGZvciBob3N0IChyZXF1aXJlZCkuDQpAQCAtNDcsMTAgKzQ3LDExIEBAIHByb3BlcnRpZXM6DQog
ICAgICAgLSBkZXNjcmlwdGlvbjogcGVyaXBoZXJhbCBidXMgY2xvY2sgZ2F0ZSAocmVxdWlyZWQg
Zm9yIE1UODE5MikuDQogICAgICAgLSBkZXNjcmlwdGlvbjogQVhJIGJ1cyBjbG9jayBnYXRlIChy
ZXF1aXJlZCBmb3IgTVQ4MTkyKS4NCiAgICAgICAtIGRlc2NyaXB0aW9uOiBBSEIgYnVzIGNsb2Nr
IGdhdGUgKHJlcXVpcmVkIGZvciBNVDgxOTIpLg0KKyAgICAgIC0gZGVzY3JpcHRpb246IGNyeXB0
byBjbG9jayB1c2VkIGZvciBkYXRhIGVuY3J5cHQvZGVjcnlwdCAob3B0aW9uYWwpLg0KIA0KICAg
Y2xvY2stbmFtZXM6DQogICAgIG1pbkl0ZW1zOiAyDQotICAgIG1heEl0ZW1zOiA4DQorICAgIG1h
eEl0ZW1zOiA5DQogICAgIGl0ZW1zOg0KICAgICAgIC0gY29uc3Q6IHNvdXJjZQ0KICAgICAgIC0g
Y29uc3Q6IGhjbGsNCkBAIC02MCw2ICs2MSw3IEBAIHByb3BlcnRpZXM6DQogICAgICAgLSBjb25z
dDogcGNsa19jZw0KICAgICAgIC0gY29uc3Q6IGF4aV9jZw0KICAgICAgIC0gY29uc3Q6IGFoYl9j
Zw0KKyAgICAgIC0gY29uc3Q6IGNyeXB0bw0KIA0KICAgcGluY3RybC1uYW1lczoNCiAgICAgaXRl
bXM6DQotLSANCjIuMTguMA0K

