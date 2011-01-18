From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH 2/4] omap: hsmmc: Rename and cleanup omap_hsmmc_dma_cleanup
Date: Tue, 18 Jan 2011 22:56:29 +0530
Message-ID: <1295371591-13610-3-git-send-email-kishore.kadiyala@ti.com>
References: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33928 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab1ARRUI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Jan 2011 12:20:08 -0500
In-Reply-To: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>

Renaming omap_hsmmc_dma_cleanup as omap_hsmmc_xfer_cleanup and doing some
cleanup by handling the error & success scenarios during a transfer for
different xfer_type.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Reviewed-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   52 ++++++++++++++++++++++------------------
 1 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8fb8586..7cf0383 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -935,25 +935,37 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
 }
 
 /*
- * DMA clean up for command errors
+ * SDMA clean up during SDMA transfers.
+ * Also unmapping of sg list in case of error/transfer done during
+ * SDMA/ADMA transfers.
  */
-static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
+static void omap_hsmmc_xfer_cleanup(struct omap_hsmmc_host *host, int errno)
 {
 	int dma_ch;
+	struct mmc_data *data = errno ? host->data : host->mrq->data;
 
-	host->data->error = errno;
-
-	spin_lock(&host->irq_lock);
-	dma_ch = host->dma_ch;
-	host->dma_ch = -1;
-	spin_unlock(&host->irq_lock);
-
-	if (host->xfer_type && dma_ch != -1) {
-		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
-			omap_hsmmc_get_dma_dir(host, host->data));
+	switch (host->xfer_type) {
+	case OMAP_HSMMC_USE_SDMA_XFER:
+		spin_lock(&host->irq_lock);
+		dma_ch = host->dma_ch;
+		host->dma_ch = -1;
+		spin_unlock(&host->irq_lock);
+		if (dma_ch != -1)
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+				host->dma_len,
+				omap_hsmmc_get_dma_dir(host, data));
 		omap_free_dma(dma_ch);
+		break;
+	case OMAP_HSMMC_USE_PIO_XFER:
+		/* TODO */
+		break;
+	default:
+		dev_dbg(mmc_dev(host->mmc), "Unknown xfer_type\n");
+	}
+	if (errno) {
+		host->data->error = errno;
+		host->data = NULL;
 	}
-	host->data = NULL;
 }
 
 /*
@@ -1059,7 +1071,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 			}
 			if (host->data || host->response_busy) {
 				if (host->data)
-					omap_hsmmc_dma_cleanup(host,
+					omap_hsmmc_xfer_cleanup(host,
 								-ETIMEDOUT);
 				host->response_busy = 0;
 				omap_hsmmc_reset_controller_fsm(host, SRD);
@@ -1072,7 +1084,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 						-ETIMEDOUT : -EILSEQ;
 
 				if (host->data)
-					omap_hsmmc_dma_cleanup(host, err);
+					omap_hsmmc_xfer_cleanup(host, err);
 				else
 					host->mrq->cmd->error = err;
 				host->response_busy = 0;
@@ -1310,7 +1322,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 {
 	struct omap_hsmmc_host *host = cb_data;
 	struct mmc_data *data = host->mrq->data;
-	int dma_ch, req_in_progress;
+	int req_in_progress;
 
 	if (!(ch_status & OMAP_DMA_BLOCK_IRQ)) {
 		dev_warn(mmc_dev(host->mmc), "unexpected dma status %x\n",
@@ -1332,16 +1344,10 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 		spin_unlock(&host->irq_lock);
 		return;
 	}
-
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
-		omap_hsmmc_get_dma_dir(host, data));
-
 	req_in_progress = host->req_in_progress;
-	dma_ch = host->dma_ch;
-	host->dma_ch = -1;
 	spin_unlock(&host->irq_lock);
 
-	omap_free_dma(dma_ch);
+	omap_hsmmc_xfer_cleanup(host, 0);
 
 	/* If DMA has finished after TC, complete the request */
 	if (!req_in_progress) {
-- 
1.7.1

