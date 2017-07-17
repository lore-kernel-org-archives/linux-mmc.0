From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH] mmc: sdhci-of-arasan: use io functions from sdhci.h
Date: Sun, 16 Jul 2017 21:23:32 -0400
Message-ID: <20170717012332.16505-1-jeff.dagenais@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36375 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdGQBXh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Jul 2017 21:23:37 -0400
Received: by mail-it0-f66.google.com with SMTP id k3so16894462ita.3
        for <linux-mmc@vger.kernel.org>; Sun, 16 Jul 2017 18:23:36 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, michal.simek@xilinx.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Jean-Francois Dagenais <jeff.dagenais@gmail.com>

This increases consistency of the code across the sdhci family.

v2: rebased onto ulfh/mmc/next and tweaked headline accordingly.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index b13c0a7d50e4..528a5d24c0bc 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -216,13 +216,13 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
 	u32 vendor;
 	struct sdhci_host *host = mmc_priv(mmc);
 
-	vendor = readl(host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
+	vendor = sdhci_readl(host, SDHCI_ARASAN_VENDOR_REGISTER);
 	if (ios->enhanced_strobe)
 		vendor |= VENDOR_ENHANCED_STROBE;
 	else
 		vendor &= ~VENDOR_ENHANCED_STROBE;
 
-	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
+	sdhci_writel(host, vendor, SDHCI_ARASAN_VENDOR_REGISTER);
 }
 
 static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
-- 
2.11.0

