From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 2/6] mmc: core: always check the length of sglist with total data size
Date: Wed, 19 Jul 2017 15:55:45 +0800
Message-ID: <1500450949-206953-1-git-send-email-shawn.lin@rock-chips.com>
References: <1500450661-158463-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:50880 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbdGSH4N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jul 2017 03:56:13 -0400
In-Reply-To: <1500450661-158463-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

All the check within mmc_mrq_prep seems to be all-or-none
proposition, so it doesn't make sense to only check the
length of sglist only under the CONFIG_MMC_DEBUG context.
I'd prefer to always keep the check there unconditionally.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/core/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b311ec9..634f9ca 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -295,10 +295,8 @@ static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq)
 
 static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 {
-#ifdef CONFIG_MMC_DEBUG
-	unsigned int i, sz;
+	unsigned int i, sz = 0;
 	struct scatterlist *sg;
-#endif
 
 	if (mrq->cmd) {
 		mrq->cmd->error = 0;
@@ -314,13 +312,12 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 		    mrq->data->blocks > host->max_blk_count ||
 		    mrq->data->blocks * mrq->data->blksz > host->max_req_size)
 			return -EINVAL;
-#ifdef CONFIG_MMC_DEBUG
-		sz = 0;
+
 		for_each_sg(mrq->data->sg, sg, mrq->data->sg_len, i)
 			sz += sg->length;
 		if (sz != mrq->data->blocks * mrq->data->blksz)
 			return -EINVAL;
-#endif
+
 		mrq->data->error = 0;
 		mrq->data->mrq = mrq;
 		if (mrq->stop) {
-- 
1.9.1


