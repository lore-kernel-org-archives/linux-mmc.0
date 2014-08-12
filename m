From: Yunpeng Gao <yunpeng.gao@intel.com>
Subject: [PATCH] mmc: card: not access RPMB partition for normal read and write
Date: Tue, 12 Aug 2014 12:01:30 +0800
Message-ID: <1407816090-7671-1-git-send-email-yunpeng.gao@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7200 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033AbaHLD7r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Aug 2014 23:59:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>, Yunpeng Gao <yunpeng.gao@intel.com>

From: Chuanxiao Dong <chuanxiao.dong@intel.com>

During kernel boot, it will try to read some logical sectors
of each block device node for the possible partition table.

But since RPMB partition is special and can not be accessed
by normal eMMC read / write CMDs, it will cause below error
messages during kernel boot:
...
<3>[    4.890052] mmc0: Got data interrupt 0x00000002 even though no data operation was in progress.
<3>[    4.892160] mmcblk0rpmb: error -110 transferring data, sector 0, nr 32, cmd response 0x900, card status 0xb00
<4>[    4.892165] mmcblk0rpmb: retrying using single block read
<3>[    4.895727] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
<3>[    4.899269] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
<3>[    4.901466] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
<3>[    4.905106] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
<3>[    4.907166] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
<3>[    4.909235] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
<3>[    4.909241] end_request: I/O error, dev mmcblk0rpmb, sector 0
<3>[    4.909247] Buffer I/O error on device mmcblk0rpmb, logical block 0
<3>[    4.909263] end_request: I/O error, dev mmcblk0rpmb, sector 8
<3>[    4.909267] Buffer I/O error on device mmcblk0rpmb, logical block 1
<3>[    4.909272] end_request: I/O error, dev mmcblk0rpmb, sector 16
<3>[    4.909275] Buffer I/O error on device mmcblk0rpmb, logical block 2
<3>[    4.909280] end_request: I/O error, dev mmcblk0rpmb, sector 24
<3>[    4.909283] Buffer I/O error on device mmcblk0rpmb, logical block 3
...

This patch will discard the access request in eMMC queue if
it is RPMB partition access request. By this way, it avoids
trigger above error messages.

Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/card/block.c |   13 +++++++++++++
 drivers/mmc/card/queue.c |    2 +-
 drivers/mmc/card/queue.h |    2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 452782b..4b79592 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1025,6 +1025,19 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
 	md->reset_done &= ~type;
 }
 
+int mmc_access_rpmb(struct mmc_queue *mq)
+{
+	struct mmc_blk_data *md = mq->data;
+	/*
+	 * If this is a RPMB partition access, return ture
+	 */
+	if (md && md->part_type == EXT_CSD_PART_CONFIG_ACC_RPMB)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(mmc_access_rpmb);
+
 static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 3e049c1..6ceede0 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -38,7 +38,7 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 		return BLKPREP_KILL;
 	}
 
-	if (mq && mmc_card_removed(mq->card))
+	if (mq && (mmc_card_removed(mq->card) || mmc_access_rpmb(mq)))
 		return BLKPREP_KILL;
 
 	req->cmd_flags |= REQ_DONTPREP;
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 5752d50..99e6521 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -73,4 +73,6 @@ extern void mmc_queue_bounce_post(struct mmc_queue_req *);
 extern int mmc_packed_init(struct mmc_queue *, struct mmc_card *);
 extern void mmc_packed_clean(struct mmc_queue *);
 
+extern int mmc_access_rpmb(struct mmc_queue *);
+
 #endif
-- 
1.7.9.5

