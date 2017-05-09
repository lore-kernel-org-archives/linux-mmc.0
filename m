From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] mmc: atmel-mci: Remove AVR32 bits from the driver
Date: Tue,  9 May 2017 20:21:17 +0300
Message-ID: <20170509172117.50588-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46050 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754120AbdEIRVW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 9 May 2017 13:21:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

AVR32 is gone. Now it's time to clean up the driver by removing
leftovers that was used by AVR32 related code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
In v2:
- remove more leftovers of avr32
 drivers/mmc/host/Kconfig     |  8 ++++----
 drivers/mmc/host/atmel-mci.c | 24 ++----------------------
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2db84dd664d7..e7d3b097cd30 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -408,11 +408,11 @@ config MMC_AU1X
 
 config MMC_ATMELMCI
 	tristate "Atmel SD/MMC Driver (Multimedia Card Interface)"
-	depends on AVR32 || ARCH_AT91
+	depends on ARCH_AT91
 	help
-	  This selects the Atmel Multimedia Card Interface driver. If
-	  you have an AT32 (AVR32) or AT91 platform with a Multimedia
-	  Card slot, say Y or M here.
+	  This selects the Atmel Multimedia Card Interface driver.
+	  If you have an AT91 platform with a Multimedia Card slot,
+	  say Y or M here.
 
 	  If unsure, say N.
 
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 388e4a3f13e6..2e96d964f582 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -44,7 +44,7 @@
 #include <asm/unaligned.h>
 
 /*
- * Superset of MCI IP registers integrated in Atmel AVR32 and AT91 Processors
+ * Superset of MCI IP registers integrated in Atmel AT91 Processor
  * Registers and bitfields marked with [2] are only available in MCI2
  */
 
@@ -172,13 +172,6 @@
 #define	atmci_writel(port, reg, value)			\
 	__raw_writel((value), (port)->regs + reg)
 
-/* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
-#ifdef CONFIG_AVR32
-#	define ATMCI_PDC_CONNECTED	0
-#else
-#	define ATMCI_PDC_CONNECTED	1
-#endif
-
 #define AUTOSUSPEND_DELAY	50
 
 #define ATMCI_DATA_ERROR_FLAGS	(ATMCI_DCRCE | ATMCI_DTOE | ATMCI_OVRE | ATMCI_UNRE)
@@ -1549,21 +1542,8 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 		break;
 	default:
-		/*
-		 * TODO: None of the currently available AVR32-based
-		 * boards allow MMC power to be turned off. Implement
-		 * power control when this can be tested properly.
-		 *
-		 * We also need to hook this into the clock management
-		 * somehow so that newly inserted cards aren't
-		 * subjected to a fast clock before we have a chance
-		 * to figure out what the maximum rate is. Currently,
-		 * there's no way to avoid this, and there never will
-		 * be for boards that don't support power control.
-		 */
 		break;
 	}
-
 }
 
 static int atmci_get_ro(struct mmc_host *mmc)
@@ -2464,7 +2444,7 @@ static void atmci_get_cap(struct atmel_mci *host)
 			"version: 0x%x\n", version);
 
 	host->caps.has_dma_conf_reg = 0;
-	host->caps.has_pdc = ATMCI_PDC_CONNECTED;
+	host->caps.has_pdc = 1;
 	host->caps.has_cfg_reg = 0;
 	host->caps.has_cstor_reg = 0;
 	host->caps.has_highspeed = 0;
-- 
2.11.0

