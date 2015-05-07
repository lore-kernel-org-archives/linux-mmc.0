From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 13/14] mmc: block: Retry errored data requests when re-tuning is needed
Date: Thu,  7 May 2015 13:10:24 +0300
Message-ID: <1430993425-2777-14-git-send-email-adrian.hunter@intel.com>
References: <1430993425-2777-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52137 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbbEGKNJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 May 2015 06:13:09 -0400
In-Reply-To: <1430993425-2777-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Retry errored data requests when re-tuning is needed and
add a flag to struct mmc_blk_request so that the retry
is only done once.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 11 ++++++++++-
 drivers/mmc/card/queue.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 325ae1e..509fcca 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1195,6 +1195,7 @@ static int mmc_blk_err_check(struct mmc_card *card,
 						    mmc_active);
 	struct mmc_blk_request *brq = &mq_mrq->brq;
 	struct request *req = mq_mrq->req;
+	int need_retune = card->host->need_retune;
 	int ecc_err = 0, gen_err = 0;
 
 	/*
@@ -1262,6 +1263,12 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	}
 
 	if (brq->data.error) {
+		if (need_retune && !brq->retune_retry_done) {
+			pr_info("%s: retrying because a re-tune was needed\n",
+				req->rq_disk->disk_name);
+			brq->retune_retry_done = 1;
+			return MMC_BLK_RETRY;
+		}
 		pr_err("%s: error %d transferring data, sector %u, nr %u, cmd response %#x, card status %#x\n",
 		       req->rq_disk->disk_name, brq->data.error,
 		       (unsigned)blk_rq_pos(req),
@@ -1821,7 +1828,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request *brq = &mq->mqrq_cur->brq;
-	int ret = 1, disable_multi = 0, retry = 0, type;
+	int ret = 1, disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
 	struct mmc_queue_req *mq_rq;
 	struct request *req = rqc;
@@ -1905,6 +1912,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 				break;
 			goto cmd_abort;
 		case MMC_BLK_RETRY:
+			retune_retry_done = brq->retune_retry_done;
 			if (retry++ < 5)
 				break;
 			/* Fall through */
@@ -1967,6 +1975,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 				mmc_start_req(card->host,
 						&mq_rq->mmc_active, NULL);
 			}
+			mq_rq->brq.retune_retry_done = retune_retry_done;
 		}
 	} while (ret);
 
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 5752d50..7e27915 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -12,6 +12,7 @@ struct mmc_blk_request {
 	struct mmc_command	cmd;
 	struct mmc_command	stop;
 	struct mmc_data		data;
+	int			retune_retry_done;
 };
 
 enum mmc_packed_type {
-- 
1.9.1

