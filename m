From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v2 0/5] Adding MMC Support on OMAP4430 SDP
Date: Tue, 4 May 2010 21:31:14 +0530 (IST)
Message-ID: <35156.10.24.255.17.1272988874.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com
List-Id: linux-mmc@vger.kernel.org

Adding board and regulator support for MMC1 and MMC2 controllers
on OMAP4.

V2:
- Rebased to Mainline version 2.6.34-rc6
- The Patch series has dependencies on I2c and Regulator support
  posted earlier
  [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26256.html
  [2] http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg02755.html
  [3] https://patchwork.kernel.org/patch/94054/
- Tested on both OMAP4430 SDP and OMAP3430 SDP
  [Also omap_hsmmc.c as Kernel Module]

V1:
  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26858.html

Kishore Kadiyala (5):
  OMAP4-HSMMC: Adding HSMMC support for OMAP4430 Board file
  OMAP4-HSMMC: Adding Card detect support
  OMAP4-HSMMC: Addind MMC-TWL regulator changes
  OMAP4-HSMMC: Adds Dummy Interface clock's for MMC controllers
  OMAP4-HSMMC: Enabling MMC support in OMAP4430SDP defconfig

 arch/arm/configs/omap_4430sdp_defconfig   |   19 ++++-
 arch/arm/mach-omap2/Makefile              |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c       |   40 ++++++++--
 arch/arm/mach-omap2/clock44xx_data.c      |    5 +
 arch/arm/mach-omap2/hsmmc.c               |  123 ++++++++++++++++++++++++++---
 arch/arm/mach-omap2/hsmmc.h               |    1 +
 arch/arm/plat-omap/include/plat/control.h |   17 ++++
 arch/arm/plat-omap/include/plat/mmc.h     |    2 +
 drivers/mfd/twl6030-irq.c                 |   27 ++++++
 drivers/mmc/host/omap_hsmmc.c             |   18 ++++-
 include/linux/i2c/twl.h                   |   42 ++++++++++
 11 files changed, 276 insertions(+), 21 deletions(-)



