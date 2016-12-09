From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 09/12] mmc: sdhci-xenon: Add SOC PHY PAD voltage control
Date: Fri,  9 Dec 2016 11:30:05 +0100
Message-ID: <882f87f8aab86a90bada5844bdb222aa416c70ee.1481279228.git-series.gregory.clement@free-electrons.com>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37424 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932393AbcLIKar (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2016 05:30:47 -0500
In-Reply-To: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>

From: Hu Ziji <huziji@marvell.com>

Some SOCs have PHY PAD outside Xenon IP.
PHY PAD voltage should match signalling voltage in use.

Add generic SOC PHY PAD voltage control interface.
Implement Aramda-3700 SOC PHY PAD voltage control.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 111 +++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-xenon.c     |   2 +-
 drivers/mmc/host/sdhci-xenon.h     |   2 +-
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 209c522c5a4b..21b3f834f1d1 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -148,6 +148,22 @@ enum phy_type_enum {
 	NR_PHY_TYPES
 };
 
+struct soc_pad_ctrl_table {
+	const char *soc;
+	void (*set_soc_pad)(struct sdhci_host *host,
+			    unsigned char signal_voltage);
+};
+
+struct soc_pad_ctrl {
+	/* Register address of SOC PHY PAD ctrl */
+	void __iomem	*reg;
+	/* SOC PHY PAD ctrl type */
+	enum soc_pad_ctrl_type pad_type;
+	/* SOC specific operation to set SOC PHY PAD */
+	void (*set_soc_pad)(struct sdhci_host *host,
+			    unsigned char signal_voltage);
+};
+
 static struct xenon_emmc_phy_regs xenon_emmc_5_0_phy_regs = {
 	.timing_adj	= SDHCI_EMMC_5_0_PHY_TIMING_ADJUST,
 	.func_ctrl	= SDHCI_EMMC_5_0_PHY_FUNC_CONTROL,
@@ -181,6 +197,8 @@ struct emmc_phy_params {
 	u8	nr_tun_times;
 	/* Divider for calculating Tuning Step */
 	u8	tun_step_divider;
+
+	struct soc_pad_ctrl pad_ctrl;
 };
 
 static int alloc_emmc_phy(struct sdhci_xenon_priv *priv)
@@ -257,6 +275,45 @@ static int emmc_phy_init(struct sdhci_host *host)
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
+ * Set SOC PHY voltage PAD control register,
+ * according to the operation voltage on PAD.
+ * The detailed operation depends on SOC implementaion.
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
@@ -630,6 +687,51 @@ static void emmc_phy_set(struct sdhci_host *host,
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
+		dev_err(mmc_dev(host->mmc), "Unable to find SOC PAD ctrl register address for %s\n",
+			np->name);
+		return -EINVAL;
+	}
+
+	params->pad_ctrl.reg = devm_ioremap_resource(mmc_dev(host->mmc),
+						     &iomem);
+	if (IS_ERR(params->pad_ctrl.reg)) {
+		dev_err(mmc_dev(host->mmc), "Unable to get SOC PHY PAD ctrl regiser for %s\n",
+			np->name);
+		return PTR_ERR(params->pad_ctrl.reg);
+	}
+
+	ret = of_property_read_string(np, "marvell,pad-type", &name);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc), "Unable to determine SOC PHY PAD ctrl type\n");
+		return ret;
+	}
+	if (!strcmp(name, "sd")) {
+		params->pad_ctrl.pad_type = SOC_PAD_SD;
+	} else if (!strcmp(name, "fixed-1-8v")) {
+		params->pad_ctrl.pad_type = SOC_PAD_FIXED_1_8V;
+	} else {
+		dev_err(mmc_dev(host->mmc), "Unsupported SOC PHY PAD ctrl type %s\n",
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
@@ -663,7 +765,14 @@ static int emmc_phy_parse_param_dt(struct sdhci_host *host,
 	else
 		params->tun_step_divider = SDHCI_TUNING_STEP_DIVIDER;
 
-	return 0;
+	return get_dt_pad_ctrl_data(host, np, params);
+}
+
+/* Set SOC PHY Voltage PAD */
+void xenon_soc_pad_ctrl(struct sdhci_host *host,
+			unsigned char signal_voltage)
+{
+	emmc_phy_set_soc_pad(host, signal_voltage);
 }
 
 /*
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 2e47fef490be..21abacf2e9b8 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -322,6 +322,8 @@ static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
 	 */
 	enable_xenon_internal_clk(host);
 
+	xenon_soc_pad_ctrl(host, ios->signal_voltage);
+
 	if (priv->init_card_type == MMC_TYPE_MMC)
 		return xenon_emmc_signal_voltage_switch(mmc, ios);
 
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index 86b5d2b1f1aa..a8312e36a03c 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -106,4 +106,6 @@ struct sdhci_xenon_priv {
 int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
 int xenon_phy_parse_dt(struct device_node *np,
 		       struct sdhci_host *host);
+void xenon_soc_pad_ctrl(struct sdhci_host *host,
+			unsigned char signal_voltage);
 #endif
-- 
git-series 0.9.1
