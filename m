From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH RFC 2/4] mmc: sdhci-msm: Add and use voltage regulator related APIs
Date: Tue,  1 May 2018 16:09:11 +0530
Message-ID: <1525171153-24476-3-git-send-email-vviswana@codeaurora.org>
References: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Asutosh Das <asutoshd@codeaurora.org>

Some platforms require that the voltage switching happen only after
the register write occurs and controller is ready for the switch. When
the controller is ready, it will inform through power irq.

Add voltage regulator APIs and use them during power irq to switch
voltage instead of relying on core layer voltage switching.

Change-Id: Iaa98686e71a5bfe0092c68e9ffa563b060c5ac60
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.txt          |  27 +-
 drivers/mmc/host/sdhci-msm.c                       | 537 +++++++++++++++++++--
 2 files changed, 529 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index c2b7b2b..c454046 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -23,6 +23,22 @@ Required properties:
 	"xo"	- TCXO clock (optional)
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
+- <supply-name>-supply: phandle to the regulator device tree node if voltage
+		regulators needs to be handled from within sdhci-msm layer.
+		Supported "supply-name" are "vdd" and "vdd-io".
+
+Optional Properties:
+	- qcom,<supply>-always-on - specifies whether supply should be kept
+		"on" always.
+	- qcom,<supply>-lpm_sup - specifies whether supply can be kept in low
+		power mode (lpm).
+	- qcom,<supply>-voltage_level - specifies voltage levels for supply.
+		Should be specified in pairs (min, max), units uV.
+	- qcom,<supply>-current_level - specifies load levels for supply in lpm
+		or high power mode (hpm). Should be specified in
+		pairs (lpm, hpm), units uA.
+
+
 
 Example:
 
@@ -33,8 +49,15 @@ Example:
 		bus-width = <8>;
 		non-removable;
 
-		vmmc-supply = <&pm8941_l20>;
-		vqmmc-supply = <&pm8941_s3>;
+		vdd-supply = <&pm8941_l20>;
+		qcom,vdd-voltage-level = <2950000 2950000>;
+		qcom,vdd-current-level = <9000 800000>;
+
+		vdd-io-supply = <&pm8941_s3>;
+		qcom,vdd-io-always-on;
+		qcom,vdd-io-lpm-sup;
+		qcom,vdd-io-voltage-level = <1800000 2950000>;
+		qcom,vdd-io-current-level = <6 22000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index d4d432b..0e0f12d 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -213,6 +213,33 @@ struct sdhci_msm_offset sdhci_msm_offset_mci_present = {
 	.core_ddr_config_2 = 0x1BC,
 };
 
