From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v10 2/7] mmc: omap_hsmmc: handle vcc and vcc_aux independently
Date: Mon, 13 Jan 2014 21:06:10 +0530
Message-ID: <1389627375-9107-3-git-send-email-balajitk@ti.com>
References: <1389279062-32291-1-git-send-email-balajitk@ti.com>
 <1389627375-9107-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1389627375-9107-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, broonie@kernel.org, tony@atomide.com
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

handle vcc and vcc_aux independently to reduce indent.

Signed-off-by: Balaji T K <balajitk@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   54 +++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1eb4350..342be25 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -286,11 +286,12 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	 * chips/cards need an interface voltage rail too.
 	 */
 	if (power_on) {
-		ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
+		if (host->vcc)
+			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
 		/* Enable interface voltage rail, if needed */
 		if (ret == 0 && host->vcc_aux) {
 			ret = regulator_enable(host->vcc_aux);
-			if (ret < 0)
+			if (ret < 0 && host->vcc)
 				ret = mmc_regulator_set_ocr(host->mmc,
 							host->vcc, 0);
 		}
@@ -298,7 +299,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 		/* Shut down the rail */
 		if (host->vcc_aux)
 			ret = regulator_disable(host->vcc_aux);
-		if (!ret) {
+		if (host->vcc) {
 			/* Then proceed to shut down the local regulator */
 			ret = mmc_regulator_set_ocr(host->mmc,
 						host->vcc, 0);
@@ -318,10 +319,10 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 	reg = devm_regulator_get(host->dev, "vmmc");
 	if (IS_ERR(reg)) {
-		dev_err(host->dev, "vmmc regulator missing\n");
+		dev_err(host->dev, "unable to get vmmc regulator %ld\n",
+			PTR_ERR(reg));
 		return PTR_ERR(reg);
 	} else {
-		mmc_slot(host).set_power = omap_hsmmc_set_power;
 		host->vcc = reg;
 		ocr_value = mmc_regulator_get_ocrmask(reg);
 		if (!mmc_slot(host).ocr_mask) {
@@ -334,31 +335,26 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 				return -EINVAL;
 			}
 		}
+	}
+	mmc_slot(host).set_power = omap_hsmmc_set_power;
 
-		/* Allow an aux regulator */
-		reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
-		host->vcc_aux = IS_ERR(reg) ? NULL : reg;
+	/* Allow an aux regulator */
+	reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
+	host->vcc_aux = IS_ERR(reg) ? NULL : reg;
 
-		/* For eMMC do not power off when not in sleep state */
-		if (mmc_slot(host).no_regulator_off_init)
-			return 0;
-		/*
-		* UGLY HACK:  workaround regulator framework bugs.
-		* When the bootloader leaves a supply active, it's
-		* initialized with zero usecount ... and we can't
-		* disable it without first enabling it.  Until the
-		* framework is fixed, we need a workaround like this
-		* (which is safe for MMC, but not in general).
-		*/
-		if (regulator_is_enabled(host->vcc) > 0 ||
-		    (host->vcc_aux && regulator_is_enabled(host->vcc_aux))) {
-			int vdd = ffs(mmc_slot(host).ocr_mask) - 1;
+	/* For eMMC do not power off when not in sleep state */
+	if (mmc_slot(host).no_regulator_off_init)
+		return 0;
+	/*
+	 * To disable boot_on regulator, enable regulator
+	 * to increase usecount and then disable it.
+	 */
+	if ((host->vcc && regulator_is_enabled(host->vcc) > 0) ||
+	    (host->vcc_aux && regulator_is_enabled(host->vcc_aux))) {
+		int vdd = ffs(mmc_slot(host).ocr_mask) - 1;
 
-			mmc_slot(host).set_power(host->dev, host->slot_id,
-						 1, vdd);
-			mmc_slot(host).set_power(host->dev, host->slot_id,
-						 0, 0);
-		}
+		mmc_slot(host).set_power(host->dev, host->slot_id, 1, vdd);
+		mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
 	}
 
 	return 0;
-- 
1.7.5.4

