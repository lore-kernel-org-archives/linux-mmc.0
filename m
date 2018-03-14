From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 29/47] mmc: remove bfin_sdh driver
Date: Wed, 14 Mar 2018 16:35:42 +0100
Message-ID: <20180314153603.3127932-30-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The blackfin architecture is getting removed, so this one
is obsolete now as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/Kconfig    |  19 --
 drivers/mmc/host/Makefile   |   1 -
 drivers/mmc/host/bfin_sdh.c | 679 --------------------------------------------
 3 files changed, 699 deletions(-)
 delete mode 100644 drivers/mmc/host/bfin_sdh.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 620c2d90a646..b4fd5d48dd35 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -646,25 +646,6 @@ config MMC_VIA_SDMMC
 
 	  If unsure, say N.
 
-config SDH_BFIN
-	tristate "Blackfin Secure Digital Host support"
-	depends on (BF54x && !BF544) || (BF51x && !BF512)
-	help
-	  If you say yes here you will get support for the Blackfin on-chip
-	  Secure Digital Host interface.  This includes support for MMC and
-	  SD cards.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_sdh.
-
-	  If unsure, say N.
-
-config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
-	bool "Blackfin EZkit Missing SDH_CMD Pull Up Resistor Workaround"
-	depends on SDH_BFIN
-	help
-	  If you say yes here SD-Cards may work on the EZkit.
-
 config MMC_CAVIUM_OCTEON
 	tristate "Cavium OCTEON SD/MMC Card Interface support"
 	depends on CAVIUM_OCTEON_SOC
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 84cd1388abc3..f563cc0b7f93 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -43,7 +43,6 @@ obj-$(CONFIG_MMC_SDHI_SYS_DMAC)		+= renesas_sdhi_sys_dmac.o
 obj-$(CONFIG_MMC_SDHI_INTERNAL_DMAC)	+= renesas_sdhi_internal_dmac.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
-obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
 octeon-mmc-objs := cavium.o cavium-octeon.o
 obj-$(CONFIG_MMC_CAVIUM_OCTEON) += octeon-mmc.o
 thunderx-mmc-objs := cavium.o cavium-thunderx.o
diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
deleted file mode 100644
index 526231e38583..000000000000
-- 
2.9.0
