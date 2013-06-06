From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 03/10] mmc: omap_hsmmc: use needs_vmmc
Date: Fri, 7 Jun 2013 00:44:12 +0530
Message-ID: <1370546059-24181-4-git-send-email-balajitk@ti.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1370546059-24181-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Update needs_vmmc with info passed from board file via platform
data pdata->needs_vmmc.
Use needs_vmmc/needs_vmmc_aux to check whether
regulator is mandatory and handle regulator errors
like EPROBE_DEFER properly

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   65 ++++++++++++++++++++++------------------
 1 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bda1a42..21fc152 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -184,6 +184,8 @@ struct omap_hsmmc_host {
 	struct omap_hsmmc_next	next_data;
 
 	struct	omap_mmc_platform_data	*pdata;
+	int needs_vmmc:1;
+	int needs_vmmc_aux:1;
 };
 
 static int omap_hsmmc_card_detect(struct device *dev, int slot)
@@ -312,11 +314,13 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	int ocr_value = 0;
 
 	reg = regulator_get(host->dev, "vmmc");
-	if (IS_ERR(reg)) {
-		dev_err(host->dev, "vmmc regulator missing\n");
+	if (IS_ERR(reg) && host->needs_vmmc) {
+		dev_err(host->dev, "unable to get vmmc regulator %ld\n",
+			PTR_ERR(reg));
 		return PTR_ERR(reg);
-	} else {
-		mmc_slot(host).set_power = omap_hsmmc_set_power;
+	}
+	mmc_slot(host).set_power = omap_hsmmc_set_power;
+	if (!IS_ERR(reg)) {
 		host->vcc = reg;
 		ocr_value = mmc_regulator_get_ocrmask(reg);
 		if (!mmc_slot(host).ocr_mask) {
@@ -329,31 +333,33 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 				return -EINVAL;
 			}
 		}
+	}
 
-		/* Allow an aux regulator */
-		reg = regulator_get(host->dev, "vmmc_aux");
-		host->vcc_aux = IS_ERR(reg) ? NULL : reg;
-
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
+	/* Allow an aux regulator */
+	reg = regulator_get(host->dev, "vmmc_aux");
+	host->vcc_aux = IS_ERR(reg) ? NULL : reg;
+	if (IS_ERR(reg) && host->needs_vmmc_aux) {
+		dev_err(host->dev, "unable to get vmmc_aux regulator %ld\n",
+			PTR_ERR(reg));
+		return PTR_ERR(reg);
+	}
 
-			mmc_slot(host).set_power(host->dev, host->slot_id,
-						 1, vdd);
-			mmc_slot(host).set_power(host->dev, host->slot_id,
-						 0, 0);
-		}
+	/* For eMMC do not power off when not in sleep state */
+	if (mmc_slot(host).no_regulator_off_init ||
+	    (!host->needs_vmmc && !host->needs_vmmc_aux))
+		return 0;
+	/*
+	 * To disable boot_on regulator, enable regulator
+	 * to increase usecount and then disable it.
+	 */
+	if ((host->vcc && regulator_is_enabled(host->vcc) > 0) ||
+	    (host->vcc_aux && regulator_is_enabled(host->vcc_aux))) {
+		int vdd = ffs(mmc_slot(host).ocr_mask) - 1;
+
+		mmc_slot(host).set_power(host->dev, host->slot_id,
+					 1, vdd);
+		mmc_slot(host).set_power(host->dev, host->slot_id,
+					 0, 0);
 	}
 
 	return 0;
@@ -1833,6 +1839,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
 	host->next_data.cookie = 1;
+	host->needs_vmmc = pdata->needs_vmmc;
+	host->needs_vmmc_aux = pdata->needs_vmmc_aux;
 
 	platform_set_drvdata(pdev, host);
 
@@ -1972,7 +1980,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (omap_hsmmc_have_reg() && !mmc_slot(host).set_power) {
 		ret = omap_hsmmc_reg_get(host);
 		if (ret)
-			goto err_reg;
+			goto err_irq_cd;
 		host->use_reg = 1;
 	}
 
@@ -2029,7 +2037,6 @@ err_slot_name:
 err_irq_cd:
 	if (host->use_reg)
 		omap_hsmmc_reg_put(host);
-err_reg:
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
 err_irq_cd_init:
-- 
1.7.5.4

