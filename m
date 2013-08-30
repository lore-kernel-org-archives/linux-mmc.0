From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 20/22] mmc: dw_mmc: gather each reset code into functions
Date: Sat, 31 Aug 2013 00:14:23 +0900
Message-ID: <001701cea593$9be22df0$d3a689d0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46391 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163Ab3H3POY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:14:24 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC000AYNNZFUP0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:14:23 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

There are three resets in CTRL register.
FIFO reset is especially used in several points with the
same routine. It could be replaced with one function and
the others may be applied similarly if needed.
So, mci_wait_reset() is modified to allow various bit field
of reset

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   81 ++++++++++++++++++++++++---------------------
 1 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 334ee04..b34573c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -110,6 +110,9 @@ static const u8 tuning_blk_pattern_8bit[] = {
 	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
 };
 
+static inline bool dw_mci_fifo_reset(struct dw_mci *host);
+static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host);
+
 #if defined(CONFIG_DEBUG_FS)
 static int dw_mci_req_show(struct seq_file *s, void *v)
 {
@@ -1200,7 +1203,7 @@ static int dw_mci_command_complete(struct dw_mci *host, struct mmc_command *cmd)
 
 static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
 {
-	u32 status = host->data_status, ctrl;
+	u32 status = host->data_status;
 
 	if (status & DW_MCI_DATA_ERROR_FLAGS) {
 		if (status & SDMMC_INT_DRTO) {
@@ -1230,15 +1233,9 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
 
 		/*
 		 * After an error, there may be data lingering
-		 * in the FIFO, so reset it - doing so
-		 * generates a block interrupt, hence setting
-		 * the scatter-gather pointer to NULL.
+		 * in the FIFO
 		 */
-		sg_miter_stop(&host->sg_miter);
-		host->sg = NULL;
-		ctrl = mci_readl(host, CTRL);
-		ctrl |= SDMMC_CTRL_FIFO_RESET;
-		mci_writel(host, CTRL, ctrl);
+		dw_mci_fifo_reset(host);
 	} else {
 		data->bytes_xfered = data->blocks * data->blksz;
 		data->error = 0;
@@ -1255,7 +1252,6 @@ static void dw_mci_tasklet_func(unsigned long priv)
 	struct mmc_request *mrq;
 	enum dw_mci_state state;
 	enum dw_mci_state prev_state;
-	u32 ctrl;
 	unsigned int err;
 
 	spin_lock(&host->lock);
@@ -1355,13 +1351,8 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				break;
 
 			/* CMD error in data command */
-			if (mrq->cmd->error && mrq->data) {
-				sg_miter_stop(&host->sg_miter);
-				host->sg = NULL;
-				ctrl = mci_readl(host, CTRL);
-				ctrl |= SDMMC_CTRL_FIFO_RESET;
-				mci_writel(host, CTRL, ctrl);
-			}
+			if (mrq->cmd->error && mrq->data)
+				dw_mci_fifo_reset(host);
 
 			host->cmd = NULL;
 			host->data = NULL;
@@ -1980,18 +1971,8 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 			if (present == 0) {
 				clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 
-				/*
-				 * Clear down the FIFO - doing so generates a
-				 * block interrupt, hence setting the
-				 * scatter-gather pointer to NULL.
-				 */
-				sg_miter_stop(&host->sg_miter);
-				host->sg = NULL;
-
-				ctrl = mci_readl(host, CTRL);
-				ctrl |= SDMMC_CTRL_FIFO_RESET;
-				mci_writel(host, CTRL, ctrl);
-
+				/* Clear down the FIFO */
+				dw_mci_fifo_reset(host);
 #ifdef CONFIG_MMC_DW_IDMAC
 				ctrl = mci_readl(host, BMOD);
 				/* Software reset of DMA */
@@ -2289,27 +2270,51 @@ no_dma:
 	return;
 }
 
-static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
+static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(500);
-	unsigned int ctrl;
+	u32 ctrl;
 
-	mci_writel(host, CTRL, (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
-				SDMMC_CTRL_DMA_RESET));
+	ctrl = mci_readl(host, CTRL);
+	ctrl |= reset;
+	mci_writel(host, CTRL, ctrl);
 
 	/* wait till resets clear */
 	do {
 		ctrl = mci_readl(host, CTRL);
-		if (!(ctrl & (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
-			      SDMMC_CTRL_DMA_RESET)))
+		if (!(ctrl & reset))
 			return true;
 	} while (time_before(jiffies, timeout));
 
-	dev_err(dev, "Timeout resetting block (ctrl %#x)\n", ctrl);
+	dev_err(host->dev,
+		"Timeout resetting block (ctrl reset %#x)\n",
+		ctrl & reset);
 
 	return false;
 }
 
+static inline bool dw_mci_fifo_reset(struct dw_mci *host)
+{
+	/*
+	 * Reseting generates a block interrupt, hence setting
+	 * the scatter-gather pointer to NULL.
+	 */
+	if (host->sg) {
+		sg_miter_stop(&host->sg_miter);
+		host->sg = NULL;
+	}
+
+	return dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
+}
+
+static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
+{
+	return dw_mci_ctrl_reset(host,
+				 SDMMC_CTRL_FIFO_RESET |
+				 SDMMC_CTRL_RESET |
+				 SDMMC_CTRL_DMA_RESET);
+}
+
 #ifdef CONFIG_OF
 static struct dw_mci_of_quirks {
 	char *quirk;
@@ -2517,7 +2522,7 @@ int dw_mci_probe(struct dw_mci *host)
 	}
 
 	/* Reset all blocks */
-	if (!mci_wait_reset(host->dev, host))
+	if (!dw_mci_ctrl_all_reset(host))
 		return -ENODEV;
 
 	host->dma_ops = host->pdata->dma_ops;
@@ -2723,7 +2728,7 @@ int dw_mci_resume(struct dw_mci *host)
 		}
 	}
 
-	if (!mci_wait_reset(host->dev, host)) {
+	if (!dw_mci_ctrl_all_reset(host)) {
 		ret = -ENODEV;
 		return ret;
 	}
-- 
1.7.0.4


