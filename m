From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH 4/4] MMC: MMC boot partitions support.
Date: Tue,  5 Apr 2011 20:09:53 -0500
Message-ID: <1302052193-23317-5-git-send-email-andreiw@motorola.com>
References: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:53796 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab1DFAaO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 20:30:14 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p360ST9a015703
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 20:28:29 -0400 (EDT)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p360ST9W015686
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 20:28:29 -0400 (EDT)
Received: by gwb17 with SMTP id 17so347377gwb.15
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 17:30:11 -0700 (PDT)
In-Reply-To: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

Allows device MMC boot partitions to be accessed. MMC partitions
are treated effectively as separate block devices on the same
MMC card.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 Documentation/mmc/00-INDEX          |    2 +
 Documentation/mmc/mmc-dev-attrs.txt |   10 ++
 Documentation/mmc/mmc-dev-parts.txt |   26 +++
 drivers/mmc/card/block.c            |  305 +++++++++++++++++++++++++++++------
 drivers/mmc/core/mmc.c              |   22 ++-
 include/linux/mmc/card.h            |    4 +-
 include/linux/mmc/mmc.h             |    8 +-
 7 files changed, 317 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/mmc/mmc-dev-parts.txt

diff --git a/Documentation/mmc/00-INDEX b/Documentation/mmc/00-INDEX
index fca586f..93dd7a7 100644
--- a/Documentation/mmc/00-INDEX
+++ b/Documentation/mmc/00-INDEX
@@ -2,3 +2,5 @@
         - this file
 mmc-dev-attrs.txt
         - info on SD and MMC device attributes
+mmc-dev-parts.txt
+        - info on SD and MMC device partitions
diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index ff2bd68..8898a95 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -1,3 +1,13 @@
+SD and MMC Block Device Attributes
+==================================
+
+These attributes are defined for the block devices associated with the
+SD or MMC device.
+
+The following attributes are read/write.
+
+	force_ro		Enforce read-only access even if write protect switch is off.
+
 SD and MMC Device Attributes
 ============================
 
diff --git a/Documentation/mmc/mmc-dev-parts.txt b/Documentation/mmc/mmc-dev-parts.txt
new file mode 100644
index 0000000..8821909
--- /dev/null
+++ b/Documentation/mmc/mmc-dev-parts.txt
@@ -0,0 +1,26 @@
+SD and MMC Device Partitions
+============================
+
+Device partitions are additional logical block devices present
+on the SD/MMC device.
+
+As of this writing, MMC boot partitions as supported and exposed as 
+/dev/mmcblkXboot0 and /dev/mmcblkXboot1, where X is the index of the
+parent /dev/mmcblkX.
+
+MMC Boot Partitions
+===================
+
+Read and write access is provided to the two MMC boot partitions. Due
+to the sensitive nature of the boot partition contents, which often store
+a bootloader or bootloader configuration tables crucial to booting the platform,
+write access is by default disabled to reduce the chance of accidental bricking.
+
+To enable write access to /dev/mmcblkXbootY, disable the forced read-only
+access:
+
+echo 0 > /sys/block/mmcblkXbootY/force_ro
+
+To re-enable read-only access:
+
+echo 1 > /sys/block/mmcblkXbootY/force_ro
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 91a6767..1e6bd91 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -76,9 +76,19 @@ struct mmc_blk_data {
 	spinlock_t	lock;
 	struct gendisk	*disk;
 	struct mmc_queue queue;
+	struct list_head part;
 
 	unsigned int	usage;
 	unsigned int	read_only;
+	unsigned int	part_type;
+
+	/*
+	 * Only set in main mmc_blk_data associated
+	 * with mmc_card with mmc_set_drvdata, and keeps
+	 * track of the current selected device partition.
+	 */
+	unsigned int	part_curr;
+	struct device_attribute force_ro;
 };
 
 static DEFINE_MUTEX(open_lock);
@@ -101,17 +111,22 @@ static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 	return md;
 }
 
