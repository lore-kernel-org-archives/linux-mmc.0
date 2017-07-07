From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH] mmc: sdhci-of-arasan: use functions and OFFSETS from sdhci.h
Date: Fri,  7 Jul 2017 08:43:30 -0400
Message-ID: <1499431410-11404-1-git-send-email-jeff.dagenais@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35480 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdGGMnn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jul 2017 08:43:43 -0400
Received: by mail-it0-f65.google.com with SMTP id v193so5166164itc.2
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jul 2017 05:43:43 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, michal.simek@xilinx.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Jean-Francois Dagenais <jeff.dagenais@gmail.com>

This increases consistency of the code across the sdhci family.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index cdee35a..da9b824 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -33,7 +33,6 @@
 #include "sdhci-pltfm.h"
 #include <linux/of.h>
 
-#define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
 #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
 
 #define VENDOR_ENHANCED_STROBE		BIT(0)
@@ -179,7 +178,7 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
 	unsigned long freq;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 
-	div = readl(host->ioaddr + SDHCI_ARASAN_CLK_CTRL_OFFSET);
+	div = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
 	div = (div & CLK_CTRL_TIMEOUT_MASK) >> CLK_CTRL_TIMEOUT_SHIFT;
 
 	freq = clk_get_rate(pltfm_host->clk);
@@ -451,13 +450,13 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
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
2.1.4

