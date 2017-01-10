From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RESEND PATCHv1 1/8] mmc: sdhci-msm: Factor out sdhci_msm_hc_select_mode
Date: Tue, 10 Jan 2017 12:30:45 +0530
Message-ID: <1484031652-12059-2-git-send-email-riteshh@codeaurora.org>
References: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This factors out sdhci_msm_hc_select_mode to later use
it during enhanced_strobe mode select.
It also further breaks sdhci_msm_hc_select_mode
into separate functions for configuring HS400 mode
or other modes.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 201 ++++++++++++++++++++++++-------------------
 1 file changed, 114 insertions(+), 87 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 32879b8..1e42647 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -464,6 +464,119 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	return 0;
 }
 
+static void msm_hc_select_default(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	u32 config;
+
+	if (!msm_host->use_cdclp533) {
+		config = readl_relaxed(host->ioaddr +
+				CORE_VENDOR_SPEC3);
+		config &= ~CORE_PWRSAVE_DLL;
+		writel_relaxed(config, host->ioaddr +
+				CORE_VENDOR_SPEC3);
+	}
+
+	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+	config &= ~CORE_HC_MCLK_SEL_MASK;
+	config |= CORE_HC_MCLK_SEL_DFLT;
+	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+
+	/*
+	 * Disable HC_SELECT_IN to be able to use the UHS mode select
+	 * configuration from Host Control2 register for all other
+	 * modes.
+	 * Write 0 to HC_SELECT_IN and HC_SELECT_IN_EN field
+	 * in VENDOR_SPEC_FUNC
+	 */
+	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+	config &= ~CORE_HC_SELECT_IN_EN;
+	config &= ~CORE_HC_SELECT_IN_MASK;
+	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+
+	/*
+	 * Make sure above writes impacting free running MCLK are completed
+	 * before changing the clk_rate at GCC.
+	 */
+	wmb();
+}
+
+static void msm_hc_select_hs400(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	u32 config, dll_lock;
+	int rc;
+
+	/* Select the divided clock (free running MCLK/2) */
+	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+	config &= ~CORE_HC_MCLK_SEL_MASK;
+	config |= CORE_HC_MCLK_SEL_HS400;
+
+	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+	/*
+	 * Select HS400 mode using the HC_SELECT_IN from VENDOR SPEC
+	 * register
+	 */
+	if (msm_host->tuning_done && !msm_host->calibration_done) {
+		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+		config |= CORE_HC_SELECT_IN_HS400;
+		config |= CORE_HC_SELECT_IN_EN;
+		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+	}
+	if (!msm_host->clk_rate && !msm_host->use_cdclp533) {
+		/*
+		 * Poll on DLL_LOCK or DDR_DLL_LOCK bits in
+		 * CORE_DLL_STATUS to be set.  This should get set
+		 * within 15 us at 200 MHz.
+		 */
+		rc = readl_relaxed_poll_timeout(host->ioaddr +
+						CORE_DLL_STATUS,
+						dll_lock,
+						(dll_lock &
+						(CORE_DLL_LOCK |
+						CORE_DDR_DLL_LOCK)), 10,
+						1000);
+		if (rc == -ETIMEDOUT)
+			pr_err("%s: Unable to get DLL_LOCK/DDR_DLL_LOCK, dll_status: 0x%08x\n",
+			       mmc_hostname(host->mmc), dll_lock);
+	}
+	/*
+	 * Make sure above writes impacting free running MCLK are completed
+	 * before changing the clk_rate at GCC.
+	 */
+	wmb();
+}
+
+/*
+ * sdhci_msm_hc_select_mode :- In general all timing modes are
+ * controlled via UHS mode select in Host Control2 register.
+ * eMMC specific HS200/HS400 doesn't have their respective modes
+ * defined here, hence we use these values.
+ *
+ * HS200 - SDR104 (Since they both are equivalent in functionality)
+ * HS400 - This involves multiple configurations
+ *		Initially SDR104 - when tuning is required as HS200
+ *		Then when switching to DDR @ 400MHz (HS400) we use
+ *		the vendor specific HC_SELECT_IN to control the mode.
+ *
+ * In addition to controlling the modes we also need to select the
+ * correct input clock for DLL depending on the mode.
+ *
+ * HS400 - divided clock (free running MCLK/2)
+ * All other modes - default (free running MCLK)
+ */
+void sdhci_msm_hc_select_mode(struct sdhci_host *host)
+{
+	struct mmc_ios ios = host->mmc->ios;
+
+	if (ios.timing == MMC_TIMING_MMC_HS400)
+		msm_hc_select_hs400(host);
+	else
+		msm_hc_select_default(host);
+}
+
 static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -894,7 +1007,6 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	struct mmc_ios curr_ios = host->mmc->ios;
