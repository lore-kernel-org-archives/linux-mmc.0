From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH 1/2] mmc: v4.14: Fix null pointer dereference in mmc_init_request
Date: Wed,  8 May 2019 12:58:32 -0600
Message-ID: <20190508185833.187068-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

It is possible for queuedata to be cleared in mmc_cleanup_queue before
the request has been started. This will result in dereferencing a null
pointer.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I think we should cherry-pick 41e3efd07d5a02c80f503e29d755aa1bbb4245de
https://lore.kernel.org/patchwork/patch/856512/ into 4.14. It fixes a
potential resource leak when shutting down the request queue. Once this
patch is applied, there is a potential for a null pointer dereference.
That's what this patch fixes. The next patch is just an optimization to
stop processing earlier.

See https://patchwork.kernel.org/patch/10925469/ for the initial
motivation.

This commit applies to v4.14.116.

This doesn't apply to 5.1 since mmc has been migrated to blk-mq.

Thanks,
Raul

 drivers/mmc/core/queue.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 0a4e77a5ba33..4bf1a9c6440b 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -159,8 +159,14 @@ static int mmc_init_request(struct request_queue *q, struct request *req,
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
 	struct mmc_queue *mq = q->queuedata;
-	struct mmc_card *card = mq->card;
-	struct mmc_host *host = card->host;
+	struct mmc_card *card;
+	struct mmc_host *host;
+
+	if (!mq)
+		return -ENODEV;
+
+	card = mq->card;
+	host = card->host;
 
 	mq_rq->sg = mmc_alloc_sg(host->max_segs, gfp);
 	if (!mq_rq->sg)
-- 
2.21.0.1020.gf2820cf01a-goog
