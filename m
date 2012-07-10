From: Kevin Hilman <khilman@ti.com>
Subject: Re: [CFT 03/11] mmc: omap_hsmmc: remove private DMA API implementation
Date: Tue, 10 Jul 2012 14:48:56 -0700
Message-ID: <87vchvl22f.fsf@ti.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
	<E1ScaYb-0003tZ-Pb@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <E1ScaYb-0003tZ-Pb@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Thu, 07 Jun 2012 12:07:13 +0100")
Sender: linux-omap-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Russell,

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> Remove the private DMA API implementation from omap_hsmmc, making it
> use entirely the DMA engine API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

While testing this, I noticed a minor problem in the case of probe
failure (e.g. if dmaengine is not built into the kernel.)

The current driver suffers from this same problem but should probably be
fixed when converting to dmaengine...

[...]

> @@ -2048,36 +1919,28 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>  		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
>  		goto err_irq;
>  	}
> -	host->dma_line_tx = res->start;
> +	tx_req = res->start;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
>  	if (!res) {
>  		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
>  		goto err_irq;
>  	}
> -	host->dma_line_rx = res->start;
> +	rx_req = res->start;
>  
> -	{
> -		dma_cap_mask_t mask;
> -		unsigned sig;
> -		extern bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
> -
> -		dma_cap_zero(mask);
> -		dma_cap_set(DMA_SLAVE, mask);
> -#if 1
> -		sig = host->dma_line_rx;
> -		host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> -		if (!host->rx_chan) {
> -			dev_warn(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", sig);
> -		}
> -#endif
> -#if 1
> -		sig = host->dma_line_tx;
> -		host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> -		if (!host->tx_chan) {
> -			dev_warn(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", sig);
> -		}
> -#endif
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
> +	if (!host->rx_chan) {
> +		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
> +		goto err_irq;
> +	}
> +
> +	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
> +	if (!host->tx_chan) {
> +		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
> +		goto err_irq;
>  	}

If either of these fails, ret is zero so even though this results in a
failed probe, the return value (ret) is zero meaning the driver still
gets bound to the device.

The patch below fixes this and applies on your 'for-next' branch.  Or,
feel free to fold this into the original if you prefer.

Kevin

>From af7537997b46ee3991985fecd4b4a302bdc0df31 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Tue, 10 Jul 2012 14:30:18 -0700
Subject: [PATCH] mmc: omap_hsmmc: ensure probe returns error if DMA channel
 request fails

If dma_request_channel() fails (e.g. because DMA engine is not built
into the kernel), the return value from probe is zero causing the
driver to be bound to the device even though probe failed.

To fix, ensure that probe returns an error value when a DMA channel
request fail.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2338703..ddcecf8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1924,12 +1924,14 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
 	if (!host->rx_chan) {
 		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
+		ret = -ENXIO;
 		goto err_irq;
 	}
 
 	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
 	if (!host->tx_chan) {
 		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
+		ret -ENXIO;
 		goto err_irq;
 	}
 
-- 
1.7.9.2

