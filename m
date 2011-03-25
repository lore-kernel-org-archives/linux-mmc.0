From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 1/1] mmc: remove redundant irq disabling
Date: Fri, 25 Mar 2011 09:47:37 +0100
Message-ID: <87zkoj7fiu.fsf@vostro.fn.ogness.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33331 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752599Ab1CYJLw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 05:11:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jens Axboe <jaxboe@fusionio.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

There is no need to disable irq's when using the sg_copy_*_buffer()
functions because those functions do that already. There are also
no races for the mm_queue struct here that would require the irq's
to be disabled before calling sg_copy_*_buffer().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
Patch against linux-next-20110324.

 drivers/mmc/card/queue.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 2ae7275..c07322c 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -343,18 +343,14 @@ unsigned int mmc_queue_map_sg(struct mmc_queue *mq)
  */
 void mmc_queue_bounce_pre(struct mmc_queue *mq)
 {
-	unsigned long flags;
-
 	if (!mq->bounce_buf)
 		return;
 
 	if (rq_data_dir(mq->req) != WRITE)
 		return;
 
-	local_irq_save(flags);
 	sg_copy_to_buffer(mq->bounce_sg, mq->bounce_sg_len,
 		mq->bounce_buf, mq->sg[0].length);
-	local_irq_restore(flags);
 }
 
 /*
@@ -363,17 +359,13 @@ void mmc_queue_bounce_pre(struct mmc_queue *mq)
  */
 void mmc_queue_bounce_post(struct mmc_queue *mq)
 {
-	unsigned long flags;
-
 	if (!mq->bounce_buf)
 		return;
 
 	if (rq_data_dir(mq->req) != READ)
 		return;
 
-	local_irq_save(flags);
 	sg_copy_from_buffer(mq->bounce_sg, mq->bounce_sg_len,
 		mq->bounce_buf, mq->sg[0].length);
-	local_irq_restore(flags);
 }
 
-- 
1.7.2.5
