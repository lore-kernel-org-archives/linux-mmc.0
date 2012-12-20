From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: queue: exclude asynchronous transfer for special request
Date: Thu, 20 Dec 2012 19:27:16 +0900
Message-ID: <003c01cdde9c$95883ad0$c098b070$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58822 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab2LTK1T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Dec 2012 05:27:19 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MFB008CCRPCG5Q0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 20 Dec 2012 19:27:17 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MFB007GSRPG8A00@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 20 Dec 2012 19:27:17 +0900 (KST)
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
 drivers/mmc/card/queue.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index fadf52e..a71db7a 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -58,6 +58,7 @@ static int mmc_queue_thread(void *d)
 	do {
 		struct request *req = NULL;
 		struct mmc_queue_req *tmp;
+		unsigned int cmd_flags = 0;
 
 		spin_lock_irq(q->queue_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -67,12 +68,19 @@ static int mmc_queue_thread(void *d)
 
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
+			if (cmd_flags & REQ_DISCARD || cmd_flags & REQ_FLUSH)
+				mq->mqrq_cur->req = NULL;
+
 			mq->mqrq_prev->brq.mrq.data = NULL;
 			mq->mqrq_prev->req = NULL;
 			tmp = mq->mqrq_prev;
-- 
1.7.0.4


