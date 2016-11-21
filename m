From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v9 11/16] mmc: sdhci-msm: Add clock changes for DDR mode.
Date: Mon, 21 Nov 2016 12:07:21 +0530
Message-ID: <1479710246-26676-12-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

SDHC MSM controller need 2x clock for MCLK at GCC.
Hence make required changes to have 2x clock for
DDR timing modes.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 00759ef..c50cee8 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -610,6 +610,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_ios curr_ios = host->mmc->ios;
 	int rc;
 
 	if (!clock) {
@@ -618,16 +619,28 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	spin_unlock_irq(&host->lock);
+	/*
+	 * The SDHC requires internal clock frequency to be double the
+	 * actual clock that will be set for DDR mode. The controller
+	 * uses the faster clock(100/400MHz) for some of its parts and
+	 * send the actual required clock (50/200MHz) to the card.
+	 */
+	if (curr_ios.timing == MMC_TIMING_UHS_DDR50 ||
+	    curr_ios.timing == MMC_TIMING_MMC_DDR52 ||
+	    curr_ios.timing == MMC_TIMING_MMC_HS400)
+		clock *= 2;
 
 	rc = clk_set_rate(msm_host->clk, clock);
 	if (rc) {
-		pr_err("%s: Failed to set clock at rate %u\n",
-		       mmc_hostname(host->mmc), clock);
+		pr_err("%s: Failed to set clock at rate %u at timing %d\n",
+		       mmc_hostname(host->mmc), clock,
+		       curr_ios.timing);
 		goto out_lock;
 	}
 	msm_host->clk_rate = clock;
-	pr_debug("%s: Setting clock at rate %lu\n",
-		 mmc_hostname(host->mmc), clk_get_rate(msm_host->clk));
+	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
+		 mmc_hostname(host->mmc), clk_get_rate(msm_host->clk),
+		 curr_ios.timing);
 
 out_lock:
 	spin_lock_irq(&host->lock);
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

