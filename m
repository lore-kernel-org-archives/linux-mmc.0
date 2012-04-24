From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/12] mmc: omap: add DMA engine support
Date: Mon, 23 Apr 2012 17:13:30 -0700
Message-ID: <20120424001330.GD3739@atomide.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLmZ-0002WS-Rd@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15959 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab2DXANf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Apr 2012 20:13:35 -0400
Content-Disposition: inline
In-Reply-To: <E1SMLmZ-0002WS-Rd@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Chris Ball <cjb@laptop.org>

* Russell King <rmk+kernel@arm.linux.org.uk> [120423 09:11]:
> Add DMA engine support to the OMAP driver.  This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.

Below is what's needed to use DMA request lines from platform data.
Note also the release_mem_region change that we'll now need for
this one also (but not as a fix).

I've posted a cleanup patch series to mostly remove plat-omap/devices.c
that takes care of passing the DMA request lines in platform data.
That series should get merged before the driver changes for this
driver to keep DMA working.

Regards,

Tony


--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1313,7 +1313,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
 	dma_cap_mask_t mask;
-	unsigned sig;
+	unsigned tx_req, rx_req;
 	int i, ret = 0;
 	int irq;
 
@@ -1389,37 +1389,44 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	host->dma_tx_burst = -1;
 	host->dma_rx_burst = -1;
 
-	if (cpu_is_omap24xx())
-		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX : OMAP24XX_DMA_MMC2_TX;
-	else
-		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
-	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+	if (!res) {
+		dev_err(host->dev, "cannot get DMA TX channel\n");
+		goto err_free_dma;
+	}
+	tx_req = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+	if (!res) {
+		dev_err(host->dev, "cannot get DMA RX channel\n");
+		goto err_free_dma;
+	}
+	rx_req = res->start;
+
+	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
 #if 0
 	if (!host->dma_tx) {
 		dev_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
-			sig);
-		goto err_dma;
+			tx_req);
+		goto err_free_dma;
 	}
 #else
 	if (!host->dma_tx)
 		dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
-			sig);
+			tx_req);
 #endif
-	if (cpu_is_omap24xx())
-		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_RX : OMAP24XX_DMA_MMC2_RX;
-	else
-		sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
-	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+
+	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
 #if 0
 	if (!host->dma_rx) {
 		dev_err(host->dev, "unable to obtain RX DMA engine channel %u\n",
-			sig);
-		goto err_dma;
+			rx_req);
+		goto err_free_dma;
 	}
 #else
 	if (!host->dma_rx)
 		dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
-			sig);
+			rx_req);
 #endif
 
 	ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
@@ -1466,7 +1473,9 @@ err_free_mmc_host:
 err_ioremap:
 	kfree(host);
 err_free_mem_region:
-	release_mem_region(res->start, resource_size(res));
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
