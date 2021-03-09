Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ACCC433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 02:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEBC965279
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 02:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCICAR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 21:00:17 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20675 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230127AbhCIB7t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 20:59:49 -0500
X-UUID: 98a9888fc1eb44a68a4d1795eebdce54-20210309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=voKB3JTtp23roJcLmppifE/2eVEe8ZJYpXa+eKJCcHU=;
        b=VG/wgq5rGW9ON/VQkr5ELeGw7quJEyKXAkFTGOMZdE4Zpkjftk0qIZTgdUEs3mzk8MzYxvFRPckrGsaxGfXX4Sb2ZCQvXTBWZls9NGOiYVBHXKmkR2FBeHnO1fetu9z3F1tIJI9UvXU9do6KcVZQmHurdoHEZwm7SV6w5jKrDTE=;
X-UUID: 98a9888fc1eb44a68a4d1795eebdce54-20210309
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1874155827; Tue, 09 Mar 2021 09:59:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 09:59:39 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Mar 2021 09:59:39 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Peng Zhou <Peng.Zhou@mediatek.com>
Subject: [PATCH v2 0/4] MediaTek eMMC inline encryption support 
Date:   Tue, 9 Mar 2021 09:53:32 +0800
Message-ID: <20210309015331.10457-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D2C565463BD08AAB9A21D43E5F22A286DBA322E6FB1527A90110E54108D30B7E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogUGVuZyBaaG91IDxQZW5nLlpob3VAbWVkaWF0ZWsuY29tPg0KDQpIZWxsbywNCg0KTWVk
aWF0ZWsgZU1NQyBoYXJkd2FyZSBJUCBoYXMgSW5saW5lIENyeXB0byBFbmdpbmUgKElDRSksDQp3
ZSBzdXBwb3J0IGlubGluZSBlbmNyeXB0aW9uIG5vdy4NCg0KRm9yIElubGluZSBDcnlwdG8gRW5n
aW5lIChJQ0UpLCBzZWU6DQotIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1tc20v
MjAyMTAxMjYwMDE0NTYuMzgyOTg5LTItZWJpZ2dlcnNAa2VybmVsLm9yZy9ULw0KDQpDaGFuZ2Vk
IGluIHYyOg0KLSBmaXggZW1haWwgZm9ybWF0DQotIGNoYW5nZSBzb21lIGRlc2NyaXB0aW9uDQoN
ClBlbmcgWmhvdSAoNCk6DQogIG1tYzogTWVkaWF0ZWs6IGFkZCBJbmxpbmUgQ3J5cHRvIEVuZ2lu
ZSBzdXBwb3J0DQogIG1tYzogTWVkaWF0ZWs6IGVuYWJsZSBjcnlwdG8gaGFyZHdhcmUgZW5naW5l
DQogIGFybTY0OiBkdHM6IE1lZGlhdGVrOiBNVDY3Nzk6IGFkZCBtbWMgbm9kZSB3aXRoIElDRSBz
ZXR0aW5nDQogIGR0LWJpbmdkaW5nczogbW1jOiBNZWRpYXRlazogYWRkIElDRSBjbG9jaw0KDQog
Li4uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sICAgICAgIHwgIDYgKystDQog
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3NzkuZHRzaSAgICAgIHwgMTQgKysrKysr
Kw0KIGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgICAgICAgICAgICAgICAgICAgICB8IDQyICsr
KysrKysrKysrKysrKysrKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xOC4wDQo=

