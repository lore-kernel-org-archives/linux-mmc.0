From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 3/8] mmc: sdhci-msm: Add DT parsing for regulator support
Date: Wed, 29 Jun 2016 16:50:28 +0530
Message-ID: <1467199233-20506-4-git-send-email-riteshh@codeaurora.org>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39439 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbcF2LVu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2016 07:21:50 -0400
In-Reply-To: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

This adds the DT parsing for regulator support
to sdhci-msm platform driver.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 386 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 384 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 6e56f2b..4964eda 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/mmc/mmc.h>
 #include <linux/slab.h>
+#include <linux/regulator/consumer.h>
 
 #include "sdhci-pltfm.h"
 
@@ -54,6 +55,39 @@
 #define CMUX_SHIFT_PHASE_SHIFT	24
 #define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
 
+/* This structure keeps information per regulator */
+struct sdhci_msm_reg_data {
+	struct regulator *reg;	/* voltage regulator handle */
+	const char *name;	/* regulator name */
+
+	/* voltage level to be set */
+	u32 low_vol_level;
+	u32 high_vol_level;
+
+	/* Load values for low power and high power mode */
+	u32 lpm_uA;
+	u32 hpm_uA;
+
+	bool is_enabled;
+	bool is_always_on;
+
+	/* is low power mode setting required for this regulator? */
+	bool lpm_sup;
+};
+
+/*
+ * This structure keeps information for all the
+ * regulators required for a SDCC slot.
+ */
+struct sdhci_msm_slot_reg_data {
+	struct sdhci_msm_reg_data *vdd_data;
+	struct sdhci_msm_reg_data *vdd_io_data;
+};
+
+struct sdhci_msm_pltfm_data {
+	struct sdhci_msm_slot_reg_data *vreg_data;
+};
+
 struct sdhci_msm_host {
 	struct platform_device *pdev;
 	void __iomem *core_mem;	/* MSM SDCC mapped address */
@@ -61,8 +95,337 @@ struct sdhci_msm_host {
 	struct clk *pclk;	/* SDHC peripheral bus clock */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct mmc_host *mmc;
+	struct sdhci_msm_pltfm_data *pdata;
 };
 
+#define MAX_PROP_SIZE 32
+static int sdhci_msm_dt_parse_vreg_info(struct device *dev,
+		struct sdhci_msm_reg_data **vreg_data, const char *vreg_name)
+{
+	int len, ret = 0;
+	const __be32 *prop;
+	char prop_name[MAX_PROP_SIZE];
+	struct sdhci_msm_reg_data *vreg;
+	struct device_node *np = dev->of_node;
+
+	snprintf(prop_name, MAX_PROP_SIZE, "%s-supply", vreg_name);
+	if (!of_parse_phandle(np, prop_name, 0)) {
+		dev_err(dev, "No vreg data found for %s\n", vreg_name);
+		ret = -EINVAL;
+		return ret;
+	}
+
+	vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
+	if (!vreg) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	vreg->name = vreg_name;
+
+	snprintf(prop_name, MAX_PROP_SIZE,
+			"qcom,%s-always-on", vreg_name);
+	if (of_get_property(np, prop_name, NULL))
+		vreg->is_always_on = true;
+
+	snprintf(prop_name, MAX_PROP_SIZE,
+			"qcom,%s-lpm-sup", vreg_name);
+	if (of_get_property(np, prop_name, NULL))
+		vreg->lpm_sup = true;
+
+	snprintf(prop_name, MAX_PROP_SIZE,
+			"qcom,%s-voltage-level", vreg_name);
+	prop = of_get_property(np, prop_name, &len);
+	if (!prop || (len != (2 * sizeof(__be32)))) {
+		dev_warn(dev, "%s %s property\n",
+			prop ? "invalid format" : "no", prop_name);
+	} else {
+		vreg->low_vol_level = be32_to_cpup(&prop[0]);
+		vreg->high_vol_level = be32_to_cpup(&prop[1]);
+	}
+
+	snprintf(prop_name, MAX_PROP_SIZE,
+			"qcom,%s-current-level", vreg_name);
+	prop = of_get_property(np, prop_name, &len);
+	if (!prop || (len != (2 * sizeof(__be32)))) {
+		dev_warn(dev, "%s %s property\n",
+			prop ? "invalid format" : "no", prop_name);
+	} else {
+		vreg->lpm_uA = be32_to_cpup(&prop[0]);
+		vreg->hpm_uA = be32_to_cpup(&prop[1]);
+	}
+
+	*vreg_data = vreg;
+	dev_dbg(dev, "%s: %s %s vol=[%d %d]uV, curr=[%d %d]uA\n",
+		vreg->name, vreg->is_always_on ? "always_on," : "",
+		vreg->lpm_sup ? "lpm_sup," : "", vreg->low_vol_level,
+		vreg->high_vol_level, vreg->lpm_uA, vreg->hpm_uA);
+
+	return ret;
+}
+
+/* Parse platform data */
+static struct sdhci_msm_pltfm_data *sdhci_msm_populate_pdata(struct device *dev)
+{
+	struct sdhci_msm_pltfm_data *pdata = NULL;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		goto out;
+
+	pdata->vreg_data = devm_kzalloc(dev, sizeof(struct
+						    sdhci_msm_slot_reg_data),
+					GFP_KERNEL);
+	if (!pdata->vreg_data)
+		goto out;
+
+	if (sdhci_msm_dt_parse_vreg_info(dev, &pdata->vreg_data->vdd_data,
+					 "vdd")) {
+		dev_err(dev, "failed parsing vdd data\n");
+		goto out;
+	}
+
+	if (sdhci_msm_dt_parse_vreg_info(dev,
+					 &pdata->vreg_data->vdd_io_data,
+					 "vdd-io")) {
+		dev_err(dev, "failed parsing vdd-io data\n");
+		goto out;
+	}
+
+	return pdata;
+out:
+	return NULL;
+}
+
+/* Regulator utility functions */
+static int sdhci_msm_vreg_init_reg(struct device *dev,
+					struct sdhci_msm_reg_data *vreg)
+{
+	int ret = 0;
+
+	/* check if regulator is already initialized? */
+	if (vreg->reg)
+		goto out;
+
+	/* Get the regulator handle */
+	vreg->reg = devm_regulator_get(dev, vreg->name);
+	if (IS_ERR(vreg->reg)) {
+		ret = PTR_ERR(vreg->reg);
+		pr_err("%s: devm_regulator_get(%s) failed. ret=%d\n",
+			__func__, vreg->name, ret);
+		goto out;
+	}
+
+	/* sanity check */
+	if (!vreg->high_vol_level || !vreg->hpm_uA) {
+		pr_err("%s: %s invalid constraints specified\n",
+		       __func__, vreg->name);
+		ret = -EINVAL;
+	}
+
+out:
+	return ret;
+}
+
+static void sdhci_msm_vreg_deinit_reg(struct sdhci_msm_reg_data *vreg)
+{
+	if (vreg->reg)
+		devm_regulator_put(vreg->reg);
+}
+
+static int sdhci_msm_vreg_set_optimum_mode(struct sdhci_msm_reg_data
+						  *vreg, int uA_load)
+{
+	int ret = 0;
+
+	/*
+	 * regulators that do not support regulator_set_voltage also
+	 * do not support regulator_set_load
+	 */
+	ret = regulator_set_load(vreg->reg, uA_load);
+	if (ret < 0)
+		pr_err("%s: regulator_set_load(reg=%s,uA_load=%d) failed. ret=%d\n",
+			       __func__, vreg->name, uA_load, ret);
+	else
+		/*
+		 * regulator_set_load() can return non zero
+		 * value even for success case.
+		 */
+		ret = 0;
+	return ret;
+}
+
+static int sdhci_msm_vreg_set_voltage(struct sdhci_msm_reg_data *vreg,
+					int min_uV, int max_uV)
+{
+	int ret = 0;
+
+	ret = regulator_set_voltage(vreg->reg, min_uV, max_uV);
+	if (ret)
+		pr_err("%s: regulator_set_voltage(%s)failed. min_uV=%d,max_uV=%d,ret=%d\n",
+			       __func__, vreg->name, min_uV, max_uV, ret);
+
+	return ret;
+}
+
+static int sdhci_msm_vreg_enable(struct sdhci_msm_reg_data *vreg)
+{
+	int ret = 0;
+
+	/* Put regulator in HPM (high power mode) */
+	ret = sdhci_msm_vreg_set_optimum_mode(vreg, vreg->hpm_uA);
+	if (ret < 0)
+		goto out;
+
+	if (!vreg->is_enabled) {
+		/* Set voltage level */
+		ret = sdhci_msm_vreg_set_voltage(vreg, vreg->high_vol_level,
+						vreg->high_vol_level);
+		if (ret)
+			goto out;
+	}
+	ret = regulator_enable(vreg->reg);
+	if (ret) {
+		pr_err("%s: regulator_enable(%s) failed. ret=%d\n",
+				__func__, vreg->name, ret);
+		goto out;
+	}
+	vreg->is_enabled = true;
+
+out:
+	return ret;
+}
+
+static int sdhci_msm_vreg_disable(struct sdhci_msm_reg_data *vreg)
+{
+	int ret = 0;
+
+	/* Never disable regulator marked as always_on */
+	if (vreg->is_enabled && !vreg->is_always_on) {
+		ret = regulator_disable(vreg->reg);
+		if (ret) {
+			pr_err("%s: regulator_disable(%s) failed. ret=%d\n",
+				__func__, vreg->name, ret);
+			goto out;
+		}
+		vreg->is_enabled = false;
+
+		ret = sdhci_msm_vreg_set_optimum_mode(vreg, 0);
+		if (ret < 0)
+			goto out;
+
+		/* Set min. voltage level to 0 */
+		ret = sdhci_msm_vreg_set_voltage(vreg, 0, vreg->high_vol_level);
+		if (ret)
+			goto out;
+	} else if (vreg->is_enabled && vreg->is_always_on) {
+		if (vreg->lpm_sup) {
+			/* Put always_on regulator in LPM (low power mode) */
+			ret = sdhci_msm_vreg_set_optimum_mode(vreg,
+							      vreg->lpm_uA);
+			if (ret < 0)
+				goto out;
+		}
+	}
+out:
+	return ret;
+}
+
+static int sdhci_msm_setup_vreg(struct sdhci_msm_pltfm_data *pdata,
+			bool enable, bool is_init)
+{
+	int ret = 0, i;
+	struct sdhci_msm_slot_reg_data *curr_slot;
+	struct sdhci_msm_reg_data *vreg_table[2];
+
+	curr_slot = pdata->vreg_data;
+	if (!curr_slot) {
+		pr_debug("%s: vreg info unavailable,assuming the slot is powered by always on domain\n",
+			 __func__);
+		goto out;
+	}
+
+	vreg_table[0] = curr_slot->vdd_data;
+	vreg_table[1] = curr_slot->vdd_io_data;
+
+	for (i = 0; i < ARRAY_SIZE(vreg_table); i++) {
+		if (vreg_table[i]) {
+			if (enable)
+				ret = sdhci_msm_vreg_enable(vreg_table[i]);
+			else
+				ret = sdhci_msm_vreg_disable(vreg_table[i]);
+			if (ret)
+				goto out;
+		}
+	}
+out:
+	return ret;
+}
+
+/*
+ * Reset vreg by ensuring it is off during probe. A call
+ * to enable vreg is needed to balance disable vreg
+ */
+static int sdhci_msm_vreg_reset(struct sdhci_msm_pltfm_data *pdata)
+{
+	int ret;
+
+	ret = sdhci_msm_setup_vreg(pdata, 1, true);
+	if (ret)
+		return ret;
+	ret = sdhci_msm_setup_vreg(pdata, 0, true);
+	return ret;
+}
+
+/* This init function should be called only once for each SDHC slot */
+static int sdhci_msm_vreg_init(struct device *dev,
+				struct sdhci_msm_pltfm_data *pdata,
+				bool is_init)
+{
+	int ret = 0;
+	struct sdhci_msm_slot_reg_data *curr_slot;
+	struct sdhci_msm_reg_data *curr_vdd_reg, *curr_vdd_io_reg;
+
+	curr_slot = pdata->vreg_data;
+	if (!curr_slot)
+		goto out;
+
+	curr_vdd_reg = curr_slot->vdd_data;
+	curr_vdd_io_reg = curr_slot->vdd_io_data;
+
+	if (!is_init)
+		/* Deregister all regulators from regulator framework */
+		goto vdd_io_reg_deinit;
+
+	/*
+	 * Get the regulator handle from voltage regulator framework
+	 * and then try to set the voltage level for the regulator
+	 */
+	if (curr_vdd_reg) {
+		ret = sdhci_msm_vreg_init_reg(dev, curr_vdd_reg);
+		if (ret)
+			goto out;
+	}
+	if (curr_vdd_io_reg) {
+		ret = sdhci_msm_vreg_init_reg(dev, curr_vdd_io_reg);
+		if (ret)
+			goto vdd_reg_deinit;
+	}
+	ret = sdhci_msm_vreg_reset(pdata);
+	if (ret)
+		dev_err(dev, "vreg reset failed (%d)\n", ret);
+	goto out;
+
+vdd_io_reg_deinit:
+	if (curr_vdd_io_reg)
+		sdhci_msm_vreg_deinit_reg(curr_vdd_io_reg);
+vdd_reg_deinit:
+	if (curr_vdd_reg)
+		sdhci_msm_vreg_deinit_reg(curr_vdd_reg);
+out:
+	return ret;
+}
+
 /* Platform specific tuning */
 static inline int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
 {
@@ -458,6 +821,15 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	/* Extract platform data */
+	if (pdev->dev.of_node) {
+		msm_host->pdata = sdhci_msm_populate_pdata(&pdev->dev);
+		if (!msm_host->pdata) {
+			dev_err(&pdev->dev, "DT parsing error\n");
+			goto pltfm_free;
+		}
+	}
+
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (!IS_ERR(msm_host->bus_clk)) {
@@ -499,13 +871,20 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (ret)
 		goto pclk_disable;
 
+	/* Setup regulators */
+	ret = sdhci_msm_vreg_init(&pdev->dev, msm_host->pdata, true);
+	if (ret) {
+		dev_err(&pdev->dev, "Regulator setup failed (%d)\n", ret);
+		goto clk_disable;
+	}
+
 	core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	msm_host->core_mem = devm_ioremap_resource(&pdev->dev, core_memres);
 
 	if (IS_ERR(msm_host->core_mem)) {
 		dev_err(&pdev->dev, "Failed to remap registers\n");
 		ret = PTR_ERR(msm_host->core_mem);
-		goto clk_disable;
+		goto vreg_deinit;
 	}
 
 	/* Reset the vendor spec register to power on reset state. */
@@ -540,10 +919,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		goto clk_disable;
+		goto vreg_deinit;
 
 	return 0;
 
+vreg_deinit:
+	sdhci_msm_vreg_init(&pdev->dev, msm_host->pdata, false);
 clk_disable:
 	clk_disable_unprepare(msm_host->clk);
 pclk_disable:
@@ -565,6 +946,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 		    0xffffffff);
 
 	sdhci_remove_host(host, dead);
+	sdhci_msm_vreg_init(&pdev->dev, msm_host->pdata, false);
 	clk_disable_unprepare(msm_host->clk);
 	clk_disable_unprepare(msm_host->pclk);
 	if (!IS_ERR(msm_host->bus_clk))
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

