Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D343C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 08:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2C8613C4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 08:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349946AbhDNIEL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:04:11 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:12151 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348780AbhDNIDf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 04:03:35 -0400
X-UUID: 773c79cf64a8478eb27eb86e41053d41-20210414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qKVhla14YBhAsSO0jOsxrzpneR3wX+fCgHwSmlXDbT4=;
        b=tzsKNSONTADBWlhCpLrtsvmU1WTnfITjLR4h2djaHoUAApX6JRn2RZS9aOrCIv4gV9C3k7yyLXK2MJNaqXicrcUi5yFLHFs/DjnGOoea+9yGOfYUQwgaUzJwzOjuwkL86qUZBef8F2FgkuJzBiLmjwTRxNDRxLOw3XpQ42we3Ho=;
X-UUID: 773c79cf64a8478eb27eb86e41053d41-20210414
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1068832856; Wed, 14 Apr 2021 16:03:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS32N1.mediatek.inc (172.27.4.71) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 16:03:07 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 16:03:06 +0800
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
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/3] MediaTek eMMC inline encryption support
Date:   Wed, 14 Apr 2021 15:50:57 +0800
Message-ID: <20210414075059.3086-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 75C7BE86BA7D80CDE58A51711A7967A9B17906F78609BE69B1A09FCFE87CB9AA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGVsbG8sDQoNCk1lZGlhdGVrIGVNTUMgaGFyZHdhcmUgSVAgaGFzIElubGluZSBDcnlwdG8gRW5n
aW5lIChJQ0UpLA0Kd2Ugc3VwcG9ydCBpbmxpbmUgZW5jcnlwdGlvbiBub3cuDQoNCkZvciBJbmxp
bmUgQ3J5cHRvIEVuZ2luZSAoSUNFKSwgc2VlOg0KLSBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1hcm0tbXNtLw0KMjAyMTAxMjYwMDE0NTYuMzgyOTg5LTItZWJpZ2dlcnNAa2VybmVsLm9y
Zy9ULw0KDQpUaGlzIHBhdGNoc2V0IHN1cHBvcnRzIE1lZGlhdGVrIGVNTUMgaW5saW5lIGVuY3J5
cHRpb24gd2hpY2ggbWVldHMgdGhlDQp1cGNvbWluZyB2ZXJzaW9uIG9mIHRoZSBlTU1DIHNwZWNp
ZmljYXRpb24gc3VjaCBhcyB2NS4xIG9yIHY1LjIuDQoNClBhdGNoIDEtMiwgYWRkIGNyeXB0byBw
cm9wZXJ0eSBhbmQgY3J5cHRvIGNsb2NrLCBwYXRjaCAzLCBkb2N1bWVudCB0aGUNCmRldmljZSB0
cmVlIGRlc2NyaXB0aW9uIGFib3V0IGNyeXB0byBjbG9jay4NCg0KUGxlYXNlIG5vdGVkIHRoYXQg
dGhlcmUgaXMgYSBzcGVjaWFsIHdheSBvZiBvbi9vZmYgY3J5cHRvIGhhcmR3YXJlIElQDQppbiBv
dXIgU29DcywgdGhlIGVuYWJsZSBiaXQgbXVzdCBiZSBjb250cm9sbGVkIHVuZGVyIEFSTSBoaWdo
ZXN0DQpzZWN1cml0eSBsZXZlbCwgdGhhdCBtZWFucyBtdXN0IGluIEFSTSB0cnVzdGVkIGZpcm13
YXJlKEFURikuDQoNCkNoYW5nZWQgaW4gdjM6DQotIFJlbW92ZWQgIm1tYzogTWVkaWF0ZWs6IGVu
YWJsZSBjcnlwdG8gaGFyZHdhcmUgZW5naW5lIiBwYXRjaCB0ZW1wb3JhcmlseS4gDQpOZWVkcyBm
aW5kaW5nIGEgYmV0dGVyIHdheSBmb3IgZW5hYmxlIGNyeXB0byBoYXJkd2FyZSBJUCB0aHJvdWdo
IEFURiwgc28gDQpyZW1vdmUgIm1tYzogTWVkaWF0ZWs6IGVuYWJsZSBjcnlwdG8gaGFyZHdhcmUg
ZW5naW5lIiBwYXRjaCB0ZW1wb3JhcmlseSwgDQp3ZSBjb3VsZCBlbmFibGUgaXQgaW4gQVRGIGRp
cmVjdGx5IHdoZW4gYm9vdCB1cCB3aGljaCB3aWxsIGJlIGEgd29ya2Fyb3VuZCANCnNvbHV0aW9u
LiBEaXNjdXNzaW5nIGFib3V0IHRoaXMsIHNlZTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtbW1jLw0KWUUlMkZuZnU4dlJFVFlOOWRPQGdtYWlsLmNvbS9ULyN0DQotIFdlIHdpbGwgcHV0
IHRoZSBhYm92ZSBtZW50aW9uZWQgcGF0Y2ggaW4gYSBzaW5nbGUgcGF0Y2gNCg0KDQpQZW5nIFpo
b3UgKDMpOg0KICBtbWM6IE1lZGlhdGVrOiBhZGQgSW5saW5lIENyeXB0byBFbmdpbmUgc3VwcG9y
dA0KICBhcm02NDogZHRzOiBNZWRpYXRlazogTVQ2Nzc5OiBhZGQgbW1jIG5vZGUgd2l0aCBJQ0Ug
c2V0dGluZw0KICBkdC1iaW5nZGluZ3M6IG1tYzogTWVkaWF0ZWs6IGFkZCBJQ0UgY2xvY2sNCg0K
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwgfCAgNiAr
KysrLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNpICAgICAgICAg
IHwgMTQgKysrKysrKysrKysrKysNCiBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMTUgKysrKysrKysrKysrKystDQogMyBmaWxlcyBjaGFuZ2VkLCAz
MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K

