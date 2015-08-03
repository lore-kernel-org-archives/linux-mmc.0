From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 09/16] mmc: host: omap_hsmmc: add separate function to set pbias
Date: Mon, 3 Aug 2015 17:56:34 +0530
Message-ID: <1438604801-11823-10-git-send-email-kishon@ti.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33931 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753578AbbHCM1Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Aug 2015 08:27:16 -0400
In-Reply-To: <1438604801-11823-1-git-send-email-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com

No functional change. Cleanup omap_hsmmc_set_power by adding separate
functions to set pbias and invoke it from omap_hsmmc_set_power.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   78 +++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 81bec66..194c59f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -306,6 +306,48 @@ err_set_ocr:
 	return ret;
 }
 
+static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
+				int vdd)
+{
+	int ret;
+
+	if (!host->pbias)
+		return 0;
+
+	if (power_on) {
+		if (vdd <= VDD_165_195)
+			ret = regulator_set_voltage(host->pbias, VDD_1V8,
+						    VDD_1V8);
+		else
+			ret = regulator_set_voltage(host->pbias, VDD_3V0,
+						    VDD_3V0);
+		if (ret < 0) {
+			dev_err(host->dev, "pbias set voltage fail\n");
+			return ret;
+		}
+
+		if (host->pbias_enabled == 0) {
+			ret = regulator_enable(host->pbias);
+			if (ret) {
+				dev_err(host->dev, "pbias reg enable fail\n");
+				return ret;
+			}
+			host->pbias_enabled = 1;
+		}
+	} else {
+		if (host->pbias_enabled == 1) {
+			ret = regulator_disable(host->pbias);
+			if (ret) {
+				dev_err(host->dev, "pbias reg disable fail\n");
+				return ret;
+			}
+			host->pbias_enabled = 0;
+		}
+	}
+
+	return 0;
+}
+
 static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 {
 	struct omap_hsmmc_host *host =
@@ -323,16 +365,9 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	if (mmc_pdata(host)->before_set_reg)
 		mmc_pdata(host)->before_set_reg(dev, power_on, vdd);
 
-	if (host->pbias) {
-		if (host->pbias_enabled == 1) {
-			ret = regulator_disable(host->pbias);
-			if (ret) {
-				dev_err(dev, "pbias reg disable failed\n");
-				return ret;
-			}
-			host->pbias_enabled = 0;
-		}
-	}
+	ret = omap_hsmmc_set_pbias(host, false, 0);
+	if (ret)
+		return ret;
 
 	/*
 	 * Assume Vcc regulator is used only to power the card ... OMAP
@@ -357,26 +392,9 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 			return ret;
 	}
 
-	if (host->pbias) {
-		if (vdd <= VDD_165_195)
-			ret = regulator_set_voltage(host->pbias, VDD_1V8,
-								VDD_1V8);
-		else
-			ret = regulator_set_voltage(host->pbias, VDD_3V0,
-								VDD_3V0);
-		if (ret < 0)
-			goto err_set_voltage;
-
-		if (host->pbias_enabled == 0) {
-			ret = regulator_enable(host->pbias);
-			if (ret) {
-				dev_err(dev, "pbias reg enable failed\n");
-				goto err_set_voltage;
-			} else {
-				host->pbias_enabled = 1;
-			}
-		}
-	}
+	ret = omap_hsmmc_set_pbias(host, true, vdd);
+	if (ret)
+		goto err_set_voltage;
 
 	if (mmc_pdata(host)->after_set_reg)
 		mmc_pdata(host)->after_set_reg(dev, power_on, vdd);
-- 
1.7.9.5

