From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 01/41] mmc: host: omap_hsmmc: Support pbias and vmmc_aux to switch to 1.8v
Date: Fri, 19 May 2017 13:45:01 +0530
Message-ID: <20170519081541.26753-2-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170519081541.26753-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Add support for vmmc_aux to switch to 1.8v. Also use "iov" instead of
"vdd" to indicate io voltage. This is in preparation for adding support
for io signal voltage switch.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/mmc/host/omap_hsmmc.c | 50 ++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8c39dccacf39..2000aaa359c8 100644
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
@@ -309,22 +328,19 @@ static int omap_hsmmc_disable_supply(struct mmc_host *mmc)
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
 
@@ -351,13 +367,13 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
 }
 
 static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
-				int vdd)
+				int iov)
 {
 	struct mmc_host *mmc = host->mmc;
 	int ret = 0;
 
 	if (mmc_pdata(host)->set_power)
-		return mmc_pdata(host)->set_power(host->dev, power_on, vdd);
+		return mmc_pdata(host)->set_power(host->dev, power_on, iov);
 
 	/*
 	 * If we don't see a Vcc regulator, assume it's a fixed
@@ -367,7 +383,7 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 		return 0;
 
 	if (mmc_pdata(host)->before_set_reg)
-		mmc_pdata(host)->before_set_reg(host->dev, power_on, vdd);
+		mmc_pdata(host)->before_set_reg(host->dev, power_on, iov);
 
 	ret = omap_hsmmc_set_pbias(host, false, 0);
 	if (ret)
@@ -387,11 +403,11 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
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
@@ -401,7 +417,7 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 	}
 
 	if (mmc_pdata(host)->after_set_reg)
-		mmc_pdata(host)->after_set_reg(host->dev, power_on, vdd);
+		mmc_pdata(host)->after_set_reg(host->dev, power_on, iov);
 
 	return 0;
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
