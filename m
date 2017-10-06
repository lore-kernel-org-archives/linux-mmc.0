From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH 5/9] Revert "mmc: dw_mmc: change the array of slots"
Date: Fri,  6 Oct 2017 15:21:28 -0400
Message-ID: <130cf23384f1e6067893a97c2fea7f0f30b3008d.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40048 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752519AbdJFTWD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Oct 2017 15:22:03 -0400
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

This reverts commit b23475faed77f6a9016013c8db6b4707466e74a8.

The Mellanox BlueField SoC requires multiple slot dw-mmc support.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/host/dw_mmc.c | 21 ++++++++++++---------
 drivers/mmc/host/dw_mmc.h |  4 +++-
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a4356d6..d11b8d7 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2582,7 +2582,8 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 
 static void dw_mci_handle_cd(struct dw_mci *host)
 {
-	struct dw_mci_slot *slot = host->slot;
+	int i = 0;
+	struct dw_mci_slot *slot = host->slot[i];
 
 	if (slot->mmc->ops->card_event)
 		slot->mmc->ops->card_event(slot->mmc);
@@ -2594,7 +2595,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 {
 	struct dw_mci *host = dev_id;
 	u32 pending;
-	struct dw_mci_slot *slot = host->slot;
+	int i = 0;
+	struct dw_mci_slot *slot = host->slot[i];
 
 	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
 
@@ -2726,7 +2728,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	slot->sdio_id = host->sdio_id0 + id;
 	slot->mmc = mmc;
 	slot->host = host;
-	host->slot = slot;
+	host->slot[id] = slot;
 
 	mmc->ops = &dw_mci_ops;
 	if (device_property_read_u32_array(host->dev, "clock-freq-min-max",
@@ -2826,7 +2828,7 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 {
 	/* Debugfs stuff is cleaned up by mmc core */
 	mmc_remove_host(slot->mmc);
-	slot->host->slot = NULL;
+	slot->host->slot[id] = NULL;
 	mmc_free_host(slot->mmc);
 }
 
@@ -3041,13 +3043,14 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 {
 	unsigned long irqflags;
 	u32 temp;
+	int i = 0;
 	struct dw_mci_slot *slot;
 
 	/*
 	 * No need for CD if all slots have a non-error GPIO
 	 * as well as broken card detection is found.
 	 */
-	slot = host->slot;
+	slot = host->slot[i];
 	if (slot->mmc->caps & MMC_CAP_NEEDS_POLL)
 		return;
 
@@ -3278,8 +3281,8 @@ void dw_mci_remove(struct dw_mci *host)
 	int i = 0;
 
 	dev_dbg(host->dev, "remove slot %d\n", i);
-	if (host->slot)
-		dw_mci_cleanup_slot(host->slot, i);
+	if (host->slot[i])
+		dw_mci_cleanup_slot(host->slot[i], i);
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
@@ -3322,9 +3325,9 @@ int dw_mci_runtime_suspend(struct device *dev)
 
 int dw_mci_runtime_resume(struct device *dev)
 {
-	int ret = 0;
+	int i = 0, ret = 0;
 	struct dw_mci *host = dev_get_drvdata(dev);
-	struct dw_mci_slot *slot = host->slot;
+	struct dw_mci_slot *slot = host->slot[i];
 
 	if (host->cur_slot &&
 	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 20a956e..e62cafc 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -20,6 +20,8 @@
 #include <linux/reset.h>
 #include <linux/interrupt.h>
 
+#define MAX_MCI_SLOTS	2
+
 enum dw_mci_state {
 	STATE_IDLE = 0,
 	STATE_SENDING_CMD,
@@ -214,7 +216,7 @@ struct dw_mci {
 	void			*priv;
 	struct clk		*biu_clk;
 	struct clk		*ciu_clk;
-	struct dw_mci_slot	*slot;
+	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
 
 	/* FIFO push and pull */
 	int			fifo_depth;
-- 
1.8.3.1

