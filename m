From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] mmc: block: remove the check of packed for end_packed_req and hdr_wrq_prep
Date: Wed, 24 Aug 2016 15:58:18 +0800
Message-ID: <1472025499-6758-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:45529 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753748AbcHXIQQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2016 04:16:16 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.236])
        by lucky1.263xmail.com (Postfix) with ESMTP id 68D5E68A
        for <linux-mmc@vger.kernel.org>; Wed, 24 Aug 2016 16:03:09 +0800 (CST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

packed should always exist without calling its cleanup function
explicitly. Moreover, we have use it when preparing packed list.
So I don't believe we should ever fall into this check again when
doing mmc_blk_packed_hdr_wrq_prep or mmc_blk_end_packed_req. And
the code of mmc_blk_end_packed_req is trying to use packed before
checking it which makes it quite weird. This patch is trying to
remove these two checks and move it to the mmc_blk_prep_packed_list.
If we find packed is null, then we should never use MMC_PACKED_NONE
and MMC_BLK_PACKED_CMD. By doing this, we could fall back to
non-packed request if finding null packed, though it's impossible
theoretically.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- remove BUG_ON and add fallback for packed instead of
  panic it.

 drivers/mmc/card/block.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 48a5dd7..c7a9b28 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1673,6 +1673,18 @@ static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
 	u8 max_packed_rw = 0;
 	u8 reqs = 0;
 
+	/*
+	 * We don't need to check packed for any further
+	 * operation of packed stuff as we set MMC_PACKED_NONE
+	 * and return zero for reqs if geting null packed. Also
+	 * we clean the flag of MMC_BLK_PACKED_CMD to avoid doing
+	 * it again when removing blk req.
+	 */
+	if (!mqrq->packed) {
+		md->flags &= (~MMC_BLK_PACKED_CMD);
+		goto no_packed;
+	}
+
 	if (!(md->flags & MMC_BLK_PACKED_CMD))
 		goto no_packed;
 
@@ -1781,8 +1793,6 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
 	u8 hdr_blocks;
 	u8 i = 1;
 
-	BUG_ON(!packed);
-
 	mqrq->cmd_type = MMC_PACKED_WRITE;
 	packed->blocks = 0;
 	packed->idx_failure = MMC_PACKED_NR_IDX;
@@ -1886,8 +1896,6 @@ static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_rq)
 	int idx = packed->idx_failure, i = 0;
 	int ret = 0;
 
-	BUG_ON(!packed);
-
 	while (!list_empty(&packed->list)) {
 		prq = list_entry_rq(packed->list.next);
 		if (idx == i) {
-- 
2.3.7


