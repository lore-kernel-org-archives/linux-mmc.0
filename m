From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/3] mmc: tmio: fix for platforms, where CONFIG_ZONE_DMA is
 not defined
Date: Fri, 27 May 2011 12:44:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105271242300.25265@axis700.grange>
References: <Pine.LNX.4.64.1105271235230.25265@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105271235230.25265@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On platforms, not defining CONFIG_ZONE_DMA, GFP_DMA cannot be used,
switch to using the dma_alloc_coherent() / dma_free_coherent() API.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    2 ++
 drivers/mmc/host/tmio_mmc_dma.c |    7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 8260bc2..f105006 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -20,6 +20,7 @@
 #include <linux/mmc/tmio.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 /* Definitions for values the CTRL_SDIO_STATUS register can take. */
 #define TMIO_SDIO_STAT_IOIRQ	0x0001
@@ -70,6 +71,7 @@ struct tmio_mmc_host {
 	struct tasklet_struct	dma_issue;
 	struct scatterlist	bounce_sg;
 	u8			*bounce_buf;
+	dma_addr_t		bounce_dma;
 
 	/* Track lost interrupts */
 	struct delayed_work	delayed_reset_work;
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 25f1ad6..7fed4c3 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
@@ -281,7 +282,8 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->chan_rx)
 			goto ereqrx;
 
-		host->bounce_buf = (u8 *)__get_free_page(GFP_KERNEL | GFP_DMA);
+		host->bounce_buf = dma_alloc_coherent(&host->pdev->dev,
+					PAGE_SIZE, &host->bounce_dma, GFP_KERNEL);
 		if (!host->bounce_buf)
 			goto ebouncebuf;
 
@@ -314,7 +316,8 @@ void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 		dma_release_channel(chan);
 	}
 	if (host->bounce_buf) {
-		free_pages((unsigned long)host->bounce_buf, 0);
+		dma_free_coherent(&host->pdev->dev, PAGE_SIZE,
+				  host->bounce_buf, host->bounce_dma);
 		host->bounce_buf = NULL;
 	}
 }
-- 
1.7.2.5

