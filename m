From: Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH] mmc: sdhci-tegra: Set DMA mask
Date: Tue, 1 Mar 2016 13:21:54 +0900
Message-ID: <56D518E2.4050303@nvidia.com>
References: <1456305079-27779-1-git-send-email-acourbot@nvidia.com>
 <29473125.UhEGU5khX5@wuerfel>
 <CAAVeFuLL-SP3_x2GC4UWcH4KEVora6r-e5xmORQdVfjcjfWDOw@mail.gmail.com>
 <6561324.RvoTsUTSRM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6561324.RvoTsUTSRM@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 02/26/2016 08:31 PM, Arnd Bergmann wrote:
> On Friday 26 February 2016 16:24:34 Alexandre Courbot wrote:
>> On Thu, Feb 25, 2016 at 11:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> Actually even if we specify a dma-ranges on the parent DT node, the
>>>> DMA range will still be limited to 32 bits because of the following
>>>> code in of_dma_configure():
>>>>
>>>>      /*
>>>>       * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
>>>>       * setup the correct supported mask.
>>>>       */
>>>>      if (!dev->coherent_dma_mask)
>>>>          dev->coherent_dma_mask = DMA_BIT_MASK(32);
>>>>
>>>>      /*
>>>>       * Set it to coherent_dma_mask by default if the architecture
>>>>       * code has not set it.
>>>>       */
>>>>      if (!dev->dma_mask)
>>>>          dev->dma_mask = &dev->coherent_dma_mask;
>>>>
>>>>      ....
>>>>      /* gets dma-ranges into dma_addr and size */
>>>>      ....
>>>>
>>>>
>>>>      *dev->dma_mask = min((*dev->dma_mask),
>>>>                   DMA_BIT_MASK(ilog2(dma_addr + size)));
>>>>
>>>> So unless the DMA mask is set on the device before of_dma_configure()
>>>> is called, the min() statement will choose the 32 bits mask that has
>>>> been previously set. So IIUC in any case, the driver will need to call
>>>> dma_set_mask()
>>>
>>> Yes, the driver definitely has to call dma_set_mask(), the property of
>>> the parent bus is used to make that fail when the bus doesn't support
>>> it.
>>
>> And that's where things seem to stop working: the driver's probe
>> function is invoked by the platform bus, *after* of_dma_configure() is
>> called. So unless I am missing something there is no way for the
>> driver to set the DMA mask in such a way that of_dma_configure() can
>> see it and do the right thing.
>>
>> In other words, most of the DMA mask logic in of_dma_configure()
>> doesn't seem to have any effect (and a 32 bits mask will be set), at
>> least on the platform bus.
>
> That is correct: of_dma_configure has to set a 32-bit DMA mask
> because that is the default that we expect to see in Linux drivers.
>
> A lot of drivers don't call dma_set_mask() at all, so this is
> the most reasonable value that typically works, unless the
> device is more limited, or you want the extra performance you
> get on devices that actually support a bigger mask.
>
>>>> Can I have your thoughts on this? Am I missing something?
>>>
>>> One point: I think the dma_set_mask() probably should be in the
>>> generic part of the sdhci driver, not the tegra specific portion.
>>
>> Ok, but then how does the generic part of the driver knows which DMA
>> mask applies to the device?
>
> If dma_set_mask() succeeds when passed a 64-bit mask, the driver
> can pass high addresses into dma_map_*() and put the result into
> the 64-bit DMA registers of the device. That is all the driver
> needs to know here.
>
> When the bus is more limited than the device, we either have
> an swiotlb/iommu that will use bounce buffers to map dma_map_* work
> anyway (using low DMA addresses for high memory), or we don't have
> an swiotlb and the dma_set_mask() operation has to fail.

Ok, I think I understand. I was expecting of_dma_configure() to do more 
than it actually needs to and be the final arbiter of a device's DMA 
mask. That's obviously not the case - thanks for the thorough explanation.

Let me send a v2 of this to see if I got it properly.
