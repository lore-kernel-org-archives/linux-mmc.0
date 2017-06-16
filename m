From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 12/16] mmc: host: omap_hsmmc: Add support to set IODELAY values
Date: Fri, 16 Jun 2017 18:15:40 +0530
Message-ID: <20170616124544.15046-13-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

The data manual of J6/J6 Eco recommends to set different IODELAY values
depending on the mode in which the MMC/SD is enumerated in order to
ensure IO timings are met.

Add support to set the IODELAY values depending on the various MMC
modes using the pinctrl APIs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   5 +
 drivers/mmc/host/omap_hsmmc.c                      | 152 ++++++++++++++++++++-
 2 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 258e25af10f7..dcf0b777c031 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -20,6 +20,11 @@ Optional properties:
 ti,dual-volt: boolean, supports dual voltage cards
 <supply-name>-supply: phandle to the regulator device tree node
 "supply-name" examples are "vmmc", "vmmc_aux" etc
+pinctrl-names: Should be a list of pinctrl state names and can be "sdr104",
+"hs200_1_8v", "ddr50", "sdr50", "sdr25", "sdr12", "hs", "ddr_1_8v" or
+"default".
+pinctrl-<num>: Phandle referencing pin configuration of the sd/emmc controller.
+See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
 ti,non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
 ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 967b7c7d4bd5..0887da4f1ff6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -258,6 +258,18 @@ struct omap_hsmmc_host {
 	struct timer_list	timer;
 	unsigned long long	data_timeout;
 
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
+
 	/* return MMC cover switch state, can be NULL if not supported.
 	 *
 	 * possible return values:
@@ -1718,6 +1730,8 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 static void omap_hsmmc_set_timing(struct omap_hsmmc_host *host)
 {
 	u32 val;
+	int ret;
+	struct pinctrl_state *pinctrl_state;
 	struct mmc_ios *ios = &host->mmc->ios;
 
 	omap_hsmmc_stop_clock(host);
@@ -1727,35 +1741,54 @@ static void omap_hsmmc_set_timing(struct omap_hsmmc_host *host)
 	switch (ios->timing) {
 	case MMC_TIMING_UHS_SDR104:
 		val |= AC12_UHSMC_SDR104;
+		pinctrl_state = host->sdr104_pinctrl_state;
 		break;
 	case MMC_TIMING_MMC_HS200:
 		val |= AC12_UHSMC_SDR104;
+		pinctrl_state = host->hs200_1_8v_pinctrl_state;
 		break;
 	case MMC_TIMING_UHS_DDR50:
 		val |= AC12_UHSMC_DDR50;
+		pinctrl_state = host->ddr50_pinctrl_state;
 		break;
 	case MMC_TIMING_UHS_SDR50:
 		val |= AC12_UHSMC_SDR50;
+		pinctrl_state = host->sdr50_pinctrl_state;
 		break;
 	case MMC_TIMING_UHS_SDR25:
 		val |= AC12_UHSMC_SDR25;
+		pinctrl_state = host->sdr25_pinctrl_state;
 		break;
 	case MMC_TIMING_UHS_SDR12:
 		val |= AC12_UHSMC_SDR12;
+		pinctrl_state = host->sdr12_pinctrl_state;
 		break;
 	case MMC_TIMING_SD_HS:
 	case MMC_TIMING_MMC_HS:
 		val |= AC12_UHSMC_RES;
+		pinctrl_state = host->hs_pinctrl_state;
 		break;
 	case MMC_TIMING_MMC_DDR52:
 		val |= AC12_UHSMC_RES;
+		pinctrl_state = host->ddr_1_8v_pinctrl_state;
 		break;
 	default:
 		val |= AC12_UHSMC_RES;
+		pinctrl_state = host->default_pinctrl_state;
 		break;
 	}
 	OMAP_HSMMC_WRITE(host->base, AC12, val);
 
+	if (host->pdata->controller_flags & OMAP_HSMMC_REQUIRE_IODELAY) {
+		ret = pinctrl_select_state(host->pinctrl, pinctrl_state);
+		if (ret) {
+			dev_err(mmc_dev(host->mmc),
+				"failed to select pinctrl state\n");
+			return;
+		}
+		host->pinctrl_state = pinctrl_state;
+	}
+
 	omap_hsmmc_start_clock(host);
 }
 
@@ -2345,8 +2378,14 @@ static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 		return ERR_PTR(-ENOMEM); /* out of memory */
 
 	legacy = dev_get_platdata(dev);
-	if (legacy && legacy->name)
-		pdata->name = legacy->name;
+	if (legacy) {
+		if (legacy->name)
+			pdata->name = legacy->name;
+		if (legacy->version)
+			pdata->version = legacy->version;
+		if (legacy->max_freq > 0)
+			pdata->max_freq = legacy->max_freq;
+	}
 
 	if (of_find_property(np, "ti,dual-volt", NULL))
 		pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
@@ -2376,6 +2415,101 @@ static inline struct omap_hsmmc_platform_data
 }
 #endif
 
