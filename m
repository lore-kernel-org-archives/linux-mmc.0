From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 12/22] mmc: core: Factor out mrq preparation from mmc_start_request()
Date: Mon, 13 Mar 2017 14:36:43 +0200
Message-ID: <1489408613-26915-13-git-send-email-adrian.hunter@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:21750 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753198AbdCMMnZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Mar 2017 08:43:25 -0400
In-Reply-To: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

In preparation to reuse the code for CQE support.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6b063f0c2553..ffc263283f54 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -292,23 +292,18 @@ static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq)
 	}
 }
 
-static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
+static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 {
 #ifdef CONFIG_MMC_DEBUG
 	unsigned int i, sz;
 	struct scatterlist *sg;
 #endif
-	mmc_retune_hold(host);
-
-	if (mmc_card_removed(host->card))
-		return -ENOMEDIUM;
-
-	mmc_mrq_pr_debug(host, mrq);
-
-	WARN_ON(!host->claimed);
 
-	mrq->cmd->error = 0;
-	mrq->cmd->mrq = mrq;
+	if (mrq->cmd) {
+		mrq->cmd->error = 0;
+		mrq->cmd->mrq = mrq;
+		mrq->cmd->data = mrq->data;
+	}
 	if (mrq->sbc) {
 		mrq->sbc->error = 0;
 		mrq->sbc->mrq = mrq;
@@ -325,8 +320,6 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 		if (sz != mrq->data->blocks * mrq->data->blksz)
 			return -EINVAL;
 #endif
-
-		mrq->cmd->data = mrq->data;
 		mrq->data->error = 0;
 		mrq->data->mrq = mrq;
 		if (mrq->stop) {
@@ -335,6 +328,27 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 			mrq->stop->mrq = mrq;
 		}
 	}
+
+	return 0;
+}
+
+static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
+{
+	int err;
+
+	mmc_retune_hold(host);
+
+	if (mmc_card_removed(host->card))
+		return -ENOMEDIUM;
+
+	mmc_mrq_pr_debug(host, mrq);
+
+	WARN_ON(!host->claimed);
+
+	err = mmc_mrq_prep(host, mrq);
+	if (err)
+		return err;
+
 	led_trigger_event(host->led, LED_FULL);
 	__mmc_start_request(host, mrq);
 
-- 
1.9.1

