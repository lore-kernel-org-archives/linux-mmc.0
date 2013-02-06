From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v9 2/2] mmc: support packed write command for eMMC4.5 device
Date: Wed, 06 Feb 2013 17:02:46 +0900
Message-ID: <003201ce0440$59730010$0c590030$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35543 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579Ab3BFICv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Feb 2013 03:02:51 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHS0013WH0GBUV0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Feb 2013 17:02:47 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MHS001NOH0M0SA0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Feb 2013 17:02:46 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>, 'Arnd Bergmann' <arnd.bergmann@linaro.org>

This patch supports packed write command of eMMC4.5 device.
Several writes can be grouped in packed command and all data
of the individual commands can be sent in a single transfer
on the bus. Large amounts of data in one transfer rather than
several data of small size are effective for eMMC write internally.
As a result, packed command help write throughput be improved.
The following tables show the results of packed write.

Type A:
test     none |  packed
iozone   25.8 |  31
tiotest  27.6 |  31.2
lmdd     31.2 |  35.4

Type B:
test     none |  packed
iozone   44.1 |  51.1
tiotest  47.9 |  52.5
lmdd     51.6 |  59.2

Type C:
test     none |  packed
iozone   19.5 |  32
tiotest  19.9 |  34.5
lmdd     22.8 |  40.7

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Reviewed-by: Maya Erez <merez@codeaurora.org>
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
---
 drivers/mmc/card/block.c   |  454 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/card/queue.c   |   96 +++++++++-
 drivers/mmc/card/queue.h   |   22 ++
 drivers/mmc/core/mmc_ops.c |    1 +
 include/linux/mmc/card.h   |    5 +
 include/linux/mmc/core.h   |    4 +
 include/linux/mmc/host.h   |    5 +
 7 files changed, 570 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1170afe..d854e1e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -59,6 +59,12 @@ MODULE_ALIAS("mmc:block");
 #define INAND_CMD38_ARG_SECTRIM2 0x88
 #define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
 
+#define mmc_req_rel_wr(req)	(((req->cmd_flags & REQ_FUA) || \
+				  (req->cmd_flags & REQ_META)) && \
+				  (rq_data_dir(req) == WRITE))
+#define PACKED_CMD_VER	0x01
+#define PACKED_CMD_WR	0x02
+
 static DEFINE_MUTEX(block_mutex);
 
 /*
@@ -89,6 +95,7 @@ struct mmc_blk_data {
 	unsigned int	flags;
 #define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
 #define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
+#define MMC_BLK_PACKED_CMD	(1 << 2)	/* MMC packed command support */
 
 	unsigned int	usage;
 	unsigned int	read_only;
@@ -113,6 +120,12 @@ struct mmc_blk_data {
 
 static DEFINE_MUTEX(open_lock);
 
+enum {
+	MMC_PACKED_NR_IDX = -1,
+	MMC_PACKED_NR_ZERO,
+	MMC_PACKED_NR_SINGLE,
+};
+
 module_param(perdev_minors, int, 0444);
 MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
 
@@ -120,6 +133,19 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      struct mmc_blk_data *md);
 static int get_card_status(struct mmc_card *card, u32 *status, int retries);
 
+static inline void mmc_blk_clear_packed(struct mmc_queue_req *mqrq)
+{
+	struct mmc_packed *packed = mqrq->packed;
+
+	BUG_ON(!packed);
+
+	mqrq->cmd_type = MMC_PACKED_NONE;
+	packed->nr_entries = MMC_PACKED_NR_ZERO;
+	packed->idx_failure = MMC_PACKED_NR_IDX;
+	packed->retries = 0;
+	packed->blocks = 0;
+}
+
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
 	struct mmc_blk_data *md;
@@ -1137,12 +1163,77 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	if (!brq->data.bytes_xfered)
 		return MMC_BLK_RETRY;
 
+	if (mmc_packed_cmd(mq_mrq->cmd_type)) {
+		if (unlikely(brq->data.blocks << 9 != brq->data.bytes_xfered))
+			return MMC_BLK_PARTIAL;
+		else
+			return MMC_BLK_SUCCESS;
+	}
+
 	if (blk_rq_bytes(req) != brq->data.bytes_xfered)
 		return MMC_BLK_PARTIAL;
 
 	return MMC_BLK_SUCCESS;
 }
 
