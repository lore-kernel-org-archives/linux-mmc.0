From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 01/11] mmc: host: omap_hsmmc: Support vmmc_aux to switch to 1.8v
Date: Thu, 30 Jul 2015 13:16:24 +0530
Message-ID: <1438242394-25599-2-git-send-email-kishon@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52434 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbbG3HrG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jul 2015 03:47:06 -0400
In-Reply-To: <1438242394-25599-1-git-send-email-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com, mugunthanvnm@ti.com

Add support for vmmc_aux to switch to 1.8v. Also use "iov" instead of
"vdd" to indicate io voltage. This is in preparation for adding support
for io signal voltage switch.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   47 +++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6d52873..09e949f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -243,10 +243,11 @@ static int omap_hsmmc_get_cover_state(struct device *dev)
 	return mmc_gpio_get_cd(host->mmc);
 }
 
-static int omap_hsmmc_enable_supply(struct mmc_host *mmc)
+static int omap_hsmmc_enable_supply(struct mmc_host *mmc, int iov)
 {
 	int ret;
 	struct mmc_ios *ios = &mmc->ios;
+	int uvoltage;
 
 	if (mmc->supply.vmmc) {
 		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
@@ -255,7 +256,24 @@ static int omap_hsmmc_enable_supply(struct mmc_host *mmc)
 	}
 
 	/* Enable interface voltage rail, if needed */
-	if (mmc->supply.vqmmc && !regulator_is_enabled(mmc->supply.vqmmc)) {
+	if (mmc->supply.vqmmc) {
+		if (regulator_is_enabled(mmc->supply.vqmmc)) {
+			ret = regulator_disable(mmc->supply.vqmmc);
+			if (ret) {
+				dev_err(mmc_dev(mmc),
+					"vmmc_aux reg disable failed\n");
+				goto err_vqmmc;
+			}
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
@@ -304,22 +322,19 @@ err_set_ocr:
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
 
@@ -343,7 +358,7 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
 	return 0;
 }
 
-static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
+static int omap_hsmmc_set_power(struct device *dev, int power_on, int iov)
 {
 	struct omap_hsmmc_host *host =
 		platform_get_drvdata(to_platform_device(dev));
@@ -358,7 +373,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 		return 0;
 
 	if (mmc_pdata(host)->before_set_reg)
-		mmc_pdata(host)->before_set_reg(dev, power_on, vdd);
+		mmc_pdata(host)->before_set_reg(dev, power_on, iov);
 
 	ret = omap_hsmmc_set_pbias(host, false, 0);
 	if (ret)
@@ -378,11 +393,11 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
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
@@ -392,7 +407,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	}
 
 	if (mmc_pdata(host)->after_set_reg)
-		mmc_pdata(host)->after_set_reg(dev, power_on, vdd);
+		mmc_pdata(host)->after_set_reg(dev, power_on, iov);
 
 	return 0;
 
-- 
1.7.9.5

