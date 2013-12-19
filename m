From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v6 2/7] mmc: omap_hsmmc: handle vcc and vcc_aux independently
Date: Thu, 19 Dec 2013 18:08:35 +0530
Message-ID: <1387456720-7202-3-git-send-email-balajitk@ti.com>
References: <1386670577-3530-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52141 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089Ab3LSMjA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Dec 2013 07:39:00 -0500
In-Reply-To: <1387456720-7202-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
Cc: tony@atomide.com, Balaji T K <balajitk@ti.com>

handle vcc and vcc_aux independently to reduce indent.

Signed-off-by: Balaji T K <balajitk@ti.com>
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

