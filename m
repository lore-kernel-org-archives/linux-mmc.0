From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/3] mmc: sdhci-sprd: Add pin control support for voltage switch
Date: Fri, 21 Jun 2019 14:12:33 +0800
Message-ID: <db6d2b2d6170fd2409916c5c41b857f4bc587a15.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

For Spreadtrum SD card voltage switching, besides regulator setting,
it also need switch related pin's state to output corresponding voltage.

This patch adds pin control operation to support voltage switch.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c |   54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 8b23c88..6ee340a 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
@@ -72,6 +73,9 @@ struct sdhci_sprd_host {
 	struct clk *clk_sdio;
 	struct clk *clk_enable;
 	struct clk *clk_2x_enable;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_uhs;
+	struct pinctrl_state *pins_default;
 	u32 base_rate;
 	int flags; /* backup of host attribute */
 	u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
@@ -405,6 +409,8 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 	int ret;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
@@ -416,6 +422,37 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
+	if (IS_ERR(sprd_host->pinctrl))
+		return 0;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+		ret = pinctrl_select_state(sprd_host->pinctrl,
+					   sprd_host->pins_uhs);
+		if (ret) {
+			pr_err("%s: failed to select uhs pin state\n",
+			       mmc_hostname(mmc));
+			return ret;
+		}
+		break;
+
+	default:
+		/* fall-through */
+	case MMC_SIGNAL_VOLTAGE_330:
+		ret = pinctrl_select_state(sprd_host->pinctrl,
+					   sprd_host->pins_default);
+		if (ret) {
+			pr_err("%s: failed to select default pin state\n",
+			       mmc_hostname(mmc));
+			return ret;
+		}
+		break;
+	}
+
+	/* Wait for 300 ~ 500 us for pin state stable */
+	usleep_range(300, 500);
+	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
 	return 0;
 }
 
@@ -504,6 +541,23 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	sprd_host = TO_SPRD_HOST(host);
 	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
 
+	sprd_host->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR(sprd_host->pinctrl)) {
+		sprd_host->pins_uhs =
+			pinctrl_lookup_state(sprd_host->pinctrl, "state_uhs");
+		if (IS_ERR(sprd_host->pins_uhs)) {
+			ret = PTR_ERR(sprd_host->pins_uhs);
+			goto pltfm_free;
+		}
+
+		sprd_host->pins_default =
+			pinctrl_lookup_state(sprd_host->pinctrl, "default");
+		if (IS_ERR(sprd_host->pins_default)) {
+			ret = PTR_ERR(sprd_host->pins_default);
+			goto pltfm_free;
+		}
+	}
+
 	clk = devm_clk_get(&pdev->dev, "sdio");
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
-- 
1.7.9.5