-	u32 config, dll_lock;
 	int rc;
 
 	if (!clock) {
@@ -913,93 +1025,8 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	    curr_ios.timing == MMC_TIMING_MMC_DDR52 ||
 	    curr_ios.timing == MMC_TIMING_MMC_HS400)
 		clock *= 2;
-	/*
-	 * In general all timing modes are controlled via UHS mode select in
-	 * Host Control2 register. eMMC specific HS200/HS400 doesn't have
-	 * their respective modes defined here, hence we use these values.
-	 *
-	 * HS200 - SDR104 (Since they both are equivalent in functionality)
-	 * HS400 - This involves multiple configurations
-	 *		Initially SDR104 - when tuning is required as HS200
-	 *		Then when switching to DDR @ 400MHz (HS400) we use
-	 *		the vendor specific HC_SELECT_IN to control the mode.
-	 *
-	 * In addition to controlling the modes we also need to select the
-	 * correct input clock for DLL depending on the mode.
-	 *
-	 * HS400 - divided clock (free running MCLK/2)
-	 * All other modes - default (free running MCLK)
-	 */
-	if (curr_ios.timing == MMC_TIMING_MMC_HS400) {
-		/* Select the divided clock (free running MCLK/2) */
-		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
-		config &= ~CORE_HC_MCLK_SEL_MASK;
-		config |= CORE_HC_MCLK_SEL_HS400;
 
-		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
-		/*
-		 * Select HS400 mode using the HC_SELECT_IN from VENDOR SPEC
-		 * register
-		 */
-		if (msm_host->tuning_done && !msm_host->calibration_done) {
-			/*
-			 * Write 0x6 to HC_SELECT_IN and 1 to HC_SELECT_IN_EN
-			 * field in VENDOR_SPEC_FUNC
-			 */
-			config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
-			config |= CORE_HC_SELECT_IN_HS400;
-			config |= CORE_HC_SELECT_IN_EN;
-			writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
-		}
-		if (!msm_host->clk_rate && !msm_host->use_cdclp533) {
-			/*
-			 * Poll on DLL_LOCK or DDR_DLL_LOCK bits in
-			 * CORE_DLL_STATUS to be set.  This should get set
-			 * within 15 us at 200 MHz.
-			 */
-			rc = readl_relaxed_poll_timeout(host->ioaddr +
-							CORE_DLL_STATUS,
-							dll_lock,
-							(dll_lock &
-							(CORE_DLL_LOCK |
-							CORE_DDR_DLL_LOCK)), 10,
-							1000);
-			if (rc == -ETIMEDOUT)
-				pr_err("%s: Unable to get DLL_LOCK/DDR_DLL_LOCK, dll_status: 0x%08x\n",
-				       mmc_hostname(host->mmc), dll_lock);
-		}
-	} else {
-		if (!msm_host->use_cdclp533) {
-			config = readl_relaxed(host->ioaddr +
-					CORE_VENDOR_SPEC3);
-			config &= ~CORE_PWRSAVE_DLL;
-			writel_relaxed(config, host->ioaddr +
-					CORE_VENDOR_SPEC3);
-		}
-
-		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
-		config &= ~CORE_HC_MCLK_SEL_MASK;
-		config |= CORE_HC_MCLK_SEL_DFLT;
-		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
-
-		/*
-		 * Disable HC_SELECT_IN to be able to use the UHS mode select
-		 * configuration from Host Control2 register for all other
-		 * modes.
-		 * Write 0 to HC_SELECT_IN and HC_SELECT_IN_EN field
-		 * in VENDOR_SPEC_FUNC
-		 */
-		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
-		config &= ~CORE_HC_SELECT_IN_EN;
-		config &= ~CORE_HC_SELECT_IN_MASK;
-		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
-	}
-
-	/*
-	 * Make sure above writes impacting free running MCLK are completed
-	 * before changing the clk_rate at GCC.
-	 */
-	wmb();
+	sdhci_msm_hc_select_mode(host);
 
 	rc = clk_set_rate(msm_host->clk, clock);
 	if (rc) {
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
