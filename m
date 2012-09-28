From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: mmc: queue: amend buffer swap for non-blocking transfer
Date: Fri, 28 Sep 2012 19:12:53 +0900
Message-ID: <00fe01cd9d61$d2f6f180$78e4d480$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55497 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab2I1KMz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 06:12:55 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MB2004RA1PI6IZ0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Sep 2012 19:12:54 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MB200H2M1PHWAB0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Sep 2012 19:12:53 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Per Forlin' <per.forlin@linaro.org>

In case both 'req' and 'mq->mqrq_prev->req' are null, there is no request
to be processed. That means there is no need to switch buffer.
Switching buffer is required only after finishing 'issue_fn'.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/card/queue.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index e360a97..fadf52e 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -68,6 +68,16 @@ static int mmc_queue_thread(void *d)
 		if (req || mq->mqrq_prev->req) {
 			set_current_state(TASK_RUNNING);
 			mq->issue_fn(mq, req);
+
+			/*
+			 * Current request becomes previous request
+			 * and vice versa.
+			 */
+			mq->mqrq_prev->brq.mrq.data = NULL;
+			mq->mqrq_prev->req = NULL;
+			tmp = mq->mqrq_prev;
+			mq->mqrq_prev = mq->mqrq_cur;
+			mq->mqrq_cur = tmp;
 		} else {
 			if (kthread_should_stop()) {
 				set_current_state(TASK_RUNNING);
@@ -77,13 +87,6 @@ static int mmc_queue_thread(void *d)
 			schedule();
 			down(&mq->thread_sem);
 		}
-
-		/* Current request becomes previous request and vice versa. */
-		mq->mqrq_prev->brq.mrq.data = NULL;
-		mq->mqrq_prev->req = NULL;
-		tmp = mq->mqrq_prev;
-		mq->mqrq_prev = mq->mqrq_cur;
-		mq->mqrq_cur = tmp;
 	} while (1);
 	up(&mq->thread_sem);
 
-- 
1.7.0.4


