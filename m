From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on
 device id
Date: Sat, 30 Nov 2013 09:33:18 -0800
Message-ID: <20131130173317.GG23334@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-3-git-send-email-tony@atomide.com>
 <5299339C.2040102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5299339C.2040102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Joel Fernandes <joelf@ti.com> [131129 16:39]:
> On 11/13/2013 08:35 PM, Tony Lindgren wrote:
> > --- a/drivers/mmc/host/omap.c
> > +++ b/drivers/mmc/host/omap.c
> > @@ -90,17 +90,6 @@
> >  #define OMAP_MMC_CMDTYPE_AC	2
> >  #define OMAP_MMC_CMDTYPE_ADTC	3
> >  
> > -#define OMAP_DMA_MMC_TX		21
> > -#define OMAP_DMA_MMC_RX		22
> > -#define OMAP_DMA_MMC2_TX	54
> > -#define OMAP_DMA_MMC2_RX	55
> > -
> > -#define OMAP24XX_DMA_MMC2_TX	47
> > -#define OMAP24XX_DMA_MMC2_RX	48
> > -#define OMAP24XX_DMA_MMC1_TX	61
> > -#define OMAP24XX_DMA_MMC1_RX	62
> > -
> > -
> >  #define DRIVER_NAME "mmci-omap"
> >  
> >  /* Specifies how often in millisecs to poll for card status changes
> > @@ -1408,19 +1397,20 @@ static int mmc_omap_probe(struct platform_device *pdev)
> >  	host->dma_tx_burst = -1;
> >  	host->dma_rx_burst = -1;
> >  
> > -	if (mmc_omap2())
> > -		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX : OMAP24XX_DMA_MMC2_TX;
> > -	else
> > -		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
> > -	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> > +	if (res)
> > +		sig = res->start;
> > +	host->dma_tx = dma_request_slave_channel_compat(mask,
> > +				omap_dma_filter_fn, &sig, &pdev->dev, "tx");
> 
> Minor comment, since we're moving to DT-only for platforms using this driver
> (hope I'm right about that), why not just do:
> 	dma_request_slave_channel_(&pdev->dev, "tx");
> 
> IORESOURCE_DMA is not created by OF layer so I guess no need to call
> platform_get_resource either.

Well this is not the omap_hsmmc.c driver, this is the one for earlier hardware
that's available on omap1 and 2420. All the later ones use the omap_hsmmc.c
driver instead. So this one we cannot make DT only unless we make mach-omap1
DT only, which is doable, but may never happen because of the effort needed.

Most of the effort would be quite trivial, except for the conversion to use
the common clock framework.

Regards,

Tony
