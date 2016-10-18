From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 7/8] mmc: queue: remove BUG_ON for bounce_sg
Date: Tue, 18 Oct 2016 20:04:39 +0800
Message-ID: <1476792279-6554-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:59214 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759670AbcJRL7E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 07:59:04 -0400
In-Reply-To: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

bounce_sg for mqrq_cur and mqrq_pre are proper
allocated when initializing the queue and will not
be freed before explicitly cleaning the queue. So from
the code itself it should be quite confident to remove
this check. If that BUG_ON take effects, it is mostly
likely the memory is randomly oopsing.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/card/queue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 8037f73..6c8978a 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -505,8 +505,6 @@ unsigned int mmc_queue_map_sg(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 			return blk_rq_map_sg(mq->queue, mqrq->req, mqrq->sg);
 	}
 
-	BUG_ON(!mqrq->bounce_sg);
-
 	if (mmc_packed_cmd(cmd_type))
 		sg_len = mmc_queue_packed_map_sg(mq, mqrq->packed,
 						 mqrq->bounce_sg, cmd_type);
-- 
2.3.7


