From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [RFC] mmc: host: sdhci-msm: Use the interconnect API
Date: Thu, 11 Oct 2018 15:03:36 +0300
Message-ID: <20181011120336.9129-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-mmc@vger.kernel.org

The interconnect API provides an interface for consumer drivers to express
their bandwidth needs in the SoC. This data is aggregated and the on-chip
interconnect hardware is configured to the appropriate power/performance
profile.

Use the interconnect API to get() the path between the endpoints used for
data transfers by the SD host controller and report the needed bandwidth
based on the clock rate, bus width and mode.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

This depends on the interconnect API: https://lkml.org/lkml/2018/8/31/444

TODO: Use macros for converting and rounding to icc units instead of
converting between kilobits and kilobytes in the consumer drivers.

 drivers/mmc/host/sdhci-msm.c | 46 ++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3cc8bfee6c18..8ca99ccdb035 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -20,6 +20,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/interconnect.h>
 #include <linux/iopoll.h>
 #include <linux/regulator/consumer.h>
 
@@ -258,6 +259,7 @@ struct sdhci_msm_host {
 	bool mci_removed;
 	const struct sdhci_msm_variant_ops *var_ops;
 	const struct sdhci_msm_offset *offset;
+	struct icc_path *path;
 };
 
 static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
@@ -1627,6 +1629,30 @@ static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
 	.offset = &sdhci_msm_v5_offset,
 };
 
+static int sdhci_msm_icc_update(struct sdhci_msm_host *msm_host)
+{
+	struct sdhci_host *host = dev_get_drvdata(&msm_host->pdev->dev);
+	struct mmc_host *mmc = host->mmc;
+	struct mmc_ios *ios = &mmc->ios;
+	unsigned char bus_width = 1 << ios->bus_width;
+	u32 bw;
+
+	/* calculate the needed bandwidth */
+	bw = host->clock;
+
+	if (host->timing == MMC_TIMING_UHS_DDR50 ||
+	    host->timing == MMC_TIMING_MMC_DDR52) {
+		bw *= 2;
+	}
+
+	if (bus_width == 4)
+		bw /= 2;
+	else if (bus_width == 1)
+		bw /= 8;
+
+	return icc_set(msm_host->path, 0, bw / 1000);
+}
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
@@ -1698,16 +1724,27 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
 
+	msm_host->path = of_icc_get(&pdev->dev, "sdhc-mem");
+	if (IS_ERR(msm_host->path)) {
+		ret = PTR_ERR(msm_host->path);
+		goto pltfm_free;
+	}
+	ret = sdhci_msm_icc_update(msm_host);
+	if (ret) {
+		dev_warn(&pdev->dev, "Interconnect setup failed (%d)\n", ret);
+		goto icc_disable;
+	}
+
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (!IS_ERR(msm_host->bus_clk)) {
 		/* Vote for max. clk rate for max. performance */
 		ret = clk_set_rate(msm_host->bus_clk, INT_MAX);
 		if (ret)
-			goto pltfm_free;
+			goto icc_disable;
 		ret = clk_prepare_enable(msm_host->bus_clk);
 		if (ret)
-			goto pltfm_free;
+			goto icc_disable;
 	}
 
 	/* Setup main peripheral bus clock */
@@ -1883,6 +1920,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
+icc_disable:
+	icc_put(msm_host->path);
 pltfm_free:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -1902,6 +1941,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
+	icc_put(msm_host->path);
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
 	if (!IS_ERR(msm_host->bus_clk))
@@ -1917,6 +1957,7 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 
+	icc_set(msm_host->path, 0, 0);
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
 
@@ -1929,6 +1970,7 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 
+	sdhci_msm_icc_update(msm_host);
 	return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
 				       msm_host->bulk_clks);
 }
