From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 07/13] mmc: omap_hsmmc: dma_request_slave_channel()
 support for DT platforms
Date: Thu, 20 Sep 2012 15:16:31 -0700
Message-ID: <20120920221630.GL28835@atomide.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-8-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348152226-13588-8-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

* Matt Porter <mporter@ti.com> [120920 07:43]:
> For platforms with DT populated, use dma_request_slave_channel()
> to acquire the DMA channel. For !DT platforms, we fall back to
> explicitly passing the omap_dma_filter_fn() to dma_request_channel().
> Once all platforms boot from DT, the dma_request_channel() path can
> be dropped.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 3a09f93..c82d0ab 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1923,14 +1923,26 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
> +	if (pdev->dev.of_node)
> +		host->rx_chan =
> +			dma_request_slave_channel(&pdev->dev, "rx");
> +	else
> +		host->rx_chan = dma_request_channel(mask,
> +						    omap_dma_filter_fn,
> +						    &rx_req);
>  	if (!host->rx_chan) {
>  		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
>  		ret = -ENXIO;
>  		goto err_irq;
>  	}
>  
> -	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
> +	if (pdev->dev.of_node)
> +		host->tx_chan =
> +			dma_request_slave_channel(&pdev->dev, "tx");
> +	else
> +		host->tx_chan = dma_request_channel(mask,
> +						    omap_dma_filter_fn,
> +						    &tx_req);
>  	if (!host->tx_chan) {
>  		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
>  		ret = -ENXIO;
> 

Here to the omap_hsmmc.c driver should not need to care about which
way to request the dma channels.

Regards,

Tony
