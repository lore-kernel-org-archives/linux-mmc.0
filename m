From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/18] ARM: Add minimal Raspberry Pi 4 support
Date: Tue, 23 Jul 2019 18:26:54 +0200
Message-ID: <b15509d6-bc2e-3d06-0eea-943e6e456d62@gmx.net>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <96113adb5fcab9c2f4bb5fa82b84ff5f9c07fd07.camel@suse.de>
 <bc650090-db86-ccac-01dc-23f08ad7b19b@gmx.net>
 <20190723093442.GA27239@lst.de>
 <04c5eaa03f3a124dbbce6186e11e19acc4539cc8.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <04c5eaa03f3a124dbbce6186e11e19acc4539cc8.camel@suse.de>
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

Hi Nicolas,

thanks for your work, but i'm a little bit sceptical about these
changes. So here some thoughts.

Am 23.07.19 um 15:32 schrieb Nicolas Saenz Julienne:
> On Tue, 2019-07-23 at 11:34 +0200, Christoph Hellwig wrote:
>> On Mon, Jul 22, 2019 at 08:10:17PM +0200, Stefan Wahren wrote:
>>> i rebased this series also and got this only on the RPi 4.
>>>
>>> After reverting the following:
>>>
>>> 79a986721de dma-mapping: remove dma_max_pfn
>>> 7559d612dff0 mmc: core: let the dma map ops handle bouncing
>>>
>>> This crash disappear, but wifi seems to be still broken.
>>>
>>> Would be nice, if you can investigate further.
>> That means dma addressing on this system doesn't just work for some
>> memory, and the mmc bounce buffering was papering over that just for
>> mmc.  Do you have highmem on this system?
>>
>> You might want to try this series, which has been submitted upstream:
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-swiotlb
> Hi Christoph,
> I tried your series on top of Stefan's, it has no effect. I guess it's no
> surprise as with mult_v7_defconfig, you get SWIOTLB=n & LPAE=n.
>
> FYI DMA addressing constraints for RPi4 are the following: devices can only
> access the first GB of ram even though the board might have up to 4GB of ram.
> The DMA addresses are aliased with a 0xc0000000 offset. So 0x00000000 phys is
> aliased to 0xc0000000 in DMA. This is the same as for an RFC you commented last
> week trying to fix similar issues for arm64.
>
> You state in "arm: use swiotlb for bounce buffer on LPAE configs" that "The DMA
> API requires that 32-bit DMA masks are always supported". If I understand it
> correctly this device breaks that assumption. Which implies we need a bounce
> buffer system in place for any straming DMA user.
>
> It seems we're unable to use dma-direct/swiotlb, so I enabled arm's dmabounce
> on all devices hooked into RPi's limited interconnect, which fixes this issue.
Does it fix the wifi issue too?
> Any thoughts on this?
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 5e5f1fabc3d4..3db8deed83a6 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -168,6 +168,7 @@ config ARCH_BCM2835
>         select PINCTRL
>         select PINCTRL_BCM2835
>         select MFD_CORE
> +       select DMABOUNCE
>         help
>           This enables support for the Broadcom BCM2835 and BCM2836 SoCs.
>           This SoC is used in the Raspberry Pi and Roku 2 devices.
> diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
> index c09cf25596af..be788849c4bb 100644
> --- a/arch/arm/mach-bcm/board_bcm2835.c
> +++ b/arch/arm/mach-bcm/board_bcm2835.c
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2010 Broadcom
>   */
>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/init.h>
>  #include <linux/irqchip.h>
>  #include <linux/of_address.h>
> @@ -24,8 +26,37 @@ static const char * const bcm2835_compat[] = {
>         NULL
>  };
>
> +static int bcm2835_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
> +{
> +       /*
> +        * The accepted dma addresses are [0xc0000000, 0xffffffff] which map to
> +        * ram's [0x00000000, 0x3fffffff].
> +        */
> +       return dma_addr < 3ULL * SZ_1G;
> +}
> +
> +/*
> + * Setup DMA mask to 1GB on devices hanging from soc interconnect
> + */
> +static int bcm2835_platform_notify(struct device *dev)
> +{
> +       if (dev->parent && !strcmp("soc", dev_name(dev->parent))) {
> +               dev->dma_mask = &dev->coherent_dma_mask;
> +               dev->coherent_dma_mask = DMA_BIT_MASK(30); /* 1GB */
Shouldn't this come from the device tree?
> +               dmabounce_register_dev(dev, 2048, 4096, bcm2835_needs_bounce);
> +       }
> +
> +       return 0;
> +}
> +
> +void __init bcm2835_init_early(void)
> +{
> +       platform_notify = bcm2835_platform_notify;
> +}
> +
>  DT_MACHINE_START(BCM2835, "BCM2835")
>         .dma_zone_size  = SZ_1G,
>         .dt_compat = bcm2835_compat,
>         .smp = smp_ops(bcm2836_smp_ops),
> +       .init_early = bcm2835_init_early,

The sum of all these changes make me think, that we should start a new
board for BCM2711 instead of extending BCM2835.

Best regards
Stefan Wahren

>  MACHINE_END
>
>  Regards,
>  Nicolas
>
