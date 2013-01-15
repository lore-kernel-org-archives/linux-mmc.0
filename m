From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mmc: sdhci-esdhc-imx: remove ESDHC_CD_GPIO handling from IO accessory
Date: Tue, 15 Jan 2013 23:19:54 +0800
Message-ID: <1358263194-3298-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:5238 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755556Ab3AOPUB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jan 2013 10:20:01 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>

With commit 9444e07 (mmc: remove unncessary mmc_gpio_free_cd() call from
slot-gpio users) in place, those ESDHC_CD_GPIO handling in IO accessory
becomes unnecessary.  Remove them.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index dd7fcc1..ae68bc9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -150,16 +150,6 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 
 	u32 val = readl(host->ioaddr + reg);
 
-	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
-		/*
-		 * After SDHCI core gets improved to never query
-		 * SDHCI_CARD_PRESENT state in GPIO case, we can
-		 * remove this check.
-		 */
-		if (boarddata->cd_type == ESDHC_CD_GPIO)
-			val &= ~SDHCI_CARD_PRESENT;
-	}
-
 	if (unlikely(reg == SDHCI_CAPABILITIES)) {
 		/* In FSL esdhc IC module, only bit20 is used to indicate the
 		 * ADMA2 capability of esdhc, but this bit is messed up on
@@ -192,13 +182,6 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 	u32 data;
 
 	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
-		if (boarddata->cd_type == ESDHC_CD_GPIO)
-			/*
-			 * These interrupts won't work with a custom
-			 * card_detect gpio (only applied to mx25/35)
-			 */
-			val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
-
 		if (val & SDHCI_INT_CARD_INT) {
 			/*
 			 * Clear and then set D3CD bit to avoid missing the
-- 
1.7.9.5


