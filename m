From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 06/16] mmc: omap_hsmmc: introduce start_clock and re-use stop_clock
Date: Fri,  6 May 2011 12:14:05 +0300
Message-ID: <1304673255-31634-7-git-send-email-adrian.hunter@nokia.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

There is similar piece of code in two functions which enables clock. Split this
code to omap_hsmmc_start_clock(). Re-use omap_hsmmc_stop_clock() in
omap_hsmmc_context_restore() as well.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index af2dbd3..915d08b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -548,6 +548,15 @@ static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 }
 
 /*
+ * Start clock to the card
+ */
+static void omap_hsmmc_start_clock(struct omap_hsmmc_host *host)
+{
+	OMAP_HSMMC_WRITE(host->base, SYSCTL,
+		OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
+}
+
+/*
  * Stop clock to the card
  */
 static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
@@ -688,8 +697,8 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		break;
 	}
 
-	OMAP_HSMMC_WRITE(host->base, SYSCTL,
-		OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
+	omap_hsmmc_stop_clock(host);
+
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 		(calc_divisor(ios) << 6) | (DTO << 16));
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
@@ -700,8 +709,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		&& time_before(jiffies, timeout))
 		;
 
-	OMAP_HSMMC_WRITE(host->base, SYSCTL,
-		OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
+	omap_hsmmc_start_clock(host);
 
 	con = OMAP_HSMMC_READ(host->base, CON);
 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
@@ -1610,8 +1618,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		&& time_before(jiffies, timeout))
 		msleep(1);
 
-	OMAP_HSMMC_WRITE(host->base, SYSCTL,
-		OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
+	omap_hsmmc_start_clock(host);
 
 	if (do_send_init_stream)
 		send_init_stream(host);
-- 
1.7.0.4