+static struct pinctrl_state
+*omap_hsmmc_iodelay_pinctrl_state(struct omap_hsmmc_host *host, char *mode,
+				  u32 *caps, u32 capmask)
+{
+	struct pinctrl_state *pinctrl_state = ERR_PTR(-ENODEV);
+	char *version = host->pdata->version;
+	char str[20];
+
+	if (!(*caps & capmask))
+		goto ret;
+
+	if (version) {
+		sprintf(str, "%s-%s", mode, version);
+		pinctrl_state = pinctrl_lookup_state(host->pinctrl, str);
+	}
+
+	if (IS_ERR(pinctrl_state))
+		pinctrl_state = pinctrl_lookup_state(host->pinctrl, mode);
+
+	if (IS_ERR(pinctrl_state)) {
+		dev_err(host->dev, "no pinctrl state for %s mode", mode);
+		*caps &= ~capmask;
+	}
+
+ret:
+	return pinctrl_state;
+}
+
+static int omap_hsmmc_config_iodelay_pinctrl_state(struct omap_hsmmc_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	struct pinctrl_state *state;
+
+	if (!(host->pdata->controller_flags & OMAP_HSMMC_REQUIRE_IODELAY))
+		return 0;
+
+	host->pinctrl = devm_pinctrl_get(host->dev);
+	if (IS_ERR(host->pinctrl)) {
+		dev_err(host->dev, "Cannot get pinctrl\n");
+		return PTR_ERR(host->pinctrl);
+	}
+
+	state = pinctrl_lookup_state(host->pinctrl, "default");
+	if (IS_ERR(state)) {
+		dev_err(host->dev, "no pinctrl state for default mode\n");
+		return PTR_ERR(state);
+	}
+	host->default_pinctrl_state = state;
+
+	state = omap_hsmmc_iodelay_pinctrl_state(host, "sdr104", &mmc->caps,
+						 MMC_CAP_UHS_SDR104);
+	if (!IS_ERR(state))
+		host->sdr104_pinctrl_state = state;
+
+	state = omap_hsmmc_iodelay_pinctrl_state(host, "ddr50", &mmc->caps,
+						 MMC_CAP_UHS_DDR50);
+	if (!IS_ERR(state))
+		host->ddr50_pinctrl_state = state;
+
+	state = omap_hsmmc_iodelay_pinctrl_state(host, "sdr50", &mmc->caps,
+						 MMC_CAP_UHS_SDR50);
+	if (!IS_ERR(state))
+		host->sdr50_pinctrl_state = state;
+
+	state = omap_hsmmc_iodelay_pinctrl_state(host, "sdr25", &mmc->caps,
+						 MMC_CAP_UHS_SDR25);
+	if (!IS_ERR(state))
+		host->sdr25_pinctrl_state = state;
+
+	state = omap_hsmmc_iodelay_pinctrl_state(host, "sdr12", &mmc->caps,
+						 MMC_CAP_UHS_SDR12);
+	if (!IS_ERR(state))
+		host->sdr12_pinctrl_state = state;
+
+	state = omap_hsmmc_iodelay_pinctrl_state(host, "ddr_1_8v", &mmc->caps,
+						 MMC_CAP_1_8V_DDR);
+	if (!IS_ERR(state))
+		host->ddr_1_8v_pinctrl_state = state;
+
+	state = omap_hsmmc_iodelay_pinctrl_state(host, "hs", &mmc->caps,
+						 MMC_CAP_MMC_HIGHSPEED |
+						 MMC_CAP_SD_HIGHSPEED);
+	if (!IS_ERR(state))
+		host->hs_pinctrl_state = state;
+
+	state = omap_hsmmc_iodelay_pinctrl_state(host, "hs200_1_8v",
+						 &mmc->caps2,
+						 MMC_CAP2_HS200_1_8V_SDR);
+	if (!IS_ERR(state))
+		host->hs200_1_8v_pinctrl_state = state;
+
+	host->pinctrl_state = host->default_pinctrl_state;
+	return 0;
+}
+
 static int omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_hsmmc_platform_data *pdata = pdev->dev.platform_data;
@@ -2523,6 +2657,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_set_capabilities(host);
 
+	ret = omap_hsmmc_config_iodelay_pinctrl_state(host);
+	if (ret)
+		goto err_pinctrl;
+
 	host->rx_chan = dma_request_chan(&pdev->dev, "rx");
 	if (IS_ERR(host->rx_chan)) {
 		dev_err(mmc_dev(host->mmc), "RX DMA channel request failed\n");
@@ -2595,6 +2733,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		dma_release_channel(host->tx_chan);
 	if (!IS_ERR_OR_NULL(host->rx_chan))
 		dma_release_channel(host->rx_chan);
+err_pinctrl:
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 	pm_runtime_dont_use_autosuspend(host->dev);
@@ -2730,6 +2869,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
 	unsigned long flags;
+	int ret;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_restore(host);
@@ -2746,7 +2886,13 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 		OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
 		OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
 	} else {
-		pinctrl_pm_select_default_state(host->dev);
+		if (host->pinctrl) {
+			ret = pinctrl_select_state(host->pinctrl,
+						   host->pinctrl_state);
+			if (ret)
+				dev_err(mmc_dev(host->mmc),
+					"failed to activate pinctrl state\n");
+		}
 	}
 	spin_unlock_irqrestore(&host->irq_lock, flags);
 	return 0;
-- 
2.11.0
