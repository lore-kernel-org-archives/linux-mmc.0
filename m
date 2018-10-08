From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V2 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
Date: Mon,  8 Oct 2018 18:55:38 +0530
Message-ID: <1539005138-32560-3-git-send-email-vbadigan@codeaurora.org>
References: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc: asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On few SDHCI-MSM controllers, the host controller's clock tuning
circuit may go out of sync if controller clocks are gated which
eventually will result in data CRC, command CRC/timeout errors.
To overcome this h/w limitation, the DLL needs to be re-initialized
and restored with its old settings once clocks are ungated.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 67 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 6918e70..1eb70c0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -234,6 +234,7 @@ struct sdhci_msm_variant_ops {
  */
 struct sdhci_msm_variant_info {
 	bool mci_removed;
+	bool uses_sdcdc10;
 	const struct sdhci_msm_variant_ops *var_ops;
 	const struct sdhci_msm_offset *offset;
 };
@@ -264,6 +265,8 @@ struct sdhci_msm_host {
 	u32 vmmc_level[2];
 	bool vqmmc_load;
 	u32 vqmmc_level[2];
+	bool uses_sdcdc10_dll;
+	bool restore_sdr_dll_cfg;
 };
 
 static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
@@ -1031,6 +1034,36 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	return ret;
 }
 
+static int sdhci_msm_restore_sdr_dll_config(struct sdhci_host *host)
+{
+	struct mmc_ios ios = host->mmc->ios;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	/*
+	 * SDR DLL comes into picure only if clock frequency is greater than
+	 * 100MHz. And its needed only for SDR104, HS200 and HS400 cards.
+	 * Its not needed for HS400es cards.
+	 */
+	if (host->clock <= CORE_FREQ_100MHZ ||
+	    !(ios.timing == MMC_TIMING_MMC_HS400 ||
+	    ios.timing == MMC_TIMING_MMC_HS200 ||
+	    ios.timing == MMC_TIMING_UHS_SDR104) ||
+	    ios.enhanced_strobe)
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
@@ -1075,7 +1108,6 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		if (rc)
 			return rc;
 
-		msm_host->saved_tuning_phase = phase;
 		rc = mmc_send_tuning(mmc, opcode, NULL);
 		if (!rc) {
 			/* Tuning is successful at this tuning point */
@@ -1100,6 +1132,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		rc = msm_config_cm_dll_phase(host, phase);
 		if (rc)
 			return rc;
+		msm_host->saved_tuning_phase = phase;
 		dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
 			 mmc_hostname(mmc), phase);
 	} else {
@@ -1807,19 +1840,39 @@ static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
 
 static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
 	.mci_removed = false,
+	.uses_sdcdc10 = false,
+	.var_ops = &mci_var_ops,
+	.offset = &sdhci_msm_mci_offset,
+};
+
+static const struct sdhci_msm_variant_info sdhci_msm_mci_sdcdc10_var = {
+	.mci_removed = false,
+	.uses_sdcdc10 = true,
 	.var_ops = &mci_var_ops,
 	.offset = &sdhci_msm_mci_offset,
 };
 
 static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
 	.mci_removed = true,
+	.uses_sdcdc10 = false,
+	.var_ops = &v5_var_ops,
+	.offset = &sdhci_msm_v5_offset,
+};
+
+static const struct sdhci_msm_variant_info sdhci_msm_v5_sdcdc10_var = {
+	.mci_removed = true,
+	.uses_sdcdc10 = true,
 	.var_ops = &v5_var_ops,
 	.offset = &sdhci_msm_v5_offset,
 };
 
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,sdhci-msm-v4-sdcdc10",
+					    .data = &sdhci_msm_mci_sdcdc10_var},
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sdhci-msm-v5-sdcdc10",
+					    .data = &sdhci_msm_v5_sdcdc10_var},
 	{},
 };
 
@@ -1880,6 +1933,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	var_info = of_device_get_match_data(&pdev->dev);
 
 	msm_host->mci_removed = var_info->mci_removed;
+	msm_host->uses_sdcdc10_dll = var_info->uses_sdcdc10;
 	msm_host->var_ops = var_info->var_ops;
 	msm_host->offset = var_info->offset;
 
@@ -2124,9 +2178,18 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
-	return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
 				       msm_host->bulk_clks);
+	/*
+	 * Whenever core-clock is gated dynamically, it's needed to
+	 * restore the SDR DLL settings when the clock is ungated.
+	 */
+	if (!ret && msm_host->uses_sdcdc10_dll && msm_host->clk_rate)
+		ret = sdhci_msm_restore_sdr_dll_config(host);
+
+	return ret;
 }
 #endif
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
