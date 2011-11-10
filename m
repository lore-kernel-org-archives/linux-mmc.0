From: Per Forlin <per.lkml@gmail.com>
Subject: [RFC] mmc: block: complete req before blk_part_switch
Date: Thu, 10 Nov 2011 22:24:48 +0100
Message-ID: <1320960288-19918-1-git-send-email-per.lkml@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55727 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab1KJVZX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2011 16:25:23 -0500
Received: by bke11 with SMTP id 11so2737725bke.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Nov 2011 13:25:22 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>

From: Per Forlin <per.forlin@stericsson.com>

Finish off any previous request before switching partition.

Can there be an ongoing request when mmc_blk_part_switch() is called?
In that case it might fail if calling mmc_switch when there is an ongoing
request.
I'm sending this as an RFC because I haven't been able to verify if this
can happen, but to me it looks suspicious. host->areq is set if there is a
previous request in the pipeline.
In case this issue is confirmed I'll send a real patch.

Signed-off-by: Per Forlin <per.forlin@stericsson.com>
---
 drivers/mmc/card/block.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 4c1a648..ca993b1 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -437,12 +437,20 @@ static const struct block_device_operations mmc_bdops = {
 #endif
 };
 
+/* returns true if current partion, otherwise false */
+static inline bool mmc_blk_part_is_current(struct mmc_card *card,
+					  struct mmc_blk_data *md)
+{
+	struct mmc_blk_data *main_md = mmc_get_drvdata(card);
+	return main_md->part_curr == md->part_type;
+}
+
 static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      struct mmc_blk_data *md)
 {
 	int ret;
 	struct mmc_blk_data *main_md = mmc_get_drvdata(card);
-	if (main_md->part_curr == md->part_type)
+	if (mmc_blk_part_is_current(card, md))
 		return 0;
 
 	if (mmc_card_mmc(card)) {
@@ -454,7 +462,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 				 card->ext_csd.part_time);
 		if (ret)
 			return ret;
-}
+	}
 
 	main_md->part_curr = md->part_type;
 	return 0;
@@ -1188,6 +1196,12 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		/* claim host only for the first request */
 		mmc_claim_host(card->host);
 
+	if (card->host->areq && req &&
+	    (req->cmd_flags & (REQ_DISCARD | REQ_FLUSH) ||
+	     !mmc_blk_part_is_current(card, md)))
+		/* complete ongoing async transfer */
+		mmc_blk_issue_rw_rq(mq, NULL);
+
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
 		ret = 0;
@@ -1195,17 +1209,11 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	}
 
 	if (req && req->cmd_flags & REQ_DISCARD) {
-		/* complete ongoing async transfer before issuing discard */
-		if (card->host->areq)
-			mmc_blk_issue_rw_rq(mq, NULL);
 		if (req->cmd_flags & REQ_SECURE)
 			ret = mmc_blk_issue_secdiscard_rq(mq, req);
 		else
 			ret = mmc_blk_issue_discard_rq(mq, req);
 	} else if (req && req->cmd_flags & REQ_FLUSH) {
-		/* complete ongoing async transfer before issuing flush */
-		if (card->host->areq)
-			mmc_blk_issue_rw_rq(mq, NULL);
 		ret = mmc_blk_issue_flush(mq, req);
 	} else {
 		ret = mmc_blk_issue_rw_rq(mq, req);
-- 
1.7.0.4

