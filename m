From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v3 0/3] ARM: OMAP2+: MMC: use separate platform data for omap3 and omap 1/2 driver
Date: Sun,  5 Oct 2014 01:26:54 +0200
Message-ID: <1412465217-17454-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:39941 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaJDX1G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Oct 2014 19:27:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

v3:
- fix compile break, by include proper platform header 
  tested with these architectures
    CONFIG_MACH_OMAP2_TUSB6010=y
    CONFIG_MACH_OMAP3_BEAGLE=y
    CONFIG_MACH_DEVKIT8000=y
    CONFIG_MACH_OMAP_LDP=y
    CONFIG_MACH_OMAP3530_LV_SOM=y
    CONFIG_MACH_OMAP3_TORPEDO=y
    CONFIG_MACH_OVERO=y
    CONFIG_MACH_OMAP3517EVM=y
    CONFIG_MACH_CRANEBOARD=y
    CONFIG_MACH_OMAP3_PANDORA=y
    CONFIG_MACH_TOUCHBOOK=y
    CONFIG_MACH_OMAP_3430SDP=y
    CONFIG_MACH_NOKIA_N810=y
    CONFIG_MACH_NOKIA_N810_WIMAX=y
    CONFIG_MACH_NOKIA_N8X0=y
    CONFIG_MACH_NOKIA_RX51=y
    CONFIG_MACH_CM_T35=y
    CONFIG_MACH_CM_T3517=y
    CONFIG_MACH_CM_T3730=y
    CONFIG_MACH_SBC3530=y
    CONFIG_MACH_TI8168EVM=y
    CONFIG_MACH_TI8148EVM=y
- dropped all patches simplifying the hsmmc-omap platform struct,
  will resubmit once the platform data split is successful

Andreas Fenkart (3):
  ARM: OMAP2+: remove unused defines from mach-omap2/mmc header
  ARM: OMAP2+: include mmc-omap platform directly in hwmod data files
  ARM: OMAP2+: use separate platform data for omap3 and omap 1/2 driver

 arch/arm/mach-omap2/board-n8x0.c                   |   2 +
 arch/arm/mach-omap2/hsmmc.c                        |  27 ++--
 arch/arm/mach-omap2/mmc.h                          |  14 --
 arch/arm/mach-omap2/omap4-common.c                 |   1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   4 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   8 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   8 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   4 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   4 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   4 +-
 drivers/mmc/host/omap_hsmmc.c                      |  28 ++--
 include/linux/platform_data/hsmmc-omap.h           | 152 +++++++++++++++++++++
 include/linux/platform_data/mmc-omap.h             |  24 ----
 14 files changed, 198 insertions(+), 83 deletions(-)
 create mode 100644 include/linux/platform_data/hsmmc-omap.h

-- 
2.1.0

