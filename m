Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939B6C2BB1D
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 03:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7030D2076B
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 03:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WOKQGFXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404878AbgDNDk7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:40:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:19563 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404874AbgDNDk6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Apr 2020 23:40:58 -0400
X-UUID: 130231d2b9d145989eaf1c2be2eb8a40-20200414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pXbuHYf29wq9I5dB9+bPlMg2JqoQVfcEPpb8kdg9al4=;
        b=WOKQGFXHfVI/VIGaXPZyHMPLRnupYoN2y/YqVZyftVjEx5/1eO3QiaNVZ+qhCrR1RzQUfwVGQ1GkE36pkUftFDezbcphpkGR5yCmmSvCUaK4YdK4URSmesoEiFBg6udCBwd3Wo+TXG3cAsRD+/favOs723Knrt/6oO2Oky6Rm5Y=;
X-UUID: 130231d2b9d145989eaf1c2be2eb8a40-20200414
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1549726525; Tue, 14 Apr 2020 11:40:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Apr 2020 11:40:54 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Apr 2020 11:40:49 +0800
From:   Yong Mao <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        yong mao <yong.mao@mediatek.com>
Subject: [PATCH 1/3] mmc: core: need do mmc_power_cycle in mmc_sdio_resend_if_cond
Date:   Tue, 14 Apr 2020 11:40:09 +0800
Message-ID: <1586835611-13857-2-git-send-email-yong.mao@mediatek.com>
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

RnJvbTogeW9uZyBtYW8gPHlvbmcubWFvQG1lZGlhdGVrLmNvbT4NCg0KV2hlbiBtbWNfc2Rpb19y
ZXNuZWRfaWZfY29uZCBpcyBpbnZva2VkLCBpdCBpbmRpY2F0ZXMgdGhlIFNESU8NCmRldmljZSBp
cyBub3QgaW4gdGhlIHJpZ2h0IHN0YXRlLiBJbiB0aGlzIGNvbmRpdGlvbiwgdGhlIHByZXZpb3Vz
DQppbXBsZW1lbnRhdGlvbiBvZiBtbWNfc2Rpb19yZXNlbmRfaWZfY29uZCBjYW4ndCBtYWtlIHN1
cmUgU0RJTw0KZGV2aWNlIGJlIGJhY2sgdG8gaWRsZSBzdGF0ZS4gbW1jX3Bvd2VyX2N5Y2xlIGNh
biByZXNldCB0aGUgU0RJTw0KZGV2aWNlIGJ5IEhXIGFuZCBhbHNvIG1ha2Ugc3VyZSBTRElPIGRl
dmljZSBlbnRlciB0byBpZGxlIHN0YXRlDQpjb3JyZWN0bHkuDQoNClNpZ25lZC1vZmYtYnk6IFlv
bmcgTWFvIDx5b25nLm1hb0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21tYy9jb3JlL3Nk
aW8uYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgYi9kcml2ZXJzL21tYy9jb3JlL3NkaW8uYw0KaW5k
ZXggZWJiMzg3YS4uYWRhMGE4MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5j
DQorKysgYi9kcml2ZXJzL21tYy9jb3JlL3NkaW8uYw0KQEAgLTU0Niw2ICs1NDYsNyBAQCBzdGF0
aWMgaW50IG1tY19zZGlvX2luaXRfdWhzX2NhcmQoc3RydWN0IG1tY19jYXJkICpjYXJkKQ0KIHN0
YXRpYyB2b2lkIG1tY19zZGlvX3Jlc2VuZF9pZl9jb25kKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwN
CiAJCQkJICAgIHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkNCiB7DQorCW1tY19wb3dlcl9jeWNsZSho
b3N0LCBob3N0LT5jYXJkLT5vY3IpOw0KIAlzZGlvX3Jlc2V0KGhvc3QpOw0KIAltbWNfZ29faWRs
ZShob3N0KTsNCiAJbW1jX3NlbmRfaWZfY29uZChob3N0LCBob3N0LT5vY3JfYXZhaWwpOw0KLS0g
DQoxLjkuMQ0K

