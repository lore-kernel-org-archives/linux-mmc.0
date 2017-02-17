From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/7] mmc: dw_mmc: move dw_mci_reset forward to avoid declaration
Date: Fri, 17 Feb 2017 10:56:40 +0800
Message-ID: <1487300205-202825-3-git-send-email-shawn.lin@rock-chips.com>
References: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:51663 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754293AbdBQC7r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 21:59:47 -0500
In-Reply-To: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 131 +++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 66 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a1ddbb8..20fe96c8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -106,7 +106,6 @@ struct idmac_desc {
 /* Each descriptor can transfer up to 4KB of data in chained mode */
 #define DW_MCI_DESC_DATA_LENGTH	0x1000
 
-static bool dw_mci_reset(struct dw_mci *host);
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
 static int dw_mci_card_busy(struct mmc_host *mmc);
 static int dw_mci_get_cd(struct mmc_host *mmc);
@@ -1674,6 +1673,71 @@ static int dw_mci_prepare_hs400_tuning(struct mmc_host *mmc,
 	return 0;
 }
 
+static bool dw_mci_reset(struct dw_mci *host)
+{
+	u32 flags = SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET;
+	bool ret = false;
+
+	/*
+	 * Resetting generates a block interrupt, hence setting
+	 * the scatter-gather pointer to NULL.
+	 */
+	if (host->sg) {
+		sg_miter_stop(&host->sg_miter);
+		host->sg = NULL;
+	}
+
+	if (host->use_dma)
+		flags |= SDMMC_CTRL_DMA_RESET;
+
+	if (dw_mci_ctrl_reset(host, flags)) {
+		/*
+		 * In all cases we clear the RAWINTS register to clear any
+		 * interrupts.
+		 */
+		mci_writel(host, RINTSTS, 0xFFFFFFFF);
+
+		/* if using dma we wait for dma_req to clear */
+		if (host->use_dma) {
+			u32 status;
+
+			if (readl_poll_timeout_atomic(host->regs + SDMMC_STATUS,
+						      status,
+						      !(status & SDMMC_STATUS_DMA_REQ),
+						      1, 500 * USEC_PER_MSEC)) {
+				dev_err(host->dev,
+					"%s: Timeout waiting for dma_req to clear during reset\n",
+					__func__);
+				goto ciu_out;
+			}
+
+			/* when using DMA next we reset the fifo again */
+			if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET))
+				goto ciu_out;
+		}
+	} else {
+		/* if the controller reset bit did clear, then set clock regs */
+		if (!(mci_readl(host, CTRL) & SDMMC_CTRL_RESET)) {
+			dev_err(host->dev,
+				"%s: fifo/dma reset bits didn't clear but ciu was reset, doing clock update\n",
+				__func__);
+			goto ciu_out;
+		}
+	}
+
+	if (host->use_dma == TRANS_MODE_IDMAC)
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
+}
+
 static const struct mmc_host_ops dw_mci_ops = {
 	.request		= dw_mci_request,
 	.pre_req		= dw_mci_pre_req,
@@ -2837,71 +2901,6 @@ static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
 	return true;
 }
 
-static bool dw_mci_reset(struct dw_mci *host)
-{
-	u32 flags = SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET;
-	bool ret = false;
-
-	/*
-	 * Reseting generates a block interrupt, hence setting
-	 * the scatter-gather pointer to NULL.
-	 */
-	if (host->sg) {
-		sg_miter_stop(&host->sg_miter);
-		host->sg = NULL;
-	}
-
-	if (host->use_dma)
-		flags |= SDMMC_CTRL_DMA_RESET;
-
-	if (dw_mci_ctrl_reset(host, flags)) {
-		/*
-		 * In all cases we clear the RAWINTS register to clear any
-		 * interrupts.
-		 */
-		mci_writel(host, RINTSTS, 0xFFFFFFFF);
-
-		/* if using dma we wait for dma_req to clear */
-		if (host->use_dma) {
-			u32 status;
-
-			if (readl_poll_timeout_atomic(host->regs + SDMMC_STATUS,
-						      status,
-						      !(status & SDMMC_STATUS_DMA_REQ),
-						      1, 500 * USEC_PER_MSEC)) {
-				dev_err(host->dev,
-					"%s: Timeout waiting for dma_req to clear during reset\n",
-					__func__);
-				goto ciu_out;
-			}
-
-			/* when using DMA next we reset the fifo again */
-			if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET))
-				goto ciu_out;
-		}
-	} else {
-		/* if the controller reset bit did clear, then set clock regs */
-		if (!(mci_readl(host, CTRL) & SDMMC_CTRL_RESET)) {
-			dev_err(host->dev,
-				"%s: fifo/dma reset bits didn't clear but ciu was reset, doing clock update\n",
-				__func__);
-			goto ciu_out;
-		}
-	}
-
-	if (host->use_dma == TRANS_MODE_IDMAC)
-		/* It is also recommended that we reset and reprogram idmac */
-		dw_mci_idmac_reset(host);
-
-	ret = true;
-
-ciu_out:
-	/* After a CTRL reset we need to have CIU set clock registers  */
-	mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
-
-	return ret;
-}
-
 static void dw_mci_cmd11_timer(unsigned long arg)
 {
 	struct dw_mci *host = (struct dw_mci *)arg;
-- 
1.9.1


