From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: block: delete packed command support
Date: Mon, 21 Nov 2016 11:08:57 +0100
Message-ID: <1479722937-19551-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36516 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbcKUKJS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2016 05:09:18 -0500
Received: by mail-wm0-f48.google.com with SMTP id g23so137347352wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2016 02:09:17 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>

I've had it with this code now.

The packed command support is a complex hurdle in the MMC/SD block
layer, around 500+ lines of code which was introduced in 2013 in
commits

ce39f9d17c14 ("mmc: support packed write command for eMMC4.5 devices")
abd9ac144947 ("mmc: add packed command feature of eMMC4.5")

...and since then it has been rotting. The original author of the
code has disappeared from the community and the mail address is
bouncing.

For the code to be exercised the host must flag that it supports
packed commands, so in mmc_blk_prep_packed_list() which is called for
every single request, the following construction appears:

u8 max_packed_rw = 0;

if ((rq_data_dir(cur) == WRITE) &&
    mmc_host_packed_wr(card->host))
        max_packed_rw = card->ext_csd.max_packed_writes;

if (max_packed_rw == 0)
    goto no_packed;

This has the following logical deductions:

- Only WRITE commands can really be packed, so the solution is
  only half-done: we support packed WRITE but not packed READ.
  The packed command support has not been finalized by supporting
  reads in three years!

- mmc_host_packed_wr() is just a static inline that checks
  host->caps2 & MMC_CAP2_PACKED_WR. The problem with this is
  that NO upstream host sets this capability flag! No driver
  in the kernel is using it, and we can't test it. Packed
  command may be supported in out-of-tree code, but I doubt
  it. I doubt that the code is even working anymore due to
  other refactorings in the MMC block layer, who would
  notice if patches affecting it broke packed commands?
  No one.

- There is no Device Tree binding or code to mark a host as
  supporting packed read or write commands, just this flag
  in caps2, so for sure there are not any DT systems using
  it either.

It has other problems as well: mmc_blk_prep_packed_list() is
speculatively picking requests out of the request queue with
blk_fetch_request() making the MMC/SD stack harder to convert
to the multiqueue block layer. By this we get rid of an
obstacle.

The way I see it this is just cruft littering the MMC/SD
stack.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Namjae Jeon <namjae.jeon@samsung.com>
Cc: Maya Erez <qca_merez@qca.qualcomm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
If you are using the packed command and ready to step up and
finalize the READ support, integrate a host to actually use
it upstream, provide proper device tree bindings and and work
to support it in the future: step up NOW or the code will
be deleted.
---
 drivers/mmc/card/block.c | 482 ++---------------------------------------------
 drivers/mmc/card/queue.c |  53 +-----
 drivers/mmc/card/queue.h |  19 --
 include/linux/mmc/host.h |   5 -
 4 files changed, 20 insertions(+), 539 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index ea9de876a846..b1d6392ed8d3 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -65,9 +65,6 @@ MODULE_ALIAS("mmc:block");
 
 #define mmc_req_rel_wr(req)	((req->cmd_flags & REQ_FUA) && \
 				  (rq_data_dir(req) == WRITE))
-#define PACKED_CMD_VER	0x01
-#define PACKED_CMD_WR	0x02
-
 static DEFINE_MUTEX(block_mutex);
 
 /*
@@ -101,7 +98,6 @@ struct mmc_blk_data {
 	unsigned int	flags;
 #define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
 #define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
-#define MMC_BLK_PACKED_CMD	(1 << 2)	/* MMC packed command support */
 
 	unsigned int	usage;
 	unsigned int	read_only;
@@ -125,12 +121,6 @@ struct mmc_blk_data {
 
 static DEFINE_MUTEX(open_lock);
 
-enum {
-	MMC_PACKED_NR_IDX = -1,
-	MMC_PACKED_NR_ZERO,
-	MMC_PACKED_NR_SINGLE,
-};
-
 module_param(perdev_minors, int, 0444);
 MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
 
@@ -138,17 +128,6 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      struct mmc_blk_data *md);
 static int get_card_status(struct mmc_card *card, u32 *status, int retries);
 
