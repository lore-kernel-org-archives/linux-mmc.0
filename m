From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/18] ARM: Add minimal Raspberry Pi 4 support
Date: Fri, 26 Jul 2019 00:09:00 +0200
Message-ID: <d4fb1feb-78a7-e860-cfdb-21d814bdcfd1@gmx.net>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <96113adb5fcab9c2f4bb5fa82b84ff5f9c07fd07.camel@suse.de>
 <bc650090-db86-ccac-01dc-23f08ad7b19b@gmx.net>
 <20190723093442.GA27239@lst.de>
 <04c5eaa03f3a124dbbce6186e11e19acc4539cc8.camel@suse.de>
 <b15509d6-bc2e-3d06-0eea-943e6e456d62@gmx.net>
 <5f9b11f54c66fd0487837f7e58af3adf7f86635f.camel@suse.de>
 <c642de0a85d67f7f758735f1bba083156cca0ddb.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c642de0a85d67f7f758735f1bba083156cca0ddb.camel@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Matthias Brugger <mbrugger@suse.com>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Am 25.07.19 um 10:22 schrieb Nicolas Saenz Julienne:
>>>> Any thoughts on this?
>>>>
>>>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>>>> index 5e5f1fabc3d4..3db8deed83a6 100644
>>>> --- a/arch/arm/mach-bcm/Kconfig
>>>> +++ b/arch/arm/mach-bcm/Kconfig
>>>> @@ -168,6 +168,7 @@ config ARCH_BCM2835
>>>>         select PINCTRL
>>>>         select PINCTRL_BCM2835
>>>>         select MFD_CORE
>>>> +       select DMABOUNCE
>>>>         help
>>>>           This enables support for the Broadcom BCM2835 and BCM2836 SoCs.
>>>>           This SoC is used in the Raspberry Pi and Roku 2 devices.
>>>> diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-
>>>> bcm/board_bcm2835.c
>>>> index c09cf25596af..be788849c4bb 100644
>>>> --- a/arch/arm/mach-bcm/board_bcm2835.c
>>>> +++ b/arch/arm/mach-bcm/board_bcm2835.c
>>>> @@ -3,6 +3,8 @@
>>>>   * Copyright (C) 2010 Broadcom
>>>>   */
>>>>
>>>> +#include <linux/device.h>
>>>> +#include <linux/dma-mapping.h>
>>>>  #include <linux/init.h>
>>>>  #include <linux/irqchip.h>
>>>>  #include <linux/of_address.h>
>>>> @@ -24,8 +26,37 @@ static const char * const bcm2835_compat[] = {
>>>>         NULL
>>>>  };
>>>>
>>>> +static int bcm2835_needs_bounce(struct device *dev, dma_addr_t dma_addr,
>>>> size_t size)
>>>> +{
>>>> +       /*
>>>> +        * The accepted dma addresses are [0xc0000000, 0xffffffff] which
>>>> map
>>>> to
>>>> +        * ram's [0x00000000, 0x3fffffff].
>>>> +        */
>>>> +       return dma_addr < 3ULL * SZ_1G;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setup DMA mask to 1GB on devices hanging from soc interconnect
>>>> + */
>>>> +static int bcm2835_platform_notify(struct device *dev)
>>>> +{
>>>> +       if (dev->parent && !strcmp("soc", dev_name(dev->parent))) {
>>>> +               dev->dma_mask = &dev->coherent_dma_mask;
>>>> +               dev->coherent_dma_mask = DMA_BIT_MASK(30); /* 1GB */
>>> Shouldn't this come from the device tree?
>> Yes, actually I could use the 'dma-ranges' parsing code I suggested on the
>> arm64 RFC. The same goes with 'dma_zone_size = SZ_1G', it ideally should be
>> calculated based on the device-tree.
>>
>> The way I see it I'm not sure it's worth the effort, in arm64 we have no
>> choice
>> as there are no board files. But here we seem to be the only ones with this
>> specific DMA addressing constraint, so fixing it in arm/common doesn't seem
>> like it's going to benefit anyone else. Let's see how the arm arch maintainers
>> react though.
>>
>> There is one catch though. I missed it earlier as I was excited to see the
>> board boot, but some devices are failing to set their DMA masks:
>>
>> [    1.989576] dwc2 fe980000.usb: can't set coherent DMA mask: -5
>>
>> It seems that other users of dmabounce also implement their own
>> dma_supported(). I have to look into it.
> Sadly it seems there are some limitations in dmabounce I didn't take into
> account earlier. Among other things it can't deal with HighMem out of the box
> and even when trying to adapt it to our needs, fails to do so as it allocates
> using GFP_ATOMIC, which rules out using the CMA when allocating coherent
> memory. Sorry for the noise, I got carried away too soon.
>
> I did a dirty hack hooking up dma-direct/swiotlb to the board. It seems to be
> working fine after some tweaks in arm's dma_capable(). That said I want to test
> it further before sending anything ;).
>
Take your time.

But please inform about possible modifications to the devicetree. I will
sent out V2 of my series in a few days.
