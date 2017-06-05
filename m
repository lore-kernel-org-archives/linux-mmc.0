From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/6] mmc: dw_mmc: remove the loop about finding slots
Date: Mon, 05 Jun 2017 13:41:31 +0900
Message-ID: <20170605044135.18304-3-jh80.chung@samsung.com>
References: <20170605044135.18304-1-jh80.chung@samsung.com>
        <CGME20170605044137epcas1p47fa50e6e9a2b68eccc1f726a33e14c0e@epcas1p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:63528 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdFEElj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2017 00:41:39 -0400
In-reply-to: <20170605044135.18304-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

dwmmc controller has used the only one slot.
It doesn't need to check the other slots.
Remove the loop about finding slots.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 115 +++++++++++++++-------------------------------
 1 file changed, 36 insertions(+), 79 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a66edd0..1b415da 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2563,26 +2563,21 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 
 static void dw_mci_handle_cd(struct dw_mci *host)
 {
-	int i;
-
-	for (i = 0; i < host->num_slots; i++) {
-		struct dw_mci_slot *slot = host->slot[i];
-
-		if (!slot)
-			continue;
+	int i = 0;
+	struct dw_mci_slot *slot = host->slot[i];
 
-		if (slot->mmc->ops->card_event)
-			slot->mmc->ops->card_event(slot->mmc);
-		mmc_detect_change(slot->mmc,
-			msecs_to_jiffies(host->pdata->detect_delay_ms));
-	}
+	if (slot->mmc->ops->card_event)
+		slot->mmc->ops->card_event(slot->mmc);
+	mmc_detect_change(slot->mmc,
+		msecs_to_jiffies(host->pdata->detect_delay_ms));
 }
 
 static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 {
 	struct dw_mci *host = dev_id;
 	u32 pending;
-	int i;
+	int i = 0;
+	struct dw_mci_slot *slot = host->slot[i];
 
 	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
 
@@ -2659,19 +2654,11 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			dw_mci_handle_cd(host);
 		}
 
-		/* Handle SDIO Interrupts */
-		for (i = 0; i < host->num_slots; i++) {
-			struct dw_mci_slot *slot = host->slot[i];
-
-			if (!slot)
-				continue;
-
-			if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
-				mci_writel(host, RINTSTS,
-					   SDMMC_INT_SDIO(slot->sdio_id));
-				__dw_mci_enable_sdio_irq(slot, 0);
-				sdio_signal_irq(slot->mmc);
-			}
+		if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
+			mci_writel(host, RINTSTS,
+				   SDMMC_INT_SDIO(slot->sdio_id));
+			__dw_mci_enable_sdio_irq(slot, 0);
+			sdio_signal_irq(slot->mmc);
 		}
 
 	}
@@ -3011,29 +2998,24 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 {
 	unsigned long irqflags;
 	u32 temp;
-	int i;
+	int i = 0;
 	struct dw_mci_slot *slot;
 
 	/*
 	 * No need for CD if all slots have a non-error GPIO
 	 * as well as broken card detection is found.
 	 */
-	for (i = 0; i < host->num_slots; i++) {
-		slot = host->slot[i];
-		if (slot->mmc->caps & MMC_CAP_NEEDS_POLL)
-			return;
-
-		if (mmc_gpio_get_cd(slot->mmc) < 0)
-			break;
-	}
-	if (i == host->num_slots)
+	slot = host->slot[i];
+	if (slot->mmc->caps & MMC_CAP_NEEDS_POLL)
 		return;
 
-	spin_lock_irqsave(&host->irq_lock, irqflags);
-	temp = mci_readl(host, INTMASK);
-	temp  |= SDMMC_INT_CD;
-	mci_writel(host, INTMASK, temp);
-	spin_unlock_irqrestore(&host->irq_lock, irqflags);
+	if (mmc_gpio_get_cd(slot->mmc) < 0) {
+		spin_lock_irqsave(&host->irq_lock, irqflags);
+		temp = mci_readl(host, INTMASK);
+		temp  |= SDMMC_INT_CD;
+		mci_writel(host, INTMASK, temp);
+		spin_unlock_irqrestore(&host->irq_lock, irqflags);
+	}
 }
 
 int dw_mci_probe(struct dw_mci *host)
@@ -3041,7 +3023,6 @@ int dw_mci_probe(struct dw_mci *host)
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int width, i, ret = 0;
 	u32 fifo_size;
-	int init_slots = 0;
 
 	if (!host->pdata) {
 		host->pdata = dw_mci_parse_dt(host);
@@ -3205,13 +3186,6 @@ int dw_mci_probe(struct dw_mci *host)
 		goto err_dmaunmap;
 
 	/*
-	 * Even though dwmmc IP is provided the multiple slots,
-	 * there is no use case in mms subsystem.
-	 * dwmmc host controller needs to initialize the one slot per an IP.
-	 */
-	host->num_slots = 1;
-
-	/*
 	 * Enable interrupts for command done, data over, data empty,
 	 * receive ready and error such as transmit, receive timeout, crc error
 	 */
@@ -3226,20 +3200,9 @@ int dw_mci_probe(struct dw_mci *host)
 		 host->irq, width, fifo_size);
 
 	/* We need at least one slot to succeed */
-	for (i = 0; i < host->num_slots; i++) {
-		ret = dw_mci_init_slot(host, i);
-		if (ret)
-			dev_dbg(host->dev, "slot %d init failed\n", i);
-		else
-			init_slots++;
-	}
-
-	if (init_slots) {
-		dev_info(host->dev, "%d slots initialized\n", init_slots);
-	} else {
-		dev_dbg(host->dev,
-			"attempted to initialize %d slots, but failed on all\n",
-			host->num_slots);
+	ret = dw_mci_init_slot(host, 0);
+	if (ret) {
+		dev_dbg(host->dev, "slot %d init failed\n", i);
 		goto err_dmaunmap;
 	}
 
@@ -3267,13 +3230,11 @@ EXPORT_SYMBOL(dw_mci_probe);
 
 void dw_mci_remove(struct dw_mci *host)
 {
-	int i;
+	int i = 0;
 
-	for (i = 0; i < host->num_slots; i++) {
-		dev_dbg(host->dev, "remove slot %d\n", i);
-		if (host->slot[i])
-			dw_mci_cleanup_slot(host->slot[i], i);
-	}
+	dev_dbg(host->dev, "remove slot %d\n", i);
+	if (host->slot[i])
+		dw_mci_cleanup_slot(host->slot[i], i);
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
@@ -3316,8 +3277,9 @@ EXPORT_SYMBOL(dw_mci_runtime_suspend);
 
 int dw_mci_runtime_resume(struct device *dev)
 {
-	int i, ret = 0;
+	int i = 0, ret = 0;
 	struct dw_mci *host = dev_get_drvdata(dev);
+	struct dw_mci_slot *slot = host->slot[i];
 
 	if (host->cur_slot &&
 	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
@@ -3356,17 +3318,12 @@ int dw_mci_runtime_resume(struct device *dev)
 		   DW_MCI_ERROR_FLAGS);
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
-	for (i = 0; i < host->num_slots; i++) {
-		struct dw_mci_slot *slot = host->slot[i];
 
-		if (!slot)
-			continue;
-		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
-			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
+	if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
+		dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
 
-		/* Force setup bus to guarantee available clock output */
-		dw_mci_setup_bus(slot, true);
-	}
+	/* Force setup bus to guarantee available clock output */
+	dw_mci_setup_bus(slot, true);
 
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
-- 
2.10.2

