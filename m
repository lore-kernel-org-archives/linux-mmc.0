From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 08/15] mmc: host: omap_hsmmc: add separate functions for enable/disable supply
Date: Thu, 27 Aug 2015 14:44:00 +0530
Message-ID: <1440666847-12594-9-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

No functional change. Cleanup omap_hsmmc_set_power by adding separate
functions for enable/disable supply and invoke it from
omap_hsmmc_set_power.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |  101 +++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 284ab00..3fa78d4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -246,6 +246,65 @@ static int omap_hsmmc_get_cover_state(struct device *dev)
 
 #ifdef CONFIG_REGULATOR
 
+static int omap_hsmmc_enable_supply(struct mmc_host *mmc, int vdd)
+{
+	int ret;
+
+	if (mmc->supply.vmmc) {
+		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable interface voltage rail, if needed */
+	if (mmc->supply.vqmmc) {
+		ret = regulator_enable(mmc->supply.vqmmc);
+		if (ret) {
+			dev_err(mmc_dev(mmc), "vmmc_aux reg enable failed\n");
+			goto err_vqmmc;
+		}
+	}
+
+	return 0;
+
+err_vqmmc:
+	if (mmc->supply.vmmc)
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
+	return ret;
+}
+
+static int omap_hsmmc_disable_supply(struct mmc_host *mmc)
+{
+	int ret;
+	int status;
+
+	if (mmc->supply.vqmmc) {
+		ret = regulator_disable(mmc->supply.vqmmc);
+		if (ret) {
+			dev_err(mmc_dev(mmc), "vmmc_aux reg disable failed\n");
+			return ret;
+		}
+	}
+
+	if (mmc->supply.vmmc) {
+		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (ret)
+			goto err_set_ocr;
+	}
+
+	return 0;
+
+err_set_ocr:
+	if (mmc->supply.vqmmc) {
+		status = regulator_enable(mmc->supply.vqmmc);
+		if (status)
+			dev_err(mmc_dev(mmc), "vmmc_aux re-enable failed\n");
+	}
+
+	return ret;
+}
+
 static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 {
 	struct omap_hsmmc_host *host =
@@ -291,36 +350,13 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	 * chips/cards need an interface voltage rail too.
 	 */
 	if (power_on) {
-		if (mmc->supply.vmmc) {
-			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-			if (ret)
-				return ret;
-		}
-
-		/* Enable interface voltage rail, if needed */
-		if (mmc->supply.vqmmc) {
-			ret = regulator_enable(mmc->supply.vqmmc);
-			if (ret) {
-				dev_err(dev, "vmmc_aux reg enable failed\n");
-				goto err_set_vqmmc;
-			}
-		}
+		ret = omap_hsmmc_enable_supply(mmc, vdd);
+		if (ret)
+			return ret;
 	} else {
-		/* Shut down the rail */
-		if (mmc->supply.vqmmc) {
-			ret = regulator_disable(mmc->supply.vqmmc);
-			if (ret) {
-				dev_err(dev, "vmmc_aux reg disable failed\n");
-				return ret;
-			}
-		}
-
-		if (mmc->supply.vmmc) {
-			/* Then proceed to shut down the local regulator */
-			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-			if (ret)
-				return ret;
-		}
+		ret = omap_hsmmc_disable_supply(mmc);
+		if (ret)
+			return ret;
 	}
 
 	if (host->pbias) {
@@ -350,12 +386,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	return 0;
 
 err_set_voltage:
-	if (mmc->supply.vqmmc)
-		regulator_disable(mmc->supply.vqmmc);
-
-err_set_vqmmc:
-	if (mmc->supply.vmmc)
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+	omap_hsmmc_disable_supply(mmc);
 
 	return ret;
 }
-- 
1.7.9.5