+static int mmc_blk_packed_err_check(struct mmc_card *card,
+				    struct mmc_async_req *areq)
+{
+	struct mmc_queue_req *mq_rq = container_of(areq, struct mmc_queue_req,
+			mmc_active);
+	struct request *req = mq_rq->req;
+	struct mmc_packed *packed = mq_rq->packed;
+	int err, check, status;
+	u8 *ext_csd;
+
+	BUG_ON(!packed);
+
+	packed->retries--;
+	check = mmc_blk_err_check(card, areq);
+	err = get_card_status(card, &status, 0);
+	if (err) {
+		pr_err("%s: error %d sending status command\n",
+				req->rq_disk->disk_name, err);
+		return MMC_BLK_ABORT;
+	}
+
+	if (status & R1_EXCEPTION_EVENT) {
+		ext_csd = kzalloc(512, GFP_KERNEL);
+		if (!ext_csd) {
+			pr_err("%s: unable to allocate buffer for ext_csd\n",
+					req->rq_disk->disk_name);
+			return -ENOMEM;
+		}
+
+		err = mmc_send_ext_csd(card, ext_csd);
+		if (err) {
+			pr_err("%s: error %d sending ext_csd\n",
+					req->rq_disk->disk_name, err);
+			check = MMC_BLK_ABORT;
+			goto free;
+		}
+
+		if ((ext_csd[EXT_CSD_EXP_EVENTS_STATUS] &
+			EXT_CSD_PACKED_FAILURE) &&
+		    (ext_csd[EXT_CSD_PACKED_CMD_STATUS] &
+			EXT_CSD_PACKED_GENERIC_ERROR)) {
+			if (ext_csd[EXT_CSD_PACKED_CMD_STATUS] &
+					EXT_CSD_PACKED_INDEXED_ERROR) {
+				packed->idx_failure =
+				  ext_csd[EXT_CSD_PACKED_FAILURE_INDEX] - 1;
+				check = MMC_BLK_PARTIAL;
+			}
+			pr_err("%s: packed cmd failed, nr %u, sectors %u, failiure index:%d\n",
+			       req->rq_disk->disk_name, packed->nr_entries,
+			       packed->blocks, packed->idx_failure);
+		}
+free:
+		kfree(ext_csd);
+	}
+
+	return check;
+}
+
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
 			       int disable_multi,
@@ -1297,10 +1388,221 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	mmc_queue_bounce_pre(mqrq);
 }
 
