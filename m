From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 0/3] OMAP hsmmc : card detect and Register offset handling
Date: Mon, 30 Aug 2010 23:18:38 +0530 (IST)
Message-ID: <23535.10.24.255.18.1283190518.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, akpm@linux-foundation.org, madhu.cr@ti.com, adrian.hunter@nokia.com
List-Id: linux-mmc@vger.kernel.org

Hi,

The patch series includes :
adding carddetect feature for MMC1 controller on OMAP4 and register offset handling
for OMAP3 & OMAP4 and followed by a fix when CONFIG_MMC_OMAP_HS not selected for OMAP4.

Patch series has been tested on OMAP3430SDP and OMAP4430SDP

Kishore Kadiyala (2):
  omap4 hsmmc : Adding card detect support for MMC1
  omap3/omap4 hsmmc: Register offset handling

Benoit Cousson (1);
  omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is not set

 arch/arm/mach-omap2/board-4430sdp.c   |   15 ++-
 arch/arm/mach-omap2/devices.c         |   30 +++--
 arch/arm/mach-omap2/hsmmc.c           |    6 +
 arch/arm/plat-omap/include/plat/mmc.h |   78 ++++++++++-
 drivers/mfd/twl6030-irq.c             |   76 ++++++++++
 drivers/mmc/host/omap_hsmmc.c         |  255 +++++++++++++++------------------
 include/linux/i2c/twl.h               |   31 ++++
 7 files changed, 340 insertions(+), 151 deletions(-)


