From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
Date: Tue, 1 Dec 2015 22:29:54 +0530
Message-ID: <20151201165954.GA1696@localhost>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448891145-10766-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: arnd-r2nGTMty4D4@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 30, 2015 at 03:45:30PM +0200, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since RFC v01:
> - dma_request_chan(); lost the mask parameter
> - The new API does not rely on RESOURCE_DMA, instead the dma_filter_map table
>   will be used to provide the needed information to the filter function in
>   legacy mode
> - Extended the example patches to convert most of daVinci to use the new API to
>   request the DMA channels.

Hi Peter,

Thanks a bunch for fixing this up!

I think overall I am happy with the proposal and aligning with 2 APIs really
_helps_.

> 
> TODO: Documentation update ;)
>
> 
> As it has been discussed in the following thread:
> http://www.gossamer-threads.com/lists/linux/kernel/2181487#2181487
> 
> Andy: I did looked at the unified device properties, but I decided to not to use
> it as I don't see it to fit well and most of the legacy board files are using
> resources to specify at least their memory regions so adding the DMA resource
> to them would be more inline with the rest of the code.

I think that is okay for now, we can align on that eventually. I think this
doesn't impact the API design though..

> 
> The ARM, mmc and spi patches are converting daVinci drivers board files to use
> the new method of requesting DMA channel.
> 
> With this series I have taken a path which would result two new API, which can
> be used to convert most of the current users already and with some work all
> users might be able to move to this set.
> With this set the filter_fn used for legacy (non DT/ACPI) channel request is no
> longer needed to be exported to client drivers since the selection of the
> correct filter_fn will be done in the core.
> 
> So, the first proposal is to have:
> 
> struct dma_chan *dma_request_chan(struct device *dev, const char *name);
> struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
> 
> The dma_request_chan_by_mask() is to request any channel matching with the
> requested capabilities, can be used to request channel for memcpy, memset, xor,
> etc where no hardware synchronization is needed.
> 
> The dma_request_chan() is to request a slave channel. The dma_request_chan() will try to find the
> channel via DT, ACPI or in case if the kernel booted in non DT/ACPI mode
> it will use a filter lookup table and retrieves the needed information from
> the dma_filter_map provided by the DMA drivers.

That sounds right, for the third case would the arch, driver or someone else
configure this?

> This legacy mode needs changes in platform code, in dmaengine drivers and
> finally the dmaengine user drivers can be converted:

Are you marking the current APIs as dericated in the end of this series

> 
> For each dmaengine driver an array of DMA device, slave and the parameter
> for the filter function needs to be added:
> 
> static struct dma_filter_map da830_edma_map[] = {
> 	DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)),
> 	DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)),
> 	DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)),
> 	DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0, 3)),
> 	DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0, 4)),
> 	DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0, 5)),
> 	DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14)),
> 	DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15)),
> 	DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16)),
> 	DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17)),
> 	DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18)),
> 	DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19)),
> };
> 
> This information is going to be needed by the dmaengine driver, so
> modification to the platform_data is needed, and the driver map should be
> added to the pdata of the DMA driver:
> 
> da8xx_edma0_pdata.filter_map = da830_edma_map;
> da8xx_edma0_pdata.filtercnt = ARRAY_SIZE(da830_edma_map);
> 
> The DMA driver then needs to convigure the needed device -> filter_fn
> mapping before it registers with dma_async_device_register() :
> 
> if (info->filter_map) {
> 	ecc->dma_slave.filter_map.map = info->filter_map;
> 	ecc->dma_slave.filter_map.mapcnt = info->filtercnt;
> 	ecc->dma_slave.filter_map.filter_fn = edma_filter_for_map;
> }
> 
> When neither DT or ACPI lookup is available the dma_request_chan() will
> try to match the requester's device name with the filter_map's list of
> device names, when a match found it will use the information from the
> dma_filter_map to get the channel with the dma_get_channel() internal
> function.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (15):
>   dmaengine: core: Allow NULL mask pointer in
>     __dma_device_satisfies_mask()
>   dmaengine: core: Move and merge the code paths using private_candidate
>   dmaengine: core: Introduce new, universal API to request a channel
>   dmaengine: edma: Add support for DMA filter mapping to slave devices
>   ARM: davinci: devices-da8xx: Add dma_filter_map to edma
>   ARM: davinci: dm355: Add dma_filter_map to edma
>   ARM: davinci: dm365: Add dma_filter_map to edma
>   ARM: davinci: dm644x: Add dma_filter_map to edma
>   ARM: davinci: dm646x: Add dma_filter_map to edma
>   mmc: davinci_mmc: Use dma_request_chan() to requesting DMA channel
>   spi: davinci: Use dma_request_chan() to requesting DMA channel
>   ARM: davinci: devices-da8xx: Remove DMA resources for MMC and SPI
>   ARM: davinci: devices: Remove DMA resources for MMC
>   ARM: davinci: dm355: Remove DMA resources for SPI
>   ARM: davinci: dm365: Remove DMA resources for SPI
> 
>  arch/arm/mach-davinci/devices-da8xx.c |  95 ++++++++++----------
>  arch/arm/mach-davinci/devices.c       |  19 ----
>  arch/arm/mach-davinci/dm355.c         |  28 ++++--
>  arch/arm/mach-davinci/dm365.c         |  30 +++++--
>  arch/arm/mach-davinci/dm644x.c        |  12 +++
>  arch/arm/mach-davinci/dm646x.c        |  11 +++
>  drivers/dma/dmaengine.c               | 160 +++++++++++++++++++++++++---------
>  drivers/dma/edma.c                    |  24 +++++
>  drivers/mmc/host/davinci_mmc.c        |  52 +++--------
>  drivers/spi/spi-davinci.c             |  76 +++++-----------
>  include/linux/dmaengine.h             |  31 +++++++
>  include/linux/platform_data/edma.h    |   5 ++
>  12 files changed, 330 insertions(+), 213 deletions(-)
> 
> -- 
> 2.6.3
> 

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
