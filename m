From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 06/16] mmc: sdhci_omap: Add support to set IODELAY values
Date: Mon, 5 Feb 2018 18:20:19 +0530
Message-ID: <20180205125029.21570-7-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The data manual of J6/J6 Eco recommends to set different IODELAY values
depending on the mode in which the MMC/SD is enumerated in order to
ensure IO timings are met.

Add support to set the IODELAY values depending on the various MMC
modes using the pinctrl APIs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 147 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index e24ae903f7ba..8b6170cd689b 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -90,8 +90,12 @@
 
 #define MAX_PHASE_DELAY		0x7C
 
+/* sdhci-omap controller flags */
+#define SDHCI_OMAP_REQUIRE_IODELAY	BIT(0)
+
 struct sdhci_omap_data {
 	u32 offset;
+	u8 flags;
 };
 
 struct sdhci_omap_host {
@@ -102,8 +106,16 @@ struct sdhci_omap_host {
 	struct sdhci_host	*host;
 	u8			bus_mode;
 	u8			power_mode;
+	u8			timing;
+	u8			flags;
+
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	**pinctrl_state;
 };
 
+static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
+static void sdhci_omap_stop_clock(struct sdhci_omap_host *omap_host);
+
 static inline u32 sdhci_omap_readl(struct sdhci_omap_host *host,
 				   unsigned int offset)
 {
@@ -436,6 +448,31 @@ static int sdhci_omap_start_signal_voltage_switch(struct mmc_host *mmc,
 	return 0;
 }
 
+static void sdhci_omap_set_timing(struct sdhci_omap_host *omap_host, u8 timing)
+{
+	int ret;
+	struct pinctrl_state *pinctrl_state;
+	struct device *dev = omap_host->dev;
+
+	if (!(omap_host->flags & SDHCI_OMAP_REQUIRE_IODELAY))
+		return;
+
+	if (omap_host->timing == timing)
+		return;
+
+	sdhci_omap_stop_clock(omap_host);
+
+	pinctrl_state = omap_host->pinctrl_state[timing];
+	ret = pinctrl_select_state(omap_host->pinctrl, pinctrl_state);
+	if (ret) {
+		dev_err(dev, "failed to select pinctrl state\n");
+		return;
+	}
+
+	sdhci_omap_start_clock(omap_host);
+	omap_host->timing = timing;
+}
+
 static void sdhci_omap_set_power_mode(struct sdhci_omap_host *omap_host,
 				      u8 power_mode)
 {
@@ -472,6 +509,7 @@ static void sdhci_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	omap_host = sdhci_pltfm_priv(pltfm_host);
 
 	sdhci_omap_set_bus_mode(omap_host, ios->bus_mode);
+	sdhci_omap_set_timing(omap_host, ios->timing);
 	sdhci_set_ios(mmc, ios);
 	sdhci_omap_set_power_mode(omap_host, ios->power_mode);
 }
@@ -680,6 +718,7 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 
 static const struct sdhci_omap_data dra7_data = {
 	.offset = 0x200,
+	.flags	= SDHCI_OMAP_REQUIRE_IODELAY,
 };
 
 static const struct of_device_id omap_sdhci_match[] = {
@@ -688,6 +727,108 @@ static const struct of_device_id omap_sdhci_match[] = {
 };
 MODULE_DEVICE_TABLE(of, omap_sdhci_match);
 
+static struct pinctrl_state
+*sdhci_omap_iodelay_pinctrl_state(struct sdhci_omap_host *omap_host, char *mode,
+				  u32 *caps, u32 capmask)
+{
+	struct device *dev = omap_host->dev;
+	struct pinctrl_state *pinctrl_state = ERR_PTR(-ENODEV);
+
+	if (!(*caps & capmask))
+		goto ret;
+
+	pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
+	if (IS_ERR(pinctrl_state)) {
+		dev_err(dev, "no pinctrl state for %s mode", mode);
+		*caps &= ~capmask;
+	}
+
+ret:
+	return pinctrl_state;
+}
+
+static int sdhci_omap_config_iodelay_pinctrl_state(struct sdhci_omap_host
+						   *omap_host)
+{
+	struct device *dev = omap_host->dev;
+	struct sdhci_host *host = omap_host->host;
+	struct mmc_host *mmc = host->mmc;
+	u32 *caps = &mmc->caps;
+	u32 *caps2 = &mmc->caps2;
+	struct pinctrl_state *state;
+	struct pinctrl_state **pinctrl_state;
+
+	if (!(omap_host->flags & SDHCI_OMAP_REQUIRE_IODELAY))
+		return 0;
+
+	pinctrl_state = devm_kzalloc(dev, sizeof(*pinctrl_state) *
+				     (MMC_TIMING_MMC_HS200 + 1), GFP_KERNEL);
+	if (!pinctrl_state)
+		return -ENOMEM;
+
+	omap_host->pinctrl = devm_pinctrl_get(omap_host->dev);
+	if (IS_ERR(omap_host->pinctrl)) {
+		dev_err(dev, "Cannot get pinctrl\n");
+		return PTR_ERR(omap_host->pinctrl);
+	}
+
+	state = pinctrl_lookup_state(omap_host->pinctrl, "default");
+	if (IS_ERR(state)) {
+		dev_err(dev, "no pinctrl state for default mode\n");
+		return PTR_ERR(state);
+	}
+	pinctrl_state[MMC_TIMING_LEGACY] = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "sdr104", caps,
+						 MMC_CAP_UHS_SDR104);
+	if (!IS_ERR(state))
+		pinctrl_state[MMC_TIMING_UHS_SDR104] = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "ddr50", caps,
+						 MMC_CAP_UHS_DDR50);
+	if (!IS_ERR(state))
+		pinctrl_state[MMC_TIMING_UHS_DDR50] = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "sdr50", caps,
+						 MMC_CAP_UHS_SDR50);
+	if (!IS_ERR(state))
+		pinctrl_state[MMC_TIMING_UHS_SDR50] = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "sdr25", caps,
+						 MMC_CAP_UHS_SDR25);
+	if (!IS_ERR(state))
+		pinctrl_state[MMC_TIMING_UHS_SDR25] = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "sdr12", caps,
+						 MMC_CAP_UHS_SDR12);
+	if (!IS_ERR(state))
+		pinctrl_state[MMC_TIMING_UHS_SDR12] = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "ddr_1_8v", caps,
+						 MMC_CAP_1_8V_DDR);
+	if (!IS_ERR(state))
+		pinctrl_state[MMC_TIMING_MMC_DDR52] = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "hs", caps,
+						 MMC_CAP_SD_HIGHSPEED);
+	if (!IS_ERR(state))
+		pinctrl_state[MMC_TIMING_SD_HS] = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "hs", caps,
+						 MMC_CAP_MMC_HIGHSPEED);
+	if (!IS_ERR(state))
+		pinctrl_state[MMC_TIMING_MMC_HS] = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "hs200_1_8v", caps2,
+						 MMC_CAP2_HS200_1_8V_SDR);
+	if (!IS_ERR(state))
+		pinctrl_state[MMC_TIMING_MMC_HS200] = state;
+
+	omap_host->pinctrl_state = pinctrl_state;
+
+	return 0;
+}
+
 static int sdhci_omap_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -724,6 +865,8 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	omap_host->base = host->ioaddr;
 	omap_host->dev = dev;
 	omap_host->power_mode = MMC_POWER_UNDEFINED;
+	omap_host->timing = MMC_TIMING_LEGACY;
+	omap_host->flags = data->flags;
 	host->ioaddr += offset;
 
 	mmc = host->mmc;
@@ -772,6 +915,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 		goto err_put_sync;
 	}
 
+	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
+	if (ret)
+		goto err_put_sync;
+
 	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
 	host->mmc_host_ops.start_signal_voltage_switch =
 					sdhci_omap_start_signal_voltage_switch;
-- 
2.11.0
