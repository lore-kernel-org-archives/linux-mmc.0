From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2 0/9] unshare and simplify omap_hsmmc platform struct
Date: Mon, 29 Sep 2014 11:32:50 +0200
Message-ID: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

v2:
- replace erroneous mmci by omap1/2
- add description to all patches
- full compile check with:
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
	CONFIG_MACH_NOKIA_RX51=y
	CONFIG_MACH_CM_T35=y
	CONFIG_MACH_CM_T3517=y
	CONFIG_MACH_CM_T3730=y
	CONFIG_MACH_SBC3530=y
- reorganized and added more patches, hence no blank ack added


Andreas Fenkart (9):
  omap_hsmmc: use separate platform data for ompa3 and omap 1/2 driver
  omap_hsmmc: remove unused fields in platform_data
  omap_hsmmc: remove un-initialized callbacks from platform data
  omap_hsmmc: remove un-ready power_saving field in omap2_hsmmc_info
  omap_hsmmc: remove unused get_context_loss_count callback
  omap_hsmmc: remove unnecessary omap_hsmmc_slot_data indirection
  omap_hsmmc: pass mmc_priv struct to gpio init / free
  omap_hsmmc: Remove unnecessary callbacks from platform data
  omap_hsmmc: remove unused slot_id parameter

 arch/arm/mach-omap2/board-rx51-peripherals.c       |   4 +-
 arch/arm/mach-omap2/hsmmc.c                        | 155 +++++------
 arch/arm/mach-omap2/hsmmc.h                        |   9 +-
 arch/arm/mach-omap2/mmc.h                          |   6 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   6 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   6 +-
 drivers/mmc/host/omap_hsmmc.c                      | 282 ++++++++++-----------
 include/linux/platform_data/hsmmc-omap.h           |  88 +++++++
 8 files changed, 299 insertions(+), 257 deletions(-)
 create mode 100644 include/linux/platform_data/hsmmc-omap.h

-- 
2.1.0

