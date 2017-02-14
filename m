From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v6 10/14] mmc: sdhci-xenon: Add SoC PHY PAD voltage control
Date: Tue, 14 Feb 2017 18:01:50 +0100
Message-ID: <3c21f3f9930373d6e6c28526c2e5b0aa2072daef.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda
List-Id: linux-mmc@vger.kernel.org

From: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Some SoCs have PHY PAD outside Xenon IP.
PHY PAD voltage should match signalling voltage in use.

Add generic SoC PHY PAD voltage control interface.
Implement Aramda-3700 SoC PHY PAD voltage control.

Signed-off-by: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Tested-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 116 +++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-xenon.c     |   2 +-
 drivers/mmc/host/sdhci-xenon.h     |   2 +-
 3 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index c26ba3a180a0..c3b7e9a21f6b 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -143,6 +143,27 @@ enum phy_type_enum {
 	NR_PHY_TYPES
 };
 
+enum soc_pad_ctrl_type {
+	SOC_PAD_SD,
+	SOC_PAD_FIXED_1_8V,
+};
+
+struct soc_pad_ctrl_table {
+	const char *soc;
+	void (*set_soc_pad)(struct sdhci_host *host,
+			    unsigned char signal_voltage);
+};
+
+struct soc_pad_ctrl {
+	/* Register address of SoC PHY PAD ctrl */
+	void __iomem	*reg;
+	/* SoC PHY PAD ctrl type */
+	enum soc_pad_ctrl_type pad_type;
+	/* SoC specific operation to set SoC PHY PAD */
+	void (*set_soc_pad)(struct sdhci_host *host,
+			    unsigned char signal_voltage);
+};
+
 static struct xenon_emmc_phy_regs xenon_emmc_5_0_phy_regs = {
 	.timing_adj	= XENON_EMMC_5_0_PHY_TIMING_ADJUST,
 	.func_ctrl	= XENON_EMMC_5_0_PHY_FUNC_CONTROL,
@@ -176,6 +197,8 @@ struct emmc_phy_params {
 	u8	nr_tun_times;
 	/* Divider for calculating Tuning Step */
 	u8	tun_step_divider;
+
+	struct soc_pad_ctrl pad_ctrl;
 };
 
 static int alloc_emmc_phy(struct sdhci_xenon_priv *priv)
@@ -252,6 +275,45 @@ static int emmc_phy_init(struct sdhci_host *host)
 	return 0;
 }
 
+#define ARMADA_3700_SOC_PAD_1_8V	0x1
+#define ARMADA_3700_SOC_PAD_3_3V	0x0
+
+static void armada_3700_soc_pad_voltage_set(struct sdhci_host *host,
+					    unsigned char signal_voltage)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct emmc_phy_params *params = priv->phy_params;
+
+	if (params->pad_ctrl.pad_type == SOC_PAD_FIXED_1_8V) {
+		writel(ARMADA_3700_SOC_PAD_1_8V, params->pad_ctrl.reg);
+	} else if (params->pad_ctrl.pad_type == SOC_PAD_SD) {
+		if (signal_voltage == MMC_SIGNAL_VOLTAGE_180)
+			writel(ARMADA_3700_SOC_PAD_1_8V, params->pad_ctrl.reg);
+		else if (signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+			writel(ARMADA_3700_SOC_PAD_3_3V, params->pad_ctrl.reg);
+	}
+}
+
+/*
+ * Set SoC PHY voltage PAD control register,
+ * according to the operation voltage on PAD.
+ * The detailed operation depends on SoC implementation.
+ */
+static void emmc_phy_set_soc_pad(struct sdhci_host *host,
+				 unsigned char signal_voltage)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct emmc_phy_params *params = priv->phy_params;
+
+	if (!params->pad_ctrl.reg)
+		return;
+
+	if (params->pad_ctrl.set_soc_pad)
+		params->pad_ctrl.set_soc_pad(host, signal_voltage);
+}
+
 /*
  * Enable eMMC PHY HW DLL
  * DLL should be enabled and stable before HS200/SDR104 tuning,
@@ -584,6 +646,51 @@ static void emmc_phy_set(struct sdhci_host *host,
 	dev_dbg(mmc_dev(host->mmc), "eMMC PHY setting completes\n");
 }
 
+static int get_dt_pad_ctrl_data(struct sdhci_host *host,
+				struct device_node *np,
+				struct emmc_phy_params *params)
+{
+	int ret = 0;
+	const char *name;
+	struct resource iomem;
+
+	if (of_device_is_compatible(np, "marvell,armada-3700-sdhci"))
+		params->pad_ctrl.set_soc_pad = armada_3700_soc_pad_voltage_set;
+	else
+		return 0;
+
+	if (of_address_to_resource(np, 1, &iomem)) {
+		dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %s\n",
+			np->name);
+		return -EINVAL;
+	}
+
+	params->pad_ctrl.reg = devm_ioremap_resource(mmc_dev(host->mmc),
+						     &iomem);
+	if (IS_ERR(params->pad_ctrl.reg)) {
+		dev_err(mmc_dev(host->mmc), "Unable to get SoC PHY PAD ctrl register for %s\n",
+			np->name);
+		return PTR_ERR(params->pad_ctrl.reg);
+	}
+
+	ret = of_property_read_string(np, "marvell,pad-type", &name);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc), "Unable to determine SoC PHY PAD ctrl type\n");
+		return ret;
+	}
+	if (!strcmp(name, "sd")) {
+		params->pad_ctrl.pad_type = SOC_PAD_SD;
+	} else if (!strcmp(name, "fixed-1-8v")) {
+		params->pad_ctrl.pad_type = SOC_PAD_FIXED_1_8V;
+	} else {
+		dev_err(mmc_dev(host->mmc), "Unsupported SoC PHY PAD ctrl type %s\n",
+			name);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static int emmc_phy_parse_param_dt(struct sdhci_host *host,
 				   struct device_node *np,
 				   struct emmc_phy_params *params)
@@ -617,7 +724,14 @@ static int emmc_phy_parse_param_dt(struct sdhci_host *host,
 	else
 		params->tun_step_divider = XENON_TUNING_STEP_DIVIDER;
 
-	return 0;
+	return get_dt_pad_ctrl_data(host, np, params);
+}
+
+/* Set SoC PHY Voltage PAD */
+void xenon_soc_pad_ctrl(struct sdhci_host *host,
+			unsigned char signal_voltage)
+{
+	emmc_phy_set_soc_pad(host, signal_voltage);
 }
 
 /*
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 99c18cad6460..f344d9fb0a1b 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -338,6 +338,8 @@ static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
 	 */
 	enable_xenon_internal_clk(host);
 
+	xenon_soc_pad_ctrl(host, ios->signal_voltage);
+
 	if (priv->init_card_type == MMC_TYPE_MMC)
 		return xenon_emmc_signal_voltage_switch(mmc, ios);
 
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index e87639774bca..57e7cb463413 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -104,4 +104,6 @@ struct sdhci_xenon_priv {
 int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
 int xenon_phy_parse_dt(struct device_node *np,
 		       struct sdhci_host *host);
+void xenon_soc_pad_ctrl(struct sdhci_host *host,
+			unsigned char signal_voltage);
 #endif
-- 
git-series 0.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
