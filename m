From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v3 0/5] OMAP: HSMMC: hwmod adaptation
Date: Wed, 23 Feb 2011 23:17:06 +0530
Message-ID: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40052 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab1BWRjp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 Feb 2011 12:39:45 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, Kishore Kadiyala <kishore.kadiyala@ti.com>

Adding hwmod data for hsmmc device on OMAP2430/OMAP3/OMAP4.
Adapting the omap_hsmmc driver to hwmod framework.

The patch series is based on -rc6 and tested on OMAP2430, OMAP3430SDP
& OMAP4430SDP.

V3:
---
Omap2420 platform consists of mmc block as in omap1 and not the
hsmmc block as present in omap2430, omap3, omap4 platforms. 
The series takes care of hwmod adaptation of hsmmc drivers and 
thus excluding the omap2420 platforms.

The patch series has dependency on :
 1)https://patchwork.kernel.org/patch/585281/ 
 2)https://patchwork.kernel.org/patch/538301/

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

Paul Walmsley (2):
  OMAP2430: hwmod data: Add HSMMC
  OMAP3: hwmod data: Add HSMMC

 arch/arm/mach-omap2/devices.c              |  251 ----------------------------
 arch/arm/mach-omap2/hsmmc.c                |  153 ++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  155 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  221 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   26 +++-
 arch/arm/mach-omap2/prcm-common.h          |    4 +
 arch/arm/plat-omap/include/plat/mmc.h      |   24 +--
 drivers/mmc/host/omap_hsmmc.c              |    4 +-
 8 files changed, 554 insertions(+), 284 deletions(-)