+static inline u8 mmc_calc_packed_hdr_segs(struct request_queue *q,
+					  struct mmc_card *card)
+{
+	unsigned int hdr_sz = mmc_large_sector(card) ? 4096 : 512;
+	unsigned int max_seg_sz = queue_max_segment_size(q);
+	unsigned int len, nr_segs = 0;
+
+	do {
+		len = min(hdr_sz, max_seg_sz);
+		hdr_sz -= len;
+		nr_segs++;
+	} while (hdr_sz);
+
+	return nr_segs;
+}
+
+static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
+{
+	struct request_queue *q = mq->queue;
+	struct mmc_card *card = mq->card;
+	struct request *cur = req, *next = NULL;
+	struct mmc_blk_data *md = mq->data;
+	struct mmc_queue_req *mqrq = mq->mqrq_cur;
+	bool en_rel_wr = card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN;
+	unsigned int req_sectors = 0, phys_segments = 0;
+	unsigned int max_blk_count, max_phys_segs;
+	bool put_back = true;
+	u8 max_packed_rw = 0;
+	u8 reqs = 0;
+
+	if (!(md->flags & MMC_BLK_PACKED_CMD))
+		goto no_packed;
+
+	if ((rq_data_dir(cur) == WRITE) &&
+	    mmc_host_packed_wr(card->host))
+		max_packed_rw = card->ext_csd.max_packed_writes;
+
+	if (max_packed_rw == 0)
+		goto no_packed;
+
+	if (mmc_req_rel_wr(cur) &&
+	    (md->flags & MMC_BLK_REL_WR) && !en_rel_wr)
+		goto no_packed;
+
+	if (mmc_large_sector(card) &&
+	    !IS_ALIGNED(blk_rq_sectors(cur), 8))
+		goto no_packed;
+
+	mmc_blk_clear_packed(mqrq);
+
+	max_blk_count = min(card->host->max_blk_count,
+			card->host->max_req_size >> 9);
+	if (unlikely(max_blk_count > 0xffff))
+		max_blk_count = 0xffff;
+
+	max_phys_segs = queue_max_segments(q);
+	req_sectors += blk_rq_sectors(cur);
+	phys_segments += cur->nr_phys_segments;
+
+	if (rq_data_dir(cur) == WRITE) {
+		req_sectors += mmc_large_sector(card) ? 8 : 1;
+		phys_segments += mmc_calc_packed_hdr_segs(q, card);
+	}
+
+	do {
+		if (reqs >= max_packed_rw - 1) {
+			put_back = false;
+			break;
+		}
+
+		spin_lock_irq(q->queue_lock);
+		next = blk_fetch_request(q);
+		spin_unlock_irq(q->queue_lock);
+		if (!next) {
+			put_back = false;
+			break;
+		}
+
+		if (mmc_large_sector(card) &&
+		    !IS_ALIGNED(blk_rq_sectors(next), 8))
+			break;
+
+		if (next->cmd_flags & REQ_DISCARD ||
+		    next->cmd_flags & REQ_FLUSH)
+			break;
+
+		if (rq_data_dir(cur) != rq_data_dir(next))
+			break;
+
+		if (mmc_req_rel_wr(next) &&
+		    (md->flags & MMC_BLK_REL_WR) && !en_rel_wr)
+			break;
+
+		req_sectors += blk_rq_sectors(next);
+		if (req_sectors > max_blk_count)
+			break;
+
+		phys_segments +=  next->nr_phys_segments;
+		if (phys_segments > max_phys_segs)
+			break;
+
+		list_add_tail(&next->queuelist, &mqrq->packed->list);
+		cur = next;
+		reqs++;
+	} while (1);
+
+	if (put_back) {
+		spin_lock_irq(q->queue_lock);
+		blk_requeue_request(q, next);
+		spin_unlock_irq(q->queue_lock);
+	}
+
+	if (reqs > 0) {
+		list_add(&req->queuelist, &mqrq->packed->list);
+		mqrq->packed->nr_entries = ++reqs;
+		mqrq->packed->retries = reqs;
+		return reqs;
+	}
+
+no_packed:
+	mqrq->cmd_type = MMC_PACKED_NONE;
+	return 0;
+}
+
+static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
+					struct mmc_card *card,
+					struct mmc_queue *mq)
+{
+	struct mmc_blk_request *brq = &mqrq->brq;
+	struct request *req = mqrq->req;
+	struct request *prq;
+	struct mmc_blk_data *md = mq->data;
+	struct mmc_packed *packed = mqrq->packed;
+	bool do_rel_wr, do_data_tag;
+	u32 *packed_cmd_hdr;
+	u8 hdr_blocks;
+	u8 i = 1;
+
+	BUG_ON(!packed);
+
+	mqrq->cmd_type = MMC_PACKED_WRITE;
+	packed->blocks = 0;
+	packed->idx_failure = MMC_PACKED_NR_IDX;
+
+	packed_cmd_hdr = packed->cmd_hdr;
+	memset(packed_cmd_hdr, 0, sizeof(packed->cmd_hdr));
+	packed_cmd_hdr[0] = (packed->nr_entries << 16) |
+		(PACKED_CMD_WR << 8) | PACKED_CMD_VER;
+	hdr_blocks = mmc_large_sector(card) ? 8 : 1;
+
+	/*
+	 * Argument for each entry of packed group
+	 */
+	list_for_each_entry(prq, &packed->list, queuelist) {
+		do_rel_wr = mmc_req_rel_wr(prq) && (md->flags & MMC_BLK_REL_WR);
+		do_data_tag = (card->ext_csd.data_tag_unit_size) &&
+			(prq->cmd_flags & REQ_META) &&
+			(rq_data_dir(prq) == WRITE) &&
+			((brq->data.blocks * brq->data.blksz) >=
+			 card->ext_csd.data_tag_unit_size);
+		/* Argument of CMD23 */
+		packed_cmd_hdr[(i * 2)] =
+			(do_rel_wr ? MMC_CMD23_ARG_REL_WR : 0) |
+			(do_data_tag ? MMC_CMD23_ARG_TAG_REQ : 0) |
+			blk_rq_sectors(prq);
+		/* Argument of CMD18 or CMD25 */
+		packed_cmd_hdr[((i * 2)) + 1] =
+			mmc_card_blockaddr(card) ?
+			blk_rq_pos(prq) : blk_rq_pos(prq) << 9;
+		packed->blocks += blk_rq_sectors(prq);
+		i++;
+	}
+
+	memset(brq, 0, sizeof(struct mmc_blk_request));
+	brq->mrq.cmd = &brq->cmd;
+	brq->mrq.data = &brq->data;
+	brq->mrq.sbc = &brq->sbc;
+	brq->mrq.stop = &brq->stop;
+
+	brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
+	brq->sbc.arg = MMC_CMD23_ARG_PACKED | (packed->blocks + hdr_blocks);
+	brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	brq->cmd.opcode = MMC_WRITE_MULTIPLE_BLOCK;
+	brq->cmd.arg = blk_rq_pos(req);
+	if (!mmc_card_blockaddr(card))
+		brq->cmd.arg <<= 9;
+	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	brq->data.blksz = 512;
+	brq->data.blocks = packed->blocks + hdr_blocks;
+	brq->data.flags |= MMC_DATA_WRITE;
+
+	brq->stop.opcode = MMC_STOP_TRANSMISSION;
+	brq->stop.arg = 0;
+	brq->stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+
+	mmc_set_data_timeout(&brq->data, card);
+
+	brq->data.sg = mqrq->sg;
+	brq->data.sg_len = mmc_queue_map_sg(mq, mqrq);
+
+	mqrq->mmc_active.mrq = &brq->mrq;
+	mqrq->mmc_active.err_check = mmc_blk_packed_err_check;
+
+	mmc_queue_bounce_pre(mqrq);
+}
+
 static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 			   struct mmc_blk_request *brq, struct request *req,
 			   int ret)
 {
+	struct mmc_queue_req *mq_rq;
+	mq_rq = container_of(brq, struct mmc_queue_req, brq);
+
 	/*
 	 * If this is an SD card and we're writing, we can first
 	 * mark the known good sectors as ok.
@@ -1317,11 +1619,84 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 			ret = blk_end_request(req, 0, blocks << 9);
 		}
 	} else {
-		ret = blk_end_request(req, 0, brq->data.bytes_xfered);
+		if (!mmc_packed_cmd(mq_rq->cmd_type))
+			ret = blk_end_request(req, 0, brq->data.bytes_xfered);
 	}
 	return ret;
 }
 
+static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_rq)
+{
+	struct request *prq;
+	struct mmc_packed *packed = mq_rq->packed;
+	int idx = packed->idx_failure, i = 0;
+	int ret = 0;
+
+	BUG_ON(!packed);
+
+	while (!list_empty(&packed->list)) {
+		prq = list_entry_rq(packed->list.next);
+		if (idx == i) {
+			/* retry from error index */
+			packed->nr_entries -= idx;
+			mq_rq->req = prq;
+			ret = 1;
+
+			if (packed->nr_entries == MMC_PACKED_NR_SINGLE) {
+				list_del_init(&prq->queuelist);
+				mmc_blk_clear_packed(mq_rq);
+			}
+			return ret;
+		}
+		list_del_init(&prq->queuelist);
+		blk_end_request(prq, 0, blk_rq_bytes(prq));
+		i++;
+	}
+
+	mmc_blk_clear_packed(mq_rq);
+	return ret;
+}
+
+static void mmc_blk_abort_packed_req(struct mmc_queue_req *mq_rq)
+{
+	struct request *prq;
+	struct mmc_packed *packed = mq_rq->packed;
+
+	BUG_ON(!packed);
+
+	while (!list_empty(&packed->list)) {
+		prq = list_entry_rq(packed->list.next);
+		list_del_init(&prq->queuelist);
+		blk_end_request(prq, -EIO, blk_rq_bytes(prq));
+	}
+
+	mmc_blk_clear_packed(mq_rq);
+}
+
+static void mmc_blk_revert_packed_req(struct mmc_queue *mq,
+				      struct mmc_queue_req *mq_rq)
+{
+	struct request *prq;
+	struct request_queue *q = mq->queue;
+	struct mmc_packed *packed = mq_rq->packed;
+
+	BUG_ON(!packed);
+
+	while (!list_empty(&packed->list)) {
+		prq = list_entry_rq(packed->list.prev);
+		if (prq->queuelist.prev != &packed->list) {
+			list_del_init(&prq->queuelist);
+			spin_lock_irq(q->queue_lock);
+			blk_requeue_request(mq->queue, prq);
+			spin_unlock_irq(q->queue_lock);
+		} else {
+			list_del_init(&prq->queuelist);
+		}
+	}
+
+	mmc_blk_clear_packed(mq_rq);
+}
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
 	struct mmc_blk_data *md = mq->data;