-static inline void mmc_blk_clear_packed(struct mmc_queue_req *mqrq)
-{
-	struct mmc_packed *packed = mqrq->packed;
-
-	mqrq->cmd_type = MMC_PACKED_NONE;
-	packed->nr_entries = MMC_PACKED_NR_ZERO;
-	packed->idx_failure = MMC_PACKED_NR_IDX;
-	packed->retries = 0;
-	packed->blocks = 0;
-}
-
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
 	struct mmc_blk_data *md;
@@ -1419,111 +1398,12 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 	if (!brq->data.bytes_xfered)
 		return MMC_BLK_RETRY;
 
-	if (mmc_packed_cmd(mq_mrq->cmd_type)) {
-		if (unlikely(brq->data.blocks << 9 != brq->data.bytes_xfered))
-			return MMC_BLK_PARTIAL;
-		else
-			return MMC_BLK_SUCCESS;
-	}
-
 	if (blk_rq_bytes(req) != brq->data.bytes_xfered)
 		return MMC_BLK_PARTIAL;
 
 	return MMC_BLK_SUCCESS;
 }
 
-static int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
-{
-	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
-	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
-	int ret = 0;
-
-
-	mqrq_cur->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
-	if (!mqrq_cur->packed) {
-		pr_warn("%s: unable to allocate packed cmd for mqrq_cur\n",
-			mmc_card_name(card));
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	mqrq_prev->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
-	if (!mqrq_prev->packed) {
-		pr_warn("%s: unable to allocate packed cmd for mqrq_prev\n",
-			mmc_card_name(card));
-		kfree(mqrq_cur->packed);
-		mqrq_cur->packed = NULL;
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	INIT_LIST_HEAD(&mqrq_cur->packed->list);
-	INIT_LIST_HEAD(&mqrq_prev->packed->list);
-
-out:
-	return ret;
-}
-
-static void mmc_packed_clean(struct mmc_queue *mq)
-{
-	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
-	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
-
-	kfree(mqrq_cur->packed);
-	mqrq_cur->packed = NULL;
-	kfree(mqrq_prev->packed);
-	mqrq_prev->packed = NULL;
-}
-
-static enum mmc_blk_status mmc_blk_packed_err_check(struct mmc_card *card,
-						    struct mmc_async_req *areq)
-{
-	struct mmc_queue_req *mq_rq = container_of(areq, struct mmc_queue_req,
-			mmc_active);
-	struct request *req = mq_rq->req;
-	struct mmc_packed *packed = mq_rq->packed;
-	enum mmc_blk_status status, check;
-	int err;
-	u8 *ext_csd;
-
-	packed->retries--;
-	check = mmc_blk_err_check(card, areq);
-	err = get_card_status(card, &status, 0);
-	if (err) {
-		pr_err("%s: error %d sending status command\n",
-		       req->rq_disk->disk_name, err);
-		return MMC_BLK_ABORT;
-	}
-
-	if (status & R1_EXCEPTION_EVENT) {
-		err = mmc_get_ext_csd(card, &ext_csd);
-		if (err) {
-			pr_err("%s: error %d sending ext_csd\n",
-			       req->rq_disk->disk_name, err);
-			return MMC_BLK_ABORT;
-		}
-
-		if ((ext_csd[EXT_CSD_EXP_EVENTS_STATUS] &
-		     EXT_CSD_PACKED_FAILURE) &&
-		    (ext_csd[EXT_CSD_PACKED_CMD_STATUS] &
-		     EXT_CSD_PACKED_GENERIC_ERROR)) {
-			if (ext_csd[EXT_CSD_PACKED_CMD_STATUS] &
-			    EXT_CSD_PACKED_INDEXED_ERROR) {
-				packed->idx_failure =
-				  ext_csd[EXT_CSD_PACKED_FAILURE_INDEX] - 1;
-				check = MMC_BLK_PARTIAL;
-			}
-			pr_err("%s: packed cmd failed, nr %u, sectors %u, "
-			       "failure index: %d\n",
-			       req->rq_disk->disk_name, packed->nr_entries,
-			       packed->blocks, packed->idx_failure);
-		}
-		kfree(ext_csd);
-	}
-
-	return check;
-}
-
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
 			       int disable_multi,
@@ -1684,222 +1564,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	mmc_queue_bounce_pre(mqrq);
 }
 
-static inline u8 mmc_calc_packed_hdr_segs(struct request_queue *q,
-					  struct mmc_card *card)
-{
-	unsigned int hdr_sz = mmc_large_sector(card) ? 4096 : 512;
-	unsigned int max_seg_sz = queue_max_segment_size(q);
-	unsigned int len, nr_segs = 0;
-
-	do {
-		len = min(hdr_sz, max_seg_sz);
-		hdr_sz -= len;
-		nr_segs++;
-	} while (hdr_sz);
-
-	return nr_segs;
-}
-
-static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
-{
-	struct request_queue *q = mq->queue;
-	struct mmc_card *card = mq->card;
-	struct request *cur = req, *next = NULL;
-	struct mmc_blk_data *md = mq->blkdata;
-	struct mmc_queue_req *mqrq = mq->mqrq_cur;
-	bool en_rel_wr = card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN;
-	unsigned int req_sectors = 0, phys_segments = 0;
-	unsigned int max_blk_count, max_phys_segs;
-	bool put_back = true;
-	u8 max_packed_rw = 0;
-	u8 reqs = 0;
-
-	/*
-	 * We don't need to check packed for any further
-	 * operation of packed stuff as we set MMC_PACKED_NONE
-	 * and return zero for reqs if geting null packed. Also
-	 * we clean the flag of MMC_BLK_PACKED_CMD to avoid doing
-	 * it again when removing blk req.
-	 */
-	if (!mqrq->packed) {
-		md->flags &= (~MMC_BLK_PACKED_CMD);
-		goto no_packed;
-	}
-
-	if (!(md->flags & MMC_BLK_PACKED_CMD))
-		goto no_packed;
-
-	if ((rq_data_dir(cur) == WRITE) &&
-	    mmc_host_packed_wr(card->host))
-		max_packed_rw = card->ext_csd.max_packed_writes;
-
-	if (max_packed_rw == 0)
-		goto no_packed;
-
-	if (mmc_req_rel_wr(cur) &&
-	    (md->flags & MMC_BLK_REL_WR) && !en_rel_wr)
-		goto no_packed;
-
-	if (mmc_large_sector(card) &&
-	    !IS_ALIGNED(blk_rq_sectors(cur), 8))
-		goto no_packed;
-
-	mmc_blk_clear_packed(mqrq);
-
-	max_blk_count = min(card->host->max_blk_count,
-			    card->host->max_req_size >> 9);
-	if (unlikely(max_blk_count > 0xffff))
-		max_blk_count = 0xffff;
-
-	max_phys_segs = queue_max_segments(q);
-	req_sectors += blk_rq_sectors(cur);
-	phys_segments += cur->nr_phys_segments;
-
-	if (rq_data_dir(cur) == WRITE) {
-		req_sectors += mmc_large_sector(card) ? 8 : 1;
-		phys_segments += mmc_calc_packed_hdr_segs(q, card);
-	}
-
-	do {
-		if (reqs >= max_packed_rw - 1) {
-			put_back = false;
-			break;
-		}
-
-		spin_lock_irq(q->queue_lock);
-		next = blk_fetch_request(q);
-		spin_unlock_irq(q->queue_lock);
-		if (!next) {
-			put_back = false;
-			break;
-		}
-
-		if (mmc_large_sector(card) &&
-		    !IS_ALIGNED(blk_rq_sectors(next), 8))
-			break;
-
-		if (mmc_req_is_special(next))
-			break;
-
-		if (rq_data_dir(cur) != rq_data_dir(next))
-			break;
-
-		if (mmc_req_rel_wr(next) &&
-		    (md->flags & MMC_BLK_REL_WR) && !en_rel_wr)
-			break;
-
-		req_sectors += blk_rq_sectors(next);
-		if (req_sectors > max_blk_count)
-			break;
-
-		phys_segments +=  next->nr_phys_segments;
-		if (phys_segments > max_phys_segs)
-			break;
-
-		list_add_tail(&next->queuelist, &mqrq->packed->list);
-		cur = next;
-		reqs++;
-	} while (1);
-
-	if (put_back) {
-		spin_lock_irq(q->queue_lock);
-		blk_requeue_request(q, next);
-		spin_unlock_irq(q->queue_lock);
-	}
-
-	if (reqs > 0) {
-		list_add(&req->queuelist, &mqrq->packed->list);
-		mqrq->packed->nr_entries = ++reqs;
-		mqrq->packed->retries = reqs;
-		return reqs;
-	}
-
-no_packed:
-	mqrq->cmd_type = MMC_PACKED_NONE;
-	return 0;
-}
-
-static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
-					struct mmc_card *card,
-					struct mmc_queue *mq)
-{
-	struct mmc_blk_request *brq = &mqrq->brq;
-	struct request *req = mqrq->req;
-	struct request *prq;
-	struct mmc_blk_data *md = mq->blkdata;
-	struct mmc_packed *packed = mqrq->packed;
-	bool do_rel_wr, do_data_tag;
-	u32 *packed_cmd_hdr;
-	u8 hdr_blocks;
-	u8 i = 1;
-
-	mqrq->cmd_type = MMC_PACKED_WRITE;
-	packed->blocks = 0;
-	packed->idx_failure = MMC_PACKED_NR_IDX;
-
-	packed_cmd_hdr = packed->cmd_hdr;
-	memset(packed_cmd_hdr, 0, sizeof(packed->cmd_hdr));
-	packed_cmd_hdr[0] = cpu_to_le32((packed->nr_entries << 16) |
-		(PACKED_CMD_WR << 8) | PACKED_CMD_VER);
-	hdr_blocks = mmc_large_sector(card) ? 8 : 1;
-
-	/*
-	 * Argument for each entry of packed group
-	 */
-	list_for_each_entry(prq, &packed->list, queuelist) {
-		do_rel_wr = mmc_req_rel_wr(prq) && (md->flags & MMC_BLK_REL_WR);
-		do_data_tag = (card->ext_csd.data_tag_unit_size) &&
-			(prq->cmd_flags & REQ_META) &&
-			(rq_data_dir(prq) == WRITE) &&
-			blk_rq_bytes(prq) >= card->ext_csd.data_tag_unit_size;
-		/* Argument of CMD23 */
-		packed_cmd_hdr[(i * 2)] = cpu_to_le32(
-			(do_rel_wr ? MMC_CMD23_ARG_REL_WR : 0) |
-			(do_data_tag ? MMC_CMD23_ARG_TAG_REQ : 0) |
-			blk_rq_sectors(prq));
-		/* Argument of CMD18 or CMD25 */
-		packed_cmd_hdr[((i * 2)) + 1] = cpu_to_le32(
-			mmc_card_blockaddr(card) ?
-			blk_rq_pos(prq) : blk_rq_pos(prq) << 9);
-		packed->blocks += blk_rq_sectors(prq);
-		i++;
-	}
-
-	memset(brq, 0, sizeof(struct mmc_blk_request));
-	brq->mrq.cmd = &brq->cmd;
-	brq->mrq.data = &brq->data;
-	brq->mrq.sbc = &brq->sbc;
-	brq->mrq.stop = &brq->stop;
-
-	brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
-	brq->sbc.arg = MMC_CMD23_ARG_PACKED | (packed->blocks + hdr_blocks);
-	brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
-
-	brq->cmd.opcode = MMC_WRITE_MULTIPLE_BLOCK;
-	brq->cmd.arg = blk_rq_pos(req);
-	if (!mmc_card_blockaddr(card))
-		brq->cmd.arg <<= 9;
-	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
-
-	brq->data.blksz = 512;
-	brq->data.blocks = packed->blocks + hdr_blocks;
-	brq->data.flags = MMC_DATA_WRITE;
-
-	brq->stop.opcode = MMC_STOP_TRANSMISSION;
-	brq->stop.arg = 0;
-	brq->stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-
-	mmc_set_data_timeout(&brq->data, card);
-
-	brq->data.sg = mqrq->sg;
-	brq->data.sg_len = mmc_queue_map_sg(mq, mqrq);
-
-	mqrq->mmc_active.mrq = &brq->mrq;
-	mqrq->mmc_active.err_check = mmc_blk_packed_err_check;
-
-	mmc_queue_bounce_pre(mqrq);
-}
-
 static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 			   struct mmc_blk_request *brq, struct request *req,
 			   int ret)
