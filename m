From: Andrei Warkentin <andreiw@motorola.com>
Subject: [comments] MMC: Reliable write support.
Date: Thu, 24 Mar 2011 16:22:31 -0500
Message-ID: <1301001751-30785-2-git-send-email-andreiw@motorola.com>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:38731 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933904Ab1CXUlL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2011 16:41:11 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2OKfTfF022007
	for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2011 16:41:29 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2OKfSjM022004
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2011 16:41:28 -0400 (EDT)
Received: by gyb11 with SMTP id 11so219320gyb.15
        for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2011 13:41:07 -0700 (PDT)
In-Reply-To: <1301001751-30785-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

This is a request-for-comments patch. Please provide your feedback.

Allows reliable writes to be used for MMC writes. Reliable writes are used
to service write REQ_FUA/REQ_META requests. Handles both the legacy and the enhanced
reliable write support in MMC cards.

Beyond REQ_FUA/REQ_META, this was meant to be used by a following patch that aimed
to reduce write amplification issues in cards employing a small (usually flash page-sized)
buffer and a large (usually erase-block sized) buffer, at the expense of performance.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |   85 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/core/mmc.c   |    5 +++
 include/linux/mmc/card.h |    2 +
 include/linux/mmc/mmc.h  |    4 ++
 4 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 61d233a..712fe96 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -48,6 +48,10 @@ MODULE_ALIAS("mmc:block");
 #endif
 #define MODULE_PARAM_PREFIX "mmcblk."
 
+#define REL_WRITES_SUPPORTED(card) (mmc_card_mmc((card)) &&	\
+    (((card)->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||	\
+     ((card)->ext_csd.rel_sectors)))
+
 static DEFINE_MUTEX(block_mutex);
 
 /*
@@ -331,6 +335,59 @@ out:
 	return err ? 0 : 1;
 }
 
+static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_blk_data *md = mq->data;
+
+	/*
+	   No-op, only service this because we need REQ_FUA
+	   for reliable writes.
+	*/
+	spin_lock_irq(&md->lock);
+	__blk_end_request_all(req, 0);
+	spin_unlock_irq(&md->lock);
+
+	return 1;
+}
+
+/*
+ * Reformat current write as a reliable write, supporting
+ * both legacy and the enhanced reliable write MMC cards.
+ * In each transfer we'll handle only as much as a single
+ * reliable write can handle, thus finish the request in
+ * partial completions.
+ */
+static inline int mmc_apply_rel_rw(struct mmc_blk_request *brq,
+				   struct mmc_card *card,
+				   struct request *req)
+{
+	int err;
+	struct mmc_command set_count;
+
+	if (!(card->ext_csd.rel_param &
+	      EXT_CSD_WR_REL_PARAM_EN)) {
+
+		/* Legacy mode imposes restrictions on transfers. */
+		if (!IS_ALIGNED(brq->cmd.arg, card->ext_csd.rel_sectors))
+			brq->data.blocks = 1;
+
+		if (brq->data.blocks > card->ext_csd.rel_sectors)
+			brq->data.blocks = card->ext_csd.rel_sectors;
+		else if (brq->data.blocks != card->ext_csd.rel_sectors)
+			brq->data.blocks = 1;
+	}
+
+	memset(&set_count, 0, sizeof(struct mmc_command));
+	set_count.opcode = MMC_SET_BLOCK_COUNT;
+	set_count.arg = brq->data.blocks | (1 << 31);
+	set_count.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(card->host, &set_count, 0);
+	if (err)
+		printk(KERN_ERR "%s: error %d SET_BLOCK_COUNT\n",
+		       req->rq_disk->disk_name, err);
+	return err;
+}
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
@@ -338,6 +395,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_blk_request brq;
 	int ret = 1, disable_multi = 0;
 
