From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: block: get idx after the check of packed
Date: Sun, 21 Aug 2016 12:22:59 +0800
Message-ID: <1471753379-814-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:44485 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbcHUE1X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Aug 2016 00:27:23 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.157])
        by lucky1.263xmail.com (Postfix) with ESMTP id 96D8053D77
        for <linux-mmc@vger.kernel.org>; Sun, 21 Aug 2016 12:27:15 +0800 (CST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

We should not use packed command before we verify
it's valid. So let's move the assignment of idx
after the check.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/card/block.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 48a5dd7..11d3046 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1883,11 +1883,13 @@ static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_rq)
 {
 	struct request *prq;
 	struct mmc_packed *packed = mq_rq->packed;
-	int idx = packed->idx_failure, i = 0;
+	int idx, i = 0;
 	int ret = 0;
 
 	BUG_ON(!packed);
 
+	idx = packed->idx_failure;
+
 	while (!list_empty(&packed->list)) {
 		prq = list_entry_rq(packed->list.next);
 		if (idx == i) {
-- 
2.3.7