@@ -1922,79 +1586,10 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 		if (blocks != (u32)-1) {
 			ret = blk_end_request(req, 0, blocks << 9);
 		}
-	} else {
-		if (!mmc_packed_cmd(mq_rq->cmd_type))
-			ret = blk_end_request(req, 0, brq->data.bytes_xfered);
-	}
-	return ret;
-}
-
-static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_rq)
-{
-	struct request *prq;
-	struct mmc_packed *packed = mq_rq->packed;
-	int idx = packed->idx_failure, i = 0;
-	int ret = 0;
-
-	while (!list_empty(&packed->list)) {
-		prq = list_entry_rq(packed->list.next);
-		if (idx == i) {
-			/* retry from error index */
-			packed->nr_entries -= idx;
-			mq_rq->req = prq;
-			ret = 1;
-
-			if (packed->nr_entries == MMC_PACKED_NR_SINGLE) {
-				list_del_init(&prq->queuelist);
-				mmc_blk_clear_packed(mq_rq);
-			}
-			return ret;
-		}
-		list_del_init(&prq->queuelist);
-		blk_end_request(prq, 0, blk_rq_bytes(prq));
-		i++;
 	}
-
-	mmc_blk_clear_packed(mq_rq);
 	return ret;
 }
 
-static void mmc_blk_abort_packed_req(struct mmc_queue_req *mq_rq)
-{
-	struct request *prq;
-	struct mmc_packed *packed = mq_rq->packed;
-
-	while (!list_empty(&packed->list)) {
-		prq = list_entry_rq(packed->list.next);
-		list_del_init(&prq->queuelist);
-		blk_end_request(prq, -EIO, blk_rq_bytes(prq));
-	}
-
-	mmc_blk_clear_packed(mq_rq);
-}
-
-static void mmc_blk_revert_packed_req(struct mmc_queue *mq,
-				      struct mmc_queue_req *mq_rq)
-{
-	struct request *prq;
-	struct request_queue *q = mq->queue;
-	struct mmc_packed *packed = mq_rq->packed;
-
-	while (!list_empty(&packed->list)) {
-		prq = list_entry_rq(packed->list.prev);
-		if (prq->queuelist.prev != &packed->list) {
-			list_del_init(&prq->queuelist);
-			spin_lock_irq(q->queue_lock);
-			blk_requeue_request(mq->queue, prq);
-			spin_unlock_irq(q->queue_lock);
-		} else {
-			list_del_init(&prq->queuelist);
-		}
-	}
-
-	mmc_blk_clear_packed(mq_rq);
-}
-
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
 	struct mmc_blk_data *md = mq->blkdata;