+/* This structure keeps information per regulator */
+struct sdhci_msm_reg_data {
+	/* voltage regulator handle */
+	struct regulator *reg;
+	/* regulator name */
+	const char *name;
+	/* voltage level to be set */
+	u32 low_vol_level;
+	u32 high_vol_level;
+	/* Load values for low power and high power mode */
+	u32 lpm_uA;
+	u32 hpm_uA;
+	/* is this regulator enabled? */
+	bool is_enabled;
+	/* is this regulator needs to be always on? */
+	bool is_always_on;
+	/* is low power mode setting required for this regulator? */
+	bool lpm_sup;
+	bool set_voltage_sup;
+};
+
+struct sdhci_msm_pltfm_data {
+	/* Change-Id: Ide3a658ad51a3c3d4a05c47c0e8f013f647c9516 */
+	struct sdhci_msm_reg_data *vdd_data;
+	struct sdhci_msm_reg_data *vdd_io_data;
+};
+
 struct sdhci_msm_host {
 	struct platform_device *pdev;
 	void __iomem *core_mem;	/* MSM SDCC mapped address */
@@ -234,6 +261,8 @@ struct sdhci_msm_host {
 	u32 caps_0;
 	bool mci_removed;
 	const struct sdhci_msm_offset *offset;
+	bool pltfm_init_done;
+	struct sdhci_msm_pltfm_data pdata;
 };
 
 /*
@@ -298,6 +327,336 @@ void sdhci_msm_vendor_writel_relaxed(u32 val, struct sdhci_host *host,
 	writel_relaxed(val, base_addr + offset);
 }
 
+enum vdd_io_level {
+	/* set vdd_io_data->low_vol_level */
+	VDD_IO_LOW,
+	/* set vdd_io_data->high_vol_level */
+	VDD_IO_HIGH,
+	/*
+	 * set whatever there in voltage_level (third argument) of
+	 * sdhci_msm_set_vdd_io_vol() function.
+	 */
+	VDD_IO_SET_LEVEL,
+};
+
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
+		dev_warn(dev, "No internal vreg data found for %s\n",
+				vreg_name);
+		ret = -EINVAL;
+		return ret;
+	}
+	vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
+	if (!vreg) {
+		ret = -ENOMEM;
+		return ret;
+	}
+	vreg->name = vreg_name;
+	snprintf(prop_name, MAX_PROP_SIZE,
+			"qcom,%s-always-on", vreg_name);
+	if (of_get_property(np, prop_name, NULL))
+		vreg->is_always_on = true;
+
+	snprintf(prop_name, MAX_PROP_SIZE,
+			"qcom,%s-lpm-sup", vreg_name);
+	if (of_get_property(np, prop_name, NULL))
+		vreg->lpm_sup = true;
+	snprintf(prop_name, MAX_PROP_SIZE,
+			"qcom,%s-voltage-level", vreg_name);
+	prop = of_get_property(np, prop_name, &len);
+	if (!prop || (len != (2 * sizeof(__be32)))) {
+		dev_warn(dev, "%s %s property\n",
+				prop ? "invalid format" : "no", prop_name);
+	} else {
+		vreg->low_vol_level = be32_to_cpup(&prop[0]);
+		vreg->high_vol_level = be32_to_cpup(&prop[1]);
+	}
+	snprintf(prop_name, MAX_PROP_SIZE,
+			"qcom,%s-current-level", vreg_name);
+	prop = of_get_property(np, prop_name, &len);
+	if (!prop || (len != (2 * sizeof(__be32)))) {
+		dev_warn(dev, "%s %s property\n",
+				prop ? "invalid format" : "no", prop_name);
+	} else {
+		vreg->lpm_uA = be32_to_cpup(&prop[0]);
+		vreg->hpm_uA = be32_to_cpup(&prop[1]);
+	}
+	*vreg_data = vreg;
+	dev_dbg(dev, "%s: %s %s vol=[%d %d]uV, curr=[%d %d]uA\n",
+			vreg->name, vreg->is_always_on ? "always_on," : "",
+			vreg->lpm_sup ? "lpm_sup," : "", vreg->low_vol_level,
+			vreg->high_vol_level, vreg->lpm_uA, vreg->hpm_uA);
+
+	return ret;
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
+	if (regulator_count_voltages(vreg->reg) > 0) {
+		vreg->set_voltage_sup = true;
+		/* sanity check */
+		if (!vreg->high_vol_level || !vreg->hpm_uA) {
+			pr_err("%s: %s invalid constraints specified high_vol_level: %d hpm_uA: %d\n",
+			       __func__, vreg->name, vreg->high_vol_level,
+			       vreg->hpm_uA);
+			ret = -EINVAL;
+		}
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
+	 * do not support regulator_set_optimum_mode
+	 */
+	if (vreg->set_voltage_sup) {
+		ret = regulator_set_load(vreg->reg, uA_load);
+		if (ret < 0)
+			pr_err("%s: regulator_set_load(reg=%s,uA_load=%d) failed. ret=%d\n",
+			       __func__, vreg->name, uA_load, ret);
+		else
+			/*
+			 * regulator_set_load() can return non zero
+			 * value even for success case.
+			 */
+			ret = 0;
+	}
+	return ret;
+}
+
+static int sdhci_msm_vreg_set_voltage(struct sdhci_msm_reg_data *vreg,
+					int min_uV, int max_uV)
+{
+	int ret = 0;
+
+	if (vreg && vreg->set_voltage_sup) {
+		ret = regulator_set_voltage(vreg->reg, min_uV, max_uV);
+		if (ret) {
+			pr_err("%s: regulator_set_voltage(%s)failed. min_uV=%d,max_uV=%d,ret=%d\n",
+			       __func__, vreg->name, min_uV, max_uV, ret);
+		}
+	}
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
+		return ret;
+
+	if (!vreg->is_enabled) {
+		/* Set voltage level */
+		ret = sdhci_msm_vreg_set_voltage(vreg, vreg->high_vol_level,
+						vreg->high_vol_level);
+		if (ret)
+			return ret;
+	}
+	ret = regulator_enable(vreg->reg);
+	if (ret) {
+		pr_err("%s: regulator_enable(%s) failed. ret=%d\n",
+				__func__, vreg->name, ret);
+		return ret;
+	}
+	vreg->is_enabled = true;
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
+	struct sdhci_msm_reg_data *vreg_table[2];
+
+	vreg_table[0] = pdata->vdd_data;
+	vreg_table[1] = pdata->vdd_io_data;
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
+/* This init function should be called only once for each SDHC slot */
+static int sdhci_msm_vreg_init(struct device *dev,
+				struct sdhci_msm_pltfm_data *pdata,
+				bool is_init)
+{
+	int ret = 0;
+	struct sdhci_msm_reg_data *curr_vdd_reg, *curr_vdd_io_reg;
+
+
+	curr_vdd_reg = pdata->vdd_data;
+	curr_vdd_io_reg = pdata->vdd_io_data;
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
+
+	goto out;
+
+vdd_io_reg_deinit:
+	if (curr_vdd_io_reg)
+		sdhci_msm_vreg_deinit_reg(curr_vdd_io_reg);
+vdd_reg_deinit:
+	if (curr_vdd_reg)
+		sdhci_msm_vreg_deinit_reg(curr_vdd_reg);
+out:
+	if (ret)
+		dev_err(dev, "vreg reset failed (%d)\n", ret);
+	return ret;
+}
+
+static int sdhci_msm_set_vdd_io_vol(struct sdhci_msm_pltfm_data *pdata,
+			enum vdd_io_level level,
+			unsigned int voltage_level)
+{
+	int ret = 0;
+	int set_level;
+	struct sdhci_msm_reg_data *vdd_io_reg;
+
+	vdd_io_reg = pdata->vdd_io_data;
+	if (vdd_io_reg && vdd_io_reg->is_enabled) {
+		switch (level) {
+		case VDD_IO_LOW:
+			set_level = vdd_io_reg->low_vol_level;
+			break;
+		case VDD_IO_HIGH:
+			set_level = vdd_io_reg->high_vol_level;
+			break;
+		case VDD_IO_SET_LEVEL:
+			set_level = voltage_level;
+			break;
+		default:
+			pr_err("%s: invalid argument level = %d",
+					__func__, level);
+			ret = -EINVAL;
+			return ret;
+		}
+		ret = sdhci_msm_vreg_set_voltage(vdd_io_reg, set_level,
+				set_level);
+	}
+	return ret;
+}
+
+/* Parse platform data */
+static void sdhci_msm_populate_pdata(struct device *dev,
+		struct sdhci_msm_pltfm_data *pdata)
+{
+	int ret = 0;
+
+	ret = sdhci_msm_dt_parse_vreg_info(dev, &pdata->vdd_data, "vdd");
+	if (ret)
+		dev_warn(dev, "failed parsing vdd data (%d)\n", ret);
+
+	ret = sdhci_msm_dt_parse_vreg_info(dev, &pdata->vdd_io_data, "vdd-io");
+	if (ret)
+		dev_warn(dev, "failed parsing vdd-io data (%d)\n", ret);
+
+}
+
 static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
 						    unsigned int clock)
 {
@@ -1326,6 +1685,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	u32 pwr_state = 0, io_level = 0;
 	u32 config;
 	const struct sdhci_msm_offset *msm_offset = msm_host->offset;
+	int ret = 0;
 
 	irq_status = sdhci_msm_vendor_readl_relaxed(host,
 			msm_offset->core_pwrctl_status);
@@ -1358,21 +1718,54 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 
 	/* Handle BUS ON/OFF*/
 	if (irq_status & CORE_PWRCTL_BUS_ON) {
+		ret = sdhci_msm_setup_vreg(&msm_host->pdata, true, false);
+		if (!ret) {
+			ret = sdhci_msm_set_vdd_io_vol(&msm_host->pdata,
+					VDD_IO_HIGH, 0);
+			if (ret)
+				pr_err("%s: error setting vdd io in BUS_ON: %d\n",
+						mmc_hostname(host->mmc), ret);
+		} else {
+			pr_err("%s: error setting up vreg ON : %d\n",
+					mmc_hostname(host->mmc), ret);
+		}
 		pwr_state = REQ_BUS_ON;
 		io_level = REQ_IO_HIGH;
 		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
 	}
 	if (irq_status & CORE_PWRCTL_BUS_OFF) {
+		if (msm_host->pltfm_init_done)
+			ret = sdhci_msm_setup_vreg(&msm_host->pdata,
+					false, false);
+		if (!ret) {
+			ret = sdhci_msm_set_vdd_io_vol(&msm_host->pdata,
+					VDD_IO_LOW, 0);
+			if (ret)
+				pr_err("%s: error setting vdd io in BUS_OFF: %d\n",
+						mmc_hostname(host->mmc), ret);
+		} else {
+			pr_err("%s: error setting up vreg OFF: %d\n",
+					mmc_hostname(host->mmc), ret);
+		}
 		pwr_state = REQ_BUS_OFF;
 		io_level = REQ_IO_LOW;
 		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
 	}
 	/* Handle IO LOW/HIGH */
 	if (irq_status & CORE_PWRCTL_IO_LOW) {
+		ret = sdhci_msm_set_vdd_io_vol(&msm_host->pdata, VDD_IO_LOW, 0);
+		if (ret)
+			pr_err("%s: error setting up vdd io low: %d\n",
+					mmc_hostname(host->mmc), ret);
 		io_level = REQ_IO_LOW;
 		irq_ack |= CORE_PWRCTL_IO_SUCCESS;
 	}
 	if (irq_status & CORE_PWRCTL_IO_HIGH) {
+		ret = sdhci_msm_set_vdd_io_vol(&msm_host->pdata,
+				VDD_IO_HIGH, 0);
+		if (ret)
+			pr_err("%s: error setting up vdd io high: %d\n",
+					mmc_hostname(host->mmc), ret);
 		io_level = REQ_IO_HIGH;
 		irq_ack |= CORE_PWRCTL_IO_SUCCESS;
 	}
@@ -1380,7 +1773,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	/*
 	 * The driver has to acknowledge the interrupt, switch voltages and
 	 * report back if it succeded or not to this register. The voltage
-	 * switches are handled by the sdhci core, so just report success.
+	 * switches may be handled by the sdhci core, so just report success.
 	 */
 	sdhci_msm_vendor_writel_relaxed(irq_ack, host,
 			msm_offset->core_pwrctl_ctl);
@@ -1612,6 +2005,74 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
 }
 
