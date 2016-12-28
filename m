From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 3/8] mmc: sdhci-msm: Factor out sdhci_msm_hs400
Date: Wed, 28 Dec 2016 16:36:26 +0530
Message-ID: <1482923191-17362-4-git-send-email-riteshh@codeaurora.org>
References: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbcL1LHV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Dec 2016 06:07:21 -0500
In-Reply-To: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

Factor out sdhci_msm_hs400 used for DLL calibration in HS400
modes. This function will be needed for enhanced_strobe as well.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3fc496e..5a37c29 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -884,6 +884,28 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return rc;
 }
 
+/*
+ * sdhci_msm_hs400 - Calibrate the DLL for HS400 bus speed mode operation.
+ * DLL operation is only needed for clock > 100MHz. For clock <= 100MHz
+ * fixed feedback clock is used.
+ */
+static void sdhci_msm_hs400(struct sdhci_host *host, struct mmc_ios *ios)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	if (host->clock > CORE_FREQ_100MHZ &&
+	    msm_host->tuning_done && !msm_host->calibration_done) {
+		ret = sdhci_msm_hs400_dll_calibration(host);
+		if (!ret)
+			msm_host->calibration_done = true;
+		else
+			pr_err("%s: Failed to calibrate DLL for hs400 mode (%d)\n",
+			       mmc_hostname(host->mmc), ret);
+	}
+}
+
 static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 					unsigned int uhs)
 {
@@ -952,12 +974,10 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 
 	spin_unlock_irq(&host->lock);
-	/* CDCLP533 HW calibration is only required for HS400 mode*/
-	if (host->clock > CORE_FREQ_100MHZ &&
-	    msm_host->tuning_done && !msm_host->calibration_done &&
-	    mmc->ios.timing == MMC_TIMING_MMC_HS400)
-		if (!sdhci_msm_hs400_dll_calibration(host))
-			msm_host->calibration_done = true;
+
+	if (mmc->ios.timing == MMC_TIMING_MMC_HS400)
+		sdhci_msm_hs400(host, &mmc->ios);
+
 	spin_lock_irq(&host->lock);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

