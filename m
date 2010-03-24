From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH] mmc: fix race condition between dma and omap_hsmmc callback
Date: Wed, 24 Mar 2010 18:30:52 +0530
Message-ID: <618f0c911003240600m1a38935av68f31a232ed8b8ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

This patch addresses the possible race condition between the dma
callback and hsmmc callback.
All the 'post data transfer' cleanup activities are now done in the
MMC TC handler.
The schedule_timeout in omap_hsmmc_start_dma_transfer is hence not
needed (which, incidentally,
was also throwing a "schedule while atomic" warning when executed).
Tested on OMAP4430 SDP.

CC: Adrian Hunter <adrian.hunter@nokia.com>
CC: Madhusudhan C <madhu.cr@ti.com>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   40 ++++++++++++++++------------------------
 1 files changed, 16 insertions(+), 24 deletions(-)

The previous discussion about this patch is here
https://patchwork.kernel.org/patch/82907/
As requested, this is now posted as a separate patch instead of
clubbing with another feature.

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 83f0aff..9a70b36 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1046,8 +1046,18 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)

 	if (end_cmd || ((status & CC) && host->cmd))
 		omap_hsmmc_cmd_done(host, host->cmd);
-	if ((end_trans || (status & TC)) && host->mrq)
+	if ((end_trans || (status & TC)) && host->mrq) {
+		if (host->dma_ch != -1) {
+			omap_free_dma(host->dma_ch);
+			host->dma_ch = -1;
+			/*
+			 * Callback run in interrupt context.
+			 * mutex_unlock will throw a kernel warning if used.
+			 */
+			up(&host->sem);
+		}
 		omap_hsmmc_xfer_done(host, data);
+	}

 	spin_unlock(&host->irq_lock);

@@ -1267,13 +1277,6 @@ static void omap_hsmmc_dma_cb(int lch, u16
ch_status, void *data)
 		return;
 	}

-	omap_free_dma(host->dma_ch);
-	host->dma_ch = -1;
-	/*
-	 * DMA Callback: run in interrupt context.
-	 * mutex_unlock will throw a kernel warning if used.
-	 */
-	up(&host->sem);
 }

 /*
@@ -1282,7 +1285,7 @@ static void omap_hsmmc_dma_cb(int lch, u16
ch_status, void *data)
 static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 					struct mmc_request *req)
 {
-	int dma_ch = 0, ret = 0, err = 1, i;
+	int dma_ch = 0, ret = 0, i;
 	struct mmc_data *data = req->data;

 	/* Sanity check: all the SG entries must be aligned by block size. */
@@ -1300,22 +1303,11 @@ static int
omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 		return -EINVAL;

 	/*
-	 * If for some reason the DMA transfer is still active,
-	 * we wait for timeout period and free the dma
+	 * Can't process the request if the previous
+	 * request is still active
 	 */
-	if (host->dma_ch != -1) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(100);
-		if (down_trylock(&host->sem)) {
-			omap_free_dma(host->dma_ch);
-			host->dma_ch = -1;
-			up(&host->sem);
-			return err;
-		}
-	} else {
-		if (down_trylock(&host->sem))
-			return err;
-	}
+	if (down_trylock(&host->sem))
+			return -EBUSY;

 	ret = omap_request_dma(omap_hsmmc_get_dma_sync_dev(host, data),
 			       "MMC/SD", omap_hsmmc_dma_cb, host, &dma_ch);
-- 
1.6.3.3