+static void sdhci_msm_set_default_hw_caps(struct device *dev,
+		struct sdhci_msm_host *msm_host,
+		struct sdhci_host *host)
+{
+	u32 version, config;
+	u16 minor;
+	u8 major;
+	const struct sdhci_msm_offset *msm_offset = msm_host->offset;
+	struct sdhci_msm_reg_data *vdd_io_reg = msm_host->pdata.vdd_io_data;
+	u32 caps = 0;
+
+	version =  sdhci_msm_vendor_readl_relaxed(host,
+			msm_offset->core_mci_version);
+	major = (version & CORE_VERSION_MAJOR_MASK) >>
+		CORE_VERSION_MAJOR_SHIFT;
+	minor = version & CORE_VERSION_MINOR_MASK;
+	dev_dbg(dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
+			version, major, minor);
+
+	/*
+	 * If voltage regulators are controlled by msm host layer and
+	 * IO voltage regulator can support 1.8V, we need to
+	 * update the capabilities here before sdhci host is added.
+	 */
+	if (vdd_io_reg && (vdd_io_reg->low_vol_level < 1950000))
+		caps |= CORE_1_8V_SUPPORT;
+	if (vdd_io_reg && (vdd_io_reg->low_vol_level > 2700000))
+		caps |= CORE_3_0V_SUPPORT;
+	if (caps) {
+		msm_host->caps_0 |= caps;
+		config =  readl_relaxed(host->ioaddr +
+				msm_offset->core_vendor_spec);
+		config |= CORE_IO_PAD_PWR_SWITCH_EN;
+		writel_relaxed(config,
+				host->ioaddr + msm_offset->core_vendor_spec);
+	}
+
+	caps = readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES);
+
+	if (major == 1 && minor >= 0x42)
+		msm_host->use_14lpp_dll_reset = true;
+	/*
+	 * SDCC 5 controller with major version 1, minor version 0x34 and later
+	 * with HS 400 mode support will use CM DLL instead of CDC LP 533 DLL.
+	 */
+	if (major == 1 && minor < 0x34)
+		msm_host->use_cdclp533 = true;
+
+	/*
+	 * Support for some capabilities is not advertised by newer
+	 * controller versions and must be explicitly enabled.
+	 */
+	if (major >= 1 && minor != 0x11 && minor != 0x12) {
+
+		vdd_io_reg = msm_host->pdata.vdd_io_data;
+		caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
+		if (msm_host->caps_0 & CORE_1_8V_SUPPORT)
+			caps |= CORE_1_8V_SUPPORT;
+	}
+	msm_host->caps_0 |= caps;
+	writel_relaxed(msm_host->caps_0, host->ioaddr +
+			msm_offset->core_vendor_spec_capabilities0);
+
+	/* Set more host capabilities */
+	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+	msm_host->mmc->caps2 |= MMC_CAP2_BOOTPART_NOACC;
+}
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{.compatible = "qcom,sdhci-msm-v5"},
@@ -1648,9 +2109,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	struct resource *core_memres;
 	struct clk *clk;
 	int ret;
