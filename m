From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC v02 00/15] dmaengine: New 'universal' API for requesting channel
Date: Wed, 02 Dec 2015 14:38:39 +0100
Message-ID: <15116008.0PghG2Imaa@wuerfel>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com> <103520159.g0xhtFsXUi@wuerfel> <565ECD3F.3070500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <565ECD3F.3070500-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 02 December 2015 12:51:43 Peter Ujfalusi wrote:
> On 12/01/2015 04:24 PM, Arnd Bergmann wrote:
> > On Tuesday 01 December 2015 15:45:32 Peter Ujfalusi wrote:
> >>>> static struct dma_filter_map da830_edma_map[] = {
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)),
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)),
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)),
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0, 3)),
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0, 4)),
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0, 5)),
> >>>>         DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14)),
> >>>>         DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15)),
> >>>>         DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16)),
> >>>>         DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17)),
> >>>>         DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18)),
> >>>>         DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19)),
> >>>
> >>> Does this ".2" and so prevent driver to use auto ID for platform devices?
> >>
> >> Yes, as all the infra around the traditional board files with platform_device
> >> creation does. Ideally we could have 'phandle' pointing from this table to the
> >> device in question (or other way around), but I'm not aware of anything we can
> >> use.
> > 
> > I was thinking that we could use a pointer to the device structure, but
> > if you have that, you can also just read the name from it.
> 
> Hrm to have pdev pointer instead of the devname string? In the core we could
> get the pdev from the caller's device with to_platform_device(dev) and simply
> compare the pointers...
> 
> One of the issue I see (in mach-davinci and mach-omap1/2) is that the pdevs
> are scattered around in the c files so gathering the pointers to a place where
> we can see them to be able to use it in the dma_filter_map is not going to be
> light weight task.
> Furthermore we have the omap_hwmod for OMAP2+ which creates the actual pdevs
> and resources from the omap_hwmod data structures so getting out the DMA event
> numbers there is not going to be easy either...
> 
> I'll hold back the RFC v3 to see if we should switch to pdev pointer or stay
> with the devname strings here.

Sorry, what I meant to say above is that I had already concluded that using
device pointers was a bad idea and we should stay with names.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
