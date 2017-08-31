From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 1/6] mmc: host: omap_hsmmc: Remove setting PBIAS voltage
Date: Thu, 31 Aug 2017 15:48:44 +0530
Message-ID: <20170831101849.9489-2-kishon@ti.com>
References: <20170831101849.9489-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:28072 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdHaKVq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Aug 2017 06:21:46 -0400
In-Reply-To: <20170831101849.9489-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com

PBIAS voltage should be set along with setting vqmmc voltage and
these voltages should be set as part of start_signal_voltage_switch
callback. However since omap_hsmmc is about to be deprecated,
remove setting of PBIAS voltage leaving the PBIAS voltage to be
at the reset value of 3.3V (we'll never have to change this to 1.8V
since UHS mode support will not be added to omap_hsmmc). This will
let pbias regulator driver to be fixed to support a maximum voltage of
3.3V.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 3b5e6d11069b..f2a1137be8bc 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -147,10 +147,6 @@
 #define OMAP_MMC_MAX_CLOCK	52000000
 #define DRIVER_NAME		"omap_hsmmc"
 
-#define VDD_1V8			1800000		/* 180000 uV */
-#define VDD_3V0			3000000		/* 300000 uV */
-#define VDD_165_195		(ffs(MMC_VDD_165_195) - 1)
-
 /*
  * One controller can have multiple slots, like on some omap boards using
  * omap.c controller driver. Luckily this is not currently done on any known
@@ -308,8 +304,7 @@ static int omap_hsmmc_disable_supply(struct mmc_host *mmc)
 	return ret;
 }
 
-static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
-				int vdd)
+static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on)
 {
 	int ret;
 
@@ -317,17 +312,6 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
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
-			return ret;
-		}
-
 		if (host->pbias_enabled == 0) {
 			ret = regulator_enable(host->pbias);
 			if (ret) {
@@ -350,8 +334,7 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
 	return 0;
 }
 
-static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
-				int vdd)
+static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on)
 {
 	struct mmc_host *mmc = host->mmc;
 	int ret = 0;
@@ -363,7 +346,7 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 	if (IS_ERR(mmc->supply.vmmc))
 		return 0;
 
-	ret = omap_hsmmc_set_pbias(host, false, 0);
+	ret = omap_hsmmc_set_pbias(host, false);
 	if (ret)
 		return ret;
 
@@ -385,7 +368,7 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 		if (ret)
 			return ret;
 
-		ret = omap_hsmmc_set_pbias(host, true, vdd);
+		ret = omap_hsmmc_set_pbias(host, true);
 		if (ret)
 			goto err_set_voltage;
 	} else {
@@ -1220,11 +1203,11 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 		clk_disable_unprepare(host->dbclk);
 
 	/* Turn the power off */
-	ret = omap_hsmmc_set_power(host, 0, 0);
+	ret = omap_hsmmc_set_power(host, 0);
 
 	/* Turn the power ON with given VDD 1.8 or 3.0v */
 	if (!ret)
-		ret = omap_hsmmc_set_power(host, 1, vdd);
+		ret = omap_hsmmc_set_power(host, 1);
 	if (host->dbclk)
 		clk_prepare_enable(host->dbclk);
 
@@ -1621,10 +1604,10 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
 		case MMC_POWER_OFF:
-			omap_hsmmc_set_power(host, 0, 0);
+			omap_hsmmc_set_power(host, 0);
 			break;
 		case MMC_POWER_UP:
-			omap_hsmmc_set_power(host, 1, ios->vdd);
+			omap_hsmmc_set_power(host, 1);
 			break;
 		case MMC_POWER_ON:
 			do_send_init_stream = 1;
-- 
2.11.0

