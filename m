From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-tegra: Set DMA mask
Date: Thu, 25 Feb 2016 18:49:06 +0900
Message-ID: <CAAVeFu+oesnB9d3wOo5QmUR++UFekahwjOQWbJw_X=MxaimDHg@mail.gmail.com>
References: <1456305079-27779-1-git-send-email-acourbot@nvidia.com> <2393024.oLdk3CGNWo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2393024.oLdk3CGNWo@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Feb 24, 2016 at 9:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 24 February 2016 18:11:19 Alexandre Courbot wrote:
>> On T210, the sdhci controller can address more than 32 bits of address
>> space. Failing to express this fact results in the use of bounce
>> buffers and affects performance.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>> I am pretty sure this one is wrong in some way, but just to get the ball
>> rolling as the use of bounce buffers is currently quite heavy on Jetson TX1.
>>
>> Thierry, Stephen, could you confirm that I got the DMA masks correctly? I
>> am not sure about the actual addressable size on TX1, and also suspect TK1 can
>> also address more than 32 bits.
>>
>> Also, I noticed that sdhci_host has a dma_mask member which I thought would do
>> the trick but actually doesn't seem to be used for anything useful. Could the
>> MMC maintainers comment on this and let me know if the DMA mask setting should
>> be moved at the core level instead of being done per-driver?
>
> So the question is what the DMA capabilities of the sdhci device are.
>
> Usually I think SDHCI should just support a 64-bit mask, and you can
> request that in the driver, but the platform might reject it, e.g.
> if the parent bus is lacking a dma-ranges property.
>
> On 32-bit platforms with no RAM above the 4GB boundary, setting a 64-bit
> mask typically succeeds, because there is no harm in using it.
>
> You should only set a 34-bit mask in the specific case that:
>
> * SDHCI reports that it supports 64-bit addressing
> * The parent bus supports 64-bit addressing and correctly sets up
>   its dma-ranges property
> * The device is connected incorrectly to the parent bus and
>   any access above 0x400000000ull fail to end up in the correct
>   memory for this particular device, but not other devices on the
>   same bus.

Thanks for the clarification. The hardware is definitely capable of >
32 bits addressing (how much more exactly, I still have to figure out
as Stephen pointed out). Parent bus is the platform bus (root node in
the DT) so I'm not too sure how the dma-ranges property should be used
in that case (as of today we have no dma-ranges property at all in
Tegra DTs). We could maybe specify it at the root level (I see at
least one arm device doing that), but then we need to make sure every
platform device supports the same range.

Actually even if we specify a dma-ranges on the parent DT node, the
DMA range will still be limited to 32 bits because of the following
code in of_dma_configure():

    /*
     * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
     * setup the correct supported mask.
     */
    if (!dev->coherent_dma_mask)
        dev->coherent_dma_mask = DMA_BIT_MASK(32);

    /*
     * Set it to coherent_dma_mask by default if the architecture
     * code has not set it.
     */
    if (!dev->dma_mask)
        dev->dma_mask = &dev->coherent_dma_mask;

    ....
    /* gets dma-ranges into dma_addr and size */
    ....


    *dev->dma_mask = min((*dev->dma_mask),
                 DMA_BIT_MASK(ilog2(dma_addr + size)));

So unless the DMA mask is set on the device before of_dma_configure()
is called, the min() statement will choose the 32 bits mask that has
been previously set. So IIUC in any case, the driver will need to call
dma_set_mask()

Can I have your thoughts on this? Am I missing something?
