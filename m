From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v4 0/5] Adding MMC Support on OMAP4430 SDP
Date: Sat, 15 May 2010 23:50:06 +0530 (IST)
Message-ID: <22422.10.24.255.17.1273947606.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53279 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882Ab0EOSU0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 15 May 2010 14:20:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, santosh.shilimkar@ti.com

Adding MMC1 and MMC2 controllers support for OMAP4

V4:
- Rebased to "for_next" branch[LO].
- The first 3 patches [1,2,3] in the series are Minimal set of changes
  with which MMC1/MMC2 works [No card detect for MMC1]on OMAP4 but with
  dependencies on following patches [Not in "for_next" branch]
  [1] I2c patches
      a)https://patchwork.kernel.org/patch/98937/
      b)https://patchwork.kernel.org/patch/98936/
      c)https://patchwork.kernel.org/patch/98939/
      d)https://patchwork.kernel.org/patch/79735/
  [2] Regulator pacth
      a)https://patchwork.kernel.org/patch/94054/
  [3] hsmmc-clk patch
      a)https://patchwork.kernel.org/patch/96821/
- The patches 4,5 adds card detect feature for MMC1
- Tested on both OMAP4430 SDP and OMAP3430 SDP
  [Also with omap_hsmmc.c as Kernel Module].
- Compile tested for rest of omap3 boards using omap3_defconfig.
  Could any one test on other boards

V3:
http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg01908.html

V2:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27612.html

V1:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26858.html


Kishore Kadiyala (5):
  OMAP4 HSMMC :Adding hsmmc support to board file
  OMAP4 HSMMC :Adding PBIAS Configuration for MMC1 Controller
  OMAP4 HSMMC :Enable HSMMC support
  OMAP HSMMC :Adding a flag to determine the card detect type
  OMAP4 HSMMC :Adding card detect support for MMC1 Controller

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
 arch/arm/mach-omap2/hsmmc.c                  |   98 +++++++++++++++++++++++---
 arch/arm/mach-omap2/hsmmc.h                  |    1 +
 arch/arm/plat-omap/include/plat/control.h    |   20 +++++
 arch/arm/plat-omap/include/plat/mmc.h        |    5 ++
 drivers/mfd/twl6030-irq.c                    |   23 ++++++
 drivers/mmc/host/omap_hsmmc.c                |   31 +++++++--
 include/linux/i2c/twl.h                      |   47 ++++++++++++
 23 files changed, 322 insertions(+), 23 deletions(-)