-	u16 host_version, core_minor;
-	u32 core_version, config;
-	u8 core_major;
+	u16 host_version;
+	u32 config;
 	const struct sdhci_msm_offset *msm_offset;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
@@ -1678,6 +2138,29 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	sdhci_msm_populate_pdata(&pdev->dev, &msm_host->pdata);
+	/*
+	 * If voltage regulators are controlled internally, set the caps2
+	 * based on regulator capability
+	 */
+	if (msm_host->pdata.vdd_io_data) {
+		struct sdhci_msm_reg_data *vdd_io = msm_host->pdata.vdd_io_data;
+		u32 caps = 0;
+
+		if (vdd_io->high_vol_level > 2700000)
+			caps |= CORE_3_0V_SUPPORT;
+		if (vdd_io->low_vol_level < 1950000)
+			caps |= CORE_1_8V_SUPPORT;
+		if (caps) {
+			msm_host->caps_0 |= caps;
+			config =  readl_relaxed(host->ioaddr +
+				msm_offset->core_vendor_spec);
+			config |= CORE_IO_PAD_PWR_SWITCH_EN;
+			writel_relaxed(config,
+				host->ioaddr + msm_offset->core_vendor_spec);
+		}
+	}
+
 	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
 
 	/* Setup SDCC bus voter clock. */
