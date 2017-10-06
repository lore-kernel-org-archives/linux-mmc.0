From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH 2/9] Revert "mmc: dw_mmc: remove the unnecessary slot variable"
Date: Fri,  6 Oct 2017 15:21:25 -0400
Message-ID: <0e89c1c60e1f6ed2210a71f0ec436f9292d2a1ad.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This reverts commit e47c0b96678c5fd731c125dca677880e06d6394c.

The Mellanox BlueField SoC requires multiple slot dw-mmc support.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/host/dw_mmc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 860313b..c9f81db 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3040,15 +3040,17 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 {
 	unsigned long irqflags;
 	u32 temp;
+	struct dw_mci_slot *slot;
 
 	/*
 	 * No need for CD if all slots have a non-error GPIO
 	 * as well as broken card detection is found.
 	 */
-	if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
+	slot = host->slot;
+	if (slot->mmc->caps & MMC_CAP_NEEDS_POLL)
 		return;
 
-	if (mmc_gpio_get_cd(host->slot->mmc) < 0) {
+	if (mmc_gpio_get_cd(slot->mmc) < 0) {
 		spin_lock_irqsave(&host->irq_lock, irqflags);
 		temp = mci_readl(host, INTMASK);
 		temp  |= SDMMC_INT_CD;
@@ -3319,6 +3321,7 @@ int dw_mci_runtime_resume(struct device *dev)
 {
 	int ret = 0;
 	struct dw_mci *host = dev_get_drvdata(dev);
+	struct dw_mci_slot *slot = host->slot;
 
 	if (host->slot &&
 	    (mmc_can_gpio_cd(host->slot->mmc) ||
@@ -3358,11 +3361,11 @@ int dw_mci_runtime_resume(struct device *dev)
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
 
-	if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
-		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
+	if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
+		dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
 
 	/* Force setup bus to guarantee available clock output */
-	dw_mci_setup_bus(host->slot, true);
+	dw_mci_setup_bus(slot, true);
 
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
-- 
1.8.3.1
