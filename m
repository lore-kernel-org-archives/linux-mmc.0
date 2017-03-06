From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V1 07/18] mmc: core: Factor out debug prints from mmc_start_request()
Date: Mon,  6 Mar 2017 11:11:02 +0200
Message-ID: <1488791473-24981-8-git-send-email-adrian.hunter@intel.com>
References: <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:33527 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753102AbdCFJRj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Mar 2017 04:17:39 -0500
In-Reply-To: <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

In preparation to reuse the code for CQE support.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 926e0fde07d7..6b063f0c2553 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -262,26 +262,19 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	host->ops->request(host, mrq);
 }
 
-static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
+static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq)
 {
-#ifdef CONFIG_MMC_DEBUG
-	unsigned int i, sz;
-	struct scatterlist *sg;
-#endif
-	mmc_retune_hold(host);
-
-	if (mmc_card_removed(host->card))
-		return -ENOMEDIUM;
-
 	if (mrq->sbc) {
 		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
 			 mmc_hostname(host), mrq->sbc->opcode,
 			 mrq->sbc->arg, mrq->sbc->flags);
 	}
 
-	pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
-		 mmc_hostname(host), mrq->cmd->opcode,
-		 mrq->cmd->arg, mrq->cmd->flags);
+	if (mrq->cmd) {
+		pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
+			 mmc_hostname(host), mrq->cmd->opcode, mrq->cmd->arg,
+			 mrq->cmd->flags);
+	}
 
 	if (mrq->data) {
 		pr_debug("%s:     blksz %d blocks %d flags %08x "
@@ -297,6 +290,20 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 			 mmc_hostname(host), mrq->stop->opcode,
 			 mrq->stop->arg, mrq->stop->flags);
 	}
+}
+
+static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
+{
+#ifdef CONFIG_MMC_DEBUG
+	unsigned int i, sz;
+	struct scatterlist *sg;
+#endif
+	mmc_retune_hold(host);
+
+	if (mmc_card_removed(host->card))
+		return -ENOMEDIUM;
+
+	mmc_mrq_pr_debug(host, mrq);
 
 	WARN_ON(!host->claimed);
 
-- 
1.9.1