@@ -1740,6 +2223,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "TCXO clk not present (%d)\n", ret);
 	}
 
+	/* Setup regulators if they are controlled internally */
+	ret = sdhci_msm_vreg_init(&pdev->dev, &msm_host->pdata, true);
+	if (ret) {
+		dev_err(&pdev->dev, "Regulator setup failed (%d)\n", ret);
+		goto clk_disable;
+	}
+
 	if (!msm_host->mci_removed) {
 		core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		msm_host->core_mem = devm_ioremap_resource(&pdev->dev,
@@ -1748,7 +2238,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		if (IS_ERR(msm_host->core_mem)) {
 			dev_err(&pdev->dev, "Failed to remap registers\n");
 			ret = PTR_ERR(msm_host->core_mem);
-			goto clk_disable;
+			goto vreg_deinit;
 		}
 	}
 
@@ -1769,34 +2259,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
 			       SDHCI_VENDOR_VER_SHIFT));
 
-	core_version =  sdhci_msm_vendor_readl_relaxed(host,
-		msm_offset->core_mci_version);
-	core_major = (core_version & CORE_VERSION_MAJOR_MASK) >>
-		      CORE_VERSION_MAJOR_SHIFT;
-	core_minor = core_version & CORE_VERSION_MINOR_MASK;
-	dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
-		core_version, core_major, core_minor);
-
-	if (core_major == 1 && core_minor >= 0x42)
-		msm_host->use_14lpp_dll_reset = true;
-
-	/*
-	 * SDCC 5 controller with major version 1, minor version 0x34 and later
-	 * with HS 400 mode support will use CM DLL instead of CDC LP 533 DLL.
-	 */
-	if (core_major == 1 && core_minor < 0x34)
-		msm_host->use_cdclp533 = true;
-
 	/*
-	 * Support for some capabilities is not advertised by newer
-	 * controller versions and must be explicitly enabled.
+	 * Based on controller version and voltage regulator support,
+	 * enable some properties.
 	 */
-	if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
-		config = readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES);
-		config |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
-		writel_relaxed(config, host->ioaddr +
-				msm_offset->core_vendor_spec_capabilities0);
-	}
+	sdhci_msm_set_default_hw_caps(&pdev->dev, msm_host, host);
 
 	/*
 	 * Power on reset state may trigger power irq if previous status of
@@ -1819,7 +2286,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Get pwr_irq failed (%d)\n",
 			msm_host->pwr_irq);
 		ret = msm_host->pwr_irq;
-		goto clk_disable;
+		goto vreg_deinit;
 	}
 
 	sdhci_msm_init_pwr_irq_wait(msm_host);
@@ -1832,7 +2299,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 					dev_name(&pdev->dev), host);
 	if (ret) {
 		dev_err(&pdev->dev, "Request IRQ failed (%d)\n", ret);
-		goto clk_disable;
+		goto vreg_deinit;
 	}
 
 	pm_runtime_get_noresume(&pdev->dev);
@@ -1857,6 +2324,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+vreg_deinit:
+	sdhci_msm_vreg_init(&pdev->dev, &msm_host->pdata, false);
 clk_disable:
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
@@ -1882,6 +2351,8 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
+	sdhci_msm_vreg_init(&pdev->dev, &msm_host->pdata, false);
+
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
 	if (!IS_ERR(msm_host->bus_clk))
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
