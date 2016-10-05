From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v5 03/12] mmc: sdhci-msm: add pltfm_data support to get clk-rates from DT
Date: Wed,  5 Oct 2016 20:10:31 +0530
Message-ID: <1475678440-3525-4-git-send-email-riteshh@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com
Cc: david.brown@linaro.org, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, sboyd@codeaurora.org, bjorn.andersson@linaro.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This adds support for sdhc-msm controllers to get supported
clk-rates from DT. sdhci-msm would need it's own set_clock
ops to be implemented. For this, supported clk-rates needs
to be populated in sdhci_msm_pltfm_data.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.txt          |  1 +
 drivers/mmc/host/sdhci-msm.c                       | 48 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

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
index 85ddaae..042ecb2 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -81,6 +81,8 @@ struct sdhci_msm_host {
 	struct clk *clk;	/* main SD/MMC bus clock */
 	struct clk *pclk;	/* SDHC peripheral bus clock */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
+	u32 *clk_table;
+	int clk_table_sz;
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
 };
@@ -582,6 +584,50 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
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
+		dev_warn(dev, "%s: Invalid dt property, err(%d)\n",
+				prop_name, count);
+		return count;
+	}
+
+	arr = kcalloc(count, sizeof(*arr), GFP_KERNEL);
+	if (!arr)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, prop_name, arr, count);
+	if (ret) {
+		kfree(arr);
+		dev_warn(dev, "%s Invalid dt array property, err(%d)\n",
+				prop_name, ret);
+		return ret;
+	}
+	*table = arr;
+	*size = count;
+	return 0;
+}
+
+void sdhci_msm_populate_dt(struct device *dev,
+						struct sdhci_msm_host *msm_host)
+{
+	int table_sz = 0;
+	u32 *table = NULL;
+
+	if (sdhci_msm_dt_get_array(dev, "clk-rates", &table, &table_sz)) {
+		dev_warn(dev, "failed in DT parsing for supported clk-rates\n");
+		return;
+	}
+	msm_host->clk_table = table;
+	msm_host->clk_table_sz = table_sz;
+}
+
 static int sdhci_msm_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -608,6 +654,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	sdhci_msm_populate_dt(&pdev->dev, msm_host);
+
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (!IS_ERR(msm_host->bus_clk)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
