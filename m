From: Saugata Das <saugata.das@stericsson.com>
Subject: [RFC] MMC-4.5 Context ID
Date: Wed, 1 Feb 2012 20:57:01 +0530
Message-ID: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:36840 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753952Ab2BAP1N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2012 10:27:13 -0500
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7DDFBDD
	for <linux-mmc@vger.kernel.org>; Wed,  1 Feb 2012 15:27:10 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EEF7B2761
	for <linux-mmc@vger.kernel.org>; Wed,  1 Feb 2012 15:27:09 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
	by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 18A6424C07D
	for <linux-mmc@vger.kernel.org>; Wed,  1 Feb 2012 16:27:02 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

From: Saugata Das <saugata.das@linaro.org>

This patch groups the read or write transfers to eMMC in different contexts
based on the block number. Transfers to consecutive blocks are grouped to a
common context. So several small transfers combine to give performance like
a large multi block transfer.

The patch creates a context of 1MB multiple in non-large unit mode. Reliable
mode is enabled in the context based on whether reliable write is enabled.

Signed-off-by: Saugata Das <saugata.das@linaro.org>
---
 drivers/mmc/card/block.c |  263 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/core/mmc.c   |    6 +
 include/linux/mmc/card.h |   13 +++
 include/linux/mmc/core.h |    9 ++
 include/linux/mmc/host.h |    1 +
 include/linux/mmc/mmc.h  |    3 +
 6 files changed, 275 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 176b78e..161174a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -127,6 +127,8 @@ enum mmc_blk_status {
 module_param(perdev_minors, int, 0444);
 MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
 
+static int mmc_blk_issue_rw_rq(struct mmc_queue *, struct request *);
+
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
 	struct mmc_blk_data *md;
@@ -1071,6 +1073,192 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	return MMC_BLK_SUCCESS;
 }
 
+/*
+ * Update the context information in the ext. CSD
+ */
+static int mmc_context_modify(struct mmc_queue *mq,
+				struct mmc_card *card,
+				unsigned int context_id,
+				unsigned char context_conf)
+{
+	/*
+	 * Wait for any ongoing transfer
+	 */
+	if (card->host->areq)
+		mmc_blk_issue_rw_rq(mq, NULL);
+
+	/*
+	 * CONTEXT_CONF array starts from context id 1
+	 */
+	return mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_CONTEXT_CONF + context_id - 1,
+			context_conf,
+			card->ext_csd.generic_cmd6_time);
+}
+
+/*
+ * Update timestamp, size and close context if needed
+ */
+static int mmc_check_close_context(struct mmc_queue *mq,
+				struct mmc_card *card,
+				unsigned int context_id,
+				unsigned int status)
+{
+	/*
+	 * Check only for valid contexts
+	 */
+	if ((context_id > 0) &&
+		(context_id <= card->ext_csd.max_context_id) &&
+		(card->mmc_context[context_id].valid)) {
+
+		/*
+		 * Incase of an error or we are multiple of erase block then
+		 * close the context
+		 */
+		if ((status) ||
+			((card->mmc_context[context_id].size %
+				card->ext_csd.lu_size) == 0)) {
+			if (mmc_context_modify(mq, card, context_id,
+					MMC_CONTEXT_CLOSE))
+				return -1;
+			card->mmc_context[context_id].valid = 0;
+		}
+		return 0;
+	}
+	return 0;
+}
+
+/*
+ * Update timestamp, size and close context if needed
+ */
+static int mmc_force_close_all_write_context(struct mmc_queue *mq,
+				struct mmc_card *card)
+{
+	int i, ret = 0;
+	for (i = 1; i <= card->ext_csd.max_context_id; i++) {
+		if (card->mmc_context[i].direction != MMC_CONTEXT_READ) {
+			ret = mmc_check_close_context(mq, card, i,
+					MMC_CONTEXT_FORCE_CLOSE);
+			if (ret)
+				return ret;
+		}
+	}
+	return ret;
+}
+
+/*
+ * Search for a context which is in the same direction and
+ * continuous in block numbers. If no matching context is
+ * found then take up an unused context. If all contexts are
+ * used then close the context which is least recently used,
+ * close it and the use it for the new transfer
+ */
+static int mmc_get_context_id(struct mmc_queue *mq,
+				struct mmc_card *card,
+				unsigned int offset,
+				unsigned int size,
+				unsigned int direction,
+				unsigned int rel_wr)
+{
+	int i, free_index = -1, lru_index = -1, ret_index;
+	unsigned int old_timestamp = -1;
+	unsigned int reliability_mode = rel_wr ? (0x01<<5) : 0;
+	struct mmc_context *context_ptr = &card->mmc_context[1];
+
+	/*
+	 * For older than 4.5 eMMC, there is no context ID
+	 */
+	if (card->ext_csd.max_context_id == 0)
+		return 0;
+
+	if (card->host->caps2 & MMC_CAP2_NO_CONTEXT)
+		return 0;
+
+	/*
+	 * If the request is LU size multiple then avoid
+	 * using any context
+	 */
+	if ((size % card->ext_csd.lu_size) == 0)
+		return 0;
+
+	/*
+	 * Context 0 is unused
+	 */
+	for (i = 1; i <= card->ext_csd.max_context_id; i++, context_ptr++) {
+
+		unsigned int context_start_blk;
+
+		if (!context_ptr->valid) {
+			if (free_index == -1)
+				free_index = i;
+			continue;
+		}
+
+		context_start_blk = context_ptr->offset -
+			context_ptr->size;
+
+		if ((context_start_blk <= offset) &&
+			(context_ptr->offset > offset)) {
+			int ret = mmc_check_close_context(mq, card, i,
+					MMC_CONTEXT_FORCE_CLOSE);
+			if (ret < 0)
+				return ret;
+			if (free_index == -1)
+				free_index = i;
+			break;
+		}
+
+		if ((lru_index == -1) ||
+			(context_ptr->timestamp < old_timestamp)) {
+			old_timestamp = context_ptr->timestamp;
+			lru_index = i;
+		}
+
+		if ((context_ptr->direction != direction) ||
+			(context_ptr->offset != offset) ||
+			(context_ptr->reliability_mode !=
+				reliability_mode))
+			continue;
+
+		context_ptr->timestamp = jiffies;
+		context_ptr->offset += size;
+		context_ptr->size += size;
+		return i;
+	}
+
+	if (free_index != -1) {
+		/*
+		 * Open a free context
+		 */
+		if (mmc_context_modify(mq, card, free_index,
+				(direction & 0x03) | reliability_mode))
+			return -1;
+		ret_index = free_index;
+	} else if (lru_index != -1) {
+		/*
+		 * Close and reopen the LRU context
+		 */
+		if (mmc_context_modify(mq, card, lru_index, MMC_CONTEXT_CLOSE))
+			return -1;
+
+		if (mmc_context_modify(mq, card, lru_index,
+				(direction & 0x03) | reliability_mode))
+			return -1;
+		ret_index = lru_index;
+	} else
+		return -1;
+
+	context_ptr = &card->mmc_context[ret_index];
+	context_ptr->offset = offset+size;
+	context_ptr->size = size;
+	context_ptr->direction = direction;
+	context_ptr->timestamp = jiffies;
+	context_ptr->reliability_mode = reliability_mode;
+	context_ptr->valid = 1;
+
+	return ret_index;
+}
+
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
 			       int disable_multi,
