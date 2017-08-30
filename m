From: Ritesh Harjani <rharjani@qti.qualcomm.com>
Subject: [RFC 4/4] mmc: sdhci-msm: Handle unexpected interrupt case on enabling legacy IRQs on CQE halt
Date: Wed, 30 Aug 2017 18:29:59 +0530
Message-ID: <1504097999-27355-5-git-send-email-rharjani@qti.qualcomm.com>
References: <1504097999-27355-1-git-send-email-rharjani@qti.qualcomm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504097999-27355-1-git-send-email-rharjani@qti.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, asutoshd@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Ritesh Harjani <riteshh@codeaurora.org>

There is a case when enabling the legacy IRQs and halting CQE is
resuling into a command response interrupt without any command in
progress. This patch handles such case here.

Error signature without this patch:-
mmc0: Got command interrupt 0x00000001 even though no command operation
was in progress.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index baa3409..8fdc2c0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1124,10 +1124,21 @@ void sdhci_msm_cqe_enable(struct mmc_host *mmc)
 void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	u32 ctrl;
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA)
 		host->desc_sz = 16;
 
+	spin_lock_irqsave(&host->lock, flags);
+
+	ctrl = sdhci_readl(host, SDHCI_INT_ENABLE);
+	ctrl |= SDHCI_INT_RESPONSE;
+	sdhci_writel(host,  ctrl, SDHCI_INT_ENABLE);
+	sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	sdhci_cqe_disable(mmc, recovery);
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
