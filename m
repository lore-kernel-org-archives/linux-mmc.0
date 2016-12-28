From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 6/8] mmc: sdhci: Clear SDHCI_HS400_TUNING flag after platform_execute_tuning
Date: Wed, 28 Dec 2016 16:36:29 +0530
Message-ID: <1482923191-17362-7-git-send-email-riteshh@codeaurora.org>
References: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Clear SDHCI_HS400_TUNING flag after platform_execute_tuning
so that platform_execute_tuning may use it if needed.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2390980..2658f89 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2114,7 +2114,6 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	spin_lock_irqsave(&host->lock, flags);
 
 	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
-	host->flags &= ~SDHCI_HS400_TUNING;
 
 	if (host->tuning_mode == SDHCI_TUNING_MODE_1)
 		tuning_count = host->tuning_count;
@@ -2156,7 +2155,9 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	if (host->ops->platform_execute_tuning) {
 		spin_unlock_irqrestore(&host->lock, flags);
-		return host->ops->platform_execute_tuning(host, opcode);
+		err = host->ops->platform_execute_tuning(host, opcode);
+		spin_lock_irqsave(&host->lock, flags);
+		goto out_unlock;
 	}
 
 	host->mmc->retune_period = tuning_count;
@@ -2167,6 +2168,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	sdhci_end_tuning(host);
 out_unlock:
+	host->flags &= ~SDHCI_HS400_TUNING;
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	return err;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
