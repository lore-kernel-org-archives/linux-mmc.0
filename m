From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc callback
Date: Wed, 10 Mar 2010 19:41:38 +0530
Message-ID: <618f0c911003100611q42e7f23cuc3c8d3f116ca7eb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

See previous post http://patchwork.kernel.org/patch/82907/
Rebased to 2.6.34-rc1 and fixed comment alignment.

CC: Adrian Hunter <adrian.hunter@nokia.com>
CC: Madhusudhan C <madhu.cr@ti.com>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 83f0aff..ea2a082 100644
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
+			/*
+			 * Callback: run in interrupt context.
+			 * mutex_unlock will throw a kernel warning if used.
+			 */
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
