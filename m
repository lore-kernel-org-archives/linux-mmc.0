From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] mmc: queue: use swap() in mmc_queue_thread()
Date: Wed, 10 Jun 2015 18:30:53 +0200
Message-ID: <1433953854-23343-1-git-send-email-fabf@skynet.be>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailrelay110.isp.belgacom.be ([195.238.20.137]:25820 "EHLO
	mailrelay110.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752622AbbFJQbI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jun 2015 12:31:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Fabian Frederick <fabf@skynet.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Use kernel.h macro definition.

Thanks to Julia Lawall for Coccinelle scripting support.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/mmc/card/queue.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 8efa368..d34e09b 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -56,7 +56,6 @@ static int mmc_queue_thread(void *d)
 	down(&mq->thread_sem);
 	do {
 		struct request *req = NULL;
-		struct mmc_queue_req *tmp;
 		unsigned int cmd_flags = 0;
 
 		spin_lock_irq(q->queue_lock);
@@ -86,9 +85,7 @@ static int mmc_queue_thread(void *d)
 
 			mq->mqrq_prev->brq.mrq.data = NULL;
 			mq->mqrq_prev->req = NULL;
-			tmp = mq->mqrq_prev;
-			mq->mqrq_prev = mq->mqrq_cur;
-			mq->mqrq_cur = tmp;
+			swap(mq->mqrq_prev, mq->mqrq_cur);
 		} else {
 			if (kthread_should_stop()) {
 				set_current_state(TASK_RUNNING);
-- 
2.4.2