+	/*
+	  Reliable writes are used to implement Forced Unit Access and
+	  REQ_META accesses, and it's supported only on MMCs.
+	 */
+	bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
+			  (req->cmd_flags & REQ_META)) &&
+		(rq_data_dir(req) == WRITE) &&
+		REL_WRITES_SUPPORTED(card);
+
 	mmc_claim_host(card->host);
 
 	do {
@@ -374,12 +440,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		if (disable_multi && brq.data.blocks > 1)
 			brq.data.blocks = 1;
 
-		if (brq.data.blocks > 1) {
+		if (brq.data.blocks > 1 || do_rel_wr) {
 			/* SPI multiblock writes terminate using a special
-			 * token, not a STOP_TRANSMISSION request.
+			 * token, not a STOP_TRANSMISSION request. Reliable
+			 * writes use SET_BLOCK_COUNT and do not use a
+			 * STOP_TRANSMISSION request either.
 			 */
-			if (!mmc_host_is_spi(card->host)
-					|| rq_data_dir(req) == READ)
+			if ((!mmc_host_is_spi(card->host) && !do_rel_wr) ||
+			    rq_data_dir(req) == READ)
 				brq.mrq.stop = &brq.stop;
 			readcmd = MMC_READ_MULTIPLE_BLOCK;
 			writecmd = MMC_WRITE_MULTIPLE_BLOCK;
@@ -396,6 +464,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 			brq.data.flags |= MMC_DATA_WRITE;
 		}
 
+		if (do_rel_wr) {
+			if (mmc_apply_rel_rw(&brq, card, req))
+				goto cmd_err;
+		}
+
 		mmc_set_data_timeout(&brq.data, card);
 
 		brq.data.sg = mq->sg;
@@ -565,6 +638,8 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 			return mmc_blk_issue_secdiscard_rq(mq, req);
 		else
 			return mmc_blk_issue_discard_rq(mq, req);
+	} else if (req->cmd_flags & REQ_FLUSH) {
+		return mmc_blk_issue_flush(mq, req);
 	} else {
 		return mmc_blk_issue_rw_rq(mq, req);
 	}
@@ -622,6 +697,8 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = &card->dev;
 	set_disk_ro(md->disk, md->read_only);
+	if (REL_WRITES_SUPPORTED(card))
+		blk_queue_flush(md->queue.queue, REQ_FLUSH | REQ_FUA);
 
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 14e95f3..1b1e142 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -299,6 +299,8 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 			ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT];
 		card->ext_csd.hc_erase_size =
 			ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] << 10;
+
+		card->ext_csd.rel_sectors = ext_csd[EXT_CSD_REL_WR_SEC_C];
 	}
 
 	if (card->ext_csd.rev >= 4) {
@@ -350,6 +352,9 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 			ext_csd[EXT_CSD_TRIM_MULT];
 	}
 
+	if (card->ext_csd.rev >= 5)
+		card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
+
 	if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
 		card->erased_byte = 0xFF;
 	else
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index adb4888..959e3d8 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -45,6 +45,8 @@ struct mmc_ext_csd {
 	u8			rev;
 	u8			erase_group_def;
 	u8			sec_feature_support;
+	u8			rel_sectors;
+	u8			rel_param;
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		hs_max_dtr;
 	unsigned int		sectors;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 264ba54..44a8157 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -255,6 +255,7 @@ struct _mmc_csd {
 
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
+#define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
@@ -264,6 +265,7 @@ struct _mmc_csd {
 #define EXT_CSD_CARD_TYPE		196	/* RO */
 #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
 #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
+#define EXT_CSD_REL_WR_SEC_C		222	/* RO */
 #define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
 #define EXT_CSD_ERASE_TIMEOUT_MULT	223	/* RO */
 #define EXT_CSD_HC_ERASE_GRP_SIZE	224	/* RO */
@@ -276,6 +278,8 @@ struct _mmc_csd {
  * EXT_CSD field definitions
  */
 
+#define EXT_CSD_WR_REL_PARAM_EN		(1<<2)
+
 #define EXT_CSD_CMD_SET_NORMAL		(1<<0)
 #define EXT_CSD_CMD_SET_SECURE		(1<<1)
 #define EXT_CSD_CMD_SET_CPSECURE	(1<<2)
-- 
1.7.0.4

