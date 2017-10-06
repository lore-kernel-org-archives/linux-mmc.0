From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH 4/9] Revert "mmc: dw_mmc: remove the 'id' arguments about functions relevant to slot"
Date: Fri,  6 Oct 2017 15:21:27 -0400
Message-ID: <81ba5b31d61e0f525a732dd6c328c22cceac6a54.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This reverts commit e4a65ef7687b6aaf36bedb497d3fd1480163d2d5.

The Mellanox BlueField SoC requires multiple slot dw-mmc support.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/host/dw_mmc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 62c0791..a4356d6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2709,7 +2709,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int dw_mci_init_slot(struct dw_mci *host)
+static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
@@ -2722,8 +2722,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
 		return -ENOMEM;
 
 	slot = mmc_priv(mmc);
-	slot->id = 0;
-	slot->sdio_id = host->sdio_id0 + slot->id;
+	slot->id = id;
+	slot->sdio_id = host->sdio_id0 + id;
 	slot->mmc = mmc;
 	slot->host = host;
 	host->slot = slot;
@@ -2822,7 +2822,7 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	return ret;
 }
 
-static void dw_mci_cleanup_slot(struct dw_mci_slot *slot)
+static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 {
 	/* Debugfs stuff is cleaned up by mmc core */
 	mmc_remove_host(slot->mmc);
@@ -3245,7 +3245,7 @@ int dw_mci_probe(struct dw_mci *host)
 		 host->irq, width, fifo_size);
 
 	/* We need at least one slot to succeed */
-	ret = dw_mci_init_slot(host);
+	ret = dw_mci_init_slot(host, 0);
 	if (ret) {
 		dev_dbg(host->dev, "slot %d init failed\n", i);
 		goto err_dmaunmap;
@@ -3275,9 +3275,11 @@ int dw_mci_probe(struct dw_mci *host)
 
 void dw_mci_remove(struct dw_mci *host)
 {
-	dev_dbg(host->dev, "remove slot\n");
+	int i = 0;
+
+	dev_dbg(host->dev, "remove slot %d\n", i);
 	if (host->slot)
-		dw_mci_cleanup_slot(host->slot);
+		dw_mci_cleanup_slot(host->slot, i);
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
-- 
1.8.3.1
