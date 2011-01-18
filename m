From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH 1/4] omap: hsmmc: Rename use_dma to xfer_type and define possible transfers
Date: Tue, 18 Jan 2011 22:56:28 +0530
Message-ID: <1295371591-13610-2-git-send-email-kishore.kadiyala@ti.com>
References: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38460 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab1ARRUG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Jan 2011 12:20:06 -0500
In-Reply-To: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>

OMAP4 introduces dedicated internal DMA which is ADMA for its MMC
controllers HSMMC1 & HSMMC2.
Renaming "use_dma" member of the struct omap_hsmmc_host to "xfer_type"
and defining the transfer modes PIO/SDMA/ADMA that can be used by the
MMC controller.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Reviewed-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5d46021..8fb8586 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -125,6 +125,11 @@
 #define OMAP_MMC_SLEEP_TIMEOUT		1000
 #define OMAP_MMC_OFF_TIMEOUT		8000
 
+/* Transfer Modes used by MMC controller */
+#define	OMAP_HSMMC_USE_PIO_XFER		0
+#define	OMAP_HSMMC_USE_SDMA_XFER	1
+#define	OMAP_HSMMC_USE_ADMA_XFER	2
+
 /*
  * One controller can have multiple slots, like on some omap boards using
  * omap.c controller driver. Luckily this is not currently done on any known
@@ -172,7 +177,8 @@ struct omap_hsmmc_host {
 	u32			bytesleft;
 	int			suspended;
 	int			irq;
-	int			use_dma, dma_ch;
+	int			dma_ch;
+	int			xfer_type; /* Transfer can be PIO/SDMA/ADMA */
 	int			dma_line_tx, dma_line_rx;
 	int			slot_id;
 	int			got_dbclk;
@@ -545,7 +551,7 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 {
 	unsigned int irq_mask;
 
-	if (host->use_dma)
+	if (host->xfer_type != OMAP_HSMMC_USE_PIO_XFER)
 		irq_mask = INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE);
 	else
 		irq_mask = INT_EN_MASK;
@@ -835,7 +841,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 			cmdreg &= ~(DDIR);
 	}
 
-	if (host->use_dma)
+	if (host->xfer_type != OMAP_HSMMC_USE_PIO_XFER)
 		cmdreg |= DMA_EN;
 
 	host->req_in_progress = 1;
@@ -864,7 +870,7 @@ static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_req
 
 	omap_hsmmc_disable_irq(host);
 	/* Do not complete the request if DMA is still in progress */
-	if (mrq->data && host->use_dma && dma_ch != -1)
+	if (mrq->data && host->xfer_type && dma_ch != -1)
 		return;
 	host->mrq = NULL;
 	mmc_request_done(host->mmc, mrq);
@@ -942,7 +948,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 	host->dma_ch = -1;
 	spin_unlock(&host->irq_lock);
 
-	if (host->use_dma && dma_ch != -1) {
+	if (host->xfer_type && dma_ch != -1) {
 		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
 			omap_hsmmc_get_dma_dir(host, host->data));
 		omap_free_dma(dma_ch);
@@ -1451,7 +1457,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 					| (req->data->blocks << 16));
 	set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);
 
-	if (host->use_dma) {
+	if (host->xfer_type) {
 		ret = omap_hsmmc_start_dma_transfer(host, req);
 		if (ret != 0) {
 			dev_dbg(mmc_dev(host->mmc), "MMC start dma failure\n");
@@ -2050,7 +2056,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	host->mmc	= mmc;
 	host->pdata	= pdata;
 	host->dev	= &pdev->dev;
-	host->use_dma	= 1;
+	host->xfer_type	= OMAP_HSMMC_USE_SDMA_XFER;
 	host->dev->dma_mask = &pdata->dma_mask;
 	host->dma_ch	= -1;
 	host->irq	= irq;
-- 
1.7.1