@@ -1080,7 +1268,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	struct mmc_blk_request *brq = &mqrq->brq;
 	struct request *req = mqrq->req;
 	struct mmc_blk_data *md = mq->data;
-	bool do_data_tag;
 
 	/*
 	 * Reliable writes are used to implement Forced Unit Access and
@@ -1157,16 +1344,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		mmc_apply_rel_rw(brq, card, req);
 
 	/*
-	 * Data tag is used only during writing meta data to speed
-	 * up write and any subsequent read of this meta data
-	 */
-	do_data_tag = (card->ext_csd.data_tag_unit_size) &&
-		(req->cmd_flags & REQ_META) &&
-		(rq_data_dir(req) == WRITE) &&
-		((brq->data.blocks * brq->data.blksz) >=
-		 card->ext_csd.data_tag_unit_size);
-
-	/*
 	 * Pre-defined multi-block transfers are preferable to
 	 * open ended-ones (and necessary for reliable writes).
 	 * However, it is not sufficient to just send CMD23,
@@ -1184,15 +1361,54 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	 * We'll avoid using CMD23-bounded multiblock writes for
 	 * these, while retaining features like reliable writes.
 	 */
-	if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
-	    (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
-	     do_data_tag)) {
-		brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
-		brq->sbc.arg = brq->data.blocks |
-			(do_rel_wr ? (1 << 31) : 0) |
-			(do_data_tag ? (1 << 29) : 0);
-		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
-		brq->mrq.sbc = &brq->sbc;
+	if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode)) {
+		/*
+		 * Context ID is used for non-large unit and non-reliable
+		 * write transfers provided the start block number
+		 * sequentially follows any of the open contexts
+		 */
+		int context_id;
+
+		/*
+		 * Data tag is used only during writing meta data to speed
+		 * up write and any subsequent read of this meta data
+		 */
+		bool do_data_tag = (card->ext_csd.data_tag_unit_size) &&
+			(req->cmd_flags & REQ_META) &&
+			(rq_data_dir(req) == WRITE) &&
+			((brq->data.blocks * brq->data.blksz) >=
+			card->ext_csd.data_tag_unit_size);
+
+		/*
+		 * During fsync, ensure that data is committed to storage
+		 */
+		if (req->cmd_flags & (REQ_FLUSH | REQ_SYNC))
+			mmc_force_close_all_write_context(mq, card);
+
+		/*
+		 * Context ID is used for non-large unit and non-reliable
+		 * write transfers provided the start block number
+		 * sequentially follows any of the open contexts
+		 */
+		context_id = mmc_get_context_id(mq,
+			card,
+			blk_rq_pos(req),
+			brq->data.blocks,
+			(rq_data_dir(req) == WRITE) ? MMC_CONTEXT_WRITE :
+				MMC_CONTEXT_READ,
+			do_rel_wr);
+
+	    if (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
+			do_data_tag || (context_id > 0)) {
+			brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
+			brq->sbc.arg = brq->data.blocks |
+				(do_rel_wr ? (1 << 31) : 0) |
+				(do_data_tag ? (1 << 29) : 0) |
+				(((context_id > 0) && (!do_rel_wr)) ?
+					((context_id & 0x0f) << 25) : 0);
+			brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
+			brq->mrq.sbc = &brq->sbc;
+		}
 	}
 
 	mmc_set_data_timeout(&brq->data, card);
