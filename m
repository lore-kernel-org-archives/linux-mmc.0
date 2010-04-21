From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 0/7] Adding MMC Support on OMAP4430 SDP
Date: Wed, 21 Apr 2010 23:48:48 +0530 (IST)
Message-ID: <63265.10.24.255.18.1271873928.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33671 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899Ab0DUSTG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Apr 2010 14:19:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: madhu.cr@ti.com, jarkko.lavinen@nokia.com, tony@atomide.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

This patch series basically adds board and regulator support for
MMC1 and MMC2 controllers on OMAP4.

This is based on latest mainline version 2.6.34-rc4 and boot tested on
OMAP4430 SDP.

This patch series has dependencies on OMAP4 i2c support and regulator
which was posted earlier
[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26256.html
[2] http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg02755.html
[3] https://patchwork.kernel.org/patch/79967/


Kishore Kadiyala (5):
  OMAP4-HSMMC: FIX for MMC5 Controller IRQ Base
  OMAP4-HSMMC: Adding HSMMC support for OMAP4430 Board file
  OMAP4-HSMMC: Adding Card detect support
  OMAP4-HSMMC: Addind MMC-TWL regulator changes
  OMAP4-HSMMC: Adds Dummy Interface clock's for MMC controllers

Santosh Shilimkar (1):
  OMAP4: Fix for CONTROL register Base

Kishore Kadiyala (1):
  OMAP4-HSMMC: Adding OMAP4 Support

 arch/arm/configs/omap_4430sdp_defconfig    |   19 +++-
 arch/arm/mach-omap2/Makefile               |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c        |   40 ++++-
 arch/arm/mach-omap2/clock44xx_data.c       |    5 +
 arch/arm/mach-omap2/devices.c              |    2 +-
 arch/arm/mach-omap2/hsmmc.c                |  217 ++++++++++++++++++++++++----
 arch/arm/mach-omap2/hsmmc.h                |    1 +
 arch/arm/plat-omap/include/plat/control.h  |   17 +++
 arch/arm/plat-omap/include/plat/mmc.h      |    3 +-
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 +-
 drivers/mmc/host/omap_hsmmc.c              |   29 +----
 11 files changed, 272 insertions(+), 66 deletions(-)


