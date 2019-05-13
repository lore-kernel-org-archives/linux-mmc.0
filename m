From: Raul E Rangel <rrangel@chromium.org>
Subject: [stable/4.14.y PATCH 2/3] mmc: Fix null pointer dereference in mmc_init_request
Date: Mon, 13 May 2019 11:55:20 -0600
Message-ID: <20190513175521.84955-3-rrangel@chromium.org>
References: <20190513175521.84955-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513175521.84955-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

It is possible for queuedata to be cleared in mmc_cleanup_queue before
the request has been started. This will result in dereferencing a null
pointer.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/core/queue.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index d99fa4e63033c..bd7d521d5ad9d 100644
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