+static inline int mmc_get_devidx(struct gendisk *disk)
+{
+	int devmaj = MAJOR(disk_devt(disk));
+	int devidx = MINOR(disk_devt(disk)) / perdev_minors;
+
+	if (!devmaj)
+		devidx = disk->first_minor / perdev_minors;
+	return devidx;
+}
+
 static void mmc_blk_put(struct mmc_blk_data *md)
 {
 	mutex_lock(&open_lock);
 	md->usage--;
 	if (md->usage == 0) {
-		int devmaj = MAJOR(disk_devt(md->disk));
-		int devidx = MINOR(disk_devt(md->disk)) / perdev_minors;
-
-		if (!devmaj)
-			devidx = md->disk->first_minor / perdev_minors;
-
+		int devidx = mmc_get_devidx(md->disk);
 		blk_cleanup_queue(md->queue.queue);
 
 		__clear_bit(devidx, dev_use);
@@ -122,6 +137,38 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	mutex_unlock(&open_lock);
 }
 
+static ssize_t force_ro_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	int ret;
+	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
+
+	ret = snprintf(buf, PAGE_SIZE, "%d",
+		       get_disk_ro(dev_to_disk(dev)) ^
+		       md->read_only);
+	mmc_blk_put(md);
+	return ret;
+}
+
+static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	int ret;
+	char *end;
+	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
+	unsigned long set = simple_strtoul(buf, &end, 0);
+	if (end == buf) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	set_disk_ro(dev_to_disk(dev), set || md->read_only);
+	ret = count;
+out:
+	mmc_blk_put(md);
+	return ret;
+}
+
 static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
 {
 	struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
@@ -176,6 +223,29 @@ struct mmc_blk_request {
 	struct mmc_data		data;
 };
 
+static inline int mmc_blk_part_switch(struct mmc_card *card,
+				      struct mmc_blk_data *md)
+{
+	int ret;
+	struct mmc_blk_data *main_md = mmc_get_drvdata(card);
+	if (main_md->part_curr == md->part_type)
+		return 0;
+
+	if (mmc_card_mmc(card)) {
+		card->ext_csd.part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
+		card->ext_csd.part_config |= md->part_type;
+
+		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_PART_CONFIG, card->ext_csd.part_config,
+				 card->ext_csd.part_time);
+		if (ret)
+			return ret;
+}
+
+	main_md->part_curr = md->part_type;
+	return 0;
+}
+
 static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 {
 	int err;
@@ -273,8 +343,6 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	unsigned int from, nr, arg;
 	int err = 0;
 
-	mmc_claim_host(card->host);
-
 	if (!mmc_can_erase(card)) {
 		err = -EOPNOTSUPP;
 		goto out;
@@ -294,8 +362,6 @@ out:
 	__blk_end_request(req, err, blk_rq_bytes(req));
 	spin_unlock_irq(&md->lock);
 
-	mmc_release_host(card->host);
-
 	return err ? 0 : 1;
 }
 
@@ -307,8 +373,6 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	unsigned int from, nr, arg;
 	int err = 0;
 
-	mmc_claim_host(card->host);
-
 	if (!mmc_can_secure_erase_trim(card)) {
 		err = -EOPNOTSUPP;
 		goto out;
@@ -330,8 +394,6 @@ out:
 	__blk_end_request(req, err, blk_rq_bytes(req));
 	spin_unlock_irq(&md->lock);
 
-	mmc_release_host(card->host);
-
 	return err ? 0 : 1;
 }
 
@@ -402,8 +464,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		(rq_data_dir(req) == WRITE) &&
 		REL_WRITES_SUPPORTED(card);
 
-	mmc_claim_host(card->host);
-
 	do {
 		struct mmc_command cmd;
 		u32 readcmd, writecmd, status = 0;
@@ -589,8 +649,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		spin_unlock_irq(&md->lock);
 	} while (ret);
 
-	mmc_release_host(card->host);
-
 	return 1;
 
  cmd_err:
@@ -617,8 +675,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		spin_unlock_irq(&md->lock);
 	}
 
-	mmc_release_host(card->host);
-
 	spin_lock_irq(&md->lock);
 	while (ret)
 		ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
