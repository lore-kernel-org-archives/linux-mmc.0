From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v6 0/8]  OMAP: HSMMC: hwmod adaptation
Date: Mon, 28 Feb 2011 20:47:57 +0530
Message-ID: <1298906285-29895-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43700 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731Ab1B1PKu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Feb 2011 10:10:50 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>

Adding hwmod data for hsmmc device on OMAP2430/OMAP3/OMAP4.
Adapting the omap_hsmmc driver to hwmod framework.

Omap2420 platform consists of mmc block as in omap1 and not the hsmmc block
as present in omap2430, omap3, omap4 platforms. The series takes care of
spliting out the mmc device init for omap2420 and thus doing hwmod adaptation
for hsmmc drivers. 

Also includes moving of mux setting API for hsmmc devices from devices.c to 
hsmmc.c and renaming of device & driver name.

The patch series is based on omap-for-linus and tested on OMAP2430, OMAP3430SDP,
OMAP4430SDP & OMAP4Panda.Also boot tested on OMAP2420SDP.

For testing hsmmc with hwmod adaptaion on OMAP2430SDP,has dependency on:
http://www.spinics.net/lists/linux-omap/msg47088.html

V6:
---
In the previous versions, implementation for adaptation of hsmmc to 
hwmod framework was based on omap_hwmod_for_each_by_class and using
this will not support flexible resgistration of hsmmc devices.
The current implemetation uses omap_hwmod_lookup and supports flexible
registration of hsmmc devices based on the entry in board file.

V5:
---
http://www.spinics.net/lists/linux-omap/msg47046.html

V4:
---
http://www.spinics.net/lists/linux-mmc/msg06237.html

V3:
--
http://www.spinics.net/lists/linux-omap/msg46783.html

V2:
---
http://www.spinics.net/lists/linux-omap/msg45443.html

V1:
---
http://www.spinics.net/lists/linux-mmc/msg05689.html


Anand Gadiyar (2):
  omap: mmc: split out init for 2420
  OMAP4: hwmod data: enable HSMMC

Kishore Kadiyala (4):
  OMAP: hwmod data: Add dev_attr and use in the host driver
  OMAP: hsmmc: Move mux configuration to hsmmc.c
  OMAP: adapt hsmmc to hwmod framework
  OMAP: hsmmc: Rename the device and driver

Paul Walmsley (2):
  OMAP2430: hwmod data: Add HSMMC
  OMAP3: hwmod data: Add HSMMC

 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c          |    6 +-
 arch/arm/mach-omap2/board-4430sdp.c          |   14 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    6 +-
 arch/arm/mach-omap2/board-igep0030.c         |    6 +-
 arch/arm/mach-omap2/board-n8x0.c             |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    4 +-
 arch/arm/mach-omap2/board-rm680.c            |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    8 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c         |   12 +-
 arch/arm/mach-omap2/clock3xxx_data.c         |   12 +-
 arch/arm/mach-omap2/clock44xx_data.c         |   20 +-
 arch/arm/mach-omap2/devices.c                |  293 ++----------------
 arch/arm/mach-omap2/hsmmc.c                  |  424 +++++++++++++++++---------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  154 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  215 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   18 +-
 arch/arm/mach-omap2/prcm-common.h            |    4 +
 arch/arm/plat-omap/include/plat/mmc.h        |   29 +-
 drivers/mmc/host/omap_hsmmc.c                |    6 +-
 24 files changed, 765 insertions(+), 484 deletions(-)

