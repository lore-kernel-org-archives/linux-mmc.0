From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 6/6] mmc: dw_mmc: remove the unnecessary slot variable
Date: Mon, 05 Jun 2017 13:41:35 +0900
Message-ID: <20170605044135.18304-7-jh80.chung@samsung.com>
References: <20170605044135.18304-1-jh80.chung@samsung.com>
        <CGME20170605044137epcas1p4e618a41342719da1ba318627baff7098@epcas1p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32924 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdFEElk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2017 00:41:40 -0400
In-reply-to: <20170605044135.18304-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the unnecessary slot variable.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 97a8b0c..a9dfb26 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2995,17 +2995,15 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 {
 	unsigned long irqflags;
 	u32 temp;
-	struct dw_mci_slot *slot;
 
 	/*
 	 * No need for CD if all slots have a non-error GPIO
 	 * as well as broken card detection is found.
 	 */
-	slot = host->slot;
-	if (slot->mmc->caps & MMC_CAP_NEEDS_POLL)
+	if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
 		return;
 
-	if (mmc_gpio_get_cd(slot->mmc) < 0) {
+	if (mmc_gpio_get_cd(host->slot->mmc) < 0) {
 		spin_lock_irqsave(&host->irq_lock, irqflags);
 		temp = mci_readl(host, INTMASK);
 		temp  |= SDMMC_INT_CD;
@@ -3273,7 +3271,6 @@ int dw_mci_runtime_resume(struct device *dev)
 {
 	int ret = 0;
 	struct dw_mci *host = dev_get_drvdata(dev);
-	struct dw_mci_slot *slot = host->slot;
 
 	if (host->slot &&
 	    (mmc_can_gpio_cd(host->slot->mmc) ||
@@ -3313,11 +3310,11 @@ int dw_mci_runtime_resume(struct device *dev)
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
 
-	if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
-		dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
+	if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
+		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
 
 	/* Force setup bus to guarantee available clock output */
-	dw_mci_setup_bus(slot, true);
+	dw_mci_setup_bus(host->slot, true);
 
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
-- 
2.10.2

