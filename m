From: Ethan Du <ethan.too@gmail.com>
Subject: [PATCH] mmc: name mmc queue thread by host index
Date: Mon, 27 Sep 2010 10:22:20 +0800
Message-ID: <AANLkTikNzqe4ppJhGWapSwvXbpqABAjybOevwRds1Ou+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51240 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758159Ab0I0CWa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 22:22:30 -0400
Received: by qyk36 with SMTP id 36so4402518qyk.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 19:22:28 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Usually there are multiple mmc host controllers, rename mmc queue thread
by host index, so we can easily identify which controller it belongs to

Signed-off-by: Ethan Du <ethan.too@gmail.com>
---
 drivers/mmc/card/queue.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index e876678..673bbdb 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -211,7 +211,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct
mmc_card *card, spinlock_t *lock

 	init_MUTEX(&mq->thread_sem);

-	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd");
+	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d",
+		host->index);
 	if (IS_ERR(mq->thread)) {
 		ret = PTR_ERR(mq->thread);
 		goto free_bounce_sg;
-- 
1.5.6.5
