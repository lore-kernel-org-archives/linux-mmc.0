From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1] mmc: cqhci: DMA Configuration prior to CQE
Date: Fri, 14 Dec 2018 10:21:55 -0800
Message-ID: <1544811715-23792-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

eMMC-5.1 JESD85-B51 Spec (Section 6.6.39), mentions DMA selection
and DMA Block size configuration on SDHCI Host need to be done
prior to enabling Command Queue Engine.

This patch fixes the sequence to follow the spec.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 159270e947cf..f701342e7212 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -248,6 +248,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
 	}
 
+	if (cq_host->ops->enable)
+		cq_host->ops->enable(mmc);
+
 	cqcfg &= ~(CQHCI_DCMD | CQHCI_TASK_DESC_SZ);
 
 	if (mmc->caps2 & MMC_CAP2_CQE_DCMD)
@@ -273,9 +276,6 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 
 	mmc->cqe_on = true;
 
-	if (cq_host->ops->enable)
-		cq_host->ops->enable(mmc);
-
 	/* Ensure all writes are done before interrupts are enabled */
 	wmb();
 
@@ -561,6 +561,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	int tag = cqhci_tag(mrq);
 	struct cqhci_host *cq_host = mmc->cqe_private;
 	unsigned long flags;
+	u32 cqcfg = 0;
 
 	if (!cq_host->enabled) {
 		pr_err("%s: cqhci: not enabled\n", mmc_hostname(mmc));
@@ -579,8 +580,19 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
+		/* Configuration must not be changed while enabled */
+		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+		if (cqcfg & CQHCI_ENABLE) {
+			cqcfg &= ~CQHCI_ENABLE;
+			cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+		}
+
 		if (cq_host->ops->enable)
 			cq_host->ops->enable(mmc);
+
+		cqcfg |= CQHCI_ENABLE;
+		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
 	}
 
 	if (mrq->data) {
-- 
2.7.4
