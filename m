From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/6] mmc: dw_mmc: change the array of slots
Date: Mon, 05 Jun 2017 13:41:32 +0900
Message-ID: <20170605044135.18304-4-jh80.chung@samsung.com>
References: <20170605044135.18304-1-jh80.chung@samsung.com>
        <CGME20170605044137epcas1p413b27e4b2f3db83c1623acf4cc2b9cdc@epcas1p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32919 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbdFEElj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2017 00:41:39 -0400
In-reply-to: <20170605044135.18304-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

It doesn't need to use the array of slots anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 21 +++++++++------------
 drivers/mmc/host/dw_mmc.h |  4 +---
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1b415da..8ed3c87 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2563,8 +2563,7 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 
 static void dw_mci_handle_cd(struct dw_mci *host)
 {
-	int i = 0;
-	struct dw_mci_slot *slot = host->slot[i];
+	struct dw_mci_slot *slot = host->slot;
 
 	if (slot->mmc->ops->card_event)
 		slot->mmc->ops->card_event(slot->mmc);
@@ -2576,8 +2575,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 {
 	struct dw_mci *host = dev_id;
 	u32 pending;
-	int i = 0;
-	struct dw_mci_slot *slot = host->slot[i];
+	struct dw_mci_slot *slot = host->slot;
 
 	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
 
@@ -2707,7 +2705,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	slot->sdio_id = host->sdio_id0 + id;
 	slot->mmc = mmc;
 	slot->host = host;
-	host->slot[id] = slot;
+	host->slot = slot;
 
 	mmc->ops = &dw_mci_ops;
 	if (device_property_read_u32_array(host->dev, "clock-freq-min-max",
@@ -2807,7 +2805,7 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 {
 	/* Debugfs stuff is cleaned up by mmc core */
 	mmc_remove_host(slot->mmc);
-	slot->host->slot[id] = NULL;
+	slot->host->slot = NULL;
 	mmc_free_host(slot->mmc);
 }
 
@@ -2998,14 +2996,13 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 {
 	unsigned long irqflags;
 	u32 temp;
-	int i = 0;
 	struct dw_mci_slot *slot;
 
 	/*
 	 * No need for CD if all slots have a non-error GPIO
 	 * as well as broken card detection is found.
 	 */
-	slot = host->slot[i];
+	slot = host->slot;
 	if (slot->mmc->caps & MMC_CAP_NEEDS_POLL)
 		return;
 
@@ -3233,8 +3230,8 @@ void dw_mci_remove(struct dw_mci *host)
 	int i = 0;
 
 	dev_dbg(host->dev, "remove slot %d\n", i);
-	if (host->slot[i])
-		dw_mci_cleanup_slot(host->slot[i], i);
+	if (host->slot)
+		dw_mci_cleanup_slot(host->slot, i);
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
@@ -3277,9 +3274,9 @@ EXPORT_SYMBOL(dw_mci_runtime_suspend);
 
 int dw_mci_runtime_resume(struct device *dev)
 {
-	int i = 0, ret = 0;
+	int ret = 0;
 	struct dw_mci *host = dev_get_drvdata(dev);
-	struct dw_mci_slot *slot = host->slot[i];
+	struct dw_mci_slot *slot = host->slot;
 
 	if (host->cur_slot &&
 	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index ce34736..1ec8f40 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -20,8 +20,6 @@
 #include <linux/reset.h>
 #include <linux/interrupt.h>
 
-#define MAX_MCI_SLOTS	2
-
 enum dw_mci_state {
 	STATE_IDLE = 0,
 	STATE_SENDING_CMD,
@@ -215,7 +213,7 @@ struct dw_mci {
 	void			*priv;
 	struct clk		*biu_clk;
 	struct clk		*ciu_clk;
-	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
+	struct dw_mci_slot	*slot;
 
 	/* FIFO push and pull */
 	int			fifo_depth;
-- 
2.10.2

