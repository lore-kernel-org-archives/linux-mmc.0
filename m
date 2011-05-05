From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 13/22] mmc: omap_hsmmc: fix few bugs when set the clock divisor
Date: Thu,  5 May 2011 14:51:13 +0300
Message-ID: <1304596282-4095-14-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

There are two pieces of code which similar, but not the same. Each of them
contains a bug.

The SYSCTL register should be read before write in the
omap_hsmmc_context_restore() to remain the state of the reserved bits.

Before set the clock divisor and DTO bits the value from the SYSCTL register
should be masked properly. We were lucky to have no problems with DTO bits. So,
make sure we have clear DTO bits properly in the omap_hsmmc_set_ios().

Additionally get rid of msleep(1). The actual time rare higher than 30us on
OMAP 3630.

The result pieces of code are split to omap_hsmmc_set_clock() function.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   59 +++++++++++++++++++---------------------
 1 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ae6d204..3c76911 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -619,6 +619,32 @@ static u16 calc_divisor(struct mmc_ios *ios)
 	return dsor;
 }
 
+static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
+{
+	struct mmc_ios *ios = &host->mmc->ios;
+	unsigned long regval;
+	unsigned long timeout;
+
+	dev_dbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
+
+	omap_hsmmc_stop_clock(host);
+
+	regval = OMAP_HSMMC_READ(host->base, SYSCTL);
+	regval = regval & ~(CLKD_MASK | DTO_MASK);
+	regval = regval | (calc_divisor(ios) << 6) | (DTO << 16);
+	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
+	OMAP_HSMMC_WRITE(host->base, SYSCTL,
+		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
+
+	/* Wait till the ICS bit is set */
+	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
+	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & ICS) != ICS
+		&& time_before(jiffies, timeout))
+		;
+
+	omap_hsmmc_start_clock(host);
+}
+
 #ifdef CONFIG_PM
 
 /*
@@ -709,19 +735,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		break;
 	}
 
-	omap_hsmmc_stop_clock(host);
-
-	OMAP_HSMMC_WRITE(host->base, SYSCTL,
-		(calc_divisor(ios) << 6) | (DTO << 16));
-	OMAP_HSMMC_WRITE(host->base, SYSCTL,
-		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
-
-	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
-	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & ICS) != ICS
-		&& time_before(jiffies, timeout))
-		;
-
-	omap_hsmmc_start_clock(host);
+	omap_hsmmc_set_clock(host);
 
 	con = OMAP_HSMMC_READ(host->base, CON);
 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
@@ -1622,8 +1636,6 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	unsigned long regval;
-	unsigned long timeout;
 	u32 con;
 	int do_send_init_stream = 0;
 
@@ -1685,22 +1697,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
-	omap_hsmmc_stop_clock(host);
-
-	regval = OMAP_HSMMC_READ(host->base, SYSCTL);
-	regval = regval & ~(CLKD_MASK);
-	regval = regval | (calc_divisor(ios) << 6) | (DTO << 16);
-	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
-	OMAP_HSMMC_WRITE(host->base, SYSCTL,
-		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
-
-	/* Wait till the ICS bit is set */
-	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
-	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & ICS) != ICS
-		&& time_before(jiffies, timeout))
-		msleep(1);
-
-	omap_hsmmc_start_clock(host);
+	omap_hsmmc_set_clock(host);
 
 	if (do_send_init_stream)
 		send_init_stream(host);
-- 
1.7.0.4

