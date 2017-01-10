From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RESEND PATCHv1 2/8] mmc: sdhci-msm: Factor out function to set/get msm clock rate
Date: Tue, 10 Jan 2017 12:30:46 +0530
Message-ID: <1484031652-12059-3-git-send-email-riteshh@codeaurora.org>
References: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Factor out msm_set/get_clock_rate_for_bus_mode for it's later
use in changing the tuning sequence for selecting HS400
bus speed mode.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 64 +++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 1e42647..3fc496e 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -138,6 +138,45 @@ struct sdhci_msm_host {
 	bool use_cdclp533;
 };
 
+static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
+						    unsigned int clock)
+{
+	struct mmc_ios ios = host->mmc->ios;
+	/*
+	 * The SDHC requires internal clock frequency to be double the
+	 * actual clock that will be set for DDR mode. The controller
+	 * uses the faster clock(100/400MHz) for some of its parts and
+	 * send the actual required clock (50/200MHz) to the card.
+	 */
+	if (ios.timing == MMC_TIMING_UHS_DDR50 ||
+	    ios.timing == MMC_TIMING_MMC_DDR52 ||
+	    ios.timing == MMC_TIMING_MMC_HS400)
+		clock *= 2;
+	return clock;
+}
+
+static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
+					    unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_ios curr_ios = host->mmc->ios;
+	int rc;
+
+	clock = msm_get_clock_rate_for_bus_mode(host, clock);
+	rc = clk_set_rate(msm_host->clk, clock);
+	if (rc) {
+		pr_err("%s: Failed to set clock at rate %u at timing %d\n",
+		       mmc_hostname(host->mmc), clock,
+		       curr_ios.timing);
+		return;
+	}
+	msm_host->clk_rate = clock;
+	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
+		 mmc_hostname(host->mmc), clk_get_rate(msm_host->clk),
+		 curr_ios.timing);
+}
+
 /* Platform specific tuning */
 static inline int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
 {
@@ -1006,8 +1045,6 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
-	struct mmc_ios curr_ios = host->mmc->ios;
-	int rc;
 
 	if (!clock) {
 		msm_host->clk_rate = clock;
@@ -1015,32 +1052,11 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	spin_unlock_irq(&host->lock);
-	/*
-	 * The SDHC requires internal clock frequency to be double the
-	 * actual clock that will be set for DDR mode. The controller
-	 * uses the faster clock(100/400MHz) for some of its parts and
-	 * send the actual required clock (50/200MHz) to the card.
-	 */
-	if (curr_ios.timing == MMC_TIMING_UHS_DDR50 ||
-	    curr_ios.timing == MMC_TIMING_MMC_DDR52 ||
-	    curr_ios.timing == MMC_TIMING_MMC_HS400)
-		clock *= 2;
 
 	sdhci_msm_hc_select_mode(host);
 
-	rc = clk_set_rate(msm_host->clk, clock);
-	if (rc) {
-		pr_err("%s: Failed to set clock at rate %u at timing %d\n",
-		       mmc_hostname(host->mmc), clock,
-		       curr_ios.timing);
-		goto out_lock;
-	}
-	msm_host->clk_rate = clock;
-	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
-		 mmc_hostname(host->mmc), clk_get_rate(msm_host->clk),
-		 curr_ios.timing);
+	msm_set_clock_rate_for_bus_mode(host, clock);
 
-out_lock:
 	spin_lock_irq(&host->lock);
 out:
 	__sdhci_msm_set_clock(host, clock);
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
