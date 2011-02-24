From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v4 0/6] OMAP: HSMMC: hwmod adaptation
Date: Fri, 25 Feb 2011 00:56:48 +0530
Message-ID: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41850 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089Ab1BXTTW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 14:19:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>

Adding hwmod data for hsmmc device on OMAP2430/OMAP3/OMAP4.
Adapting the omap_hsmmc driver to hwmod framework.

The patch series is based on omap-for-linus and tested on 
OMAP2430, OMAP3430SDP & OMAP4430SDP.
Also boot tested on OMAP2420SDP.

V4:
---
Omap2420 platform consists of mmc block as in omap1 and not the
hsmmc block as present in omap2430, omap3, omap4 platforms. 
The series takes care of hwmod adaptation of hsmmc drivers and 
thus excluding the omap2420 platforms.

Also includes renaming of device & driver name.

The patch series has dependency on :
 1)https://patchwork.kernel.org/patch/585281/ 
 2)https://patchwork.kernel.org/patch/538301/

V3:
--
http://www.spinics.net/lists/linux-omap/msg46783.html

V2:
---
http://www.spinics.net/lists/linux-omap/msg45443.html

V1:
---
http://www.spinics.net/lists/linux-mmc/msg05689.html


Anand Gadiyar (1):
  OMAP4: hwmod data: enable HSMMC

Kishore Kadiyala (2):
  OMAP: hwmod data: Add dev_attr and use in the host driver
  OMAP: adapt hsmmc to hwmod framework
  OMAP: hsmmc: Rename the device and driver

Paul Walmsley (2):
  OMAP2430: hwmod data: Add HSMMC
  OMAP3: hwmod data: Add HSMMC

 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c          |    6 +-
 arch/arm/mach-omap2/board-4430sdp.c          |    4 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    6 +-
 arch/arm/mach-omap2/board-igep0030.c         |    6 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    4 +-
 arch/arm/mach-omap2/board-rm680.c            |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    8 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c         |   12 +-
 arch/arm/mach-omap2/clock3xxx_data.c         |   12 +-
 arch/arm/mach-omap2/clock44xx_data.c         |   20 +-
 arch/arm/mach-omap2/devices.c                |  251 ----------------
 arch/arm/mach-omap2/hsmmc.c                  |  417 +++++++++++++++++---------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  152 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  215 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   16 +-
 arch/arm/mach-omap2/prcm-common.h            |    4 +
 arch/arm/plat-omap/include/plat/mmc.h        |   29 +--
 drivers/mmc/host/omap_hsmmc.c                |    6 +-
 23 files changed, 713 insertions(+), 471 deletions(-)

