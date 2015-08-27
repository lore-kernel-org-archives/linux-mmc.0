From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 03/15] mmc: host: omap_hsmmc: cleanup omap_hsmmc_reg_get()
Date: Thu, 27 Aug 2015 14:43:55 +0530
Message-ID: <1440666847-12594-4-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

No functional change. Instead of using a local regulator variable
in omap_hsmmc_reg_get() for holding the return value of
devm_regulator_get_optional() and then assigning to omap_hsmmc_host
regulator members: vcc, vcc_aux and pbias, directly use the
omap_hsmmc_host regulator members.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2eafd6f..3fde2f9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -343,24 +343,22 @@ error_set_power:
 
 static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
-	struct regulator *reg;
 	int ocr_value = 0;
 	int ret;
 
 	if (mmc_pdata(host)->set_power)
 		return 0;
 
-	reg = devm_regulator_get_optional(host->dev, "vmmc");
-	if (IS_ERR(reg)) {
-		ret = PTR_ERR(reg);
+	host->vcc = devm_regulator_get_optional(host->dev, "vmmc");
+	if (IS_ERR(host->vcc)) {
+		ret = PTR_ERR(host->vcc);
 		if (ret != -ENODEV)
 			return ret;
-		host->vcc = NULL;
 		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
-			PTR_ERR(reg));
+			PTR_ERR(host->vcc));
+		host->vcc = NULL;
 	} else {
-		host->vcc = reg;
-		ocr_value = mmc_regulator_get_ocrmask(reg);
+		ocr_value = mmc_regulator_get_ocrmask(host->vcc);
 		if (!mmc_pdata(host)->ocr_mask) {
 			mmc_pdata(host)->ocr_mask = ocr_value;
 		} else {
@@ -374,28 +372,24 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	}
 
 	/* Allow an aux regulator */
-	reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
-	if (IS_ERR(reg)) {
-		ret = PTR_ERR(reg);
+	host->vcc_aux = devm_regulator_get_optional(host->dev, "vmmc_aux");
+	if (IS_ERR(host->vcc_aux)) {
+		ret = PTR_ERR(host->vcc_aux);
 		if (ret != -ENODEV)
 			return ret;
-		host->vcc_aux = NULL;
 		dev_dbg(host->dev, "unable to get vmmc_aux regulator %ld\n",
-			PTR_ERR(reg));
-	} else {
-		host->vcc_aux = reg;
+			PTR_ERR(host->vcc_aux));
+		host->vcc_aux = NULL;
 	}
 
-	reg = devm_regulator_get_optional(host->dev, "pbias");
-	if (IS_ERR(reg)) {
-		ret = PTR_ERR(reg);
+	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
+	if (IS_ERR(host->pbias)) {
+		ret = PTR_ERR(host->pbias);
 		if (ret != -ENODEV)
 			return ret;
-		host->pbias = NULL;
 		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
-			PTR_ERR(reg));
-	} else {
-		host->pbias = reg;
+			PTR_ERR(host->pbias));
+		host->pbias = NULL;
 	}
 
 	/* For eMMC do not power off when not in sleep state */
-- 
1.7.9.5
