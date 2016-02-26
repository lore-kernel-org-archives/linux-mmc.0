From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-tegra: Set DMA mask
Date: Fri, 26 Feb 2016 16:24:34 +0900
Message-ID: <CAAVeFuLL-SP3_x2GC4UWcH4KEVora6r-e5xmORQdVfjcjfWDOw@mail.gmail.com>
References: <1456305079-27779-1-git-send-email-acourbot@nvidia.com>
 <2393024.oLdk3CGNWo@wuerfel> <CAAVeFu+oesnB9d3wOo5QmUR++UFekahwjOQWbJw_X=MxaimDHg@mail.gmail.com>
 <29473125.UhEGU5khX5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35477 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbcBZHYy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Feb 2016 02:24:54 -0500
In-Reply-To: <29473125.UhEGU5khX5@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Feb 25, 2016 at 11:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> Actually even if we specify a dma-ranges on the parent DT node, the
>> DMA range will still be limited to 32 bits because of the following
>> code in of_dma_configure():
>>
>>     /*
>>      * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
>>      * setup the correct supported mask.
>>      */
>>     if (!dev->coherent_dma_mask)
>>         dev->coherent_dma_mask = DMA_BIT_MASK(32);
>>
>>     /*
>>      * Set it to coherent_dma_mask by default if the architecture
>>      * code has not set it.
>>      */
>>     if (!dev->dma_mask)
>>         dev->dma_mask = &dev->coherent_dma_mask;
>>
>>     ....
>>     /* gets dma-ranges into dma_addr and size */
>>     ....
>>
>>
>>     *dev->dma_mask = min((*dev->dma_mask),
>>                  DMA_BIT_MASK(ilog2(dma_addr + size)));
>>
>> So unless the DMA mask is set on the device before of_dma_configure()
>> is called, the min() statement will choose the 32 bits mask that has
>> been previously set. So IIUC in any case, the driver will need to call
>> dma_set_mask()
>
> Yes, the driver definitely has to call dma_set_mask(), the property of
> the parent bus is used to make that fail when the bus doesn't support
> it.

And that's where things seem to stop working: the driver's probe
function is invoked by the platform bus, *after* of_dma_configure() is
called. So unless I am missing something there is no way for the
driver to set the DMA mask in such a way that of_dma_configure() can
see it and do the right thing.

In other words, most of the DMA mask logic in of_dma_configure()
doesn't seem to have any effect (and a 32 bits mask will be set), at
least on the platform bus.

>> Can I have your thoughts on this? Am I missing something?
>
> One point: I think the dma_set_mask() probably should be in the
> generic part of the sdhci driver, not the tegra specific portion.

Ok, but then how does the generic part of the driver knows which DMA
mask applies to the device?

> I also forget how this really needs to interact with swiotlb. I know
> we have discussed this a couple of times, but the result currently
> is lost to me.
> Maybe the answer was that if swiotlb or iommu are enabled, then
> dma_set_mask() should always succeed, but the mask should not actually
> be updated?
