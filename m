From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] mmc: omap_hsmmc: add DMA engine support
Date: Wed, 18 Apr 2012 12:53:18 -0700
Message-ID: <20120418195318.GN21106@atomide.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRs1-0004bP-HH@rmk-PC.arm.linux.org.uk>
 <20120418181112.GK21106@atomide.com>
 <20120418190923.GQ25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120418190923.GQ25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120418 12:12]:
> On Wed, Apr 18, 2012 at 11:11:12AM -0700, Tony Lindgren wrote:
> > * Russell King <rmk+kernel@arm.linux.org.uk> [120418 03:15]:
> > > Add DMA engine support to the OMAP HSMMC driver.  This supplements the
> > > private DMA API implementation contained within this driver, and the
> > > driver can be switched at build time between using DMA engine and the
> > > private DMA API.
> > 
> > Glad to see this happening!
> > 
> > No luck here though, after a quick test I'm getting the following with MMC
> > not working:
> 
> Did you enable OMAP DMA engine support?

Heh that's it :) Yup it works now after adding:

CONFIG_DMADEVICES=y
CONFIG_DMA_OMAP=y

How about just continue on PIO if DMA reques fails:

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1921,16 +1921,12 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
-	if (!host->rx_chan) {
-		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
-		goto err_irq;
-	}
+	if (!host->rx_chan)
+		dev_info(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
 
 	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
-	if (!host->tx_chan) {
-		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
-		goto err_irq;
-	}
+	if (!host->tx_chan)
+		dev_info(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
 
 	/* Request IRQ for MMC operations */
 	ret = request_irq(host->irq, omap_hsmmc_irq, 0,
