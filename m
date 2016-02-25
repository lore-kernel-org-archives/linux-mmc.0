From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci-tegra: Set DMA mask
Date: Thu, 25 Feb 2016 15:52:13 +0100
Message-ID: <29473125.UhEGU5khX5@wuerfel>
References: <1456305079-27779-1-git-send-email-acourbot@nvidia.com> <2393024.oLdk3CGNWo@wuerfel> <CAAVeFu+oesnB9d3wOo5QmUR++UFekahwjOQWbJw_X=MxaimDHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:56243 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933052AbcBYOwW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Feb 2016 09:52:22 -0500
In-Reply-To: <CAAVeFu+oesnB9d3wOo5QmUR++UFekahwjOQWbJw_X=MxaimDHg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday 25 February 2016 18:49:06 Alexandre Courbot wrote:
> On Wed, Feb 24, 2016 at 9:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 24 February 2016 18:11:19 Alexandre Courbot wrote:
> >> On T210, the sdhci controller can address more than 32 bits of address
> >> space. Failing to express this fact results in the use of bounce
> >> buffers and affects performance.
> >>
> >> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> >> ---
> >> I am pretty sure this one is wrong in some way, but just to get the ball
> >> rolling as the use of bounce buffers is currently quite heavy on Jetson TX1.
> >>
> >> Thierry, Stephen, could you confirm that I got the DMA masks correctly? I
> >> am not sure about the actual addressable size on TX1, and also suspect TK1 can
> >> also address more than 32 bits.
> >>
> >> Also, I noticed that sdhci_host has a dma_mask member which I thought would do
> >> the trick but actually doesn't seem to be used for anything useful. Could the
> >> MMC maintainers comment on this and let me know if the DMA mask setting should
> >> be moved at the core level instead of being done per-driver?
> >
> > So the question is what the DMA capabilities of the sdhci device are.
> >
> > Usually I think SDHCI should just support a 64-bit mask, and you can
> > request that in the driver, but the platform might reject it, e.g.
> > if the parent bus is lacking a dma-ranges property.
> >
> > On 32-bit platforms with no RAM above the 4GB boundary, setting a 64-bit
> > mask typically succeeds, because there is no harm in using it.
> >
> > You should only set a 34-bit mask in the specific case that:
> >
> > * SDHCI reports that it supports 64-bit addressing
> > * The parent bus supports 64-bit addressing and correctly sets up
> >   its dma-ranges property
> > * The device is connected incorrectly to the parent bus and
> >   any access above 0x400000000ull fail to end up in the correct
> >   memory for this particular device, but not other devices on the
> >   same bus.
> 
> Thanks for the clarification. The hardware is definitely capable of >
> 32 bits addressing (how much more exactly, I still have to figure out
> as Stephen pointed out). Parent bus is the platform bus (root node in
> the DT) so I'm not too sure how the dma-ranges property should be used
> in that case (as of today we have no dma-ranges property at all in
> Tegra DTs).

I meant the actual physical bus. AXI buses that are typically used
can have either 32-bit or 64-bit addressing, but IIRC they wouldn't
have anything inbetween based on the way this protocol works (i.e.
not an actual set of address wires, but a data packet getting sent
around on a point to point link).

> We could maybe specify it at the root level (I see at
> least one arm device doing that), but then we need to make sure every
> platform device supports the same range.

I think there is still a bug in the code that will lead to
dma_set_mask just succeeding, regardless of what the bus supports,
and this should really really be fixed.

I think it will just keep working for platforms that accidentally
don't set the dma-ranges property, but it may be slower as we fall
back to swiotlb.

> Actually even if we specify a dma-ranges on the parent DT node, the
> DMA range will still be limited to 32 bits because of the following
> code in of_dma_configure():
> 
>     /*
>      * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
>      * setup the correct supported mask.
>      */
>     if (!dev->coherent_dma_mask)
>         dev->coherent_dma_mask = DMA_BIT_MASK(32);
> 
>     /*
>      * Set it to coherent_dma_mask by default if the architecture
>      * code has not set it.
>      */
>     if (!dev->dma_mask)
>         dev->dma_mask = &dev->coherent_dma_mask;
> 
>     ....
>     /* gets dma-ranges into dma_addr and size */
>     ....
> 
> 
>     *dev->dma_mask = min((*dev->dma_mask),
>                  DMA_BIT_MASK(ilog2(dma_addr + size)));
> 
> So unless the DMA mask is set on the device before of_dma_configure()
> is called, the min() statement will choose the 32 bits mask that has
> been previously set. So IIUC in any case, the driver will need to call
> dma_set_mask()

Yes, the driver definitely has to call dma_set_mask(), the property of
the parent bus is used to make that fail when the bus doesn't support
it.

> Can I have your thoughts on this? Am I missing something?

One point: I think the dma_set_mask() probably should be in the
generic part of the sdhci driver, not the tegra specific portion.

I also forget how this really needs to interact with swiotlb. I know
we have discussed this a couple of times, but the result currently
is lost to me.
Maybe the answer was that if swiotlb or iommu are enabled, then
dma_set_mask() should always succeed, but the mask should not actually
be updated?

	Arnd
