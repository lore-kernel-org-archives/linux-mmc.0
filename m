From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2] mmc: queue: exclude asynchronous transfer for special
 request
Date: Wed, 26 Dec 2012 10:40:17 +0900
Message-ID: <000701cde309$f5ed8fd0$e1c8af70$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45897 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab2LZBkU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Dec 2012 20:40:20 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MFM00KR17ANDXE0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 26 Dec 2012 10:40:18 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MFM00KRV7B6IBG0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 26 Dec 2012 10:40:18 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Per Forlin' <per.forlin@linaro.org>, 'Konstantin Dorfman' <kdorfman@codeaurora.org>

Unlike normal r/w request, special requests(discard, flush)
is finished with a one-time issue_fn. Request change to
mqrq_prev makes unnecessary call.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/card/queue.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index fadf52e..c7e8716 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -24,6 +24,8 @@
 
 #define MMC_QUEUE_SUSPENDED	(1 << 0)
 
+#define MMC_REQ_SPECIAL_MASK	(REQ_DISCARD | REQ_FLUSH)
+
 /*
  * Prepare a MMC request. This just filters out odd stuff.
  */
@@ -58,6 +60,7 @@ static int mmc_queue_thread(void *d)
 	do {
 		struct request *req = NULL;
 		struct mmc_queue_req *tmp;
+		unsigned int cmd_flags = 0;
 
 		spin_lock_irq(q->queue_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -67,12 +70,19 @@ static int mmc_queue_thread(void *d)
 
 		if (req || mq->mqrq_prev->req) {
 			set_current_state(TASK_RUNNING);
+			cmd_flags = req ? req->cmd_flags : 0;
 			mq->issue_fn(mq, req);
 
 			/*
 			 * Current request becomes previous request
 			 * and vice versa.
+			 * In case of special requests, current request
+			 * has been finished. Do not remain it to previous
+			 * request.
 			 */
+			if (cmd_flags & MMC_REQ_SPECIAL_MASK)
+				mq->mqrq_cur->req = NULL;
+
 			mq->mqrq_prev->brq.mrq.data = NULL;
 			mq->mqrq_prev->req = NULL;
 			tmp = mq->mqrq_prev;
-- 
1.7.0.4


