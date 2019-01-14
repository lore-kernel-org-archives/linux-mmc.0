From: Alamy Liu <alamy.liu@gmail.com>
Subject: [PATCH 2/2] mmc: cqhci: replace DCMD_SLOT with cq_host->dcmd_slot
Date: Mon, 14 Jan 2019 11:17:22 -0800
Message-ID: <20190114191724.29960-2-alamy.liu@gmail.com>
References: <20190114191724.29960-1-alamy.liu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114191724.29960-1-alamy.liu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alamy Liu <alamy.liu@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Prevent to use fixed value (DCMD_SLOT) after it had been determined
and saved in a variable (cq_host->dcmd).

Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
---
 drivers/mmc/host/cqhci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 26d63594b7..4cc7863c13 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -76,7 +76,8 @@ static void setup_trans_desc(struct cqhci_host *cq_host, u8 tag)
 	if (cq_host->link_desc_len > 8)
 		*(link_temp + 8) = 0;
 
-	if (tag == DCMD_SLOT && (cq_host->mmc->caps2 & MMC_CAP2_CQE_DCMD)) {
+	if ((tag == cq_host->dcmd_slot)
+	    && (cq_host->mmc->caps2 & MMC_CAP2_CQE_DCMD)) {
 		*link_temp = CQHCI_VALID(0) | CQHCI_ACT(0) | CQHCI_END(1);
 		return;
 	}
@@ -548,9 +549,9 @@ static void cqhci_post_req(struct mmc_host *host, struct mmc_request *mrq)
 	}
 }
 
-static inline int cqhci_tag(struct mmc_request *mrq)
+static inline int cqhci_tag(struct mmc_request *mrq, struct cqhci_host *cq_host)
 {
-	return mrq->cmd ? DCMD_SLOT : mrq->tag;
+	return mrq->cmd ? cq_host->dcmd_slot : mrq->tag;
 }
 
 static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -558,8 +559,8 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	int err = 0;
 	u64 data = 0;
 	u64 *task_desc = NULL;
-	int tag = cqhci_tag(mrq);
 	struct cqhci_host *cq_host = mmc->cqe_private;
+	int tag = cqhci_tag(mrq, cq_host);
 	unsigned long flags;
 
 	if (!cq_host->enabled) {
@@ -824,7 +825,7 @@ static bool cqhci_timeout(struct mmc_host *mmc, struct mmc_request *mrq,
 			  bool *recovery_needed)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
-	int tag = cqhci_tag(mrq);
+	int tag = cqhci_tag(mrq, cq_host);
 	struct cqhci_slot *slot = &cq_host->slot[tag];
 	unsigned long flags;
 	bool timed_out;
-- 
2.17.1
