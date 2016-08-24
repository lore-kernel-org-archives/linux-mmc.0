From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v4 3/9] mmc: sdhci-msm: add pltfm_data support to get clk-rates from DT
Date: Wed, 24 Aug 2016 15:33:38 +0530
Message-ID: <1472033024-14890-4-git-send-email-riteshh@codeaurora.org>
References: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34042 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbcHXKFb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2016 06:05:31 -0400
In-Reply-To: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, bjorn.andersson@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>

This adds support for sdhc-msm controllers to get supported
clk-rates from DT. sdhci-msm would need it's own set_clock
ops to be implemented. For this, supported clk-rates needs
to be populated in sdhci_msm_pltfm_data.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.txt          |  1 +
 drivers/mmc/host/sdhci-msm.c                       | 60 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 485483a..6a83b38 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -17,6 +17,7 @@ Required properties:
 	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
 	"core"	- SDC MMC clock (MCLK) (required)
 	"bus"	- SDCC bus voter clock (optional)
+- clk-rates: Array of supported GCC clock frequencies for sdhc, Units - Hz.
 
 Example:
 
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 85ddaae..a46dd98 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -74,6 +74,11 @@
 #define CMUX_SHIFT_PHASE_SHIFT	24
 #define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
 
+struct sdhci_msm_pltfm_data {
+	u32 *clk_table;
+	int clk_table_sz;
+};
+
 struct sdhci_msm_host {
 	struct platform_device *pdev;
 	void __iomem *core_mem;	/* MSM SDCC mapped address */
@@ -83,6 +88,7 @@ struct sdhci_msm_host {
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
+	struct sdhci_msm_pltfm_data *pdata;
 };
 
 /* Platform specific tuning */
@@ -582,6 +588,56 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.ops = &sdhci_msm_ops,
 };
 
+static int sdhci_msm_dt_get_array(struct device *dev, const char *prop_name,
+				u32 **table, int *size)
+{
+	struct device_node *np = dev->of_node;
+	int count, ret;
+	u32 *arr;
+
+	count = of_property_count_elems_of_size(np, prop_name, sizeof(u32));
+	if (count < 0) {
+		dev_err(dev, "%s: Invalid dt property, err(%d)\n",
+				prop_name, count);
+		return count;
+	}
+
+	arr = devm_kzalloc(dev, count * sizeof(*arr), GFP_KERNEL);
+	if (!arr)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, prop_name, arr, count);
+	if (ret) {
+		dev_err(dev, "%s Invalid dt array property, err(%d)\n",
+				prop_name, ret);
+		return ret;
+	}
+	*table = arr;
+	*size = count;
+	return 0;
+}
+
+static struct sdhci_msm_pltfm_data *sdhci_msm_populate_pdata(struct device *dev,
+						struct sdhci_msm_host *msm_host)
+{
+	struct sdhci_msm_pltfm_data *pdata = NULL;
+	int table_sz = 0;
+	u32 *table = NULL;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	if (sdhci_msm_dt_get_array(dev, "clk-rates", &table, &table_sz)) {
+		dev_err(dev, "failed in DT parsing for supported clk-rates\n");
+		return NULL;
+	}
+	pdata->clk_table = table;
+	pdata->clk_table_sz = table_sz;
+
+	return pdata;
+}
+
 static int sdhci_msm_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -608,6 +664,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	msm_host->pdata = sdhci_msm_populate_pdata(&pdev->dev, msm_host);
+	if (!msm_host->pdata)
+		goto pltfm_free;
+
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (!IS_ERR(msm_host->bus_clk)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