@@ -629,16 +685,31 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 
 static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 {
+	int ret;
+	struct mmc_blk_data *md = mq->data;
+	struct mmc_card *card = md->queue.card;
+
+	mmc_claim_host(card->host);
+	ret = mmc_blk_part_switch(card, md);
+	if (ret) {
+		ret = 0;
+		goto out;
+	}
+
 	if (req->cmd_flags & REQ_DISCARD) {
 		if (req->cmd_flags & REQ_SECURE)
-			return mmc_blk_issue_secdiscard_rq(mq, req);
+			ret = mmc_blk_issue_secdiscard_rq(mq, req);
 		else
-			return mmc_blk_issue_discard_rq(mq, req);
+			ret = mmc_blk_issue_discard_rq(mq, req);
 	} else if (req->cmd_flags & REQ_FLUSH) {
-		return mmc_blk_issue_flush(mq, req);
+		ret = mmc_blk_issue_flush(mq, req);
 	} else {
-		return mmc_blk_issue_rw_rq(mq, req);
+		ret = mmc_blk_issue_rw_rq(mq, req);
 	}
+
+out:
+	mmc_release_host(card->host);
+	return ret;
 }
 
 static inline int mmc_blk_readonly(struct mmc_card *card)
@@ -647,7 +718,11 @@ static inline int mmc_blk_readonly(struct mmc_card *card)
 	       !(card->csd.cmdclass & CCC_BLOCK_WRITE);
 }
 
-static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
+static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
+					      struct device *parent,
+					      sector_t size,
+					      bool default_ro,
+					      const char *subname)
 {
 	struct mmc_blk_data *md;
 	int devidx, ret;
@@ -663,7 +738,6 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 		goto out;
 	}
 
-
 	/*
 	 * Set the read-only status based on the supported commands
 	 * and the write protect switch.
@@ -677,6 +751,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	}
 
 	spin_lock_init(&md->lock);
+	INIT_LIST_HEAD(&md->part);
 	md->usage = 1;
 
 	ret = mmc_init_queue(&md->queue, card, &md->lock);
@@ -691,8 +766,8 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	md->disk->fops = &mmc_bdops;
 	md->disk->private_data = md;
 	md->disk->queue = md->queue.queue;
-	md->disk->driverfs_dev = &card->dev;
-	set_disk_ro(md->disk, md->read_only);
+	md->disk->driverfs_dev = parent;
+	set_disk_ro(md->disk, md->read_only || default_ro);
 	if (REL_WRITES_SUPPORTED(card))
 		blk_queue_flush(md->queue.queue, REQ_FLUSH | REQ_FUA);
 
@@ -708,33 +783,97 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	 * messages to tell when the card is present.
 	 */
 
-	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
-		"mmcblk%d", devidx);
+	if (subname)
+		snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
+			 "mmcblk%d%s",
+			 mmc_get_devidx(dev_to_disk(parent)), subname);
+	else
+		snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
+			 "mmcblk%d", devidx);
 
 	blk_queue_logical_block_size(md->queue.queue, 512);
+	set_capacity(md->disk, size);
+	return md;
+
+ err_putdisk:
+	put_disk(md->disk);
+ err_kfree:
+	kfree(md);
+ out:
+	return ERR_PTR(ret);
+}
+
+static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
+{
+	sector_t size;
+	struct mmc_blk_data *md;
 
 	if (!mmc_card_sd(card) && mmc_card_blockaddr(card)) {
 		/*
 		 * The EXT_CSD sector count is in number or 512 byte
 		 * sectors.
 		 */
-		set_capacity(md->disk, card->ext_csd.sectors);
+		size = card->ext_csd.sectors;
 	} else {
 		/*
 		 * The CSD capacity field is in units of read_blkbits.
 		 * set_capacity takes units of 512 bytes.
 		 */
-		set_capacity(md->disk,
-			card->csd.capacity << (card->csd.read_blkbits - 9));
+		size = card->csd.capacity << (card->csd.read_blkbits - 9);
 	}
+
+	md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL);
 	return md;
+}
 
