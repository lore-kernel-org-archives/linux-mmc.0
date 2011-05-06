From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 08/16] mmc: omap_hsmmc: split same pieces of code to separate functions
Date: Fri,  6 May 2011 12:14:07 +0300
Message-ID: <1304673255-31634-9-git-send-email-adrian.hunter@nokia.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:45954 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755982Ab1EFJQC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 May 2011 05:16:02 -0400
In-Reply-To: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

There are few places with the same functionality. This patch creates two
functions omap_hsmmc_set_bus_width() and omap_hsmmc_set_bus_mode() to do the
job.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   85 ++++++++++++++++++++---------------------
 1 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index dd0d9d5..4f6e552 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -633,6 +633,41 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 	omap_hsmmc_start_clock(host);
 }
 
+static void omap_hsmmc_set_bus_width(struct omap_hsmmc_host *host)
+{
+	struct mmc_ios *ios = &host->mmc->ios;
+	u32 con;
+
+	con = OMAP_HSMMC_READ(host->base, CON);
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_8:
+		OMAP_HSMMC_WRITE(host->base, CON, con | DW8);
+		break;
+	case MMC_BUS_WIDTH_4:
+		OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
+		OMAP_HSMMC_WRITE(host->base, HCTL,
+			OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
+		break;
+	case MMC_BUS_WIDTH_1:
+		OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
+		OMAP_HSMMC_WRITE(host->base, HCTL,
+			OMAP_HSMMC_READ(host->base, HCTL) & ~FOUR_BIT);
+		break;
+	}
+}
+
+static void omap_hsmmc_set_bus_mode(struct omap_hsmmc_host *host)
+{
+	struct mmc_ios *ios = &host->mmc->ios;
+	u32 con;
+
+	con = OMAP_HSMMC_READ(host->base, CON);
+	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
+		OMAP_HSMMC_WRITE(host->base, CON, con | OD);
+	else
+		OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
+}
+
 #ifdef CONFIG_PM
 
 /*
@@ -644,7 +679,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	struct mmc_ios *ios = &host->mmc->ios;
 	struct omap_mmc_platform_data *pdata = host->pdata;
 	int context_loss = 0;
-	u32 hctl, capa, con;
+	u32 hctl, capa;
 	unsigned long timeout;
 
 	if (pdata->get_context_loss_count) {
@@ -706,30 +741,12 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	if (host->power_mode == MMC_POWER_OFF)
 		goto out;
 
-	con = OMAP_HSMMC_READ(host->base, CON);
-	switch (ios->bus_width) {
-	case MMC_BUS_WIDTH_8:
-		OMAP_HSMMC_WRITE(host->base, CON, con | DW8);
-		break;
-	case MMC_BUS_WIDTH_4:
-		OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
-		OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
-		break;
-	case MMC_BUS_WIDTH_1:
-		OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
-		OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) & ~FOUR_BIT);
-		break;
-	}
+	omap_hsmmc_set_bus_width(host);
 
 	omap_hsmmc_set_clock(host);
 
-	con = OMAP_HSMMC_READ(host->base, CON);
-	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
-		OMAP_HSMMC_WRITE(host->base, CON, con | OD);
-	else
-		OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
+	omap_hsmmc_set_bus_mode(host);
+
 out:
 	host->context_loss = context_loss;
 
@@ -1554,7 +1571,6 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	u32 con;
 	int do_send_init_stream = 0;
 
 	mmc_host_enable(host->mmc);
@@ -1580,22 +1596,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	/* FIXME: set registers based only on changes to ios */
 
-	con = OMAP_HSMMC_READ(host->base, CON);
-	switch (mmc->ios.bus_width) {
-	case MMC_BUS_WIDTH_8:
-		OMAP_HSMMC_WRITE(host->base, CON, con | DW8);
-		break;
-	case MMC_BUS_WIDTH_4:
-		OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
-		OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
-		break;
-	case MMC_BUS_WIDTH_1:
-		OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
-		OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) & ~FOUR_BIT);
-		break;
-	}
+	omap_hsmmc_set_bus_width(host);
 
 	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		/* Only MMC1 can interface at 3V without some flavor
@@ -1620,11 +1621,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (do_send_init_stream)
 		send_init_stream(host);
 
-	con = OMAP_HSMMC_READ(host->base, CON);
-	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
-		OMAP_HSMMC_WRITE(host->base, CON, con | OD);
-	else
-		OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
+	omap_hsmmc_set_bus_mode(host);
 
 	if (host->power_mode == MMC_POWER_OFF)
 		mmc_host_disable(host->mmc);
-- 
1.7.0.4

