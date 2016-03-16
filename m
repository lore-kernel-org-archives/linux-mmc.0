From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] mmc: card: don't use PF_MEMALLOC
Date: Wed, 16 Mar 2016 12:43:55 +0100
Message-ID: <1458128635-3539-1-git-send-email-martink@posteo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:36044 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596AbcCPLpt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Mar 2016 07:45:49 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 7653820A44
	for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 12:45:47 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, axboe@fb.com, chuanxiao.dong@intel.com, fabf@skynet.be
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

PF_MEMALLOC is assigned to processes by mm. If drivers prevent memory
reclaim and mm is not in control, strange hang-up or OOM Killer invocation
could happen.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
I use MMC cards with this change perfectly fine. As I understand it,
even *if* PF_MEMALLOC has a real reason to be here, I think it should
be very well documented.


 drivers/mmc/card/queue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 6f4323c..be71249 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -51,8 +51,6 @@ static int mmc_queue_thread(void *d)
 	struct mmc_queue *mq = d;
 	struct request_queue *q = mq->queue;
 
-	current->flags |= PF_MEMALLOC;
-
 	down(&mq->thread_sem);
 	do {
 		struct request *req = NULL;
-- 
2.1.4

