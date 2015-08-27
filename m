From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 11/15] mmc: host: omap_hsmmc: don't use ->set_power to set initial regulator state
Date: Thu, 27 Aug 2015 14:44:03 +0530
Message-ID: <1440666847-12594-12-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

If the regulator is enabled on boot (checked using regulator_is_enabled),
invoke regulator_enable() so that the usecount reflects the correct
state of the regulator and then disable the regulator so that the
initial state of the regulator is disabled. Avoid using ->set_power,
since set_power also takes care of setting the voltages which is not
needed at this point.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   66 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index eec6975..cd4bd6d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -409,6 +409,59 @@ err_set_voltage:
 	return ret;
 }
 
+static int omap_hsmmc_disable_boot_regulator(struct regulator *reg)
+{
+	int ret;
+
+	if (!reg)
+		return 0;
+
+	if (regulator_is_enabled(reg)) {
+		ret = regulator_enable(reg);
+		if (ret)
+			return ret;
+
+		ret = regulator_disable(reg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int omap_hsmmc_disable_boot_regulators(struct omap_hsmmc_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	/*
+	 * disable regulators enabled during boot and get the usecount
+	 * right so that regulators can be enabled/disabled by checking
+	 * the return value of regulator_is_enabled
+	 */
+	ret = omap_hsmmc_disable_boot_regulator(mmc->supply.vmmc);
+	if (ret) {
+		dev_err(host->dev, "fail to disable boot enabled vmmc reg\n");
+		return ret;
+	}
+
+	ret = omap_hsmmc_disable_boot_regulator(mmc->supply.vqmmc);
+	if (ret) {
+		dev_err(host->dev,
+			"fail to disable boot enabled vmmc_aux reg\n");
+		return ret;
+	}
+
+	ret = omap_hsmmc_disable_boot_regulator(host->pbias);
+	if (ret) {
+		dev_err(host->dev,
+			"failed to disable boot enabled pbias reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
 	int ocr_value = 0;
@@ -456,17 +509,10 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	/* For eMMC do not power off when not in sleep state */
 	if (mmc_pdata(host)->no_regulator_off_init)
 		return 0;
-	/*
-	 * To disable boot_on regulator, enable regulator
-	 * to increase usecount and then disable it.
-	 */
-	if ((mmc->supply.vmmc && regulator_is_enabled(mmc->supply.vmmc) > 0) ||
-	    (mmc->supply.vqmmc && regulator_is_enabled(mmc->supply.vqmmc))) {
-		int vdd = ffs(mmc_pdata(host)->ocr_mask) - 1;
 
-		omap_hsmmc_set_power(host->dev, 1, vdd);
-		omap_hsmmc_set_power(host->dev, 0, 0);
-	}
+	ret = omap_hsmmc_disable_boot_regulators(host);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
1.7.9.5
