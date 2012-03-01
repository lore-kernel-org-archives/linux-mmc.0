From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Start getting rid of pdata callbacks with
 gpio_find_by_chip_name()
Date: Thu, 01 Mar 2012 10:55:21 -0800
Message-ID: <20120301185044.29210.44521.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11573 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab2CASzY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Mar 2012 13:55:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linuxkernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi all,

This series adds gpio_find_by_name() that allows finding
GPIOs on specific gpio_chips. As the GPIO numbers can be
dynamic, it's hard to find the GPIO numbers from drivers
using them directly.

So far we've dealt with this using platform specific callbacks,
but that is messy. This series removes the needs for these
callbacks for omap hsmmc driver. Further callbacks can be
removed people are OK with adding gpio_find_by_name().

This series is based on the omap fixes-non-critical that's
needed for the arch/arm/mach-omap2 parts of this series.

Regards,

Tony

---

Tony Lindgren (4):
      gpiolib: Add gpiochip_find_by_name() and gpio_find_by_chip_name()
      mmc: omap_hsmmc: Use gpio_find_by_chip_name() for omap_hsmmc_gpio_init()
      mmc: omap_hsmmc: Use GPIO offset for external GPIO chips
      mmc: omap_hsmmc: Simplify init for twl6030 MMC card detect


 arch/arm/mach-omap2/board-3430sdp.c          |   13 +-
 arch/arm/mach-omap2/board-4430sdp.c          |   45 --------
 arch/arm/mach-omap2/board-cm-t35.c           |    8 -
 arch/arm/mach-omap2/board-devkit8000.c       |    7 -
 arch/arm/mach-omap2/board-igep0020.c         |    8 -
 arch/arm/mach-omap2/board-omap3beagle.c      |    9 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    8 -
 arch/arm/mach-omap2/board-omap3pandora.c     |   13 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |    8 -
 arch/arm/mach-omap2/board-omap3touchbook.c   |    7 -
 arch/arm/mach-omap2/board-omap4panda.c       |   52 ----------
 arch/arm/mach-omap2/board-zoom-peripherals.c |    7 -
 arch/arm/mach-omap2/hsmmc.c                  |    3 +
 arch/arm/mach-omap2/hsmmc.h                  |    5 +
 arch/arm/plat-omap/include/plat/mmc.h        |    3 +
 drivers/gpio/gpio-twl4030.c                  |    2 
 drivers/gpio/gpiolib.c                       |   47 +++++++++
 drivers/mfd/twl6030-irq.c                    |   33 +++---
 drivers/mmc/host/omap_hsmmc.c                |  140 +++++++++++++++++++-------
 include/asm-generic/gpio.h                   |    3 -
 20 files changed, 204 insertions(+), 217 deletions(-)

-- 
Signature
