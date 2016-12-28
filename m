From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 8/8] mmc: sdhci-msm: Provide enhanced_strobe mode feature support
Date: Wed, 28 Dec 2016 16:36:31 +0530
Message-ID: <1482923191-17362-9-git-send-email-riteshh@codeaurora.org>
References: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This provides enhanced_strobe mode feature support in sdhci-msm
driver.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index fa9bce3..f958697 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -103,6 +103,7 @@
 
 #define CORE_DDR_200_CFG		0x184
 #define CORE_CDC_T4_DLY_SEL		BIT(0)
+#define CORE_CMDIN_RCLK_EN		BIT(1)
 #define CORE_START_CDC_TRAFFIC		BIT(6)
 #define CORE_VENDOR_SPEC3	0x1b0
 #define CORE_PWRSAVE_DLL	BIT(3)
@@ -547,6 +548,7 @@ static void msm_hc_select_hs400(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_ios ios = host->mmc->ios;
 	u32 config, dll_lock;
 	int rc;
 
@@ -560,7 +562,8 @@ static void msm_hc_select_hs400(struct sdhci_host *host)
 	 * Select HS400 mode using the HC_SELECT_IN from VENDOR SPEC
 	 * register
 	 */
-	if (msm_host->tuning_done && !msm_host->calibration_done) {
+	if ((msm_host->tuning_done || ios.enhanced_strobe) &&
+	    !msm_host->calibration_done) {
 		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
 		config |= CORE_HC_SELECT_IN_HS400;
 		config |= CORE_HC_SELECT_IN_EN;
@@ -734,6 +737,7 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
 
 static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
 {
+	struct mmc_host *mmc = host->mmc;
 	u32 dll_status, config;
 	int ret;
 
@@ -748,6 +752,12 @@ static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
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
@@ -782,6 +792,7 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_host *mmc = host->mmc;
 	int ret;
 	u32 config;
 
@@ -795,14 +806,17 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
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
@@ -899,6 +913,7 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 
 /*
  * sdhci_msm_hs400 - Calibrate the DLL for HS400 bus speed mode operation.
+ * This needs to be done for both tuning and enhanced_strobe mode.
  * DLL operation is only needed for clock > 100MHz. For clock <= 100MHz
  * fixed feedback clock is used.
  */
@@ -909,7 +924,8 @@ static void sdhci_msm_hs400(struct sdhci_host *host, struct mmc_ios *ios)
 	int ret;
 
 	if (host->clock > CORE_FREQ_100MHZ &&
-	    msm_host->tuning_done && !msm_host->calibration_done) {
+	    (msm_host->tuning_done || ios->enhanced_strobe) &&
+	    !msm_host->calibration_done) {
 		ret = sdhci_msm_hs400_dll_calibration(host);
 		if (!ret)
 			msm_host->calibration_done = true;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
