From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RFC 3/4] mmc: sdhci-msm: Change the desc_sz on cqe_enable/disable.
Date: Wed, 30 Aug 2017 18:34:10 +0530
Message-ID: <1504098251-27739-4-git-send-email-riteshh@codeaurora.org>
References: <1504098251-27739-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58800 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdH3NEn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2017 09:04:43 -0400
In-Reply-To: <1504098251-27739-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, asutoshd@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

When CMDQ is halted the HW expects descriptor size to
be same which is using in CMDQ mode.
Thus adjust the desc_sz of sdhci accordingly.

Without this patch below command gives ADMA error
when CQE is enabled.
cat /sys/kernel/debug/mmc0/mmc0:0001/ext_csd

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 346cdfb..baa3409 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1111,9 +1111,29 @@ static u32 sdhci_msm_cqe_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
+void sdhci_msm_cqe_enable(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->flags & SDHCI_USE_64_BIT_DMA)
+		host->desc_sz = 12;
+
+	sdhci_cqe_enable(mmc);
+}
+
+void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->flags & SDHCI_USE_64_BIT_DMA)
+		host->desc_sz = 16;
+
+	sdhci_cqe_disable(mmc, recovery);
+}
+
 static const struct cqhci_host_ops sdhci_msm_cqhci_ops = {
-	.enable		= sdhci_cqe_enable,
-	.disable	= sdhci_cqe_disable,
+	.enable		= sdhci_msm_cqe_enable,
+	.disable	= sdhci_msm_cqe_disable,
 };
 
 #ifdef CONFIG_MMC_CQHCI
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

