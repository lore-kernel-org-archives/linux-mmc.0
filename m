From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v2 0/5] OMAP: HSMMC: hwmod adaptation
Date: Wed,  9 Feb 2011 02:23:46 +0530
Message-ID: <1297198431-23779-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, Kishore Kadiyala <kishore.kadiyala@ti.com>
List-Id: linux-mmc@vger.kernel.org

Adding hwmod data for hsmmc device on OMAP2420/OMAP2430/OMAP3/OMAP4.
Adapting the omap_hsmmc driver to hwmod framework

V2:
---
Updated hwmod data for OMAP2420 & OMAP2430. 

The patch series is rebased on v2.6.38-rc4 and tested on OMAP4430SDP, 
OMAP3430SDP & OMAP2430SDP.

For OMAP2430SDP validation, the patch series has dependency on
https://patchwork.kernel.org/patch/538301/

Testing on N8x0 is pending due to unavailability of working ones.
Will be thankful if some body test this series on N8x0.

V1:
---
http://www.spinics.net/lists/linux-mmc/msg05689.html


Kishore Kadiyala (2):
  OMAP2420: hwmod data: Add HSMMC
  OMAP: devices: Modify HSMMC device to adapt to hwmod framework

Paul Walmsley (2):
  OMAP2430: hwmod data: Add HSMMC
  OMAP3: hwmod data: Add HSMMC
  
Benoit Cousson (1):  
  OMAP4: hwmod data: Add HSMMC

 arch/arm/mach-omap1/devices.c              |   41 ++++
 arch/arm/mach-omap2/board-n8x0.c           |    6 +-
 arch/arm/mach-omap2/devices.c              |  207 ++++-------------
 arch/arm/mach-omap2/hsmmc.c                |    6 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   80 +++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  155 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  221 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  339 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h          |    2 +
 arch/arm/mach-omap2/prm-regbits-34xx.h     |    4 +
 arch/arm/plat-omap/devices.c               |   50 ----
 arch/arm/plat-omap/include/plat/mmc.h      |   43 ++---
 drivers/mmc/host/omap_hsmmc.c              |    4 +-
 13 files changed, 908 insertions(+), 250 deletions(-)

