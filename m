From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 3/6] dmaengine: core: Introduce new, universal API to request a channel
Date: Fri, 27 Nov 2015 12:26:28 +0100
Message-ID: <3014022.sbSbxmCZ7n@wuerfel>
References: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com> <24788322.ynD35Kf0xi@wuerfel> <56583B95.7060503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:58185 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbbK0L07 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Nov 2015 06:26:59 -0500
In-Reply-To: <56583B95.7060503@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org

On Friday 27 November 2015 13:16:37 Peter Ujfalusi wrote:
> On 11/27/2015 01:00 PM, Arnd Bergmann wrote:
> > On Friday 27 November 2015 10:29:39 Peter Ujfalusi wrote:
> >> struct dma_chan *dma_request_chan(struct device *dev, const char *name,
> >>                                const dma_cap_mask_t *mask);
> >> To request a slave channel. The mask parameter is optional and it is used
> >> to check if the received channel's capabilities can satisfy the requested
> >> mask. The dma_request_chan() will try to find the channel via DT, ACPI or
> >> in case if the kernel booted in non DT/ACPI mode it will use a filter
> >> lookup table and retrieves the RESOURCE_DMA from the requester's device.
> >> This legacy mode needs changes in platform code, in dmaengine drivers and
> >> finally the dmaengine user drivers can be converted:
> > 
> > I think we should not introduce the mask parameter at all. In the rare
> > case that we actually need to pass a mask other than DMA_SLAVE today,
> > we should be able to encode that in the data we pass to the filter
> > function.
> 
> I have seen that drivers check the capabilities themselves after getting the
> channel, so I thought that if we move that also to the core we can save on
> duplicated lines around the kernel. It is not needed to get the channel. As
> you can see in the mmc patch, I pass NULL and the channel I got is the correct
> one.
> Sure, I can remove it.

Ok.

> >> RESOURCE_DMA needs to be added to the platform devices with names
> >>
> >> For each dmaengine driver a string array listing the devices handled by the
> >> given DMA driver:
> >>
> >> static char *da8xx_edma0_devices[] = {
> >>      "davinci-mcasp.0",
> >>      "da830-mmc.0",
> >> };
> >>
> >> This information is going to be needed by the dmaengine driver, so
> >> modification to the platform_data is needed, and the driver map should be
> >> added to the pdata of the DMA driver:
> > 
> > However, a lot of drivers definitely need to pass a data pointer for
> > each device. I see that you currently rely on the IORESOURCE_DMA
> > method that a couple of platforms use today, but I think it would
> > be backwards to do it that way for the platforms that require passing
> > more than an integer number today.
> > 
> > Having a pointer as the filter function argument is intentional and I'd
> > prefer to change the platforms that currently use IORESOURCE_DMA (davinci,
> > pxa, omap1, blackfin, alchemy) to stop doing it instead, and return
> > IORESOURCE_DMA to its original meaning that was limited to ISAPNP style
> > devices not using the dmaengine API.
> 
> Something like this:
> 
> /* include/linux/dmaengine.h */
> 
> struct dma_filter_map {
>         char *devname;
>         char *slave;
>         void *param;
> };
> 
> struct dma_filter {
>         dma_filter_fn filter_fn;
>         int mapcnt;
>         struct dma_filter_map *map;
> };
> 
> /* arch/arm/mach-davinci/devices-da8xx.c */
> 
> static struct dma_filter_map da8xx_edma0_map[] = {
>         {
>                 .devname = "davinci-mcasp.0",
>                 .slave = "tx",
>                 .param = (void*)DAVINCI_DA8XX_DMA_MCASP0_AXEVT,
>         },
>         {
>                 .devname = "davinci-mcasp.0",
>                 .slave = "rx",
>                 .param = (void*)DAVINCI_DA8XX_DMA_MCASP0_AREVT,
>         },
>         {
>                 .devname = "da830-mmc.0",
>                 .slave = "tx",
>                 .param = (void*)DA8XX_DMA_MMCSD0_TX,
>         },
>         {
>                 .devname = "da830-mmc.0",
>                 .slave = "rx",
>                 .param = (void*)DA8XX_DMA_MMCSD0_RX,
>         },
> };
> 
> I had this version first, but decided to go with a simpler one present in this
> RFC series.

Yes, that is what I had in mind. Let's see what others think about the two
options.

I would also avoid the 'struct dma_filter' entirely by using a zero-terminated
list and passing the filter function and map table separately, but your approach
seems reasonable as well.

In my initial suggestion, the idea was to do the registration of the filter map
separately from registering the dmaengine device to give us a little more
flexibility in converting existing code, but it requires listing both the
dmaengine device and the slave devname in the map, so your approach is probably
better in the long run even if it requires a little more work for doing the
conversion.

	Arnd
