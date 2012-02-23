From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/6] mmc: omap_hsmmc: use platform_get_resource_byname for
	tx/rx DMA channels
Date: Thu, 23 Feb 2012 16:56:44 +0530
Message-ID: <1329996409-26861-2-git-send-email-rnayak@ti.com>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1329996409-26861-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

Git rid of hardcoded tx/rx DMA channels based on pdev->id
and use platform_get_resource_byname() to retrieve them
instead.

Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Tested-by: Venkatraman S <svenkatr-l0cyMroinI0@public.gmane.org>
---
 drivers/mmc/host/omap_hsmmc.c |   35 +++++++++++------------------------
 1 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fd0c661..2a660ab 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1977,32 +1977,19 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_conf_bus_power(host);
 
-	/* Select DMA lines */
-	switch (host->id) {
-	case OMAP_MMC1_DEVID:
-		host->dma_line_tx = OMAP24XX_DMA_MMC1_TX;
-		host->dma_line_rx = OMAP24XX_DMA_MMC1_RX;
-		break;
-	case OMAP_MMC2_DEVID:
-		host->dma_line_tx = OMAP24XX_DMA_MMC2_TX;
-		host->dma_line_rx = OMAP24XX_DMA_MMC2_RX;
-		break;
-	case OMAP_MMC3_DEVID:
-		host->dma_line_tx = OMAP34XX_DMA_MMC3_TX;
-		host->dma_line_rx = OMAP34XX_DMA_MMC3_RX;
-		break;
-	case OMAP_MMC4_DEVID:
-		host->dma_line_tx = OMAP44XX_DMA_MMC4_TX;
-		host->dma_line_rx = OMAP44XX_DMA_MMC4_RX;
-		break;
-	case OMAP_MMC5_DEVID:
-		host->dma_line_tx = OMAP44XX_DMA_MMC5_TX;
-		host->dma_line_rx = OMAP44XX_DMA_MMC5_RX;
-		break;
-	default:
-		dev_err(mmc_dev(host->mmc), "Invalid MMC id\n");
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+	if (!res) {
+		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
+		goto err_irq;
+	}
+	host->dma_line_tx = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+	if (!res) {
+		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
 		goto err_irq;
 	}
+	host->dma_line_rx = res->start;
 
 	/* Request IRQ for MMC operations */
 	ret = request_irq(host->irq, omap_hsmmc_irq, 0,
-- 
1.7.1