@@ -1332,10 +1707,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	struct mmc_queue_req *mq_rq;
 	struct request *req = rqc;
 	struct mmc_async_req *areq;
+	const u8 packed_nr = 2;
+	u8 reqs = 0;
 
 	if (!rqc && !mq->mqrq_prev->req)
 		return 0;
 
+	if (rqc)
+		reqs = mmc_blk_prep_packed_list(mq, rqc);
+
 	do {
 		if (rqc) {
 			/*
@@ -1346,9 +1726,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			    (card->ext_csd.data_sector_size == 4096)) {
 				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
 					req->rq_disk->disk_name);
+				mq_rq = mq->mqrq_cur;
 				goto cmd_abort;
 			}
-			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
+
+			if (reqs >= packed_nr)
+				mmc_blk_packed_hdr_wrq_prep(mq->mqrq_cur,
+						card, mq);
+			else
+				mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
 			areq = &mq->mqrq_cur->mmc_active;
 		} else
 			areq = NULL;
@@ -1372,8 +1758,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 * A block was successfully transferred.
 			 */
 			mmc_blk_reset_success(md, type);
-			ret = blk_end_request(req, 0,
+
+			if (mmc_packed_cmd(mq_rq->cmd_type)) {
+				ret = mmc_blk_end_packed_req(mq_rq);
+				break;
+			} else {
+				ret = blk_end_request(req, 0,
 						brq->data.bytes_xfered);
+			}
+
 			/*
 			 * If the blk_end_request function returns non-zero even
 			 * though all data has been transferred and no errors
@@ -1406,7 +1799,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			err = mmc_blk_reset(md, card->host, type);
 			if (!err)
 				break;
-			if (err == -ENODEV)
+			if (err == -ENODEV ||
+				mmc_packed_cmd(mq_rq->cmd_type))
 				goto cmd_abort;
 			/* Fall through */
 		}
@@ -1437,22 +1831,38 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		}
 
 		if (ret) {
-			/*
-			 * In case of a incomplete request
-			 * prepare it again and resend.
-			 */
-			mmc_blk_rw_rq_prep(mq_rq, card, disable_multi, mq);
-			mmc_start_req(card->host, &mq_rq->mmc_active, NULL);
+			if (mmc_packed_cmd(mq_rq->cmd_type)) {
+				if (!mq_rq->packed->retries)
+					goto cmd_abort;
+				mmc_blk_packed_hdr_wrq_prep(mq_rq, card, mq);
+				mmc_start_req(card->host,
+					      &mq_rq->mmc_active, NULL);
+			} else {
+
+				/*
+				 * In case of a incomplete request
+				 * prepare it again and resend.
+				 */
+				mmc_blk_rw_rq_prep(mq_rq, card,
+						disable_multi, mq);
+				mmc_start_req(card->host,
+						&mq_rq->mmc_active, NULL);
+			}
 		}
 	} while (ret);
 
 	return 1;
 
  cmd_abort:
