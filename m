From: Sonny Rao <sonnyrao@chromium.org>
Subject: [PATCH] mmc: dw_mmc: change to use recommended reset procedure
Date: Wed, 28 May 2014 17:35:09 -0700
Message-ID: <1401323709-10345-1-git-send-email-sonnyrao@chromium.org>
References: <CAPz6YkW+eJjoUz0YRb_JOsKXMUhCe4hRUQVQLhZbkfo01fVnqg@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f201.google.com ([209.85.220.201]:60690 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbaE2Afl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 20:35:41 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so2067084vcb.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 May 2014 17:35:40 -0700 (PDT)
In-Reply-To: <CAPz6YkW+eJjoUz0YRb_JOsKXMUhCe4hRUQVQLhZbkfo01fVnqg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grundler@chromium.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jh80.chung@samsung.com, cjb@laptop.org, tgih.jun@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, t.figa@samsung.com, dianders@chromium.org, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Sonny Rao <sonnyrao@chromium.org>

This patch changes the fifo reset code to follow the reset procedure
outlined in the documentation of Synopsys Mobile storage host databook.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
v2: Add Generic DMA support
    per the documentation, move interrupt clear before wait
    make the test for DMA host->use_dma rather than host->using_dma
    add proper return values (although it appears no caller checks)
v3: rename fifo reset function, and change callers
    use this combined reset function in dw_mci_resume()
    just one caller left (probe), so get rid of dw_mci_ctrl_all_reset()
    use DMA reset bit for all systems which use DMA
    remove extra IDMAC reset in dw_mci_work_routine_card()
    do CIU clock update in error path, if CIU reset cleared

 drivers/mmc/host/dw_mmc.c | 85 +++++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/dw_mmc.h |  1 +
 2 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 55cd110..988492c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -111,8 +111,7 @@ static const u8 tuning_blk_pattern_8bit[] = {
 	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
 };
 
-static inline bool dw_mci_fifo_reset(struct dw_mci *host);
-static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host);
+static inline bool dw_mci_reset(struct dw_mci *host);
 
 #if defined(CONFIG_DEBUG_FS)
 static int dw_mci_req_show(struct seq_file *s, void *v)
@@ -1254,7 +1253,7 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
 		 * After an error, there may be data lingering
 		 * in the FIFO
 		 */
-		dw_mci_fifo_reset(host);
+		dw_mci_reset(host);
 	} else {
 		data->bytes_xfered = data->blocks * data->blksz;
 		data->error = 0;
@@ -1371,7 +1370,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 
 			/* CMD error in data command */
 			if (mrq->cmd->error && mrq->data)
-				dw_mci_fifo_reset(host);
+				dw_mci_reset(host);
 
 			host->cmd = NULL;
 			host->data = NULL;
@@ -1982,14 +1981,9 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 			}
 
 			/* Power down slot */
-			if (present == 0) {
+			if (present == 0)
 				/* Clear down the FIFO */
-				dw_mci_fifo_reset(host);
-#ifdef CONFIG_MMC_DW_IDMAC
-				dw_mci_idmac_reset(host);
-#endif
-
-			}
+				dw_mci_reset(host);
 
 			spin_unlock_bh(&host->lock);
 
@@ -2323,8 +2317,11 @@ static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
 	return false;
 }
 
-static inline bool dw_mci_fifo_reset(struct dw_mci *host)
+static inline bool dw_mci_reset(struct dw_mci *host)
 {
+	u32 flags = SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET;
+	bool ret = false;
+
 	/*
 	 * Reseting generates a block interrupt, hence setting
 	 * the scatter-gather pointer to NULL.
@@ -2334,15 +2331,57 @@ static inline bool dw_mci_fifo_reset(struct dw_mci *host)
 		host->sg = NULL;
 	}
 
-	return dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
-}
+	if (host->use_dma)
+		flags |= SDMMC_CTRL_DMA_RESET;
 
-static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
-{
-	return dw_mci_ctrl_reset(host,
-				 SDMMC_CTRL_FIFO_RESET |
-				 SDMMC_CTRL_RESET |
-				 SDMMC_CTRL_DMA_RESET);
+	if (dw_mci_ctrl_reset(host, flags)) {
+		/*
+		 * In all cases we clear the RAWINTS register to clear any
+		 * interrupts.
+		 */
+		mci_writel(host, RINTSTS, 0xFFFFFFFF);
+
+		/* if using dma we wait for dma_req to clear */
+		if (host->use_dma) {
+			unsigned long timeout = jiffies + msecs_to_jiffies(500);
+			u32 status;
+			do {
+				status = mci_readl(host, STATUS);
+				if (!(status & SDMMC_STATUS_DMA_REQ))
+					break;
+				cpu_relax();
+			} while (time_before(jiffies, timeout));
+
+			if (status & SDMMC_STATUS_DMA_REQ) {
+				dev_err(host->dev,
+					"%s: Timeout waiting for dma_req to "
+					"clear during reset", __func__);
+				goto ciu_out;
+			}
+
+			/* when using DMA next we reset the fifo again */
+			if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET))
+				goto ciu_out;
+		}
+	} else {
+		dev_err(host->dev, "%s: Reset bits didn't clear", __func__);
+
+		/* if the controller reset bit did clear, then set clock regs */
+		if (!(mci_readl(host, CTRL) & SDMMC_CTRL_RESET))
+			goto ciu_out;
+	}
+
+	if (IS_ENABLED(CONFIG_MMC_DW_IDMAC))
+		/* It is also recommended that we reset and reprogram idmac */
+		dw_mci_idmac_reset(host);
+
+	ret = true;
+
+ciu_out:
+	/* After a CTRL reset we need to have CIU set clock registers  */
+	mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
+
+	return ret;
 }
 
 #ifdef CONFIG_OF
@@ -2432,6 +2471,7 @@ int dw_mci_probe(struct dw_mci *host)
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int width, i, ret = 0;
 	u32 fifo_size;
+	u32 flags;
 	int init_slots = 0;
 
 	if (!host->pdata) {
@@ -2555,7 +2595,8 @@ int dw_mci_probe(struct dw_mci *host)
 	}
 
 	/* Reset all blocks */
-	if (!dw_mci_ctrl_all_reset(host))
+	flags = SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET | SDMMC_CTRL_DMA_RESET;
+	if (!dw_mci_ctrl_reset(host, flags))
 		return -ENODEV;
 
 	host->dma_ops = host->pdata->dma_ops;
@@ -2744,7 +2785,7 @@ int dw_mci_resume(struct dw_mci *host)
 		}
 	}
 
-	if (!dw_mci_ctrl_all_reset(host)) {
+	if (!dw_mci_reset(host)) {
 		ret = -ENODEV;
 		return ret;
 	}
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 6bf24ab..2505804 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -129,6 +129,7 @@
 #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
 /* Status register defines */
 #define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
+#define SDMMC_STATUS_DMA_REQ		BIT(31)
 /* FIFOTH register defines */
 #define SDMMC_SET_FIFOTH(m, r, t)	(((m) & 0x7) << 28 | \
 					 ((r) & 0xFFF) << 16 | \
-- 
1.8.3.2

