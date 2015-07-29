From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 08/17] mmc: host: omap_hsmmc: add separate functions for enable/disable supply
Date: Wed, 29 Jul 2015 16:39:38 +0530
Message-ID: <1438168187-1614-9-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

No functional change. Cleanup omap_hsmmc_set_power by adding separate
functions for enable/disable supply and invoke it from
omap_hsmmc_set_power.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |  101 +++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d308552..a0f8c1d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -247,6 +247,65 @@ static int omap_hsmmc_get_cover_state(struct device *dev)
 
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
@@ -289,36 +348,13 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
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
@@ -348,12 +384,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
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
