From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 7/8] mmc: sdhci-msm: Make HS400 tuning follow as per recommeneded HW sequence
Date: Wed, 28 Dec 2016 16:36:30 +0530
Message-ID: <1482923191-17362-8-git-send-email-riteshh@codeaurora.org>
References: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

During tuning execution for HS400 mode, HW sequence recommends
to select MCLK_SEL/2(0x3) in VENDOR_SPEC & sdhc msm clock at GCC
to be 400MHZ (nearest supported clk). Add this change in tuning
sequence during HS400 tuning.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 84d29dd..fa9bce3 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -151,7 +151,8 @@ static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
 	 */
 	if (ios.timing == MMC_TIMING_UHS_DDR50 ||
 	    ios.timing == MMC_TIMING_MMC_DDR52 ||
-	    ios.timing == MMC_TIMING_MMC_HS400)
+	    ios.timing == MMC_TIMING_MMC_HS400 ||
+	    host->flags & SDHCI_HS400_TUNING)
 		clock *= 2;
 	return clock;
 }
@@ -611,7 +612,8 @@ void sdhci_msm_hc_select_mode(struct sdhci_host *host)
 {
 	struct mmc_ios ios = host->mmc->ios;
 
-	if (ios.timing == MMC_TIMING_MMC_HS400)
+	if (ios.timing == MMC_TIMING_MMC_HS400 ||
+	    host->flags & SDHCI_HS400_TUNING)
 		msm_hc_select_hs400(host);
 	else
 		msm_hc_select_default(host);
@@ -831,6 +833,16 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 	    ios.timing == MMC_TIMING_UHS_SDR104))
 		return 0;
 
+	/*
+	 * For HS400 tuning in HS200 timing requires:
+	 * - select MCLK/2 in VENDOR_SPEC
+	 * - program MCLK to 400MHz (or nearest supported) in GCC
+	 */
+	if (host->flags & SDHCI_HS400_TUNING) {
+		sdhci_msm_hc_select_mode(host);
+		msm_set_clock_rate_for_bus_mode(host, ios.clock);
+	}
+
 retry:
 	/* First of all reset the tuning block */
 	rc = msm_init_cm_dll(host);
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