@@ -1284,6 +1500,13 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
 		mmc_queue_bounce_post(mq_rq);
 
+		if (mmc_check_close_context(mq,
+				card,
+				((brq->sbc.arg) >> 25) & 0x0f,
+				status) < 0) {
+			status = MMC_BLK_CMD_ERR;
+		}
+
 		switch (status) {
 		case MMC_BLK_SUCCESS:
 		case MMC_BLK_PARTIAL:
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index dc03291..469d100 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -533,6 +533,12 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		} else {
 			card->ext_csd.data_tag_unit_size = 0;
 		}
+
+		/* LU size in 512 byte sectors */
+		card->ext_csd.lu_size =
+			(ext_csd[EXT_CSD_LARGE_UNIT_SIZE_M1] + 1) * 0x800;
+		card->ext_csd.max_context_id =
+			ext_csd[EXT_CSD_CONTEXT_CAPABILITIES] & 0x0f;
 	}
 
 out:
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f9a0663..2e5b85a 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -73,6 +73,8 @@ struct mmc_ext_csd {
 	unsigned int		hpi_cmd;		/* cmd used as HPI */
 	unsigned int            data_sector_size;       /* 512 bytes or 4KB */
 	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
+	unsigned int		lu_size;
+	unsigned int		max_context_id;
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
 	u8			raw_partition_support;	/* 160 */
@@ -184,6 +186,16 @@ struct sdio_func_tuple;
 #define MAX_MMC_PART_NAME_LEN	20
 
 /*
+ * Contexts can be upto 15
+ */
+#define MMC_NUM_CONTEXT			15
+#define MMC_CONTEXT_CLOSE		0
+#define MMC_CONTEXT_WRITE		1
+#define MMC_CONTEXT_READ		2
+
+#define MMC_CONTEXT_FORCE_CLOSE	1
+
+/*
  * MMC Physical partitions
  */
 struct mmc_part {
@@ -268,6 +280,7 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
+	struct mmc_context  mmc_context[MMC_NUM_CONTEXT];
 };
 
 /*
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 87a976c..f20ebc5 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -130,6 +130,15 @@ struct mmc_request {
 	void			(*done)(struct mmc_request *);/* completion function */
 };
 
+struct mmc_context {
+	unsigned int offset;
+	unsigned int size;
+	unsigned int direction;
+	unsigned int timestamp;
+	unsigned int reliability_mode;
+	unsigned int valid;
+};
+
 struct mmc_host;
 struct mmc_card;
 struct mmc_async_req;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index dd13e05..661e262 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -255,6 +255,7 @@ struct mmc_host {
 #define MMC_CAP2_NO_SLEEP_CMD	(1 << 4)	/* Don't allow sleep command */
 #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */
 #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
+#define MMC_CAP2_NO_CONTEXT	(1 << 7)	/* context ID not supported */
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index b822a2c..809c3a5 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -274,6 +274,7 @@ struct _mmc_csd {
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
+#define EXT_CSD_CONTEXT_CONF		37	/* R/W : array of 15 config */
 #define EXT_CSD_DATA_SECTOR_SIZE	61	/* R */
 #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
@@ -316,6 +317,8 @@ struct _mmc_csd {
 #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
+#define EXT_CSD_LARGE_UNIT_SIZE_M1	495 /* RO */
+#define EXT_CSD_CONTEXT_CAPABILITIES	496	/* RO */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
 #define EXT_CSD_HPI_FEATURES		503	/* RO */
-- 
1.7.4.3

