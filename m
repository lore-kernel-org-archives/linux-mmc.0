From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 02/25] mmc: queue: Factor out mmc_queue_alloc_bounce_bufs()
Date: Fri, 25 Nov 2016 12:06:59 +0200
Message-ID: <1480068442-5169-3-git-send-email-adrian.hunter@intel.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21734 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752415AbcKYKMf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Nov 2016 05:12:35 -0500
In-Reply-To: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

In preparation for supporting a queue of requests, factor out
mmc_queue_alloc_bounce_bufs().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/queue.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index c4ac4b8a1a98..ea8b01f76d55 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -186,6 +186,31 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
 }
 
+static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
+					unsigned int bouncesz)
+{
+	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
+	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
+
+	mqrq_cur->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
+	if (!mqrq_cur->bounce_buf) {
+		pr_warn("%s: unable to allocate bounce cur buffer\n",
+			mmc_card_name(mq->card));
+		return false;
+	}
+
+	mqrq_prev->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
+	if (!mqrq_prev->bounce_buf) {
+		pr_warn("%s: unable to allocate bounce prev buffer\n",
+			mmc_card_name(mq->card));
+		kfree(mqrq_cur->bounce_buf);
+		mqrq_cur->bounce_buf = NULL;
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -235,24 +260,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		if (bouncesz > (host->max_blk_count * 512))
 			bouncesz = host->max_blk_count * 512;
 
-		if (bouncesz > 512) {
-			mqrq_cur->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
-			if (!mqrq_cur->bounce_buf) {
-				pr_warn("%s: unable to allocate bounce cur buffer\n",
-					mmc_card_name(card));
-			} else {
-				mqrq_prev->bounce_buf =
-						kmalloc(bouncesz, GFP_KERNEL);
-				if (!mqrq_prev->bounce_buf) {
-					pr_warn("%s: unable to allocate bounce prev buffer\n",
-						mmc_card_name(card));
-					kfree(mqrq_cur->bounce_buf);
-					mqrq_cur->bounce_buf = NULL;
-				}
-			}
-		}
-
-		if (mqrq_cur->bounce_buf && mqrq_prev->bounce_buf) {
+		if (bouncesz > 512 &&
+		    mmc_queue_alloc_bounce_bufs(mq, bouncesz)) {
 			blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_ANY);
 			blk_queue_max_hw_sectors(mq->queue, bouncesz / 512);
 			blk_queue_max_segments(mq->queue, bouncesz / 512);
-- 
1.9.1

