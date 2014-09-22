From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 0/6] unshare and simplify omap_hsmmc platform struct
Date: Mon, 22 Sep 2014 13:55:05 +0200
Message-ID: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

mmci and omap_hsmmc share very little fields in the platform
struct. unsharing significantly simplifies the omap_hsmmc driver

Andreas Fenkart (6):
  omap_hsmmc: unshare platform data struct with mmci driver
  omap_hsmmc: remove unused callbacks from platform data struct
  omap_hsmmc: remove unused fields in platform_data
  omap_hsmmc: remove unused get_context_loss_count callback
  omap_hsmmc: remove un-initialized callbacks from platform data
  omap_hsmmc: remove un-initialized get_cover_state callback

 arch/arm/mach-omap2/hsmmc.c                        |  61 ++--------
 arch/arm/mach-omap2/hsmmc.h                        |  10 --
 arch/arm/mach-omap2/mmc.h                          |   6 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   6 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   6 +-
 drivers/mmc/host/omap_hsmmc.c                      | 133 +++------------------
 include/linux/platform_data/hsmmc-omap.h           | 103 ++++++++++++++++
 7 files changed, 142 insertions(+), 183 deletions(-)
 create mode 100644 include/linux/platform_data/hsmmc-omap.h

-- 
2.1.0

