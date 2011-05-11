From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Wed, 11 May 2011 12:39:39 +0200
Message-ID: <1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
References: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
Return-path: <openezx-devel-bounces@lists.openezx.org>
In-Reply-To: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
List-Unsubscribe: <https://lists.openezx.org/mailman/options/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=unsubscribe>
List-Archive: <http://lists.openezx.org/pipermail/openezx-devel>
List-Post: <mailto:openezx-devel@lists.openezx.org>
List-Help: <mailto:openezx-devel-request@lists.openezx.org?subject=help>
List-Subscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=subscribe>
Sender: openezx-devel-bounces@lists.openezx.org
Errors-To: openezx-devel-bounces@lists.openezx.org
To: linux-mmc@vger.kernel.org
Cc: openezx-devel@lists.openezx.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, Chris Ball <cjb@laptop.org>, Antonio Ospite <ospite@studenti.unina.it>
List-Id: linux-mmc@vger.kernel.org

Add support for powering up SD cards driven by regulators.
This makes the mmc_spi driver work also with the Motorola A910 phone.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Changes since v2:
  - Use IS_ERR_OR_NULL() to correctly handle the stub regulator_get()

Changes since v1:
  - Remove the ifdef CONFIG_REGULATOR as regulator_get() degenerates to 
    a stub as well when the regulator framework is disabled.
  - Release the regulator in mmc_spi_remove()


Chris if this one turns to be OK you could pick up patches 1-3 from previous 
messages and patch 4 v3 from this one. Let me know if you want me to resend the 
whole series instead.

Thanks,
   Antonio

 drivers/mmc/host/mmc_spi.c |   63 +++++++++++++++++++++++++++++++++++--------
 1 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 0f3672d..70dd603 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -31,6 +31,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/crc7.h>
 #include <linux/crc-itu-t.h>
+#include <linux/regulator/consumer.h>
 #include <linux/scatterlist.h>
 
 #include <linux/mmc/host.h>
@@ -150,11 +151,13 @@ struct mmc_spi_host {
 	 */
 	void			*ones;
 	dma_addr_t		ones_dma;
+
+	struct regulator	*vcc;
 };
 
 static inline int mmc_spi_canpower(struct mmc_spi_host *host)
 {
-	return host->pdata && host->pdata->setpower;
+	return (host->pdata && host->pdata->setpower) || host->vcc;
 }
 
 /****************************************************************************/
@@ -1225,17 +1228,35 @@ static inline int mmc_spi_setpower(struct mmc_spi_host *host,
 					unsigned char power_mode,
 					unsigned int vdd)
 {
+	if (!mmc_spi_canpower(host))
+		return -ENOSYS;
+
 	/* switch power on/off if possible, accounting for
 	 * max 250msec powerup time if needed.
 	 */
-	if (mmc_spi_canpower(host)) {
-		switch (power_mode) {
-		case MMC_POWER_OFF:
-		case MMC_POWER_UP:
+	switch (power_mode) {
+	case MMC_POWER_OFF:
+		if (host->vcc) {
+			int ret = mmc_regulator_set_ocr(host->mmc,
+							host->vcc, 0);
+			if (ret)
+				return ret;
+		} else {
+			host->pdata->setpower(&host->spi->dev, vdd);
+		}
+		break;
+
+	case MMC_POWER_UP:
+		if (host->vcc) {
+			int ret = mmc_regulator_set_ocr(host->mmc,
+							host->vcc, vdd);
+			if (ret)
+				return ret;
+		} else {
 			host->pdata->setpower(&host->spi->dev, vdd);
-			if (power_mode == MMC_POWER_UP)
-				msleep(host->powerup_msecs);
 		}
+		msleep(host->powerup_msecs);
+		break;
 	}
 
 	return 0;
@@ -1420,12 +1441,27 @@ static int mmc_spi_probe(struct spi_device *spi)
 	 * and power switching gpios.
 	 */
 	host->pdata = mmc_spi_get_pdata(spi);
-	if (host->pdata)
-		mmc->ocr_avail = host->pdata->ocr_mask;
-	if (!mmc->ocr_avail) {
-		dev_warn(&spi->dev, "ASSUMING 3.2-3.4 V slot power\n");
-		mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
+
+	host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
+	if (IS_ERR_OR_NULL(host->vcc)) {
+		host->vcc = NULL;
+	} else {
+		host->mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vcc);
+		if (host->pdata && host->pdata->ocr_mask)
+			dev_warn(mmc_dev(host->mmc),
+				"ocr_mask/setpower will not be used\n");
 	}
+
+	if (host->vcc == NULL) {
+		/* fall-back to platform data */
+		if (host->pdata)
+			mmc->ocr_avail = host->pdata->ocr_mask;
+		if (!mmc->ocr_avail) {
+			dev_warn(&spi->dev, "ASSUMING 3.2-3.4 V slot power\n");
+			mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+		}
+	}
+
 	if (mmc_spi_canpower(host)) {
 		host->powerup_msecs = host->pdata->powerup_msecs;
 		if (!host->powerup_msecs || host->powerup_msecs > 250)
@@ -1523,6 +1559,9 @@ static int __devexit mmc_spi_remove(struct spi_device *spi)
 		if (host->pdata && host->pdata->exit)
 			host->pdata->exit(&spi->dev, mmc);
 
+		if (host->vcc)
+			regulator_put(host->vcc);
+
 		mmc_remove_host(mmc);
 
 		if (host->dma_dev) {
-- 
1.7.5.1
