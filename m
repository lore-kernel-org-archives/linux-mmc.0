From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC] MMC: Request for comments attempt at dealing with removeable suspend/resume.
Date: Mon,  4 Apr 2011 15:31:09 -0500
Message-ID: <1301949069-13283-1-git-send-email-andreiw@motorola.com>
References: <BANLkTikMmf-d1BVG6ZMUV-L-nB05ytQVYw@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:41921 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab1DDTvJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 15:51:09 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34JpSRV019392
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 15:51:28 -0400 (EDT)
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com [209.85.161.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34JpS3G019389
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 15:51:28 -0400 (EDT)
Received: by gxk27 with SMTP id 27so3402561gxk.15
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 12:51:06 -0700 (PDT)
In-Reply-To: <BANLkTikMmf-d1BVG6ZMUV-L-nB05ytQVYw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

Is there any value to doing something like this in order to be able to suspend/resume
with a (manually, or rootfs) mounted filesystem on mmcblk?

Thoughts?

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |   76 +++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/core/core.c  |    3 +-
 2 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index ee8f7a9..19eb5b6 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -53,6 +53,9 @@ MODULE_ALIAS("mmc:block");
      ((card)->ext_csd.rel_sectors)))
 
 static DEFINE_MUTEX(block_mutex);
+static DEFINE_MUTEX(orphan_mutex);
+
+struct list_head orphans = LIST_HEAD_INIT(orphans);
 
 /*
  * The defaults come from config options but can be overriden by module
@@ -77,6 +80,7 @@ struct mmc_blk_data {
 	struct gendisk	*disk;
 	struct mmc_queue queue;
 	struct list_head part;
+	struct list_head orphan;
 
 	unsigned int	usage;
 	unsigned int	read_only;
@@ -88,6 +92,7 @@ struct mmc_blk_data {
 	 * track of the current selected device partition.
 	 */
 	unsigned int	part_curr;
+	u32		raw_cid[4];
 	struct device_attribute force_ro;
 };
 
@@ -126,10 +131,12 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	mutex_lock(&open_lock);
 	md->usage--;
 	if (md->usage == 0) {
-		int devidx = mmc_get_devidx(md->disk);
-		blk_cleanup_queue(md->queue.queue);
+		mutex_lock(&orphan_mutex);
+		list_del(&md->orphan);
+		mutex_unlock(&orphan_mutex);
 
-		__clear_bit(devidx, dev_use);
+		blk_cleanup_queue(md->queue.queue);
+		__clear_bit(mmc_get_devidx(md->disk), dev_use);
 
 		put_disk(md->disk);
 		kfree(md);
@@ -718,6 +725,49 @@ static inline int mmc_blk_readonly(struct mmc_card *card)
 	       !(card->csd.cmdclass & CCC_BLOCK_WRITE);
 }
 
+static inline struct mmc_blk_data *mmc_lookup_orphan(struct mmc_card *card,
+						     struct device *parent,
+						     unsigned int part_type,
+						     sector_t size)
+{
+	int ret;
+	struct list_head *pos, *q;
+	struct mmc_blk_data *md;
+	bool found = false;
+
+	mutex_lock(&orphan_mutex);
+	list_for_each_safe(pos, q, &orphans) {
+		md = list_entry(pos, struct mmc_blk_data, orphan);
+		if (!memcmp(md->raw_cid, card->raw_cid, sizeof(md->raw_cid)) &&
+		    md->part_type == part_type) {
+			list_del(pos);
+			found = true;
+			mmc_blk_get(md->disk);
+			break;
+		}
+	}
+	mutex_unlock(&orphan_mutex);
+
+	if (!found)
+		return NULL;
+
+	ret = mmc_init_queue(&md->queue, card, &md->lock);
+	if (ret)
+		return NULL;
+
+	INIT_LIST_HEAD(&md->part);
+	md->disk->driverfs_dev = parent;
+	md->queue.issue_fn = mmc_blk_issue_rq;
+	md->queue.data = md;
+	md->disk->queue = md->queue.queue;
+	if (REL_WRITES_SUPPORTED(card))
+		blk_queue_flush(md->queue.queue, REQ_FLUSH | REQ_FUA);
+	blk_queue_logical_block_size(md->queue.queue, 512);
+	set_capacity(md->disk, size);
+	printk("set cap to %x\n", (unsigned int) get_capacity(md->disk));
+	return md;
+}
+
 static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      struct device *parent,
 					      sector_t size,
@@ -752,7 +802,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	spin_lock_init(&md->lock);
 	INIT_LIST_HEAD(&md->part);
+	INIT_LIST_HEAD(&md->orphan);
 	md->usage = 1;
+	memcpy(md->raw_cid, card->raw_cid, sizeof(card->raw_cid));
 
 	ret = mmc_init_queue(&md->queue, card, &md->lock);
 	if (ret)
@@ -822,7 +874,9 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 		size = card->csd.capacity << (card->csd.read_blkbits - 9);
 	}
 
-	md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL);
+	md = mmc_lookup_orphan(card, &card->dev, 0, size);
+	if (!md)
+		md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL);
 	return md;
 }
 
@@ -836,8 +890,10 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 	char cap_str[10];
 	struct mmc_blk_data *part_md;
 
-	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
-				    subname);
+	part_md = mmc_lookup_orphan(card, disk_to_dev(md->disk), part_type, size);
+	if (!part_md)
+		part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size,
+					    default_ro, subname);
 	if (IS_ERR(part_md))
 		return PTR_ERR(part_md);
 	part_md->part_type = part_type;
@@ -906,6 +962,10 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 
 		/* Then flush out any already in there */
 		mmc_cleanup_queue(&md->queue);
+
+		mutex_lock(&orphan_mutex);
+		list_add(&md->orphan, &orphans);
+		mutex_unlock(&orphan_mutex);
 		mmc_blk_put(md);
 	}
 }
@@ -933,8 +993,10 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	md->force_ro.attr.name = "force_ro";
 	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
 	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
-	if (ret)
+	if (ret) {
 		del_gendisk(md->disk);
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 85ef72c..87c4af7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1823,11 +1823,10 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 		if (!host->bus_ops || host->bus_ops->suspend)
 			break;
 
-		mmc_claim_host(host);
-
 		if (host->bus_ops->remove)
 			host->bus_ops->remove(host);
 
+		mmc_claim_host(host);
 		mmc_detach_bus(host);
 		mmc_release_host(host);
 		host->pm_flags = 0;
-- 
1.7.0.4

