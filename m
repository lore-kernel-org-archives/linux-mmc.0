From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 14/15] mmc: block: Retry errored data requests when re-tuning is needed
Date: Fri, 27 Feb 2015 14:55:56 +0200
Message-ID: <1425041756-3438-1-git-send-email-adrian.hunter@intel.com>
References: <1422522030-17793-15-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48041 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbbB0M5x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Feb 2015 07:57:53 -0500
In-Reply-To: <1422522030-17793-15-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Retry errored data requests when re-tuning is needed and
add a flag to struct mmc_blk_request so that the retry
is only done once.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in V3:

	Only retry when there is an error

 drivers/mmc/card/block.c | 11 ++++++++++-
 drivers/mmc/card/queue.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 293e938..3baf7ea 100644
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

