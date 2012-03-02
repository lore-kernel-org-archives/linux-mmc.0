From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/4] Start getting rid of pdata callbacks with gpio_find_by_chip_name()
Date: Fri, 02 Mar 2012 14:36:54 +0530
Message-ID: <4F508DAE.9000005@ti.com>
References: <20120301185044.29210.44521.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:35446 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965439Ab2CBJHC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Mar 2012 04:07:02 -0500
Received: by ghbf1 with SMTP id f1so767216ghb.23
        for <linux-mmc@vger.kernel.org>; Fri, 02 Mar 2012 01:07:00 -0800 (PST)
In-Reply-To: <20120301185044.29210.44521.stgit@kaulin.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On Friday 02 March 2012 12:25 AM, Tony Lindgren wrote:
> Hi all,
>
> This series adds gpio_find_by_name() that allows finding
> GPIOs on specific gpio_chips. As the GPIO numbers can be
> dynamic, it's hard to find the GPIO numbers from drivers
> using them directly.
>
> So far we've dealt with this using platform specific callbacks,
> but that is messy. This series removes the needs for these
> callbacks for omap hsmmc driver. Further callbacks can be
> removed people are OK with adding gpio_find_by_name().
>
> This series is based on the omap fixes-non-critical that's
> needed for the arch/arm/mach-omap2 parts of this series.

I tested these on my beagle/panda/omap4sdp and they seem to
work fine, also fixing the broken panda card detect (due to
missing card_detect_irq in the board file). There are still
issues however when I build twl4030-gpio as a module, which I
already commented on, and the fact that the init sequence now
works by luck :)
The other issue also is that the multiple insmod/rmmod test
suggested by Russell still fails, since the second time around
the gpio_requests in the board callback fail because they are
not freed when you do a module unload/unbind.
That would need this patch from me to add the .teardown
hooks
http://marc.info/?l=linux-omap&m=133007767831297&w=2

regards,
Rajendra

>
> Regards,
>
> Tony
>
> ---
>
> Tony Lindgren (4):
>        gpiolib: Add gpiochip_find_by_name() and gpio_find_by_chip_name()
>        mmc: omap_hsmmc: Use gpio_find_by_chip_name() for omap_hsmmc_gpio_init()
>        mmc: omap_hsmmc: Use GPIO offset for external GPIO chips
>        mmc: omap_hsmmc: Simplify init for twl6030 MMC card detect
>
>
>   arch/arm/mach-omap2/board-3430sdp.c          |   13 +-
>   arch/arm/mach-omap2/board-4430sdp.c          |   45 --------
>   arch/arm/mach-omap2/board-cm-t35.c           |    8 -
>   arch/arm/mach-omap2/board-devkit8000.c       |    7 -
>   arch/arm/mach-omap2/board-igep0020.c         |    8 -
>   arch/arm/mach-omap2/board-omap3beagle.c      |    9 +-
>   arch/arm/mach-omap2/board-omap3evm.c         |    8 -
>   arch/arm/mach-omap2/board-omap3pandora.c     |   13 +-
>   arch/arm/mach-omap2/board-omap3stalker.c     |    8 -
>   arch/arm/mach-omap2/board-omap3touchbook.c   |    7 -
>   arch/arm/mach-omap2/board-omap4panda.c       |   52 ----------
>   arch/arm/mach-omap2/board-zoom-peripherals.c |    7 -
>   arch/arm/mach-omap2/hsmmc.c                  |    3 +
>   arch/arm/mach-omap2/hsmmc.h                  |    5 +
>   arch/arm/plat-omap/include/plat/mmc.h        |    3 +
>   drivers/gpio/gpio-twl4030.c                  |    2
>   drivers/gpio/gpiolib.c                       |   47 +++++++++
>   drivers/mfd/twl6030-irq.c                    |   33 +++---
>   drivers/mmc/host/omap_hsmmc.c                |  140 +++++++++++++++++++-------
>   include/asm-generic/gpio.h                   |    3 -
>   20 files changed, 204 insertions(+), 217 deletions(-)
>

