From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 00/10 v3] mmc: tmio/sdhi: hotplug & PM
Date: Thu,  9 Feb 2012 22:57:06 +0100
Message-ID: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58200 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab2BIV5V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 16:57:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

This is v3 of a patch series, that uses the recently committed generic 
GPIO card hotplug handler, fixes minor PM issues, adds some cosmetic 
clean up. The series applies on top of mmc-next of 09 Feb. 2012.

Guennadi Liakhovetski (10):
  mmc: simplify mmc_cd_gpio_request() by removing two parameters
  mmc: tmio: calculate the native hotplug condition only once
  mmc: tmio_mmc: support the generic MMC GPIO card hotplug helper
  mmc: sh_mobile_sdhi: pass card hotplug GPIO number to TMIO MMC
  ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO
    hotplug helper
  ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO
    hotplug helper
  mmc: tmio_mmc: power status flag doesn't have to be exposed in
    platform data
  mmc: tmio_mmc: remove unused sdio_irq_enabled flag
  mmc: sh_mobile_sdhi: do not manage PM clocks manually
  mmc: tmio: cosmetic: prettify the tmio_mmc_set_ios() function

 arch/arm/mach-shmobile/board-ag5evm.c   |   22 +------
 arch/arm/mach-shmobile/board-mackerel.c |   22 +------
 drivers/mmc/core/cd-gpio.c              |   13 +++-
 drivers/mmc/host/sh_mobile_sdhi.c       |    7 +--
 drivers/mmc/host/tmio_mmc.h             |    9 +--
 drivers/mmc/host/tmio_mmc_pio.c         |  102 ++++++++++++++-----------------
 include/linux/mfd/tmio.h                |   26 ++++++--
 include/linux/mmc/cd-gpio.h             |    3 +-
 include/linux/mmc/sh_mobile_sdhi.h      |    1 +
 9 files changed, 86 insertions(+), 119 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
