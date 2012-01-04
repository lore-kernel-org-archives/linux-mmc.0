From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 00/11] mmc: tmio/sdhi: hotplug & PM
Date: Wed,  4 Jan 2012 15:17:05 +0100
Message-ID: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

This patch series uses a previously proposed generic GPIO card hotplug 
handler, fixes multiple PM issues, adds some cosmetic clean up. Not all of 
these patches really depend on each other, but it's easier to preserve the 
original order. Some patches, e.g., #9, are an RFC so far and might have to 
be reworked a bit.

Guennadi Liakhovetski (11):
  mmc: tmio: calculate the native hotplug condition only once
  mmc: tmio_mmc: support the generic MMC GPIO card hotplug helper
  mmc: sh_mobile_sdhi: pass card hotplug GPIO number and flags to TMIO
    MMC
  ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO
    hotplug helper
  ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO
    hotplug helper
  mfd: tmio: remove now unneeded tmio_mmc_cd_wakeup()
  mmc: tmio_mmc: power status flag doesn't have to be exposed in
    platform data
  mmc: tmio_mmc: remove unused sdio_irq_enabled flag
  mmc: sh_mobile_sdhi: do not manage PM clocks manually on ARM
  mmc: tmio: reconfigure the controller on runtime resume
  mmc: tmio: cosmetic: prettify the tmio_mmc_set_ios() function

 arch/arm/mach-shmobile/board-ag5evm.c   |   24 +------
 arch/arm/mach-shmobile/board-mackerel.c |   24 +------
 drivers/mmc/host/sh_mobile_sdhi.c       |   11 +++-
 drivers/mmc/host/tmio_mmc.h             |    9 +--
 drivers/mmc/host/tmio_mmc_pio.c         |  104 ++++++++++++++-----------------
 include/linux/mfd/tmio.h                |   17 ++---
 include/linux/mmc/sh_mobile_sdhi.h      |    3 +
 7 files changed, 79 insertions(+), 113 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
