From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 12/30] mmc: queue: Use queue depth to allocate and free
Date: Fri,  8 Jul 2016 13:22:53 +0300
Message-ID: <1467973391-29221-13-git-send-email-adrian.hunter@intel.com>
References: <1467973391-29221-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:45373 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360AbcGHK2R (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jul 2016 06:28:17 -0400
In-Reply-To: <1467973391-29221-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Instead of allocating resources for 2 slots in the queue, allow for an
arbitrary number.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/queue.c | 103 +++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 57 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 1a8e5d45f74d..dba991979a6b 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -186,86 +186,75 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
 					unsigned int bouncesz)
 {
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
-	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
-
-	mqrq_cur->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
-	if (!mqrq_cur->bounce_buf) {
-		pr_warn("%s: unable to allocate bounce cur buffer\n",
-			mmc_card_name(mq->card));
-		return false;
-	}
+	int i;
 
-	mqrq_prev->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
-	if (!mqrq_prev->bounce_buf) {
-		pr_warn("%s: unable to allocate bounce prev buffer\n",
-			mmc_card_name(mq->card));
-		kfree(mqrq_cur->bounce_buf);
-		mqrq_cur->bounce_buf = NULL;
-		return false;
+	for (i = 0; i < mq->qdepth; i++) {
+		mq->mqrq[i].bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
+		if (!mq->mqrq[i].bounce_buf)
+			goto out_err;
 	}
 
 	return true;
+
+out_err:
+	while (--i >= 0) {
+		kfree(mq->mqrq[i].bounce_buf);
+		mq->mqrq[i].bounce_buf = NULL;
+	}
+	pr_warn("%s: unable to allocate bounce buffers\n",
+		mmc_card_name(mq->card));
+	return false;
 }
 
 static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
 				      unsigned int bouncesz)
 {
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
-	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
-	int ret;
-
-	mqrq_cur->sg = mmc_alloc_sg(1, &ret);
-	if (ret)
-		return ret;
+	int i, ret;
 
-	mqrq_cur->bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
-	if (ret)
-		return ret;
-
-	mqrq_prev->sg = mmc_alloc_sg(1, &ret);
-	if (ret)
-		return ret;
+	for (i = 0; i < mq->qdepth; i++) {
+		mq->mqrq[i].sg = mmc_alloc_sg(1, &ret);
+		if (ret)
+			return ret;
 
-	mqrq_prev->bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
+		mq->mqrq[i].bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
 {
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
-	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
-	int ret;
+	int i, ret;
 
-	mqrq_cur->sg = mmc_alloc_sg(max_segs, &ret);
-	if (ret)
-		return ret;
+	for (i = 0; i < mq->qdepth; i++) {
+		mq->mqrq[i].sg = mmc_alloc_sg(max_segs, &ret);
+		if (ret)
+			return ret;
+	}
 
-	mqrq_prev->sg = mmc_alloc_sg(max_segs, &ret);
+	return 0;
+}
 
-	return ret;
+static void mmc_queue_req_free_bufs(struct mmc_queue_req *mqrq)
+{
+	kfree(mqrq->bounce_sg);
+	mqrq->bounce_sg = NULL;
+
+	kfree(mqrq->sg);
+	mqrq->sg = NULL;
+
+	kfree(mqrq->bounce_buf);
+	mqrq->bounce_buf = NULL;
 }
 
 static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
 {
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
-	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
-
-	kfree(mqrq_cur->bounce_sg);
-	mqrq_cur->bounce_sg = NULL;
-	kfree(mqrq_prev->bounce_sg);
-	mqrq_prev->bounce_sg = NULL;
-
-	kfree(mqrq_cur->sg);
-	mqrq_cur->sg = NULL;
-	kfree(mqrq_cur->bounce_buf);
-	mqrq_cur->bounce_buf = NULL;
-
-	kfree(mqrq_prev->sg);
-	mqrq_prev->sg = NULL;
-	kfree(mqrq_prev->bounce_buf);
-	mqrq_prev->bounce_buf = NULL;
+	int i;
+
+	for (i = 0; i < mq->qdepth; i++)
+		mmc_queue_req_free_bufs(&mq->mqrq[i]);
 }
 
 /**
-- 
1.9.1