@@ -2005,15 +1600,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	struct mmc_queue_req *mq_rq;
 	struct request *req = rqc;
 	struct mmc_async_req *areq;
-	const u8 packed_nr = 2;
 	u8 reqs = 0;
 
 	if (!rqc && !mq->mqrq_prev->req)
 		return 0;
 
-	if (rqc)
-		reqs = mmc_blk_prep_packed_list(mq, rqc);
-
 	do {
 		if (rqc) {
 			/*
@@ -2028,11 +1619,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 				goto cmd_abort;
 			}
 
-			if (reqs >= packed_nr)
-				mmc_blk_packed_hdr_wrq_prep(mq->mqrq_cur,
-							    card, mq);
-			else
-				mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
+			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
 			areq = &mq->mqrq_cur->mmc_active;
 		} else
 			areq = NULL;
@@ -2057,13 +1644,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 */
 			mmc_blk_reset_success(md, type);
 
-			if (mmc_packed_cmd(mq_rq->cmd_type)) {
-				ret = mmc_blk_end_packed_req(mq_rq);
-				break;
-			} else {
-				ret = blk_end_request(req, 0,
-						brq->data.bytes_xfered);
-			}
+			ret = blk_end_request(req, 0,
+					brq->data.bytes_xfered);
 
 			/*
 			 * If the blk_end_request function returns non-zero even
@@ -2100,8 +1682,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			err = mmc_blk_reset(md, card->host, type);
 			if (!err)
 				break;
-			if (err == -ENODEV ||
-				mmc_packed_cmd(mq_rq->cmd_type))
+			if (err == -ENODEV)
 				goto cmd_abort;
 			/* Fall through */
 		}
@@ -2132,23 +1713,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		}
 
 		if (ret) {
-			if (mmc_packed_cmd(mq_rq->cmd_type)) {
-				if (!mq_rq->packed->retries)
-					goto cmd_abort;
-				mmc_blk_packed_hdr_wrq_prep(mq_rq, card, mq);
-				mmc_start_req(card->host,
-					      &mq_rq->mmc_active, NULL);
-			} else {
-
-				/*
-				 * In case of a incomplete request
-				 * prepare it again and resend.
-				 */
-				mmc_blk_rw_rq_prep(mq_rq, card,
-						disable_multi, mq);
-				mmc_start_req(card->host,
-						&mq_rq->mmc_active, NULL);
-			}
+			/*
+			 * In case of a incomplete request
+			 * prepare it again and resend.
+			 */
+			mmc_blk_rw_rq_prep(mq_rq, card,
+					disable_multi, mq);
+			mmc_start_req(card->host,
+					&mq_rq->mmc_active, NULL);
 			mq_rq->brq.retune_retry_done = retune_retry_done;
 		}
 	} while (ret);
