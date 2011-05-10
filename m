From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Subject: [PATCHv2.1] mmc: omap_hsmmc: split duplicate code to calc_divisor() function
Date: Tue, 10 May 2011 15:51:54 +0300
Message-ID: <5a2a0ae8f9ee7cfe8df507d7288d99c0e9ac7156.1305030690.git.ext-andriy.shevchenko@nokia.com>
References: <1304673255-31634-6-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:51344 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426Ab1EJMr0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 08:47:26 -0400
In-Reply-To: <1304673255-31634-6-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>

There are two places where the same calculations are done. Let's split them to
separate function.

In addition the new function is simplified by usage DIV_ROUND_UP kernel macro.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   46 +++++++++++++++++------------------------
 1 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b9200ef..8787ba8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -17,6 +17,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
@@ -584,6 +585,20 @@ static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 }
 
+/* Calculate divisor for the given clock frequency */
+static u16 calc_divisor(struct mmc_ios *ios)
+{
+	u16 dsor = 0;
+
+	if (ios->clock) {
+		dsor = DIV_ROUND_UP(OMAP_MMC_MASTER_CLOCK, ios->clock);
+		if (dsor > 250)
+			dsor = 250;
+	}
+
+	return dsor;
+}
+
 #ifdef CONFIG_PM
 
 /*
@@ -596,7 +611,6 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	struct omap_mmc_platform_data *pdata = host->pdata;
 	int context_loss = 0;
 	u32 hctl, capa, con;
-	u16 dsor = 0;
 	unsigned long timeout;
 
 	if (pdata->get_context_loss_count) {
@@ -675,21 +689,10 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		break;
 	}
 
-	if (ios->clock) {
-		dsor = OMAP_MMC_MASTER_CLOCK / ios->clock;
-		if (dsor < 1)
-			dsor = 1;
-
-		if (OMAP_MMC_MASTER_CLOCK / dsor > ios->clock)
-			dsor++;
-
-		if (dsor > 250)
-			dsor = 250;
-	}
-
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 		OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
-	OMAP_HSMMC_WRITE(host->base, SYSCTL, (dsor << 6) | (DTO << 16));
+	OMAP_HSMMC_WRITE(host->base, SYSCTL,
+		(calc_divisor(ios) << 6) | (DTO << 16));
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
 
@@ -1527,7 +1530,6 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	u16 dsor = 0;
 	unsigned long regval;
 	unsigned long timeout;
 	u32 con;
@@ -1591,21 +1593,11 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
-	if (ios->clock) {
-		dsor = OMAP_MMC_MASTER_CLOCK / ios->clock;
-		if (dsor < 1)
-			dsor = 1;
-
-		if (OMAP_MMC_MASTER_CLOCK / dsor > ios->clock)
-			dsor++;
-
-		if (dsor > 250)
-			dsor = 250;
-	}
 	omap_hsmmc_stop_clock(host);
+
 	regval = OMAP_HSMMC_READ(host->base, SYSCTL);
 	regval = regval & ~(CLKD_MASK);
-	regval = regval | (dsor << 6) | (DTO << 16);
+	regval = regval | (calc_divisor(ios) << 6) | (DTO << 16);
 	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
-- 
1.6.3.3

