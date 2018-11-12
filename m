From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V4 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
Date: Mon, 12 Nov 2018 11:52:47 +0530
Message-ID: <1542003767-10028-1-git-send-email-vbadigan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc: asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On few SDHCI-MSM controllers, the host controller's clock tuning
circuit may go out of sync if controller clocks are gated which
eventually will result in data CRC, command CRC/timeout errors.
To overcome this h/w limitation, the DLL needs to be re-initialized
and restored with its old settings once clocks are ungated.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 78 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3cc8bfe..4cac593 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -232,6 +232,7 @@ struct sdhci_msm_variant_ops {
  */
 struct sdhci_msm_variant_info {
 	bool mci_removed;
+	bool restore_dll_config;
 	const struct sdhci_msm_variant_ops *var_ops;
 	const struct sdhci_msm_offset *offset;
 };
@@ -256,6 +257,7 @@ struct sdhci_msm_host {
 	bool pwr_irq_flag;
 	u32 caps_0;
 	bool mci_removed;
+	bool restore_dll_config;
 	const struct sdhci_msm_variant_ops *var_ops;
 	const struct sdhci_msm_offset *offset;
 };
@@ -1025,6 +1027,48 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	return ret;
 }
 
+static bool sdhci_msm_is_tuning_needed(struct sdhci_host *host)
+{
+	struct mmc_ios *ios = &host->mmc->ios;
+
+	/*
+	 * Tuning is required for SDR104, HS200 and HS400 cards and
+	 * if clock frequency is greater than 100MHz in these modes.
+	 */
+	if (host->clock <= CORE_FREQ_100MHZ ||
+	    !(ios->timing == MMC_TIMING_MMC_HS400 ||
+	    ios->timing == MMC_TIMING_MMC_HS200 ||
+	    ios->timing == MMC_TIMING_UHS_SDR104) ||
+	    ios->enhanced_strobe)
+		return false;
+
+	return true;
+}
+
+static int sdhci_msm_restore_sdr_dll_config(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	/*
+	 * SDR DLL comes into picture only for timing modes which needs
+	 * tuning.
+	 */
+	if (!sdhci_msm_is_tuning_needed(host))
+		return 0;
+
+	/* Reset the tuning block */
+	ret = msm_init_cm_dll(host);
+	if (ret)
+		return ret;
+
+	/* Restore the tuning block */
+	ret = msm_config_cm_dll_phase(host, msm_host->saved_tuning_phase);
+
+	return ret;
+}
+
 static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1035,14 +1079,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 
-	/*
-	 * Tuning is required for SDR104, HS200 and HS400 cards and
-	 * if clock frequency is greater than 100MHz in these modes.
-	 */
-	if (host->clock <= CORE_FREQ_100MHZ ||
-	    !(ios.timing == MMC_TIMING_MMC_HS400 ||
-	    ios.timing == MMC_TIMING_MMC_HS200 ||
-	    ios.timing == MMC_TIMING_UHS_SDR104))
+	if (!sdhci_msm_is_tuning_needed(host))
 		return 0;
 
 	/*
@@ -1069,7 +1106,6 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		if (rc)
 			return rc;
 
-		msm_host->saved_tuning_phase = phase;
 		rc = mmc_send_tuning(mmc, opcode, NULL);
 		if (!rc) {
 			/* Tuning is successful at this tuning point */
@@ -1094,6 +1130,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		rc = msm_config_cm_dll_phase(host, phase);
 		if (rc)
 			return rc;
+		msm_host->saved_tuning_phase = phase;
 		dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
 			 mmc_hostname(mmc), phase);
 	} else {
@@ -1616,7 +1653,6 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 };
 
 static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
-	.mci_removed = false,
 	.var_ops = &mci_var_ops,
 	.offset = &sdhci_msm_mci_offset,
 };
@@ -1627,9 +1663,17 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	.offset = &sdhci_msm_v5_offset,
 };
 
+static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
+	.mci_removed = true,
+	.restore_dll_config = true,
+	.var_ops = &v5_var_ops,
+	.offset = &sdhci_msm_v5_offset,
+};
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
 	{},
 };
 
@@ -1689,6 +1733,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	var_info = of_device_get_match_data(&pdev->dev);
 
 	msm_host->mci_removed = var_info->mci_removed;
+	msm_host->restore_dll_config = var_info->restore_dll_config;
 	msm_host->var_ops = var_info->var_ops;
 	msm_host->offset = var_info->offset;
 
@@ -1928,9 +1973,20 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
-	return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
 				       msm_host->bulk_clks);
+	if (ret)
+		return ret;
+	/*
+	 * Whenever core-clock is gated dynamically, it's needed to
+	 * restore the SDR DLL settings when the clock is ungated.
+	 */
+	if (msm_host->restore_dll_config && msm_host->clk_rate)
+		return sdhci_msm_restore_sdr_dll_config(host);
+
+	return 0;
 }
 #endif
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
