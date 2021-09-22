Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF1C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36ED16124A
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhIVKeH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:34:07 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:9997 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhIVKd6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2021 06:33:58 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18MAB9WW012571;
        Wed, 22 Sep 2021 18:11:09 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Sep
 2021 18:31:28 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <adrian.hunter@intel.com>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <andrew@aj.id.au>
CC:     <BMC-SW@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 09/10] dt-bindings: mmc: aspeed: Add max-tap-delay property
Date:   Wed, 22 Sep 2021 18:31:15 +0800
Message-ID: <20210922103116.30652-10-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18MAB9WW012571
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add max-tap-delay proptery in order to record the maximum
tap delay on different platforms.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 987b287f3bff..5bb66849df65 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -37,6 +37,9 @@ properties:
   clocks:
     maxItems: 1
     description: The SD/SDIO controller clock gate
+  max-tap-delay:
+    maxItems: 1
+    description: The maximum delay in picosecond for SD/SDIO controller
 
 patternProperties:
   "^sdhci@[0-9a-f]+$":
-- 
2.17.1