@@ -2156,15 +1728,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	return 1;
 
  cmd_abort:
-	if (mmc_packed_cmd(mq_rq->cmd_type)) {
-		mmc_blk_abort_packed_req(mq_rq);
-	} else {
-		if (mmc_card_removed(card))
-			req->cmd_flags |= REQ_QUIET;
-		while (ret)
-			ret = blk_end_request(req, -EIO,
-					blk_rq_cur_bytes(req));
-	}
+	if (mmc_card_removed(card))
+		req->cmd_flags |= REQ_QUIET;
+	while (ret)
+		ret = blk_end_request(req, -EIO,
+				blk_rq_cur_bytes(req));
 
  start_new_req:
 	if (rqc) {
@@ -2172,12 +1740,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			rqc->cmd_flags |= REQ_QUIET;
 			blk_end_request_all(rqc, -EIO);
 		} else {
-			/*
-			 * If current request is packed, it needs to put back.
-			 */
-			if (mmc_packed_cmd(mq->mqrq_cur->cmd_type))
-				mmc_blk_revert_packed_req(mq, mq->mqrq_cur);
-
 			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
 			mmc_start_req(card->host,
 				      &mq->mqrq_cur->mmc_active, NULL);
@@ -2360,14 +1922,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		blk_queue_write_cache(md->queue.queue, true, true);
 	}
 
