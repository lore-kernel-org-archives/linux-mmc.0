From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v5 0/2] Adding Card detect support for MMC1 on OMAP4
Date: Thu, 17 Jun 2010 20:56:47 +0530 (IST)
Message-ID: <43570.10.24.255.17.1276788407.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

Adding Card detect support for MMC1 controller on OMAP4.

V5:
   - Rebased to Mainline version 2.6.35-rc3
   - Tested on OMAP4430SDP and OMAP3430SDP
   - Could any one try testing on other boards
V4:
   http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg01958.html
   http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg01949.html

Kishore Kadiyala (2):
  OMAP HSMMC: Adding a Flag to determine the type of Card detect
  OMAP4 HSMMC: Adding card detect support for MMC1 Controller

 arch/arm/mach-omap2/board-3430sdp.c          |    3 ++
 arch/arm/mach-omap2/board-4430sdp.c          |   11 ++++--
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +
 arch/arm/mach-omap2/board-igep0020.c         |    2 +
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c     |    3 ++
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +
 arch/arm/mach-omap2/hsmmc.c                  |    1 +
 arch/arm/mach-omap2/hsmmc.h                  |    1 +
 arch/arm/plat-omap/include/plat/mmc.h        |    5 +++
 drivers/mfd/twl6030-irq.c                    |   23 +++++++++++++
 drivers/mmc/host/omap_hsmmc.c                |   30 ++++++++++++++---
 include/linux/i2c/twl.h                      |   46 ++++++++++++++++++++++++++
 16 files changed, 129 insertions(+), 8 deletions(-)

