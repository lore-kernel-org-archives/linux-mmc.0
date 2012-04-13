From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 1/4] mmc: queue: rename mmc_request function
Date: Fri, 13 Apr 2012 17:54:11 +0530
Message-ID: <1334319854-5989-2-git-send-email-svenkatr@ti.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39167 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab2DMMYp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Apr 2012 08:24:45 -0400
In-Reply-To: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>

The name mmc_request is used for both the issue function
and a data structure, which creates conflicts in symbol lookups
in editors. Rename the function to mmc_request_fn

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/card/queue.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 996f8e3..49af43c 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -96,7 +96,7 @@ static int mmc_queue_thread(void *d)
  * on any queue on this host, and attempt to issue it.  This may
  * not be the queue we were asked to process.
  */
-static void mmc_request(struct request_queue *q)
+static void mmc_request_fn(struct request_queue *q)
 {
 	struct mmc_queue *mq = q->queuedata;
 	struct request *req;
@@ -171,7 +171,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		limit = *mmc_dev(host)->dma_mask;
 
 	mq->card = card;
-	mq->queue = blk_init_queue(mmc_request, lock);
+	mq->queue = blk_init_queue(mmc_request_fn, lock);
 	if (!mq->queue)
 		return -ENOMEM;
 
-- 
1.7.10.rc2

