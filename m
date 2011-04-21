From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [RESEND PATCH 3/4] mmc_spi.c: factor out a mmc_spi_setpower() function
Date: Thu, 21 Apr 2011 14:27:52 +0200
Message-ID: <1303388873-15467-4-git-send-email-ospite@studenti.unina.it>
References: <1300733202-27316-1-git-send-email-ospite@studenti.unina.it>
 <1303388873-15467-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:41452 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab1DUM2C (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2011 08:28:02 -0400
In-Reply-To: <1303388873-15467-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, openezx-devel@lists.openezx.org, spi-devel-general@lists.sourceforge.net

Factor out a mmc_spi_setpower() function so to make changing it more
elegant without adding too much stuff to mmc_spi_set_ios().

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 drivers/mmc/host/mmc_spi.c |   43 +++++++++++++++++++++++++++++++------------
 1 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 9eae23c..0f3672d 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1221,6 +1221,26 @@ static void mmc_spi_shutdownsequence(struct mmc_spi_host *host)
 	}
 }
 
+static inline int mmc_spi_setpower(struct mmc_spi_host *host,
+					unsigned char power_mode,
+					unsigned int vdd)
+{
+	/* switch power on/off if possible, accounting for
+	 * max 250msec powerup time if needed.
+	 */
+	if (mmc_spi_canpower(host)) {
+		switch (power_mode) {
+		case MMC_POWER_OFF:
+		case MMC_POWER_UP:
+			host->pdata->setpower(&host->spi->dev, vdd);
+			if (power_mode == MMC_POWER_UP)
+				msleep(host->powerup_msecs);
+		}
+	}
+
+	return 0;
+}
+
 static char *mmc_powerstring(u8 power_mode)
 {
 	switch (power_mode) {
@@ -1236,24 +1256,23 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct mmc_spi_host *host = mmc_priv(mmc);
 
 	if (host->power_mode != ios->power_mode) {
+		int ret;
 
 		dev_dbg(&host->spi->dev, "mmc_spi: power %s (%d)%s\n",
 				mmc_powerstring(ios->power_mode),
 				ios->vdd,
 				mmc_spi_canpower(host) ? ", can switch" : "");
 
-		/* switch power on/off if possible, accounting for
-		 * max 250msec powerup time if needed.
-		 */
-		if (mmc_spi_canpower(host)) {
-			switch (ios->power_mode) {
-			case MMC_POWER_OFF:
-			case MMC_POWER_UP:
-				host->pdata->setpower(&host->spi->dev,
-						ios->vdd);
-				if (ios->power_mode == MMC_POWER_UP)
-					msleep(host->powerup_msecs);
-			}
+		ret = mmc_spi_setpower(host, ios->power_mode, ios->vdd);
+		if (ret) {
+			dev_err(mmc_dev(mmc), "unable to set power\n");
+			/*
+			 * The .set_ios() function in the mmc_host_ops
+			 * struct return void, and failing to set the
+			 * power should be rare so we print an error and
+			 * return here.
+			 */
+			return;
 		}
 
 		/* See 6.4.1 in the simplified SD card physical spec 2.0 */
-- 
1.7.4.4

