From: Raul E Rangel <rrangel@chromium.org>
Subject: [stable/4.14.y PATCH 3/3] mmc: Kill the request if the queuedata has been removed
Date: Mon, 13 May 2019 11:55:21 -0600
Message-ID: <20190513175521.84955-4-rrangel@chromium.org>
References: <20190513175521.84955-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513175521.84955-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

No reason to even try processing the request if the queue is shutting
down.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/core/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index bd7d521d5ad9d..e7ac7163fafa4 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -30,7 +30,7 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 {
 	struct mmc_queue *mq = q->queuedata;
 
-	if (mq && (mmc_card_removed(mq->card) || mmc_access_rpmb(mq)))
+	if (!mq || mmc_card_removed(mq->card) || mmc_access_rpmb(mq))
 		return BLKPREP_KILL;
 
 	req->rq_flags |= RQF_DONTPREP;
-- 
2.21.0.1020.gf2820cf01a-goog
