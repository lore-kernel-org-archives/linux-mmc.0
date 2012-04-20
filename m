From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
Date: Fri, 20 Apr 2012 09:50:00 -0700
Message-ID: <20120420164957.GC21106@atomide.com>
References: <20120418202447.GT25053@n2100.arm.linux.org.uk>
 <20120418210142.GR21106@atomide.com>
 <20120418211606.GU25053@n2100.arm.linux.org.uk>
 <20120418213642.GV25053@n2100.arm.linux.org.uk>
 <20120419013914.GV21106@atomide.com>
 <20120419174332.GY25053@n2100.arm.linux.org.uk>
 <20120419180741.GX21106@atomide.com>
 <20120420151034.GA24205@n2100.arm.linux.org.uk>
 <20120420152623.GA21106@atomide.com>
 <20120420153743.GB24205@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120420153743.GB24205@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120420 08:41]:
> 
> So, with this patch plus my original patch to omap's mmc host driver, this
> should result in something which works without all the overhead of drivers
> supplying the port information.  Please confirm, and I'll merge this into
> the original omap-dma.c commit.

Then something like this is still needed on top of your original mmc driver
patch for omap2420:

--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1617,11 +1617,14 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	host->dma_tx_burst = -1;
 	host->dma_rx_burst = -1;
 
-	sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
+	if (cpu_is_omap24xx())
+		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX :  OMAP24XX_DMA_MMC2_TX;
+	else
+		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
 	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
 #if 0
 	if (!host->dma_tx) {
-		def_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
+		dev_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
 			sig);
 		goto err_dma;
 	}
@@ -1632,7 +1635,10 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 #endif
 #endif
 #ifdef USE_DMA_ENGINE
-	sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
+	if (cpu_is_omap24xx())
+		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_RX :  OMAP24XX_DMA_MMC2_RX;
+	else
+		sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
 	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
 #if 0
 	if (!host->dma_rx) {