-	if (mmc_card_mmc(card) &&
-	    (area_type == MMC_BLK_DATA_AREA_MAIN) &&
-	    (md->flags & MMC_BLK_CMD23) &&
-	    card->ext_csd.packed_event_en) {
-		if (!mmc_packed_init(&md->queue, card))
-			md->flags |= MMC_BLK_PACKED_CMD;
-	}
-
 	return md;
 
  err_putdisk:
@@ -2471,8 +2025,6 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		 */
 		card = md->queue.card;
 		mmc_cleanup_queue(&md->queue);
-		if (md->flags & MMC_BLK_PACKED_CMD)
-			mmc_packed_clean(&md->queue);
 		if (md->disk->flags & GENHD_FL_UP) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
 			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 3f6a2463ab30..7dacf2744fbd 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -406,41 +406,6 @@ void mmc_queue_resume(struct mmc_queue *mq)
 	}
 }
 
-static unsigned int mmc_queue_packed_map_sg(struct mmc_queue *mq,
-					    struct mmc_packed *packed,
-					    struct scatterlist *sg,
-					    enum mmc_packed_type cmd_type)
-{
-	struct scatterlist *__sg = sg;
-	unsigned int sg_len = 0;
-	struct request *req;
-
-	if (mmc_packed_wr(cmd_type)) {
-		unsigned int hdr_sz = mmc_large_sector(mq->card) ? 4096 : 512;
-		unsigned int max_seg_sz = queue_max_segment_size(mq->queue);
-		unsigned int len, remain, offset = 0;
-		u8 *buf = (u8 *)packed->cmd_hdr;
-
-		remain = hdr_sz;
-		do {
-			len = min(remain, max_seg_sz);
-			sg_set_buf(__sg, buf + offset, len);
-			offset += len;
-			remain -= len;
-			sg_unmark_end(__sg++);
-			sg_len++;
-		} while (remain);
-	}
-
-	list_for_each_entry(req, &packed->list, queuelist) {
-		sg_len += blk_rq_map_sg(mq->queue, req, __sg);
-		__sg = sg + (sg_len - 1);
-		sg_unmark_end(__sg++);
-	}
-	sg_mark_end(sg + (sg_len - 1));
-	return sg_len;
-}
-
 /*
  * Prepare the sg list(s) to be handed of to the host driver
  */
