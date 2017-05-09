From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mmc: atmel-mci: Remove AVR32 bits from the driver
Date: Tue,  9 May 2017 20:03:02 +0300
Message-ID: <20170509170302.49117-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2843 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755855AbdEIRDl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 9 May 2017 13:03:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

AVR32 is gone. Now it's time to clean up the driver by removing
leftovers that was used by AVR32 related code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/atmel-mci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 388e4a3f13e6..55a3ff63bf47 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
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
@@ -2464,7 +2457,7 @@ static void atmci_get_cap(struct atmel_mci *host)
 			"version: 0x%x\n", version);
 
 	host->caps.has_dma_conf_reg = 0;
-	host->caps.has_pdc = ATMCI_PDC_CONNECTED;
+	host->caps.has_pdc = 1;
 	host->caps.has_cfg_reg = 0;
 	host->caps.has_cstor_reg = 0;
 	host->caps.has_highspeed = 0;
-- 
2.11.0

