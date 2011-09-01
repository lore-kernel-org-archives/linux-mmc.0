From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 1/2] omap: hsmmc: Normalize dma cleanup operations
Date: Fri, 2 Sep 2011 00:35:56 +0530
Message-ID: <1314903957-24408-2-git-send-email-svenkatr@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: per.forlin@linaro.org, cjb@laptop.org, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Reuse omap_hsmmc_dma_cleanup even for normal dma teardown in
omap_hsmmc_dma_cb. Consolidate multiple points of dma unmap into a 
single location in post_req function, to prevent double unmapping.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 21e4a79..5b7776c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -999,7 +999,8 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 {
 	int dma_ch;
 
-	host->data->error = errno;
+	if (host->data)
+		host->data->error = errno;
 
 	spin_lock(&host->irq_lock);
 	dma_ch = host->dma_ch;
@@ -1007,12 +1008,8 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 	spin_unlock(&host->irq_lock);
 
 	if (host->use_dma && dma_ch != -1) {
-		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg,
-			host->data->sg_len,
-			omap_hsmmc_get_dma_dir(host, host->data));
 		omap_free_dma(dma_ch);
 	}
-	host->data = NULL;
 }
 
 /*
@@ -1370,7 +1367,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 {
 	struct omap_hsmmc_host *host = cb_data;
 	struct mmc_data *data;
-	int dma_ch, req_in_progress;
+	int req_in_progress;
 
 	if (!(ch_status & OMAP_DMA_BLOCK_IRQ)) {
 		dev_warn(mmc_dev(host->mmc), "unexpected dma status %x\n",
@@ -1394,16 +1391,9 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 		return;
 	}
 
-	if (!data->host_cookie)
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     omap_hsmmc_get_dma_dir(host, data));
-
 	req_in_progress = host->req_in_progress;
-	dma_ch = host->dma_ch;
-	host->dma_ch = -1;
 	spin_unlock(&host->irq_lock);
-
-	omap_free_dma(dma_ch);
+	omap_hsmmc_dma_cleanup(host, 0);
 
 	/* If DMA has finished after TC, complete the request */
 	if (!req_in_progress) {
@@ -1575,7 +1565,7 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (host->use_dma) {
+	if (data->host_cookie) {
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
 			     omap_hsmmc_get_dma_dir(host, data));
 		data->host_cookie = 0;
-- 
1.7.1

