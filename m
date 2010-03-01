From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc callback
Date: Mon, 1 Mar 2010 16:55:35 +0530
Message-ID: <618f0c911003010325q201fbcedr776da21c709ac421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:39980 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab0CALZf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Mar 2010 06:25:35 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

It is observed that sometimes the MMC Transfer Complete (TC) is not
received when DMA completion callback is processed (or takes too long
to process)
This patch moves the releasing of DMA channel from dma callback to the
mmc transfer complete handler.
This is observed consistently when descriptor loading is used (see the
rest of the series)

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 83f0aff..06337f6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1046,8 +1046,18 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)

 	if (end_cmd || ((status & CC) && host->cmd))
 		omap_hsmmc_cmd_done(host, host->cmd);
-	if ((end_trans || (status & TC)) && host->mrq)
+	if ((end_trans || (status & TC)) && host->mrq) {
 		omap_hsmmc_xfer_done(host, data);
+		if (host->dma_ch != -1) {
+			omap_free_dma(host->dma_ch);
+			host->dma_ch = -1;
+		/*
+		 * Callback: run in interrupt context.
+		 * mutex_unlock will throw a kernel warning if used.
+		 */
+			up(&host->sem);
+		}
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
-- 
1.6.3.3
