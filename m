From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v7 09/14] mmc: sdhci-msm: Add clock changes for DDR mode.
Date: Mon, 14 Nov 2016 11:30:43 +0530
Message-ID: <1479103248-9491-10-git-send-email-riteshh@codeaurora.org>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479103248-9491-1-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, kdorfman-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

SDHC MSM controller need 2x clock for MCLK at GCC.
Hence make required changes to have 2x clock for
DDR timing modes.

Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/host/sdhci-msm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b96a4a7..41a4ea7 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -637,6 +637,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_ios curr_ios = host->mmc->ios;
 	int rc;
 
 	if (!clock) {
@@ -645,11 +646,23 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	spin_unlock_irq(&host->lock);
+	/*
+	 * The SDHC requires internal clock frequency to be double the
+	 * actual clock that will be set for DDR mode. The controller
+	 * uses the faster clock(100/400MHz) for some of its parts and
+	 * send the actual required clock (50/200MHz) to the card.
+	 */
+	if ((curr_ios.timing == MMC_TIMING_UHS_DDR50) ||
+	    (curr_ios.timing == MMC_TIMING_MMC_DDR52) ||
+	    (curr_ios.timing == MMC_TIMING_MMC_HS400))
+		clock *= 2;
+
 	if (clock != msm_host->clk_rate) {
 		rc = clk_set_rate(msm_host->clk, clock);
 		if (rc) {
-			pr_err("%s: Failed to set clock at rate %u\n",
-			       mmc_hostname(host->mmc), clock);
+			pr_err("%s: Failed to set clock at rate %u at timing %d\n",
+			       mmc_hostname(host->mmc), clock,
+			       curr_ios.timing);
 			spin_lock_irq(&host->lock);
 			goto out;
 		}
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
