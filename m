From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v3 3/9] mmc: sdhci-msm: add pltfm_data support to get clk-rates from DT
Date: Fri, 19 Aug 2016 10:06:18 +0530
Message-ID: <1471581384-18961-4-git-send-email-riteshh@codeaurora.org>
References: <1471581384-18961-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1471581384-18961-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, bjorn.andersson@linaro.org, shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This adds support for sdhc-msm controllers to get supported
clk-rates from DT. sdhci-msm would need it's own set_clock
ops to be implemented. For this, supported clk-rates needs
to be populated in sdhci_msm_pltfm_data.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.txt          |  1 +
 drivers/mmc/host/sdhci-msm.c                       | 71 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)

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
index 85ddaae..2bf141b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -74,6 +74,11 @@
 #define CMUX_SHIFT_PHASE_SHIFT	24
 #define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
 
+struct sdhci_msm_pltfm_data {
+	u32 *clk_table;
+	size_t clk_table_sz;
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
@@ -582,6 +588,67 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.ops = &sdhci_msm_ops,
 };
 
+static int sdhci_msm_dt_get_array(struct device *dev, const char *prop_name,
+				u32 **table, size_t *size)
+{
+	struct device_node *np = dev->of_node;
+	int count = 0;
+	u32 *arr = NULL;
+	int ret = 0;
+
+	count = of_property_count_elems_of_size(np, prop_name, sizeof(u32));
+	if (count < 0) {
+		dev_err(dev, "%s: Invalid dt property, err(%d)\n",
+				prop_name, count);
+		ret = count;
+		goto out;
+	}
+
+	arr = devm_kzalloc(dev, count * sizeof(*arr), GFP_KERNEL);
+	if (!arr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = of_property_read_u32_array(np, prop_name, arr, count);
+	if (ret) {
+		dev_err(dev, "%s Invalid dt array property, err(%d)\n",
+				prop_name, ret);
+		goto out;
+	}
+	*table = arr;
+	*size = count;
+out:
+	return ret;
+}
+
+static struct sdhci_msm_pltfm_data *sdhci_msm_populate_pdata(struct device *dev,
+						struct sdhci_msm_host *msm_host)
+{
+	struct sdhci_msm_pltfm_data *pdata = NULL;
+	size_t table_sz = 0;
+	u32 *table = NULL;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		goto out;
+
+	if (sdhci_msm_dt_get_array(dev, "clk-rates", &table, &table_sz)) {
+		dev_err(dev, "failed in DT parsing for supported clk-rates\n");
+		goto out;
+	}
+	if (!table || !table_sz) {
+		dev_err(dev, "Invalid clock table\n");
+		goto out;
+	}
+	pdata->clk_table = table;
+	pdata->clk_table_sz = table_sz;
+
+	return pdata;
+out:
+	return NULL;
+}
+
 static int sdhci_msm_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -608,6 +675,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
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
