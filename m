From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 1/4] mmc_spi.c: factor out the check for power capability
Date: Mon, 21 Mar 2011 19:46:39 +0100
Message-ID: <1300733202-27316-2-git-send-email-ospite@studenti.unina.it>
References: <1300733202-27316-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1300733202-27316-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Daniel Ribeiro <drwyrm@gmail.com>, David Brownell <dbrownell@users.sourceforge.net>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Ernst Schwab <eschwab@online.de>, Sonic Zhang <sonic.zhang@analog.com>, Linus Walleij <linus.walleij@stericsson.com>, openezx-devel@lists.openezx.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Factor out the 'canpower' condition into a dedicated function in order
to avoid repetition and to make changing the condition easier.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 drivers/mmc/host/mmc_spi.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index fd877f6..1db18ce 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -152,6 +152,10 @@ struct mmc_spi_host {
 	dma_addr_t		ones_dma;
 };
 
+static inline int mmc_spi_canpower(struct mmc_spi_host *host)
+{
+	return host->pdata && host->pdata->setpower;
+}
 
 /****************************************************************************/
 
@@ -1187,19 +1191,16 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct mmc_spi_host *host = mmc_priv(mmc);
 
 	if (host->power_mode != ios->power_mode) {
-		int		canpower;
-
-		canpower = host->pdata && host->pdata->setpower;
 
 		dev_dbg(&host->spi->dev, "mmc_spi: power %s (%d)%s\n",
 				mmc_powerstring(ios->power_mode),
 				ios->vdd,
-				canpower ? ", can switch" : "");
+				mmc_spi_canpower(host) ? ", can switch" : "");
 
 		/* switch power on/off if possible, accounting for
 		 * max 250msec powerup time if needed.
 		 */
-		if (canpower) {
+		if (mmc_spi_canpower(host)) {
 			switch (ios->power_mode) {
 			case MMC_POWER_OFF:
 			case MMC_POWER_UP:
@@ -1223,7 +1224,8 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 *   - MOSI low comes from writing zero
 		 *   - Chipselect is usually active low...
 		 */
-		if (canpower && ios->power_mode == MMC_POWER_OFF) {
+		if (mmc_spi_canpower(host) &&
+		    ios->power_mode == MMC_POWER_OFF) {
 			int mres;
 			u8 nullbyte = 0;
 
@@ -1399,7 +1401,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 		dev_warn(&spi->dev, "ASSUMING 3.2-3.4 V slot power\n");
 		mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
 	}
-	if (host->pdata && host->pdata->setpower) {
+	if (mmc_spi_canpower(host)) {
 		host->powerup_msecs = host->pdata->powerup_msecs;
 		if (!host->powerup_msecs || host->powerup_msecs > 250)
 			host->powerup_msecs = 250;
@@ -1459,7 +1461,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 			host->dma_dev ? "" : ", no DMA",
 			(host->pdata && host->pdata->get_ro)
 				? "" : ", no WP",
-			(host->pdata && host->pdata->setpower)
+			mmc_spi_canpower(host)
 				? "" : ", no poweroff",
 			(mmc->caps & MMC_CAP_NEEDS_POLL)
 				? ", cd polling" : "");
-- 
1.7.4.1
