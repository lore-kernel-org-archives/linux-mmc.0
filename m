From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v3 0/5] Adding MMC Support on OMAP4430 SDP
Date: Fri, 14 May 2010 01:41:25 +0530 (IST)
Message-ID: <12472.10.24.255.17.1273781485.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41599 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab0EMULn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 May 2010 16:11:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com

Adding MMC1 and MMC2 controllers support for OMAP4

V3:
- Rebased to Mainline version 2.6.34-rc7
- The Patch series has dependencies on I2c, regultor patches.
  Listing the patches below:
  [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26256.html
  [2] http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg02755.html
  [3] https://patchwork.kernel.org/patch/94054/
  [4] https://patchwork.kernel.org/patch/93918/
  [5] https://patchwork.kernel.org/patch/96821/
- Tested on both OMAP4430 SDP and OMAP3430 SDP
  [Also with omap_hsmmc.c as Kernel Module].
- Compile tested for rest of omap3 boards using omap3_defconfig.
  Could any one test on other boards

V2:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27612.html

V1:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26858.html

Kishore Kadiyala (5):
  OMAP HSMMC: Adding a flag to determine the card detect type
  OMAP4 HSMMC: Adding hsmmc support to board file
  OMAP4 HSMMC: Adding card detect support for MMC1 Controller
  OMAP4 HSMMC: Adding PBIAS Configuration for MMC1 Controller
  OMAP4 HSMMC: Enable HSMMC support

 arch/arm/configs/omap_4430sdp_defconfig      |   19 +++++-
 arch/arm/mach-omap2/Makefile                 |    3 +-
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +
 arch/arm/mach-omap2/board-3430sdp.c          |    3 +
 arch/arm/mach-omap2/board-4430sdp.c          |   64 +++++++++++++++--
 arch/arm/mach-omap2/board-cm-t35.c           |    3 +
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +
 arch/arm/mach-omap2/board-igep0020.c         |    3 +
 arch/arm/mach-omap2/board-ldp.c              |    2 +
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c     |    4 +
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +
 arch/arm/mach-omap2/board-overo.c            |    3 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 +
 arch/arm/mach-omap2/board-zoom-peripherals.c |    3 +
 arch/arm/mach-omap2/hsmmc.c                  |  101 +++++++++++++++++++++++---
 arch/arm/mach-omap2/hsmmc.h                  |    1 +
 arch/arm/plat-omap/include/plat/control.h    |   20 +++++
 arch/arm/plat-omap/include/plat/mmc.h        |    5 ++
 drivers/mfd/twl6030-irq.c                    |   23 ++++++
 drivers/mmc/host/omap_hsmmc.c                |   31 +++++++--
 include/linux/i2c/twl.h                      |   47 ++++++++++++
 23 files changed, 323 insertions(+), 25 deletions(-)