- err_putdisk:
-	put_disk(md->disk);
- err_kfree:
-	kfree(md);
- out:
-	return ERR_PTR(ret);
+static int mmc_blk_alloc_part(struct mmc_card *card,
+			      struct mmc_blk_data *md,
+			      unsigned int part_type,
+			      sector_t size,
+			      bool default_ro,
+			      const char *subname)
+{
+	char cap_str[10];
+	struct mmc_blk_data *part_md;
+
+	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
+				    subname);
+	if (IS_ERR(part_md))
+		return PTR_ERR(part_md);
+	part_md->part_type = part_type;
+	list_add(&part_md->part, &md->part);
+
+	string_get_size((u64)get_capacity(part_md->disk) << 9, STRING_UNITS_2,
+			cap_str, sizeof(cap_str));
+	printk(KERN_INFO "%s: %s %s partition %u %s\n",
+	       part_md->disk->disk_name, mmc_card_id(card),
+	       mmc_card_name(card), part_md->part_type, cap_str);
+	return 0;
+}
+
+static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
+{
+	int ret = 0;
+
+	if (!mmc_card_mmc(card))
+		return 0;
+
+	if (card->ext_csd.boot_size) {
+		ret = mmc_blk_alloc_part(card, md, EXT_CSD_PART_CONFIG_ACC_BOOT0,
+					 card->ext_csd.boot_size >> 9,
+					 true,
+					 "boot0");
+		if (ret)
+			return ret;
+		ret = mmc_blk_alloc_part(card, md, EXT_CSD_PART_CONFIG_ACC_BOOT1,
+					 card->ext_csd.boot_size >> 9,
+					 true,
+					 "boot1");
+		if (ret)
+			return ret;
+	}
+
+	return ret;
 }
 
 static int
@@ -755,9 +894,54 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
 	return 0;
 }
 
+static void mmc_blk_remove_req(struct mmc_blk_data *md)
+{
+	if (md) {
+		if (md->disk->flags & GENHD_FL_UP) {
+			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
+
+			/* Stop new requests from getting into the queue */
+			del_gendisk(md->disk);
+		}
+
+		/* Then flush out any already in there */
+		mmc_cleanup_queue(&md->queue);
+		mmc_blk_put(md);
+	}
+}
+
+static void mmc_blk_remove_parts(struct mmc_card *card,
+				 struct mmc_blk_data *md)
+{
+	struct list_head *pos, *q;
+	struct mmc_blk_data *part_md;
+
+	list_for_each_safe(pos, q, &md->part) {
+		part_md = list_entry(pos, struct mmc_blk_data, part);
+		list_del(pos);
+		mmc_blk_remove_req(part_md);
+	}
+}
+
+static int mmc_add_disk(struct mmc_blk_data *md)
+{
+	int ret;
+
+	add_disk(md->disk);
+	md->force_ro.show = force_ro_show;
+	md->force_ro.store = force_ro_store;
+	md->force_ro.attr.name = "force_ro";
+	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
+	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
+	if (ret)
+		del_gendisk(md->disk);
+
+	return ret;
+}
+
 static int mmc_blk_probe(struct mmc_card *card)
 {
-	struct mmc_blk_data *md;
+	struct mmc_blk_data *md, *part_md;
 	int err;
 	char cap_str[10];
 
@@ -781,14 +965,22 @@ static int mmc_blk_probe(struct mmc_card *card)
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
 		cap_str, md->read_only ? "(ro)" : "");
 
+	if (mmc_blk_alloc_parts(card, md))
+		goto out;
+
 	mmc_set_drvdata(card, md);
-	add_disk(md->disk);
+	if (mmc_add_disk(md))
+		goto out;
+
+	list_for_each_entry(part_md, &md->part, part) {
+		if (mmc_add_disk(part_md))
+			goto out;
+	}
 	return 0;
 
  out:
-	mmc_cleanup_queue(&md->queue);
-	mmc_blk_put(md);
-
+	mmc_blk_remove_parts(card, md);
+	mmc_blk_remove_req(md);
 	return err;
 }
 
