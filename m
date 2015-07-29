From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 03/17] mmc: host: omap_hsmmc: cleanup omap_hsmmc_reg_get()
Date: Wed, 29 Jul 2015 16:39:33 +0530
Message-ID: <1438168187-1614-4-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

No functional change. Instead of using a local regulator variable
in omap_hsmmc_reg_get() for holding the return value of
devm_regulator_get_optional() and then assigning to omap_hsmmc_host
regulator members: vcc, vcc_aux and pbias, directly use the
omap_hsmmc_host regulator members.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7f7625d..a78e15e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -341,19 +341,17 @@ error_set_power:
 
 static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
-	struct regulator *reg;
 	int ocr_value = 0;
 
-	reg = devm_regulator_get_optional(host->dev, "vmmc");
-	if (IS_ERR(reg)) {
-		if (PTR_ERR(reg) == -EPROBE_DEFER)
+	host->vcc = devm_regulator_get_optional(host->dev, "vmmc");
+	if (IS_ERR(host->vcc)) {
+		if (PTR_ERR(host->vcc) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
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
@@ -368,26 +366,22 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	mmc_pdata(host)->set_power = omap_hsmmc_set_power;
 
 	/* Allow an aux regulator */
-	reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
-	if (IS_ERR(reg)) {
-		if (PTR_ERR(reg) == -EPROBE_DEFER)
+	host->vcc_aux = devm_regulator_get_optional(host->dev, "vmmc_aux");
+	if (IS_ERR(host->vcc_aux)) {
+		if (PTR_ERR(host->vcc_aux) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
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
-		if (PTR_ERR(reg) == -EPROBE_DEFER)
+	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
+	if (IS_ERR(host->pbias)) {
+		if (PTR_ERR(host->pbias) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
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
