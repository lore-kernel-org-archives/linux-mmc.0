From: Peter Turczak <pt@netconsequence.de>
Subject: [PATCH] Add basic support for password protected (locked) SD cards.
Date: Mon, 1 Jul 2013 14:52:32 +0200
Message-ID: <04F10DA1-D19F-4AD1-904E-6FD628602F7A@netconsequence.de>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from netconsequence.de ([85.214.40.104]:44892 "EHLO
	mx.netconsequence.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab3GAM7p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jul 2013 08:59:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Adds support for sd cards that are locked by a password and rereading an
already enumerated card.
This fixes compatibility issues with password locked cards as they would 
not enumerate correctly when detecting them. The card side locking 
functionality is specified as mandatory in the Physical Layer Specifications,
Version 3.01.

Signed-off-by: Peter Turczak <pt@netconsequence.de>
---
drivers/mmc/card/block.c |   63 +++++++++++++++++++++++++++++++++++++++++++---
drivers/mmc/core/sd.c    |   24 ++++++++++++++++-
include/linux/mmc/card.h |    4 +++
3 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index dd27b07..0e49e62 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -568,12 +568,57 @@ cmd_err:
	return err;
}

+static int mmc_blk_ioctl_rescan(struct block_device *bdev)
+{
+	struct mmc_blk_data *md;
+	struct mmc_card *card;
+	int err;
+
+	/*
+	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
+	 * whole block device, not on a partition.  This prevents overspray
+	 * between sibling partitions.
+	 */
+	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
+		return -EPERM;
+
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md) {
+		err = -EINVAL;
+		goto cmd_err;
+	}
+
+	card = md->queue.card;
+	if (IS_ERR(card)) {
+		err = PTR_ERR(card);
+		goto cmd_done;
+	}
+
+	mmc_power_restore_host(card->host);
+
+	/* Enable scanning of partition tables after unlocking */
+	if (!mmc_card_locked(card))
+		md->disk->flags &= ~GENHD_FL_NO_PART_SCAN;
+	else
+		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
+
+	ioctl_by_bdev(bdev, BLKRRPART, 0);
+cmd_done:
+	mmc_blk_put(md);
+cmd_err:
+	kfree(idata->buf);
+	kfree(idata);
+	return err;
+}
+
static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
	unsigned int cmd, unsigned long arg)
{
	int ret = -EINVAL;
	if (cmd == MMC_IOC_CMD)
		ret = mmc_blk_ioctl_cmd(bdev, (struct mmc_ioc_cmd __user *)arg);
+	else if (cmd == MMC_IOC_RESCAN)
+		ret = mmc_blk_ioctl_rescan(bdev);
	return ret;
}

@@ -775,7 +820,7 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
	u32 status, stop_status = 0;
	int err, retry;

-	if (mmc_card_removed(card))
+	if (mmc_card_removed(card) || mmc_card_locked(card))
		return ERR_NOMEDIUM;

	/*
@@ -1738,6 +1783,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
			areq = &mq->mqrq_cur->mmc_active;
		} else
			areq = NULL;
+
		areq = mmc_start_req(card->host, areq, (int *) &status);
		if (!areq) {
			if (status == MMC_BLK_NEW_REQUEST)
@@ -1857,7 +1903,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
	if (mmc_packed_cmd(mq_rq->cmd_type)) {
		mmc_blk_abort_packed_req(mq_rq);
	} else {
-		if (mmc_card_removed(card))
+		if (mmc_card_removed(card) || mmc_card_locked(card))
			req->cmd_flags |= REQ_QUIET;
		while (ret)
			ret = blk_end_request(req, -EIO,
@@ -2018,6 +2064,13 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
	if (area_type & MMC_BLK_DATA_AREA_RPMB)
		md->disk->flags |= GENHD_FL_NO_PART_SCAN;

+	/* If SD/MMC is locked, any read operation will fail
+	 * so there is no point in doing a partition scan
+	 * until the device is unlocked.
+	 */
+	if (mmc_card_locked(card))
+		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
+
	/*
	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
	 *
@@ -2093,6 +2146,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
		size = card->csd.capacity << (card->csd.read_blkbits - 9);
	}

+
	md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
					MMC_BLK_DATA_AREA_MAIN);
	return md;
@@ -2319,9 +2373,10 @@ static int mmc_blk_probe(struct mmc_card *card)

	string_get_size((u64)get_capacity(md->disk) << 9, STRING_UNITS_2,
			cap_str, sizeof(cap_str));
-	pr_info("%s: %s %s %s %s\n",
+	pr_info("%s: %s %s %s %s %s\n",
		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
-		cap_str, md->read_only ? "(ro)" : "");
+		cap_str, md->read_only ? "(ro)" : "",
+		mmc_card_locked(card) ? "(locked)" : "");

	if (mmc_blk_alloc_parts(card, md))
		goto out;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 9e645e1..f774e9c 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -805,8 +805,30 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
	bool reinit)
{
	int err;
+	int status;

-	if (!reinit) {
+	/*
+	 * Test if card is locked
+	 */
+	err = mmc_send_status(card, &status);
+	if (err)
+		return err;
+
+	if (status & R1_CARD_IS_LOCKED)
+		mmc_card_set_locked(card);
+	else {
+		/* If card used to be locked, this is _not_ an reinit! */
+		if (mmc_card_locked(card))
+			reinit = false;
+
+		mmc_card_clr_locked(card);
+	}
+
+	/*
+	 * If card is locked or already initialized, do not try to
+	 * set it up further .
+	 */
+	if (!reinit && !mmc_card_locked(card)) {
		/*
		 * Fetch SCR from card.
		 */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f31725b..08f325d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -249,6 +249,7 @@ struct mmc_card {
#define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
#define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
#define MMC_STATE_DOING_BKOPS	(1<<10)		/* card is doing BKOPS */
+#define MMC_STATE_LOCKED	(1<<11)		/* card is password protected */
	unsigned int		quirks; 	/* card quirks */
#define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -416,6 +417,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
#define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
#define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
+#define mmc_card_locked(c)	((c)->state & MMC_STATE_LOCKED)

#define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
#define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -429,6 +431,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
#define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
#define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
#define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
+#define mmc_card_set_locked(c)	((c)->state |= MMC_STATE_LOCKED)
+#define mmc_card_clr_locked(c)	((c)->state &= ~MMC_STATE_LOCKED)

/*
 * Quirk add/remove for MMC products.
-- 
1.7.0.4

