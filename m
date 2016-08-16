From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v2 7/8] mmc: sdhci-msm: Add clock changes for DDR mode.
Date: Tue, 16 Aug 2016 17:11:07 +0530
Message-ID: <1471347668-22978-8-git-send-email-riteshh@codeaurora.org>
References: <1471347668-22978-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33111 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbcHPLmM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Aug 2016 07:42:12 -0400
In-Reply-To: <1471347668-22978-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

SDHC MSM controller need 2x clock for MCLK at GCC.
Hence make required changes to have 2x clock for
DDR timing modes.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 1eb5074..e68f0c9 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -649,21 +649,35 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
-	u32 msm_clock = 0;
+	struct mmc_ios curr_ios = host->mmc->ios;
+	u32 msm_clock = clock, ddr_clock = 0;
 	int rc = 0;
 
 	if (!clock)
 		goto out;
 
-	if (clock != msm_host->clk_rate) {
-		msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
+	msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
+	if ((curr_ios.timing == MMC_TIMING_UHS_DDR50) ||
+		(curr_ios.timing == MMC_TIMING_MMC_DDR52) ||
+		(curr_ios.timing == MMC_TIMING_MMC_HS400)) {
+		/*
+		 * The SDHC requires internal clock frequency to be double the
+		 * actual clock that will be set for DDR mode. The controller
+		 * uses the faster clock(100/400MHz) for some of its parts and
+		 * send the actual required clock (50/200MHz) to the card.
+		 */
+		ddr_clock = clock * 2;
+		msm_clock = sdhci_msm_get_msm_clk_rate(host, ddr_clock);
+	}
+
+	if (msm_clock != msm_host->clk_rate) {
 		rc = clk_set_rate(msm_host->clk, msm_clock);
 		if (rc) {
 			pr_err("%s: failed to set clock at rate %u, requested clock rate %u\n",
 				mmc_hostname(host->mmc), msm_clock, clock);
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

