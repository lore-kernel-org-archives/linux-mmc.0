From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 11/22] mmc: omap_hsmmc: split duplicate code to calc_divisor() function
Date: Thu,  5 May 2011 14:51:11 +0300
Message-ID: <1304596282-4095-12-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

There are two places where the same calculations are done. Let's split them to
separate function.

In addition the new function is simplified by usage DIV_ROUND_UP kernel macro.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   45 ++++++++++++++++------------------------
 1 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7a153af..045c581 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -596,6 +596,20 @@ static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
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
@@ -608,7 +622,6 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	struct omap_mmc_platform_data *pdata = host->pdata;
 	int context_loss = 0;
 	u32 hctl, capa, con;
-	u16 dsor = 0;
 	unsigned long timeout;
 
 	if (pdata->get_context_loss_count) {
@@ -687,21 +700,10 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
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
 
@@ -1612,7 +1614,6 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	u16 dsor = 0;
 	unsigned long regval;
 	unsigned long timeout;
 	u32 con;
@@ -1676,21 +1677,11 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
1.7.0.4

