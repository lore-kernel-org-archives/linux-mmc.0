From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 4/6] mmc: dw_mmc: remove the 'id' arguments about functions
 relevant to slot
Date: Mon, 05 Jun 2017 13:41:33 +0900
Message-ID: <20170605044135.18304-5-jh80.chung@samsung.com>
References: <20170605044135.18304-1-jh80.chung@samsung.com>
        <CGME20170605044137epcas1p4c0df9a32c3987a0c4751900cdb439650@epcas1p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32922 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbdFEElk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2017 00:41:40 -0400
In-reply-to: <20170605044135.18304-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

Doesn't need to pass the id value for slot functions.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 8ed3c87..8a4fa88 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2688,7 +2688,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
+static int dw_mci_init_slot(struct dw_mci *host)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
@@ -2701,8 +2701,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		return -ENOMEM;
 
 	slot = mmc_priv(mmc);
-	slot->id = id;
-	slot->sdio_id = host->sdio_id0 + id;
+	slot->id = 0;
+	slot->sdio_id = host->sdio_id0 + slot->id;
 	slot->mmc = mmc;
 	slot->host = host;
 	host->slot = slot;
@@ -2801,7 +2801,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	return ret;
 }
 
-static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
+static void dw_mci_cleanup_slot(struct dw_mci_slot *slot)
 {
 	/* Debugfs stuff is cleaned up by mmc core */
 	mmc_remove_host(slot->mmc);
@@ -3197,7 +3197,7 @@ int dw_mci_probe(struct dw_mci *host)
 		 host->irq, width, fifo_size);
 
 	/* We need at least one slot to succeed */
-	ret = dw_mci_init_slot(host, 0);
+	ret = dw_mci_init_slot(host);
 	if (ret) {
 		dev_dbg(host->dev, "slot %d init failed\n", i);
 		goto err_dmaunmap;
@@ -3227,11 +3227,9 @@ EXPORT_SYMBOL(dw_mci_probe);
 
 void dw_mci_remove(struct dw_mci *host)
 {
-	int i = 0;
-
-	dev_dbg(host->dev, "remove slot %d\n", i);
+	dev_dbg(host->dev, "remove slot\n");
 	if (host->slot)
-		dw_mci_cleanup_slot(host->slot, i);
+		dw_mci_cleanup_slot(host->slot);
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
-- 
2.10.2