-	if (mmc_card_removed(card))
-		req->cmd_flags |= REQ_QUIET;
-	while (ret)
-		ret = blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
+	if (mmc_packed_cmd(mq_rq->cmd_type)) {
+		mmc_blk_abort_packed_req(mq_rq);
+	} else {
+		if (mmc_card_removed(card))
+			req->cmd_flags |= REQ_QUIET;
+		while (ret)
+			ret = blk_end_request(req, -EIO,
+					blk_rq_cur_bytes(req));
+	}
 
  start_new_req:
 	if (rqc) {
@@ -1460,6 +1870,12 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			rqc->cmd_flags |= REQ_QUIET;
 			blk_end_request_all(rqc, -EIO);
 		} else {
+			/*
+			 * If current request is packed, it needs to put back.
+			 */
+			if (mmc_packed_cmd(mq->mqrq_cur->cmd_type))
+				mmc_blk_revert_packed_req(mq, mq->mqrq_cur);
+
 			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
 			mmc_start_req(card->host,
 				      &mq->mqrq_cur->mmc_active, NULL);
@@ -1634,6 +2050,14 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		blk_queue_flush(md->queue.queue, REQ_FLUSH | REQ_FUA);
 	}
 
+	if (mmc_card_mmc(card) &&
+	    (area_type == MMC_BLK_DATA_AREA_MAIN) &&
+	    (md->flags & MMC_BLK_CMD23) &&
+	    card->ext_csd.packed_event_en) {
+		if (!mmc_packed_init(&md->queue, card))
+			md->flags |= MMC_BLK_PACKED_CMD;
+	}
+
 	return md;
 
  err_putdisk:
