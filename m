From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v4 00/10] ARM: OMAP1/2+: MMC: separate platform data for mmc and mmc hs driver
Date: Sat,  8 Nov 2014 15:33:07 +0100
Message-ID: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

v4:
- rework patch descriptions
- dropped patch removing unused defines in mach-omap2/mmc.h
- rebase 3.18.0-rc3
- compile test omap1 and omap2

compile tested
OMAP1:
CONFIG_MACH_OMAP_INNOVATOR=y
CONFIG_MACH_OMAP_H2=y
CONFIG_MACH_OMAP_H3=y
CONFIG_MACH_HERALD=y
CONFIG_MACH_OMAP_OSK=y
CONFIG_MACH_OMAP_PERSEUS2=y
CONFIG_MACH_OMAP_FSAMPLE=y
CONFIG_MACH_VOICEBLUE=y
CONFIG_MACH_OMAP_PALMTE=y
CONFIG_MACH_OMAP_PALMZ71=y
CONFIG_MACH_OMAP_PALMTT=y
CONFIG_MACH_SX1=y
CONFIG_MACH_NOKIA770=y
CONFIG_MACH_AMS_DELTA=y
CONFIG_MACH_OMAP_GENERIC=y

OMAP2:
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

Andreas Fenkart (10):
  ARM: OMAP2: MMC: include mmc-omap platform header directly
  ARM: OMAP1/2+: MMC: separate platform data for mmc and mmc hs driver
  omap_hsmmc: remove unused fields in platform_data
  omap_hsmmc: remove un-initialized callbacks from platform data
  omap_hsmmc: remove never read power_saving field in omap2_hsmmc_info
  omap_hsmmc: remove unused get_context_loss_count callback
  omap_hsmmc: remove unnecessary omap_hsmmc_slot_data indirection
  omap_hsmmc: pass mmc_priv struct to gpio init / free
  omap_hsmmc: Remove unnecessary callbacks from platform data
  omap_hsmmc: remove unused slot_id parameter

 arch/arm/mach-omap2/board-n8x0.c                   |   2 +
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   4 +-
 arch/arm/mach-omap2/hsmmc.c                        | 158 +++++-------
 arch/arm/mach-omap2/hsmmc.h                        |   9 +-
 arch/arm/mach-omap2/mmc.h                          |  10 -
 arch/arm/mach-omap2/omap4-common.c                 |   1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   4 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   8 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   8 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   4 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   4 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   4 +-
 drivers/mmc/host/omap_hsmmc.c                      | 282 ++++++++++-----------
 include/linux/platform_data/hsmmc-omap.h           |  90 +++++++
 include/linux/platform_data/mmc-omap.h             |  27 --
 16 files changed, 312 insertions(+), 304 deletions(-)
 create mode 100644 include/linux/platform_data/hsmmc-omap.h

-- 
2.1.1

