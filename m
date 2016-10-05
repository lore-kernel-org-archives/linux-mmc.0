From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v5 08/12] mmc: sdhci-msm: Add clock changes for DDR mode.
Date: Wed,  5 Oct 2016 20:10:36 +0530
Message-ID: <1475678440-3525-9-git-send-email-riteshh@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com
Cc: david.brown@linaro.org, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, sboyd@codeaurora.org, bjorn.andersson@linaro.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

SDHC MSM controller need 2x clock for MCLK at GCC.
Hence make required changes to have 2x clock for
DDR timing modes.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9d18cf0..eb1a9e3 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -669,6 +669,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_ios curr_ios = host->mmc->ios;
 	u32 msm_clock;
 	int rc;
 
@@ -676,15 +677,29 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 		goto out;
 
 	spin_unlock_irq(&host->lock);
-	if ((clock != msm_host->clk_rate) && msm_host->clk_table) {
-		msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
+	if (((curr_ios.timing == MMC_TIMING_UHS_DDR50) ||
+		(curr_ios.timing == MMC_TIMING_MMC_DDR52) ||
+		(curr_ios.timing == MMC_TIMING_MMC_HS400)) &&
+		msm_host->clk_table) {
+		/*
+		 * The SDHC requires internal clock frequency to be double the
+		 * actual clock that will be set for DDR mode. The controller
+		 * uses the faster clock(100/400MHz) for some of its parts and
+		 * send the actual required clock (50/200MHz) to the card.
+		 */
+		clock *= 2;
+	}
+	msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
+
+	if ((msm_clock != msm_host->clk_rate) && msm_host->clk_table) {
 		rc = clk_set_rate(msm_host->clk, msm_clock);
 		if (rc) {
-			pr_err("%s: failed to set clock at rate %u, requested clock rate %u\n",
-				mmc_hostname(host->mmc), msm_clock, clock);
+			pr_err("%s: failed to set clock at rate %u at timing %d\n",
+				mmc_hostname(host->mmc), msm_clock,
+				curr_ios.timing);
 			goto out;
 		}
-		msm_host->clk_rate = clock;
+		msm_host->clk_rate = msm_clock;
 		pr_debug("%s: setting clock at rate %lu\n",
 			mmc_hostname(host->mmc), clk_get_rate(msm_host->clk));
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
