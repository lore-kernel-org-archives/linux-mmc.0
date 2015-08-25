From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 01/11] mmc: host: omap_hsmmc: Support vmmc_aux to switch to 1.8v
Date: Tue, 25 Aug 2015 14:35:32 +0530
Message-ID: <1440493542-26150-2-git-send-email-kishon@ti.com>
References: <1440493542-26150-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440493542-26150-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add support for vmmc_aux to switch to 1.8v. Also use "iov" instead of
"vdd" to indicate io voltage. This is in preparation for adding support
for io signal voltage switch.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   48 +++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d884d8f..9c13157 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -244,11 +244,12 @@ static int omap_hsmmc_get_cover_state(struct device *dev)
 	return mmc_gpio_get_cd(host->mmc);
 }
 
-static int omap_hsmmc_enable_supply(struct mmc_host *mmc)
+static int omap_hsmmc_enable_supply(struct mmc_host *mmc, int iov)
 {
 	int ret;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 	struct mmc_ios *ios = &mmc->ios;
+	int uvoltage;
 
 	if (mmc->supply.vmmc) {
 		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
@@ -257,7 +258,25 @@ static int omap_hsmmc_enable_supply(struct mmc_host *mmc)
 	}
 
 	/* Enable interface voltage rail, if needed */
-	if (mmc->supply.vqmmc && !host->vqmmc_enabled) {
+	if (mmc->supply.vqmmc) {
+		if (host->vqmmc_enabled) {
+			ret = regulator_disable(mmc->supply.vqmmc);
+			if (ret) {
+				dev_err(mmc_dev(mmc),
+					"vmmc_aux reg disable failed\n");
+				goto err_vqmmc;
+			}
+			host->vqmmc_enabled = 0;
+		}
+
+		uvoltage = (iov == VDD_165_195) ? VDD_1V8 : VDD_3V0;
+		ret = regulator_set_voltage(mmc->supply.vqmmc, uvoltage,
+					    uvoltage);
+		if (ret) {
+			dev_err(mmc_dev(mmc), "vmmc_aux set voltage failed\n");
+			goto err_vqmmc;
+		}
+
 		ret = regulator_enable(mmc->supply.vqmmc);
 		if (ret) {
 			dev_err(mmc_dev(mmc), "vmmc_aux reg enable failed\n");
@@ -309,22 +328,19 @@ err_set_ocr:
 }
 
 static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
-				int vdd)
+				int iov)
 {
 	int ret;
+	int uvoltage;
 
 	if (!host->pbias)
 		return 0;
 
 	if (power_on) {
-		if (vdd <= VDD_165_195)
-			ret = regulator_set_voltage(host->pbias, VDD_1V8,
-						    VDD_1V8);
-		else
-			ret = regulator_set_voltage(host->pbias, VDD_3V0,
-						    VDD_3V0);
-		if (ret < 0) {
-			dev_err(host->dev, "pbias set voltage fail\n");
+		uvoltage = (iov <= VDD_165_195) ? VDD_1V8 : VDD_3V0;
+		ret = regulator_set_voltage(host->pbias, uvoltage, uvoltage);
+		if (ret) {
+			dev_err(host->dev, "pbias set voltage failed\n");
 			return ret;
 		}
 
@@ -348,7 +364,7 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
 	return 0;
 }
 
-static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
+static int omap_hsmmc_set_power(struct device *dev, int power_on, int iov)
 {
 	struct omap_hsmmc_host *host =
 		platform_get_drvdata(to_platform_device(dev));
@@ -363,7 +379,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 		return 0;
 
 	if (mmc_pdata(host)->before_set_reg)
-		mmc_pdata(host)->before_set_reg(dev, power_on, vdd);
+		mmc_pdata(host)->before_set_reg(dev, power_on, iov);
 
 	ret = omap_hsmmc_set_pbias(host, false, 0);
 	if (ret)
@@ -383,11 +399,11 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	 * chips/cards need an interface voltage rail too.
 	 */
 	if (power_on) {
-		ret = omap_hsmmc_enable_supply(mmc);
+		ret = omap_hsmmc_enable_supply(mmc, iov);
 		if (ret)
 			return ret;
 
-		ret = omap_hsmmc_set_pbias(host, true, vdd);
+		ret = omap_hsmmc_set_pbias(host, true, iov);
 		if (ret)
 			goto err_set_voltage;
 	} else {
@@ -397,7 +413,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	}
 
 	if (mmc_pdata(host)->after_set_reg)
-		mmc_pdata(host)->after_set_reg(dev, power_on, vdd);
+		mmc_pdata(host)->after_set_reg(dev, power_on, iov);
 
 	return 0;
 
-- 
1.7.9.5
