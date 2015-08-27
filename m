From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 07/15] mmc: host: omap_hsmmc: return error if any of the regulator APIs fail
Date: Thu, 27 Aug 2015 14:43:59 +0530
Message-ID: <1440666847-12594-8-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Return error if any of the regulator APIs (regulator_enable,
regulator_disable, regulator_set_voltage) fails in
omap_hsmmc_set_power to avoid undefined behavior.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   52 +++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index c4c284e..284ab00 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -269,8 +269,11 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	if (host->pbias) {
 		if (host->pbias_enabled == 1) {
 			ret = regulator_disable(host->pbias);
-			if (!ret)
-				host->pbias_enabled = 0;
+			if (ret) {
+				dev_err(dev, "pbias reg disable failed\n");
+				return ret;
+			}
+			host->pbias_enabled = 0;
 		}
 	}
 
@@ -288,23 +291,35 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	 * chips/cards need an interface voltage rail too.
 	 */
 	if (power_on) {
-		if (mmc->supply.vmmc)
+		if (mmc->supply.vmmc) {
 			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+			if (ret)
+				return ret;
+		}
+
 		/* Enable interface voltage rail, if needed */
-		if (ret == 0 && mmc->supply.vqmmc) {
+		if (mmc->supply.vqmmc) {
 			ret = regulator_enable(mmc->supply.vqmmc);
-			if (ret < 0 && mmc->supply.vmmc)
-				ret = mmc_regulator_set_ocr(mmc,
-							    mmc->supply.vmmc,
-							    0);
+			if (ret) {
+				dev_err(dev, "vmmc_aux reg enable failed\n");
+				goto err_set_vqmmc;
+			}
 		}
 	} else {
 		/* Shut down the rail */
-		if (mmc->supply.vqmmc)
+		if (mmc->supply.vqmmc) {
 			ret = regulator_disable(mmc->supply.vqmmc);
+			if (ret) {
+				dev_err(dev, "vmmc_aux reg disable failed\n");
+				return ret;
+			}
+		}
+
 		if (mmc->supply.vmmc) {
 			/* Then proceed to shut down the local regulator */
 			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+			if (ret)
+				return ret;
 		}
 	}
 
@@ -316,19 +331,32 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 			ret = regulator_set_voltage(host->pbias, VDD_3V0,
 								VDD_3V0);
 		if (ret < 0)
-			goto error_set_power;
+			goto err_set_voltage;
 
 		if (host->pbias_enabled == 0) {
 			ret = regulator_enable(host->pbias);
-			if (!ret)
+			if (ret) {
+				dev_err(dev, "pbias reg enable failed\n");
+				goto err_set_voltage;
+			} else {
 				host->pbias_enabled = 1;
+			}
 		}
 	}
 
 	if (mmc_pdata(host)->after_set_reg)
 		mmc_pdata(host)->after_set_reg(dev, power_on, vdd);
 
-error_set_power:
+	return 0;
+
+err_set_voltage:
+	if (mmc->supply.vqmmc)
+		regulator_disable(mmc->supply.vqmmc);
+
+err_set_vqmmc:
+	if (mmc->supply.vmmc)
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
 	return ret;
 }
 
-- 
1.7.9.5
