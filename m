From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 21/30] mmc: Convert "mutex" to semaphore
Date: Tue, 07 Sep 2010 14:33:22 -0000
Message-ID: <20100907125056.703221226@linutronix.de>
References: <20100907124636.880953480@linutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:43871 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932219Ab0IGOdl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Sep 2010 10:33:41 -0400
Content-Disposition: inline; filename=drivers-mmc-card-queue-sema.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@infradead.org>, linux-mmc@vger.kernel.org

Get rid of init_MUTEX[_LOCKED]() and use sema_init() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mmc@vger.kernel.org

---
 drivers/mmc/card/queue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/mmc/card/queue.c
===================================================================
--- linux-2.6.orig/drivers/mmc/card/queue.c
+++ linux-2.6/drivers/mmc/card/queue.c
@@ -209,7 +209,7 @@ int mmc_init_queue(struct mmc_queue *mq,
 		sg_init_table(mq->sg, host->max_phys_segs);
 	}
 
-	init_MUTEX(&mq->thread_sem);
+	sema_init(&mq->thread_sem, 1);
 
 	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd");
 	if (IS_ERR(mq->thread)) {


