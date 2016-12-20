From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 4/4] mmc: sdhci-msm: provide enhanced_strobe mode feature support
Date: Tue, 20 Dec 2016 11:23:19 +0530
Message-ID: <1482213199-29152-5-git-send-email-riteshh@codeaurora.org>
References: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This provide support for enhanced_strobe feature to sdhci-msm.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 32879b8..d092a16 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -102,6 +102,7 @@
 
 #define CORE_DDR_200_CFG		0x184
 #define CORE_CDC_T4_DLY_SEL		BIT(0)
+#define CORE_CMDIN_RCLK_EN		BIT(1)
 #define CORE_START_CDC_TRAFFIC		BIT(6)
 #define CORE_VENDOR_SPEC3	0x1b0
 #define CORE_PWRSAVE_DLL	BIT(3)
@@ -579,6 +580,7 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
 
 static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
 {
+	struct mmc_host *mmc = host->mmc;
 	u32 dll_status, config;
 	int ret;
 
@@ -593,6 +595,12 @@ static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
 	 */
 	writel_relaxed(DDR_CONFIG_POR_VAL, host->ioaddr + CORE_DDR_CONFIG);
 
+	if (mmc->ios.enhanced_strobe) {
+		config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
+		config |= CORE_CMDIN_RCLK_EN;
+		writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
+	}
+
 	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
 	config |= CORE_DDR_CAL_EN;
 	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
@@ -627,6 +635,7 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_host *mmc = host->mmc;
 	int ret;
 	u32 config;
 
@@ -640,14 +649,17 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	if (ret)
 		goto out;
 
-	/* Set the selected phase in delay line hw block */
-	ret = msm_config_cm_dll_phase(host, msm_host->saved_tuning_phase);
-	if (ret)
-		goto out;
+	if (!mmc->ios.enhanced_strobe) {
+		/* Set the selected phase in delay line hw block */
+		ret = msm_config_cm_dll_phase(host,
+					      msm_host->saved_tuning_phase);
+		if (ret)
+			goto out;
+		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+		config |= CORE_CMD_DAT_TRACK_SEL;
+		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	}
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
-	config |= CORE_CMD_DAT_TRACK_SEL;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 	if (msm_host->use_cdclp533)
 		ret = sdhci_msm_cdclp533_calibration(host);
 	else
@@ -802,7 +814,8 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 	spin_unlock_irq(&host->lock);
 	/* CDCLP533 HW calibration is only required for HS400 mode*/
 	if (host->clock > CORE_FREQ_100MHZ &&
-	    msm_host->tuning_done && !msm_host->calibration_done &&
+	    (msm_host->tuning_done || mmc->ios.enhanced_strobe) &&
+	    !msm_host->calibration_done &&
 	    mmc->ios.timing == MMC_TIMING_MMC_HS400)
 		if (!sdhci_msm_hs400_dll_calibration(host))
 			msm_host->calibration_done = true;
@@ -941,7 +954,8 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 		 * Select HS400 mode using the HC_SELECT_IN from VENDOR SPEC
 		 * register
 		 */
-		if (msm_host->tuning_done && !msm_host->calibration_done) {
+		if ((msm_host->tuning_done || curr_ios.enhanced_strobe) &&
+		    !msm_host->calibration_done) {
 			/*
 			 * Write 0x6 to HC_SELECT_IN and 1 to HC_SELECT_IN_EN
 			 * field in VENDOR_SPEC_FUNC
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