@@ -1742,6 +2166,8 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 
 		/* Then flush out any already in there */
 		mmc_cleanup_queue(&md->queue);
+		if (md->flags & MMC_BLK_PACKED_CMD)
+			mmc_packed_clean(&md->queue);
 		mmc_blk_put(md);
 	}
 }
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 5e09710..c0d1315 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -362,6 +362,49 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
 
+int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
+{
+	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
+	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
+	int ret = 0;
+
+
+	mqrq_cur->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
+	if (!mqrq_cur->packed) {
+		pr_warn("%s: unable to allocate packed cmd for mqrq_cur\n",
+			   mmc_card_name(card));
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	mqrq_prev->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
+	if (!mqrq_cur->packed) {
+		pr_warn("%s: unable to allocate packed cmd for mqrq_prev\n",
+			   mmc_card_name(card));
+		kfree(mqrq_cur->packed);
+		mqrq_cur->packed = NULL;
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&mqrq_cur->packed->list);
+	INIT_LIST_HEAD(&mqrq_prev->packed->list);
+
+out:
+	return ret;
+}
+
+void mmc_packed_clean(struct mmc_queue *mq)
+{
+	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
+	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
+
+	kfree(mqrq_cur->packed);
+	mqrq_cur->packed = NULL;
+	kfree(mqrq_prev->packed);
+	mqrq_prev->packed = NULL;
+}
+
 /**
  * mmc_queue_suspend - suspend a MMC request queue
  * @mq: MMC queue to suspend
@@ -406,6 +449,41 @@ void mmc_queue_resume(struct mmc_queue *mq)
 	}
 }
 
+static unsigned int mmc_queue_packed_map_sg(struct mmc_queue *mq,
+					    struct mmc_packed *packed,
+					    struct scatterlist *sg,
+					    enum mmc_packed_type cmd_type)
+{
+	struct scatterlist *__sg = sg;
+	unsigned int sg_len = 0;
+	struct request *req;
+
+	if (mmc_packed_wr(cmd_type)) {
+		unsigned int hdr_sz = mmc_large_sector(mq->card) ? 4096 : 512;
+		unsigned int max_seg_sz = queue_max_segment_size(mq->queue);
+		unsigned int len, remain, offset = 0;
+		u8 *buf = (u8 *)packed->cmd_hdr;
+
+		remain = hdr_sz;
+		do {
+			len = min(remain, max_seg_sz);
+			sg_set_buf(__sg, buf + offset, len);
+			offset += len;
+			remain -= len;
+			(__sg++)->page_link &= ~0x02;
+			sg_len++;
+		} while (remain);
+	}
+
+	list_for_each_entry(req, &packed->list, queuelist) {
+		sg_len += blk_rq_map_sg(mq->queue, req, __sg);
+		__sg = sg + (sg_len - 1);
+		(__sg++)->page_link &= ~0x02;
+	}
+	sg_mark_end(sg + (sg_len - 1));
+	return sg_len;
+}
+
 /*
  * Prepare the sg list(s) to be handed of to the host driver
  */
@@ -414,14 +492,26 @@ unsigned int mmc_queue_map_sg(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 	unsigned int sg_len;
 	size_t buflen;
 	struct scatterlist *sg;
+	enum mmc_packed_type cmd_type;
 	int i;
 
-	if (!mqrq->bounce_buf)
-		return blk_rq_map_sg(mq->queue, mqrq->req, mqrq->sg);
+	cmd_type = mqrq->cmd_type;
+
+	if (!mqrq->bounce_buf) {
+		if (mmc_packed_cmd(cmd_type))
+			return mmc_queue_packed_map_sg(mq, mqrq->packed,
+						       mqrq->sg, cmd_type);
+		else
+			return blk_rq_map_sg(mq->queue, mqrq->req, mqrq->sg);
+	}
 
 	BUG_ON(!mqrq->bounce_sg);
 
-	sg_len = blk_rq_map_sg(mq->queue, mqrq->req, mqrq->bounce_sg);
+	if (mmc_packed_cmd(cmd_type))
+		sg_len = mmc_queue_packed_map_sg(mq, mqrq->packed,
+						 mqrq->bounce_sg, cmd_type);
+	else
+		sg_len = blk_rq_map_sg(mq->queue, mqrq->req, mqrq->bounce_sg);
 
 	mqrq->bounce_sg_len = sg_len;
 
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index e20c27b..031bf63 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -12,6 +12,23 @@ struct mmc_blk_request {
 	struct mmc_data		data;
 };
 
+enum mmc_packed_type {
+	MMC_PACKED_NONE = 0,
+	MMC_PACKED_WRITE,
+};
+
+#define mmc_packed_cmd(type)	((type) != MMC_PACKED_NONE)
+#define mmc_packed_wr(type)	((type) == MMC_PACKED_WRITE)
+
+struct mmc_packed {
+	struct list_head	list;
+	u32			cmd_hdr[1024];
+	unsigned int		blocks;
+	u8			nr_entries;
+	u8			retries;
+	s16			idx_failure;
+};
+
 struct mmc_queue_req {
 	struct request		*req;
 	struct mmc_blk_request	brq;
@@ -20,6 +37,8 @@ struct mmc_queue_req {
 	struct scatterlist	*bounce_sg;
 	unsigned int		bounce_sg_len;
 	struct mmc_async_req	mmc_active;
+	enum mmc_packed_type	cmd_type;
+	struct mmc_packed	*packed;
 };
 
 struct mmc_queue {
@@ -49,4 +68,7 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 extern void mmc_queue_bounce_pre(struct mmc_queue_req *);
 extern void mmc_queue_bounce_post(struct mmc_queue_req *);
 
+extern int mmc_packed_init(struct mmc_queue *, struct mmc_card *);
+extern void mmc_packed_clean(struct mmc_queue *);
+
 #endif
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 6d8f701..49f04bc 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -363,6 +363,7 @@ int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	return mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD,
 			ext_csd, 512);
 }
+EXPORT_SYMBOL_GPL(mmc_send_ext_csd);
 
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp)
 {
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 237f253..61b2c30 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -310,6 +310,11 @@ static inline void mmc_part_add(struct mmc_card *card, unsigned int size,
 	card->nr_parts++;
 }
 
+static inline bool mmc_large_sector(struct mmc_card *card)
+{
+	return card->ext_csd.data_sector_size == 4096;
+}
+
 /*
  *  The world is not perfect and supplies us with broken mmc/sdio devices.
  *  For at least some of these bugs we need a work-around.
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 495d133..39613b9 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -18,6 +18,9 @@ struct mmc_request;
 struct mmc_command {
 	u32			opcode;
 	u32			arg;
+#define MMC_CMD23_ARG_REL_WR	(1 << 31)
+#define MMC_CMD23_ARG_PACKED	((0 << 31) | (1 << 30))
+#define MMC_CMD23_ARG_TAG_REQ	(1 << 29)
 	u32			resp[4];
 	unsigned int		flags;		/* expected response type */
 #define MMC_RSP_PRESENT	(1 << 0)
@@ -148,6 +151,7 @@ extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
+extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
 
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index b8e4ea2..1a70c62 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -463,6 +463,11 @@ static inline int mmc_host_uhs(struct mmc_host *host)
 		 MMC_CAP_UHS_DDR50);
 }
 
+static inline int mmc_host_packed_wr(struct mmc_host *host)
+{
+	return host->caps2 & MMC_CAP2_PACKED_WR;
+}
+
 #ifdef CONFIG_MMC_CLKGATE
 void mmc_host_clk_hold(struct mmc_host *host);
 void mmc_host_clk_release(struct mmc_host *host);
-- 
1.7.0.4


