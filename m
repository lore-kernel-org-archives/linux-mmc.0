From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 05/17] mmc: host: omap_hsmmc: use mmc_host's vmmc and vqmmc
Date: Wed, 29 Jul 2015 16:39:35 +0530
Message-ID: <1438168187-1614-6-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

No functional change. Instead of using our own vcc and vcc_aux
members, use vmmc and vqmmc present in mmc_host which is present
for the same purpose.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   63 ++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0e690d7..dad1473 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -181,15 +181,6 @@ struct omap_hsmmc_host {
 	struct	mmc_data	*data;
 	struct	clk		*fclk;
 	struct	clk		*dbclk;
-	/*
-	 * vcc == configured supply
-	 * vcc_aux == optional
-	 *   -	MMC1, supply for DAT4..DAT7
-	 *   -	MMC2/MMC2, external level shifter voltage supply, for
-	 *	chip (SDIO, eMMC, etc) or transceiver (MMC2 only)
-	 */
-	struct	regulator	*vcc;
-	struct	regulator	*vcc_aux;
 	struct	regulator	*pbias;
 	bool			pbias_enabled;
 	void	__iomem		*base;
@@ -260,13 +251,14 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 {
 	struct omap_hsmmc_host *host =
 		platform_get_drvdata(to_platform_device(dev));
+	struct mmc_host *mmc = host->mmc;
 	int ret = 0;
 
 	/*
 	 * If we don't see a Vcc regulator, assume it's a fixed
 	 * voltage always-on regulator.
 	 */
-	if (!host->vcc)
+	if (!mmc->supply.vmmc)
 		return 0;
 
 	if (mmc_pdata(host)->before_set_reg)
@@ -295,23 +287,23 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	 * chips/cards need an interface voltage rail too.
 	 */
 	if (power_on) {
-		if (host->vcc)
-			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
+		if (mmc->supply.vmmc)
+			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 		/* Enable interface voltage rail, if needed */
-		if (ret == 0 && host->vcc_aux) {
-			ret = regulator_enable(host->vcc_aux);
-			if (ret < 0 && host->vcc)
-				ret = mmc_regulator_set_ocr(host->mmc,
-							host->vcc, 0);
+		if (ret == 0 && mmc->supply.vqmmc) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			if (ret < 0 && mmc->supply.vmmc)
+				ret = mmc_regulator_set_ocr(mmc,
+							    mmc->supply.vmmc,
+							    0);
 		}
 	} else {
 		/* Shut down the rail */
-		if (host->vcc_aux)
-			ret = regulator_disable(host->vcc_aux);
-		if (host->vcc) {
+		if (mmc->supply.vqmmc)
+			ret = regulator_disable(mmc->supply.vqmmc);
+		if (mmc->supply.vmmc) {
 			/* Then proceed to shut down the local regulator */
-			ret = mmc_regulator_set_ocr(host->mmc,
-						host->vcc, 0);
+			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 		}
 	}
 
@@ -342,29 +334,30 @@ error_set_power:
 static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
 	int ocr_value = 0;
+	struct mmc_host *mmc = host->mmc;
 
-	host->vcc = devm_regulator_get_optional(host->dev, "vmmc");
-	if (IS_ERR(host->vcc)) {
-		if (PTR_ERR(host->vcc) == -EPROBE_DEFER)
+	mmc->supply.vmmc = devm_regulator_get_optional(host->dev, "vmmc");
+	if (IS_ERR(mmc->supply.vmmc)) {
+		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
-			PTR_ERR(host->vcc));
-		host->vcc = NULL;
+			PTR_ERR(mmc->supply.vmmc));
+		mmc->supply.vmmc = NULL;
 	} else {
-		ocr_value = mmc_regulator_get_ocrmask(host->vcc);
+		ocr_value = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
 		if (ocr_value > 0)
 			mmc_pdata(host)->ocr_mask = ocr_value;
 	}
 	mmc_pdata(host)->set_power = omap_hsmmc_set_power;
 
 	/* Allow an aux regulator */
-	host->vcc_aux = devm_regulator_get_optional(host->dev, "vmmc_aux");
-	if (IS_ERR(host->vcc_aux)) {
-		if (PTR_ERR(host->vcc_aux) == -EPROBE_DEFER)
+	mmc->supply.vqmmc = devm_regulator_get_optional(host->dev, "vmmc_aux");
+	if (IS_ERR(mmc->supply.vqmmc)) {
+		if (PTR_ERR(mmc->supply.vqmmc) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		dev_dbg(host->dev, "unable to get vmmc_aux regulator %ld\n",
-			PTR_ERR(host->vcc_aux));
-		host->vcc_aux = NULL;
+			PTR_ERR(mmc->supply.vqmmc));
+		mmc->supply.vqmmc = NULL;
 	}
 
 	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
@@ -383,8 +376,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	 * To disable boot_on regulator, enable regulator
 	 * to increase usecount and then disable it.
 	 */
-	if ((host->vcc && regulator_is_enabled(host->vcc) > 0) ||
-	    (host->vcc_aux && regulator_is_enabled(host->vcc_aux))) {
+	if ((mmc->supply.vmmc && regulator_is_enabled(mmc->supply.vmmc) > 0) ||
+	    (mmc->supply.vqmmc && regulator_is_enabled(mmc->supply.vqmmc))) {
 		int vdd = ffs(mmc_pdata(host)->ocr_mask) - 1;
 
 		mmc_pdata(host)->set_power(host->dev, 1, vdd);
-- 
1.7.9.5
