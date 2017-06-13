From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: queue: Drop call to blk_cleanup_queue()
Date: Tue, 13 Jun 2017 10:59:06 +0200
Message-ID: <20170613085906.5726-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36763 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbdFMI7Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2017 04:59:24 -0400
Received: by mail-lf0-f53.google.com with SMTP id o83so65126622lff.3
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2017 01:59:18 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

commit 0d8587376878c8da5a4953025e621c5dceb8b76a
"mmc: core: Allocate per-request data using the block layer core"
added a call to blk_cleanup_queue() into the mmc_cleanup_queue()
call.

This might look intutitive (and that is why I made the mistake),
since the cleanup is called if we fail in mmc_init_queue(), but due
to the nature of the MMC stack we are cleaning up the queue
inside the stack once the queue has been started.

The actual call to blk_cleanup_queue() is in mmc_blk_put() in
block.c, calling it twice wreaks havoc.

Fixes: 0d8587376878 ("mmc: core: Allocate per-request data using the block layer core")
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/queue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4bf9978b707a..ba689a2ffc51 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -312,7 +312,6 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	q->queuedata = NULL;
 	blk_start_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
-	blk_cleanup_queue(mq->queue);
 
 	mq->card = NULL;
 }
-- 
2.9.4