@@ -449,26 +414,14 @@ unsigned int mmc_queue_map_sg(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 	unsigned int sg_len;
 	size_t buflen;
 	struct scatterlist *sg;
-	enum mmc_packed_type cmd_type;
 	int i;
 
-	cmd_type = mqrq->cmd_type;
-
-	if (!mqrq->bounce_buf) {
-		if (mmc_packed_cmd(cmd_type))
-			return mmc_queue_packed_map_sg(mq, mqrq->packed,
-						       mqrq->sg, cmd_type);
-		else
-			return blk_rq_map_sg(mq->queue, mqrq->req, mqrq->sg);
-	}
+	if (!mqrq->bounce_buf)
+		return blk_rq_map_sg(mq->queue, mqrq->req, mqrq->sg);
 
 	BUG_ON(!mqrq->bounce_sg);
 
-	if (mmc_packed_cmd(cmd_type))
-		sg_len = mmc_queue_packed_map_sg(mq, mqrq->packed,
-						 mqrq->bounce_sg, cmd_type);
-	else
-		sg_len = blk_rq_map_sg(mq->queue, mqrq->req, mqrq->bounce_sg);
+	sg_len = blk_rq_map_sg(mq->queue, mqrq->req, mqrq->bounce_sg);
 
 	mqrq->bounce_sg_len = sg_len;
 
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index ae96eb223990..47f5532b5776 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -22,23 +22,6 @@ struct mmc_blk_request {
 	int			retune_retry_done;
 };
 
-enum mmc_packed_type {
-	MMC_PACKED_NONE = 0,
-	MMC_PACKED_WRITE,
-};
-
-#define mmc_packed_cmd(type)	((type) != MMC_PACKED_NONE)
-#define mmc_packed_wr(type)	((type) == MMC_PACKED_WRITE)
-
-struct mmc_packed {
-	struct list_head	list;
-	u32			cmd_hdr[1024];
-	unsigned int		blocks;
-	u8			nr_entries;
-	u8			retries;
-	s16			idx_failure;
-};
-
 struct mmc_queue_req {
 	struct request		*req;
 	struct mmc_blk_request	brq;
@@ -47,8 +30,6 @@ struct mmc_queue_req {
 	struct scatterlist	*bounce_sg;
 	unsigned int		bounce_sg_len;
 	struct mmc_async_req	mmc_active;
-	enum mmc_packed_type	cmd_type;
-	struct mmc_packed	*packed;
 };
 
 struct mmc_queue {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 5310f94be0ab..37c3d82d8550 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -495,11 +495,6 @@ static inline int mmc_host_uhs(struct mmc_host *host)
 		 MMC_CAP_UHS_DDR50);
 }
 
-static inline int mmc_host_packed_wr(struct mmc_host *host)
-{
-	return host->caps2 & MMC_CAP2_PACKED_WR;
-}
-
 static inline int mmc_card_hs(struct mmc_card *card)
 {
 	return card->host->ios.timing == MMC_TIMING_SD_HS ||
-- 
2.7.4

