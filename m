From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v7 09/13] mmc: sdhci-xenon: Add SoC PHY PAD voltage control
Date: Thu, 30 Mar 2017 17:23:01 +0200
Message-ID: <4363b2b62cd424745ebc2e630d30dad968814e46.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda
List-Id: linux-mmc@vger.kernel.org

From: Hu Ziji <huziji@marvell.com>

Some SoCs have PHY PAD outside Xenon IP.
PHY PAD voltage should match signalling voltage in use.

Add generic SoC PHY PAD voltage control interface.
Implement Aramda-3700 SoC PHY PAD voltage control.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Tested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 110 +++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-xenon.c     |   2 +-
 drivers/mmc/host/sdhci-xenon.h     |   2 +-
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index b14544e91b65..4bdbcd3f2645 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -143,6 +143,21 @@ enum xenon_phy_type_enum {
 	NR_PHY_TYPES
 };
 
+enum soc_pad_ctrl_type {
+	SOC_PAD_SD,
+	SOC_PAD_FIXED_1_8V,
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
@@ -176,6 +191,8 @@ struct xenon_emmc_phy_params {
 	u8	nr_tun_times;
 	/* Divider for calculating Tuning Step */
 	u8	tun_step_divider;
+
+	struct soc_pad_ctrl pad_ctrl;
 };
 
 static int xenon_alloc_emmc_phy(struct sdhci_host *host)
@@ -254,6 +271,45 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
 	return 0;
 }
 
+#define ARMADA_3700_SOC_PAD_1_8V	0x1
+#define ARMADA_3700_SOC_PAD_3_3V	0x0
+
+static void armada_3700_soc_pad_voltage_set(struct sdhci_host *host,
+					    unsigned char signal_voltage)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct xenon_emmc_phy_params *params = priv->phy_params;
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
+static void xenon_emmc_phy_set_soc_pad(struct sdhci_host *host,
+				       unsigned char signal_voltage)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct xenon_emmc_phy_params *params = priv->phy_params;
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
@@ -562,6 +618,51 @@ static void xenon_emmc_phy_set(struct sdhci_host *host,
 	dev_dbg(mmc_dev(host->mmc), "eMMC PHY setting completes\n");
 }
 
+static int get_dt_pad_ctrl_data(struct sdhci_host *host,
+				struct device_node *np,
+				struct xenon_emmc_phy_params *params)
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
 static int xenon_emmc_phy_parse_param_dt(struct sdhci_host *host,
 					 struct device_node *np,
 					 struct xenon_emmc_phy_params *params)
@@ -590,7 +691,14 @@ static int xenon_emmc_phy_parse_param_dt(struct sdhci_host *host,
 				  &value))
 		params->tun_step_divider = value & 0xFF;
 
-	return 0;
+	return get_dt_pad_ctrl_data(host, np, params);
+}
+
+/* Set SoC PHY Voltage PAD */
+void xenon_soc_pad_ctrl(struct sdhci_host *host,
+			unsigned char signal_voltage)
+{
+	xenon_emmc_phy_set_soc_pad(host, signal_voltage);
 }
 
 /*
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 36e22bd2b8cc..8e56b9ccfb39 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -280,6 +280,8 @@ static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
 	 */
 	xenon_enable_internal_clk(host);
 
+	xenon_soc_pad_ctrl(host, ios->signal_voltage);
+
 	/*
 	 * If Vqmmc is fixed on platform, vqmmc regulator should be unavailable.
 	 * Thus SDHCI_CTRL_VDD_180 bit might not work then.
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index b29d45358de8..6e6523ea01ce 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -96,4 +96,6 @@ int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
 void xenon_clean_phy(struct sdhci_host *host);
 int xenon_phy_parse_dt(struct device_node *np,
 		       struct sdhci_host *host);
+void xenon_soc_pad_ctrl(struct sdhci_host *host,
+			unsigned char signal_voltage);
 #endif
-- 
git-series 0.9.1
