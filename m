From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 7/7] mmc: dw_mmc: improve dw_mci_reset a bit
Date: Fri, 17 Feb 2017 10:59:52 +0800
Message-ID: <1487300392-204037-1-git-send-email-shawn.lin@rock-chips.com>
References: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:53502 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755018AbdBQDCX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 22:02:23 -0500
In-Reply-To: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Too much condition iteration makes the code
less readable. Slightly improve it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a4a43e6..e165db05 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1692,6 +1692,7 @@ static bool dw_mci_reset(struct dw_mci *host)
 {
 	u32 flags = SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET;
 	bool ret = false;
+	u32 status = 0;
 
 	/*
 	 * Resetting generates a block interrupt, hence setting
@@ -1707,29 +1708,30 @@ static bool dw_mci_reset(struct dw_mci *host)
 
 	if (dw_mci_ctrl_reset(host, flags)) {
 		/*
-		 * In all cases we clear the RAWINTS register to clear any
-		 * interrupts.
+		 * In all cases we clear the RAWINTS
+		 * register to clear any interrupts.
 		 */
 		mci_writel(host, RINTSTS, 0xFFFFFFFF);
 
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
+		if (!host->use_dma) {
+			ret = true;
+			goto ciu_out;
+		}
 
-			/* when using DMA next we reset the fifo again */
-			if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET))
-				goto ciu_out;
+		/* Wait for dma_req to be cleared */
+		if (readl_poll_timeout_atomic(host->regs + SDMMC_STATUS,
+					      status,
+					      !(status & SDMMC_STATUS_DMA_REQ),
+					      1, 500 * USEC_PER_MSEC)) {
+			dev_err(host->dev,
+				"%s: Timeout waiting for dma_req to be cleared\n",
+				__func__);
+			goto ciu_out;
 		}
+
+		/* when using DMA next we reset the fifo again */
+		if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET))
+			goto ciu_out;
 	} else {
 		/* if the controller reset bit did clear, then set clock regs */
 		if (!(mci_readl(host, CTRL) & SDMMC_CTRL_RESET)) {
-- 
1.9.1