@@ -796,36 +988,43 @@ static void mmc_blk_remove(struct mmc_card *card)
 {
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
-	if (md) {
-		/* Stop new requests from getting into the queue */
-		del_gendisk(md->disk);
-
-		/* Then flush out any already in there */
-		mmc_cleanup_queue(&md->queue);
-
-		mmc_blk_put(md);
-	}
+	mmc_blk_remove_parts(card, md);
+	mmc_blk_remove_req(md);
 	mmc_set_drvdata(card, NULL);
 }
 
 #ifdef CONFIG_PM
 static int mmc_blk_suspend(struct mmc_card *card, pm_message_t state)
 {
+	struct mmc_blk_data *part_md;
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	if (md) {
 		mmc_queue_suspend(&md->queue);
+		list_for_each_entry(part_md, &md->part, part) {
+			mmc_queue_suspend(&part_md->queue);
+		}
 	}
 	return 0;
 }
 
 static int mmc_blk_resume(struct mmc_card *card)
 {
+	struct mmc_blk_data *part_md;
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	if (md) {
 		mmc_blk_set_blksize(md, card);
+
+		/*
+		 * Resume involves the card going into idle state,
+		 * so current partition is always the main one.
+		 */
+		md->part_curr = md->part_type;
 		mmc_queue_resume(&md->queue);
+		list_for_each_entry(part_md, &md->part, part) {
+			mmc_queue_resume(&part_md->queue);
+		}
 	}
 	return 0;
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a5cf423..ba1c878 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -288,7 +288,10 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 
 	if (card->ext_csd.rev >= 3) {
 		u8 sa_shift = ext_csd[EXT_CSD_S_A_TIMEOUT];
-		card->ext_csd.bootconfig = ext_csd[EXT_CSD_BOOT_CONFIG];
+		card->ext_csd.part_config = ext_csd[EXT_CSD_PART_CONFIG];
+
+		/* EXT_CSD value is in units of 10ms, but we store in ms */
+		card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
 
 		/* Sleep / awake timeout in 100ns units */
 		if (sa_shift > 0 && sa_shift <= 0x17)
@@ -302,6 +305,12 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 			ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] << 10;
 
 		card->ext_csd.rel_sectors = ext_csd[EXT_CSD_REL_WR_SEC_C];
+
+		/*
+		 * There are two boot regions of equal size, defined in
+		 * multiples of 128K.
+		 */
+		card->ext_csd.boot_size = ext_csd[EXT_CSD_BOOT_MULT] << 17;
 	}
 
 	if (card->ext_csd.rev >= 4) {
@@ -576,10 +585,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Ensure eMMC user default partition is enabled
 	 */
-	if (card->ext_csd.bootconfig & 0x7) {
-		card->ext_csd.bootconfig &= ~0x7;
-		mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_CONFIG,
-			   card->ext_csd.bootconfig, 0);
+	if (card->ext_csd.part_config & EXT_CSD_PART_CONFIG_ACC_MASK) {
+		card->ext_csd.part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_PART_CONFIG,
+				 card->ext_csd.part_config,
+				 card->ext_csd.part_time);
+		if (err && err != -EBADMSG)
+			goto free_card;
 	}
 
 	/*
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index c4e96fa..b90cacc 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -47,7 +47,8 @@ struct mmc_ext_csd {
 	u8			sec_feature_support;
 	u8			rel_sectors;
 	u8			rel_param;
-	u8			bootconfig;
+	u8			part_config;
+	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		hs_max_dtr;
 	unsigned int		sectors;
@@ -60,6 +61,7 @@ struct mmc_ext_csd {
 	bool			enhanced_area_en;	/* enable bit */
 	unsigned long long	enhanced_area_offset;	/* Units: Byte */
 	unsigned int		enhanced_area_size;	/* Units: KB */
+	unsigned int		boot_size;		/* in bytes */
 };
 
 struct sd_scr {
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 390aa6e..373b2bf 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -257,19 +257,21 @@ struct _mmc_csd {
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
-#define EXT_CSD_BOOT_CONFIG		179	/* R/W */
+#define EXT_CSD_PART_CONFIG		179	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
 #define EXT_CSD_HS_TIMING		185	/* R/W */
 #define EXT_CSD_REV			192	/* RO */
 #define EXT_CSD_STRUCTURE		194	/* RO */
 #define EXT_CSD_CARD_TYPE		196	/* RO */
+#define EXT_CSD_PART_SWITCH_TIME        199     /* RO */
 #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
 #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
 #define EXT_CSD_REL_WR_SEC_C		222	/* RO */
 #define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
 #define EXT_CSD_ERASE_TIMEOUT_MULT	223	/* RO */
 #define EXT_CSD_HC_ERASE_GRP_SIZE	224	/* RO */
+#define EXT_CSD_BOOT_MULT		226	/* RO */
 #define EXT_CSD_SEC_TRIM_MULT		229	/* RO */
 #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
@@ -281,6 +283,10 @@ struct _mmc_csd {
 
 #define EXT_CSD_WR_REL_PARAM_EN		(1<<2)
 
+#define EXT_CSD_PART_CONFIG_ACC_MASK	(0x7)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT0	(0x1)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT1	(0x2)
+
 #define EXT_CSD_CMD_SET_NORMAL		(1<<0)
 #define EXT_CSD_CMD_SET_SECURE		(1<<1)
 #define EXT_CSD_CMD_SET_CPSECURE	(1<<2)
-- 
1.7.0.4

