Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02E2C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Dec 2022 01:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiLTBxC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Dec 2022 20:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLTBxC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2022 20:53:02 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C192DFA
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2022 17:53:00 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8B63B84F87;
        Tue, 20 Dec 2022 02:52:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671501177;
        bh=2dpcU4HV0vebiYmInIi1aOzYmhB8uTABzkdtQYGB6qM=;
        h=From:To:Cc:Subject:Date:From;
        b=XxYVWB8T70QVLD8hJ1IyuZSDf/HLYcaeVuFL7d6RPfisWRzqFwYemOB3karJwgLLp
         UPrerrjIyP/z3tMunkwQ2x5NgVYCV26U0ki19+nj2RZzHrU17uTiuhSyxmu2baQNso
         zR/J2TwRl6luNETxuSqQansUQsDQY5pCvtc2wYCRJsiZCvMJhv5//QKx3fTqGtAzdF
         YxQqonG3Nu4qmg0bkKkz/NGNTIFSXqS9CCjMwwsxAhkgsEJcg1jeg7v0WftJV18vsd
         RKJSqmJ5IQonDuOOsa+74WW+vOsbLoRBjrxPnVjq3xwaKutRUkkY1wOCAZrAMsf99q
         ZSzGuYY4PmyGQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zach Brown <zach.brown@ni.com>
Subject: [PATCH] [RFC] mmc: sdhci: Always apply sdhci-caps-mask and sdhci-caps to caps
Date:   Tue, 20 Dec 2022 02:52:54 +0100
Message-Id: <20221220015254.796568-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The original implementation in the commit referenced below only modifies
caps in case no caps are passed to sdhci_read_caps() via parameter, this
does not seem correct. Always modify the caps according to the properties
from DT.

92e0c44b92e4 ("mmc: sdhci: Use sdhci-caps-mask and sdhci-caps to change the caps read during __sdhci_read_caps")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Zach Brown <zach.brown@ni.com>
To: linux-mmc@vger.kernel.org
---
Note: I am sending it as an RFC, because it seems I might be missing
      something obvious.
---
 drivers/mmc/host/sdhci.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f3af1bd0f7b95..52719d3118ffd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4124,24 +4124,16 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
 		return;
 
-	if (caps) {
-		host->caps = *caps;
-	} else {
-		host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
-		host->caps &= ~lower_32_bits(dt_caps_mask);
-		host->caps |= lower_32_bits(dt_caps);
-	}
+	host->caps = caps ? *caps : sdhci_readl(host, SDHCI_CAPABILITIES);
+	host->caps &= ~lower_32_bits(dt_caps_mask);
+	host->caps |= lower_32_bits(dt_caps);
 
 	if (host->version < SDHCI_SPEC_300)
 		return;
 
-	if (caps1) {
-		host->caps1 = *caps1;
-	} else {
-		host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
-		host->caps1 &= ~upper_32_bits(dt_caps_mask);
-		host->caps1 |= upper_32_bits(dt_caps);
-	}
+	host->caps1 = caps1 ? *caps1 : sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	host->caps1 &= ~upper_32_bits(dt_caps_mask);
+	host->caps1 |= upper_32_bits(dt_caps);
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
-- 
2.35.1

