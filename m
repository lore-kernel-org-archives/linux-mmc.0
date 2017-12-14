From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 06/12] mmc: sdhci_omap: Add support to set IODELAY values
Date: Thu, 14 Dec 2017 18:39:35 +0530
Message-ID: <20171214130941.26666-7-kishon@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214130941.26666-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

The data manual of J6/J6 Eco recommends to set different IODELAY values
depending on the mode in which the MMC/SD is enumerated in order to
ensure IO timings are met.

Add support to set the IODELAY values depending on the various MMC
modes using the pinctrl APIs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 174 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index b20f4c79ccc6..594e41200d8a 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -93,8 +93,12 @@
 
 #define MAX_PHASE_DELAY		0x7C
 
+/* sdhci-omap controller flags */
+#define SDHCI_OMAP_REQUIRE_IODELAY	BIT(0)
+
 struct sdhci_omap_data {
 	u32 offset;
+	u8 flags;
 };
 
 struct sdhci_omap_host {
@@ -105,6 +109,20 @@ struct sdhci_omap_host {
 	struct sdhci_host	*host;
 	u8			bus_mode;
 	u8			power_mode;
+	u8			timing;
+	u8			flags;
+
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pinctrl_state;
+	struct pinctrl_state	*default_pinctrl_state;
+	struct pinctrl_state	*sdr104_pinctrl_state;
+	struct pinctrl_state	*hs200_1_8v_pinctrl_state;
+	struct pinctrl_state	*ddr50_pinctrl_state;
+	struct pinctrl_state	*sdr50_pinctrl_state;
+	struct pinctrl_state	*sdr25_pinctrl_state;
+	struct pinctrl_state	*sdr12_pinctrl_state;
+	struct pinctrl_state	*hs_pinctrl_state;
+	struct pinctrl_state	*ddr_1_8v_pinctrl_state;
 };
 
 static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
@@ -449,6 +467,62 @@ static int sdhci_omap_start_signal_voltage_switch(struct mmc_host *mmc,
 	return 0;
 }
 
+static void sdhci_omap_set_timing(struct sdhci_omap_host *omap_host, u8 timing)
+{
+	int ret;
+	struct pinctrl_state *pinctrl_state;
+	struct device *dev = omap_host->dev;
+
+	if (omap_host->timing == timing)
+		return;
+
+	sdhci_omap_stop_clock(omap_host);
+
+	switch (timing) {
+	case MMC_TIMING_UHS_SDR104:
+		pinctrl_state = omap_host->sdr104_pinctrl_state;
+		break;
+	case MMC_TIMING_MMC_HS200:
+		pinctrl_state = omap_host->hs200_1_8v_pinctrl_state;
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		pinctrl_state = omap_host->ddr50_pinctrl_state;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		pinctrl_state = omap_host->sdr50_pinctrl_state;
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		pinctrl_state = omap_host->sdr25_pinctrl_state;
+		break;
+	case MMC_TIMING_UHS_SDR12:
+		pinctrl_state = omap_host->sdr12_pinctrl_state;
+		break;
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_MMC_HS:
+		pinctrl_state = omap_host->hs_pinctrl_state;
+		break;
+	case MMC_TIMING_MMC_DDR52:
+		pinctrl_state = omap_host->ddr_1_8v_pinctrl_state;
+		break;
+	default:
+		pinctrl_state = omap_host->default_pinctrl_state;
+		break;
+	}
+
+	if (omap_host->flags & SDHCI_OMAP_REQUIRE_IODELAY) {
+		ret = pinctrl_select_state(omap_host->pinctrl, pinctrl_state);
+		if (ret) {
+			dev_err(dev, "failed to select pinctrl state\n");
+			goto ret;
+		}
+		omap_host->pinctrl_state = pinctrl_state;
+	}
+
+ret:
+	sdhci_omap_start_clock(omap_host);
+	omap_host->timing = timing;
+}
+
 static void sdhci_omap_set_power_mode(struct sdhci_omap_host *omap_host,
 				      u8 power_mode)
 {
@@ -485,6 +559,7 @@ static void sdhci_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	omap_host = sdhci_pltfm_priv(pltfm_host);
 
 	sdhci_omap_set_bus_mode(omap_host, ios->bus_mode);
+	sdhci_omap_set_timing(omap_host, ios->timing);
 	sdhci_set_ios(mmc, ios);
 	sdhci_omap_set_power_mode(omap_host, ios->power_mode);
 }
@@ -693,6 +768,7 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 
 static const struct sdhci_omap_data dra7_data = {
 	.offset = 0x200,
+	.flags	= SDHCI_OMAP_REQUIRE_IODELAY,
 };
 
 static const struct of_device_id omap_sdhci_match[] = {
@@ -701,6 +777,98 @@ static const struct of_device_id omap_sdhci_match[] = {
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
+
+	if (!(omap_host->flags & SDHCI_OMAP_REQUIRE_IODELAY))
+		return 0;
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
+	omap_host->default_pinctrl_state = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "sdr104", caps,
+						 MMC_CAP_UHS_SDR104);
+	if (!IS_ERR(state))
+		omap_host->sdr104_pinctrl_state = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "ddr50", caps,
+						 MMC_CAP_UHS_DDR50);
+	if (!IS_ERR(state))
+		omap_host->ddr50_pinctrl_state = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "sdr50", caps,
+						 MMC_CAP_UHS_SDR50);
+	if (!IS_ERR(state))
+		omap_host->sdr50_pinctrl_state = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "sdr25", caps,
+						 MMC_CAP_UHS_SDR25);
+	if (!IS_ERR(state))
+		omap_host->sdr25_pinctrl_state = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "sdr12", caps,
+						 MMC_CAP_UHS_SDR12);
+	if (!IS_ERR(state))
+		omap_host->sdr12_pinctrl_state = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "ddr_1_8v", caps,
+						 MMC_CAP_1_8V_DDR);
+	if (!IS_ERR(state))
+		omap_host->ddr_1_8v_pinctrl_state = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "hs", caps,
+						 MMC_CAP_MMC_HIGHSPEED |
+						 MMC_CAP_SD_HIGHSPEED);
+	if (!IS_ERR(state))
+		omap_host->hs_pinctrl_state = state;
+
+	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "hs200_1_8v", caps2,
+						 MMC_CAP2_HS200_1_8V_SDR);
+	if (!IS_ERR(state))
+		omap_host->hs200_1_8v_pinctrl_state = state;
+
+	omap_host->pinctrl_state = omap_host->default_pinctrl_state;
+
+	return 0;
+}
+
 static int sdhci_omap_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -737,6 +905,8 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	omap_host->base = host->ioaddr;
 	omap_host->dev = dev;
 	omap_host->power_mode = MMC_POWER_UNDEFINED;
+	omap_host->timing = MMC_TIMING_LEGACY;
+	omap_host->flags = data->flags;
 	host->ioaddr += offset;
 
 	mmc = host->mmc;
@@ -785,6 +955,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
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
