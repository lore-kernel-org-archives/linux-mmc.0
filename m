From: Ritesh Harjani <rharjani@qti.qualcomm.com>
Subject: [RFC 1/4] mmc: cqhci: Move CQHCI_ENABLE before setting TDLBA/TDLBAU
Date: Wed, 30 Aug 2017 18:29:56 +0530
Message-ID: <1504097999-27355-2-git-send-email-rharjani@qti.qualcomm.com>
References: <1504097999-27355-1-git-send-email-rharjani@qti.qualcomm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504097999-27355-1-git-send-email-rharjani@qti.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, asutoshd@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Ritesh Harjani <riteshh@codeaurora.org>

Without this patch the CQHCI registers are getting reset
again.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/cqhci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 8650a13..2a7351c 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -262,6 +262,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 
 	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
 
+	cqcfg |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
 	cqhci_writel(cq_host, lower_32_bits(cq_host->desc_dma_base),
 		     CQHCI_TDLBA);
 	cqhci_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
@@ -271,10 +274,6 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 
 	cqhci_set_irqs(cq_host, 0);
 
-	cqcfg |= CQHCI_ENABLE;
-
-	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-
 	mmc->cqe_on = true;
 
 	if (cq_host->ops->enable)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
