From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: block: remove unused struct mmc_card *card
Date: Thu,  6 Jul 2017 16:26:55 +0800
Message-ID: <1499329615-104052-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:37877 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdGFI1N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jul 2017 04:27:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

It was never used and introduced a long standing compile
warning:

drivers/mmc/core/block.c: In function 'power_ro_lock_store':
drivers/mmc/core/block.c:191:19: warning: variable 'card' set but not
used [-Wunused-but-set-variable]

Remove it to fix the warning.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/block.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0cfac2d..4adde50 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -188,7 +188,6 @@ static ssize_t power_ro_lock_store(struct device *dev,
 {
 	int ret;
 	struct mmc_blk_data *md, *part_md;
-	struct mmc_card *card;
 	struct mmc_queue *mq;
 	struct request *req;
 	unsigned long set;
@@ -201,7 +200,6 @@ static ssize_t power_ro_lock_store(struct device *dev,
 
 	md = mmc_blk_get(dev_to_disk(dev));
 	mq = &md->queue;
-	card = md->queue.card;
 
 	/* Dispatch locking to the block layer */
 	req = blk_get_request(mq->queue, REQ_OP_DRV_OUT, __GFP_RECLAIM);
-- 
1.9.1


