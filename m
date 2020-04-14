Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF173C352B6
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 03:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDAFE2075E
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 03:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hkvI7C/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404895AbgDNDlB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:41:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16151 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404877AbgDNDlA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Apr 2020 23:41:00 -0400
X-UUID: aaf2067a1a0a453a9baad549a1a15e3e-20200414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SkuybeaYmadFxyJ4GbnzpSoKVqrqaPzUzjiC/dZm8Jw=;
        b=hkvI7C/dlEUsEq1OtfZDTkkdZYWqJRrvmDlVyaNOzUUgfMFRs3x87M9ol+nyAEx207mmqnfjd8XdDA5P5g1wneraCwvjb7gQnhQyyfXkNQ8AAz4qJphyricLL4AY2mrD6ZySm0KKvesrFlKCLpctnN3ZGCnENaAduj2cP4HmkMo=;
X-UUID: aaf2067a1a0a453a9baad549a1a15e3e-20200414
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 925647458; Tue, 14 Apr 2020 11:40:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Apr 2020 11:40:55 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Apr 2020 11:40:50 +0800
From:   Yong Mao <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        yong mao <yong.mao@mediatek.com>
Subject: [PATCH 3/3] mmc: core: fix mmc_sdio_reinit_card fail issue
Date:   Tue, 14 Apr 2020 11:40:11 +0800
Message-ID: <1586835611-13857-4-git-send-email-yong.mao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
References: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogeW9uZyBtYW8gPHlvbmcubWFvQG1lZGlhdGVrLmNvbT4NCg0KSWYgU0RJTyBkZXZpY2Ug
aXMgaW5pdGlhbGl6ZWQgYnkgVUhTIG1vZGUsIGl0IHdpbGwgcnVuIHdpdGggMS44diBwb3dlci4N
CkluIHRoaXMgbW9kZSwgbW1jX2dvX2lkbGUgbWF5IG5vdCBtYWtlIFNESU8gZGV2aWNlIGdvIGlk
bGUgc3VjY2Vzc2Z1bGx5DQppbiBzb21lIHNwZWNpYWwgU0RJTyBkZXZpY2UuIEFuZCB0aGVuIGl0
IGNhbid0IGJlIHJlLWluaXRpYWxpemVkDQpzdWNjZXNzZnVsbHkuDQpBY2NvcmRpbmcgdG8gdGhl
IGxvZ2ljIGluIHNkaW9fcmVzZXRfY29tbSBhbmQgbW1jX3NkaW9fc3dfcmVzZXQsDQppbnZva2lu
ZyBtbWNfc2V0X2Nsb2NrKGhvc3QsIGhvc3QtPmZfbWluKSBiZWZvcmUgbW1jX3NlbmRfaW9fb3Bf
Y29uZA0KY2FuIG1ha2UgdGhpcyBTRElPIGRldmljZSBiYWNrIHRvIHJpZ2h0IHN0YXRlLg0KDQpT
aWduZWQtb2ZmLWJ5OiBZb25nIE1hbyA8eW9uZy5tYW9AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9tbWMvY29yZS9zZGlvLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jIGIvZHJpdmVycy9tbWMv
Y29yZS9zZGlvLmMNCmluZGV4IGYxNzNjYWQuLmRjNGRjNjMgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L21tYy9jb3JlL3NkaW8uYw0KKysrIGIvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMNCkBAIC04NTAs
NiArODUwLDcgQEAgc3RhdGljIGludCBtbWNfc2Rpb19yZWluaXRfY2FyZChzdHJ1Y3QgbW1jX2hv
c3QgKmhvc3QpDQogDQogCXNkaW9fcmVzZXQoaG9zdCk7DQogCW1tY19nb19pZGxlKGhvc3QpOw0K
KwltbWNfc2V0X2Nsb2NrKGhvc3QsIGhvc3QtPmZfbWluKTsNCiAJbW1jX3NlbmRfaWZfY29uZCho
b3N0LCBob3N0LT5jYXJkLT5vY3IpOw0KIA0KIAlyZXQgPSBtbWNfc2VuZF9pb19vcF9jb25kKGhv
c3QsIDAsIE5VTEwpOw0KLS0gDQoxLjkuMQ0K

