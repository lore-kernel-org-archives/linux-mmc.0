From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH 0/5] OMAP: HSMMC: hwmod adaptation
Date: Wed,  2 Feb 2011 20:57:37 +0530
Message-ID: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40255 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab1BBPVp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Feb 2011 10:21:45 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com, Kishore Kadiyala <kishore.kadiyala@ti.com>

Adding hwmod data for hsmmc device on OMAP2420/OMAP2430/OMAP3/OMAP4.
Adapting the omap_hsmmc driver to hwmod framework.

The patch series is based on v2.6.38-rc3 and tested on OMAP4430SDP & 
OMAP3430SDP.

Testing pending on OMAP2420SDP & OMAP2430SDP since mmc/sd cards are not getting
detected. Currently omap2_hsmmc_init call is missing in the board files, but 
updating it is not helping though.
Investigation is under progress and any pointers on working version of MMC/SD on
OMAP2420/2430 SDP would be helpful.


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
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   88 +++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  155 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  221 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  339 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h          |    2 +
 arch/arm/mach-omap2/prm-regbits-34xx.h     |    4 +
 arch/arm/plat-omap/devices.c               |   50 ----
 arch/arm/plat-omap/include/plat/mmc.h      |   43 ++---
 drivers/mmc/host/omap_hsmmc.c              |    4 +-
 13 files changed, 916 insertions(+), 250 deletions(-)

