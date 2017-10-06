From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH 6/9] Revert "mmc: dw_mmc: remove the loop about finding slots"
Date: Fri,  6 Oct 2017 15:21:29 -0400
Message-ID: <6afec6ed816a424fe78a2d8a300fbfeef0bf8bc2.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This reverts commit 58870241a67453be7dc9ab368d5a0cdc9c404616.

The Mellanox BlueField SoC requires multiple slot dw-mmc support.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/host/dw_mmc.c | 115 +++++++++++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d11b8d7..ef36e05 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2582,21 +2582,26 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 
 static void dw_mci_handle_cd(struct dw_mci *host)
 {
-	int i = 0;
-	struct dw_mci_slot *slot = host->slot[i];
+	int i;
+
+	for (i = 0; i < host->num_slots; i++) {
+		struct dw_mci_slot *slot = host->slot[i];
+
+		if (!slot)
+			continue;
 
-	if (slot->mmc->ops->card_event)
-		slot->mmc->ops->card_event(slot->mmc);
-	mmc_detect_change(slot->mmc,
-		msecs_to_jiffies(host->pdata->detect_delay_ms));
+		if (slot->mmc->ops->card_event)
+			slot->mmc->ops->card_event(slot->mmc);
+		mmc_detect_change(slot->mmc,
+			msecs_to_jiffies(host->pdata->detect_delay_ms));
+	}
 }
 
 static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 {
 	struct dw_mci *host = dev_id;
 	u32 pending;
-	int i = 0;
-	struct dw_mci_slot *slot = host->slot[i];
+	int i;
 
 	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
 
@@ -2675,11 +2680,19 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			dw_mci_handle_cd(host);
 		}
 
-		if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
-			mci_writel(host, RINTSTS,
-				   SDMMC_INT_SDIO(slot->sdio_id));
-			__dw_mci_enable_sdio_irq(slot, 0);
-			sdio_signal_irq(slot->mmc);
+		/* Handle SDIO Interrupts */
+		for (i = 0; i < host->num_slots; i++) {
+			struct dw_mci_slot *slot = host->slot[i];
+
+			if (!slot)
+				continue;
+
+			if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
+				mci_writel(host, RINTSTS,
+					   SDMMC_INT_SDIO(slot->sdio_id));
+				__dw_mci_enable_sdio_irq(slot, 0);
+				sdio_signal_irq(slot->mmc);
+			}
 		}
 
 	}
@@ -3043,24 +3056,29 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 {
 	unsigned long irqflags;
 	u32 temp;
-	int i = 0;
+	int i;
 	struct dw_mci_slot *slot;
 
 	/*
 	 * No need for CD if all slots have a non-error GPIO
 	 * as well as broken card detection is found.
 	 */
-	slot = host->slot[i];
-	if (slot->mmc->caps & MMC_CAP_NEEDS_POLL)
-		return;
+	for (i = 0; i < host->num_slots; i++) {
+		slot = host->slot[i];
+		if (slot->mmc->caps & MMC_CAP_NEEDS_POLL)
+			return;
 
-	if (mmc_gpio_get_cd(slot->mmc) < 0) {
-		spin_lock_irqsave(&host->irq_lock, irqflags);
-		temp = mci_readl(host, INTMASK);
-		temp  |= SDMMC_INT_CD;
-		mci_writel(host, INTMASK, temp);
-		spin_unlock_irqrestore(&host->irq_lock, irqflags);
+		if (mmc_gpio_get_cd(slot->mmc) < 0)
+			break;
 	}
+	if (i == host->num_slots)
+		return;
+
+	spin_lock_irqsave(&host->irq_lock, irqflags);
+	temp = mci_readl(host, INTMASK);
+	temp  |= SDMMC_INT_CD;
+	mci_writel(host, INTMASK, temp);
+	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
 int dw_mci_probe(struct dw_mci *host)
@@ -3068,6 +3086,7 @@ int dw_mci_probe(struct dw_mci *host)
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int width, i, ret = 0;
 	u32 fifo_size;
+	int init_slots = 0;
 
 	if (!host->pdata) {
 		host->pdata = dw_mci_parse_dt(host);
@@ -3234,6 +3253,13 @@ int dw_mci_probe(struct dw_mci *host)
 		goto err_dmaunmap;
 
 	/*
+	 * Even though dwmmc IP is provided the multiple slots,
+	 * there is no use case in mmc subsystem.
+	 * dwmmc host controller needs to initialize the one slot per an IP.
+	 */
+	host->num_slots = 1;
+
+	/*
 	 * Enable interrupts for command done, data over, data empty,
 	 * receive ready and error such as transmit, receive timeout, crc error
 	 */
@@ -3248,9 +3274,20 @@ int dw_mci_probe(struct dw_mci *host)
 		 host->irq, width, fifo_size);
 
 	/* We need at least one slot to succeed */
-	ret = dw_mci_init_slot(host, 0);
-	if (ret) {
-		dev_dbg(host->dev, "slot %d init failed\n", i);
+	for (i = 0; i < host->num_slots; i++) {
+		ret = dw_mci_init_slot(host, i);
+		if (ret)
+			dev_dbg(host->dev, "slot %d init failed\n", i);
+		else
+			init_slots++;
+	}
+
+	if (init_slots) {
+		dev_info(host->dev, "%d slots initialized\n", init_slots);
+	} else {
+		dev_dbg(host->dev,
+			"attempted to initialize %d slots, but failed on all\n",
+			host->num_slots);
 		goto err_dmaunmap;
 	}
 
@@ -3278,11 +3315,13 @@ int dw_mci_probe(struct dw_mci *host)
 
 void dw_mci_remove(struct dw_mci *host)
 {
-	int i = 0;
+	int i;
 
-	dev_dbg(host->dev, "remove slot %d\n", i);
-	if (host->slot[i])
-		dw_mci_cleanup_slot(host->slot[i], i);
+	for (i = 0; i < host->num_slots; i++) {
+		dev_dbg(host->dev, "remove slot %d\n", i);
+		if (host->slot[i])
+			dw_mci_cleanup_slot(host->slot[i], i);
+	}
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
@@ -3325,9 +3364,8 @@ int dw_mci_runtime_suspend(struct device *dev)
 
 int dw_mci_runtime_resume(struct device *dev)
 {
-	int i = 0, ret = 0;
+	int i, ret = 0;
 	struct dw_mci *host = dev_get_drvdata(dev);
-	struct dw_mci_slot *slot = host->slot[i];
 
 	if (host->cur_slot &&
 	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
@@ -3366,12 +3404,17 @@ int dw_mci_runtime_resume(struct device *dev)
 		   DW_MCI_ERROR_FLAGS);
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
+	for (i = 0; i < host->num_slots; i++) {
+		struct dw_mci_slot *slot = host->slot[i];
 
-	if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
-		dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
+		if (!slot)
+			continue;
+		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
+			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
 
-	/* Force setup bus to guarantee available clock output */
-	dw_mci_setup_bus(slot, true);
+		/* Force setup bus to guarantee available clock output */
+		dw_mci_setup_bus(slot, true);
+	}
 
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
-- 
1.8.3.1
