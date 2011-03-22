From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCHv4] MMC: MMC boot partitions support.
Date: Tue, 22 Mar 2011 16:11:40 -0500
Message-ID: <1300828300-8677-2-git-send-email-andreiw@motorola.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:37810 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab1CVUaC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 16:30:02 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2MKUI6P027212
	for <linux-mmc@vger.kernel.org>; Tue, 22 Mar 2011 16:30:18 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2MKRQq8025787
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 22 Mar 2011 16:30:18 -0400 (EDT)
Received: by mail-gy0-f170.google.com with SMTP id 11so3639331gyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 22 Mar 2011 13:29:59 -0700 (PDT)
In-Reply-To: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

Allows device MMC boot partitions to be accessed. MMC partitions
are treated effectively as separate block devices on the same
MMC card.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/Kconfig   |   18 ++++
 drivers/mmc/card/block.c   |  212 +++++++++++++++++++++++++++++++++++---------
 drivers/mmc/core/mmc.c     |    5 +
 drivers/mmc/core/mmc_ops.h |    1 -
 include/linux/mmc/card.h   |    2 +
 include/linux/mmc/core.h   |    1 +
 include/linux/mmc/mmc.h    |    6 ++
 7 files changed, 203 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 3b1f783..c7ad8bb 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -32,6 +32,24 @@ config MMC_BLOCK_MINORS
 
 	  If unsure, say 8 here.
 
+config MMC_BLOCK_MMC_PART
+	tristate "MMC block MMC device partitioning support"
+	depends on BLOCK
+	default n
+	help
+	  Say Y here to enable access to MMC partitions other than
+	  the user area, such as the boot partitions. The other partitions
+	  will appear as separate mmcblk devices.
+
+config MMC_BLOCK_MMC_PART_BOOT
+	tristate "MMC block MMC boot partition support"
+	depends on MMC_BLOCK_MMC_PART
+	default n
+	help
+	  Say Y here to enable access to the MMC boot partitions. Boot
+	  partitions are used by some devices to store bootloader information.
+	  The boot partitions will appear as separate mmcblk devices.
+
 config MMC_BLOCK_BOUNCE
 	bool "Use bounce buffer for simple hosts"
 	depends on MMC_BLOCK
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 61d233a..2595405 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -72,9 +72,18 @@ struct mmc_blk_data {
 	spinlock_t	lock;
 	struct gendisk	*disk;
 	struct mmc_queue queue;
+	struct list_head part;
 
 	unsigned int	usage;
 	unsigned int	read_only;
+	unsigned int    part_type;
+
+	/*
+	   Only set in main mmc_blk_data associated
+	   with mmc_card with mmc_set_drvdata, and keeps
+	   track of the current selected device partition.
+	*/
+	unsigned int    part_curr;
 };
 
 static DEFINE_MUTEX(open_lock);
@@ -172,6 +181,28 @@ struct mmc_blk_request {
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
+		card->ext_csd.part_cfg &= ~EXT_CSD_PCFG_ACC_MASK;
+		card->ext_csd.part_cfg |= md->part_type;
+
+		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_PCFG, card->ext_csd.part_cfg);
+		if (ret)
+			return ret;
+	}
+
+	main_md->part_curr = md->part_type;
+	return 0;
+}
+
 static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 {
 	int err;
@@ -269,8 +300,6 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	unsigned int from, nr, arg;
 	int err = 0;
 
-	mmc_claim_host(card->host);
-
 	if (!mmc_can_erase(card)) {
 		err = -EOPNOTSUPP;
 		goto out;
@@ -290,8 +319,6 @@ out:
 	__blk_end_request(req, err, blk_rq_bytes(req));
 	spin_unlock_irq(&md->lock);
 
-	mmc_release_host(card->host);
-
 	return err ? 0 : 1;
 }
 
@@ -303,8 +330,6 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	unsigned int from, nr, arg;
 	int err = 0;
 
-	mmc_claim_host(card->host);
-
 	if (!mmc_can_secure_erase_trim(card)) {
 		err = -EOPNOTSUPP;
 		goto out;
@@ -326,8 +351,6 @@ out:
 	__blk_end_request(req, err, blk_rq_bytes(req));
 	spin_unlock_irq(&md->lock);
 
-	mmc_release_host(card->host);
-
 	return err ? 0 : 1;
 }
 
@@ -338,8 +361,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_blk_request brq;
 	int ret = 1, disable_multi = 0;
 
-	mmc_claim_host(card->host);
-
 	do {
 		struct mmc_command cmd;
 		u32 readcmd, writecmd, status = 0;
@@ -520,8 +541,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		spin_unlock_irq(&md->lock);
 	} while (ret);
 
-	mmc_release_host(card->host);
-
 	return 1;
 
  cmd_err:
@@ -548,8 +567,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		spin_unlock_irq(&md->lock);
 	}
 
-	mmc_release_host(card->host);
-
 	spin_lock_irq(&md->lock);
 	while (ret)
 		ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
@@ -560,14 +577,29 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 
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
@@ -576,7 +608,8 @@ static inline int mmc_blk_readonly(struct mmc_card *card)
 	       !(card->csd.cmdclass & CCC_BLOCK_WRITE);
 }
 
-static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
+static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
+					      sector_t size)
 {
 	struct mmc_blk_data *md;
 	int devidx, ret;
@@ -592,7 +625,6 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 		goto out;
 	}
 
-
 	/*
 	 * Set the read-only status based on the supported commands
 	 * and the write protect switch.
@@ -606,6 +638,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	}
 
 	spin_lock_init(&md->lock);
+	INIT_LIST_HEAD(&md->part);
 	md->usage = 1;
 
 	ret = mmc_init_queue(&md->queue, card, &md->lock);
@@ -639,29 +672,84 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 		"mmcblk%d", devidx);
 
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
+	md = mmc_blk_alloc_req(card, size);
+	md->part_type = 0;
 	return md;
+}
 
- err_putdisk:
-	put_disk(md->disk);
- err_kfree:
-	kfree(md);
- out:
-	return ERR_PTR(ret);
+static int __maybe_unused mmc_blk_alloc_part(struct mmc_card *card,
+					     struct mmc_blk_data *md,
+					     unsigned int part_type,
+					     sector_t size)
+{
+	char cap_str[10];
+	struct mmc_blk_data *part_md;
+
+	part_md = mmc_blk_alloc_req(card, size);
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
+#ifdef CONFIG_MMC_BLOCK_MMC_PART_BOOT
+	if (card->ext_csd.boot_size) {
+		ret = mmc_blk_alloc_part(card, md, EXT_CSD_PCFG_ACC_BOOT0,
+					 card->ext_csd.boot_size >> 9);
+		if (ret)
+			return ret;
+		ret = mmc_blk_alloc_part(card, md, EXT_CSD_PCFG_ACC_BOOT1,
+					 card->ext_csd.boot_size >> 9);
+		if (ret)
+			return ret;
+	}
+#endif
+
+	return ret;
 }
 
 static int
@@ -682,9 +770,37 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
 	return 0;
 }
 
+static void mmc_blk_remove_req(struct mmc_blk_data *md, bool del_disk)
+{
+	if (md) {
+		if (del_disk) {
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
+				 struct mmc_blk_data *md, bool del_disk)
+{
+	struct list_head *pos, *q;
+	struct mmc_blk_data *part_md;
+
+	list_for_each_safe(pos, q, &md->part) {
+		part_md = list_entry(pos, struct mmc_blk_data, part);
+		list_del(pos);
+		mmc_blk_remove_req(part_md, del_disk);
+	}
+}
+
 static int mmc_blk_probe(struct mmc_card *card)
 {
-	struct mmc_blk_data *md;
+	struct mmc_blk_data *md, *part_md;
 	int err;
 	char cap_str[10];
 
@@ -708,14 +824,20 @@ static int mmc_blk_probe(struct mmc_card *card)
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
 		cap_str, md->read_only ? "(ro)" : "");
 
+	if (mmc_blk_alloc_parts(card, md))
+		goto out;
+
 	mmc_set_drvdata(card, md);
 	add_disk(md->disk);
+
+	list_for_each_entry(part_md, &md->part, part) {
+		add_disk(part_md->disk);
+	}
 	return 0;
 
  out:
-	mmc_cleanup_queue(&md->queue);
-	mmc_blk_put(md);
-
+	mmc_blk_remove_parts(card, md, false);
+	mmc_blk_remove_req(md, false);
 	return err;
 }
 
@@ -723,36 +845,44 @@ static void mmc_blk_remove(struct mmc_card *card)
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
+	mmc_blk_remove_parts(card, md, true);
+	mmc_blk_remove_req(md, true);
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
+
+		/*
+		  Resume involves the card going into idle state,
+		  so current partition is always the main one.
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
index 14e95f3..a370230 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -299,6 +299,11 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 			ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT];
 		card->ext_csd.hc_erase_size =
 			ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] << 10;
+
+
+		/* There are two boot regions of equal size */
+		card->ext_csd.part_cfg = ext_csd[EXT_CSD_PCFG];
+		card->ext_csd.boot_size = ext_csd[EXT_CSD_BOOT_MULT] * SZ_128K;
 	}
 
 	if (card->ext_csd.rev >= 4) {
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index e6d44b8..9276946 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -20,7 +20,6 @@ int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
 int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
-int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value);
 int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index adb4888..7f00e37 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -45,6 +45,7 @@ struct mmc_ext_csd {
 	u8			rev;
 	u8			erase_group_def;
 	u8			sec_feature_support;
+	u8			part_cfg;
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		hs_max_dtr;
 	unsigned int		sectors;
@@ -57,6 +58,7 @@ struct mmc_ext_csd {
 	bool			enhanced_area_en;	/* enable bit */
 	unsigned long long	enhanced_area_offset;	/* Units: Byte */
 	unsigned int		enhanced_area_size;	/* Units: KB */
+	unsigned int		boot_size;		/* in bytes */
 };
 
 struct sd_scr {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 64e013f..c11bef9 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -135,6 +135,7 @@ extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
+extern int mmc_switch(struct mmc_card *, u8, u8, u8);
 
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 264ba54..589670a 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -256,6 +256,7 @@ struct _mmc_csd {
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
+#define EXT_CSD_PCFG			179	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
 #define EXT_CSD_HS_TIMING		185	/* R/W */
@@ -267,6 +268,7 @@ struct _mmc_csd {
 #define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
 #define EXT_CSD_ERASE_TIMEOUT_MULT	223	/* RO */
 #define EXT_CSD_HC_ERASE_GRP_SIZE	224	/* RO */
+#define EXT_CSD_BOOT_MULT		226	/* RO */
 #define EXT_CSD_SEC_TRIM_MULT		229	/* RO */
 #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
@@ -276,6 +278,10 @@ struct _mmc_csd {
  * EXT_CSD field definitions
  */
 
+#define EXT_CSD_PCFG_ACC_MASK           (0x7)
+#define EXT_CSD_PCFG_ACC_BOOT0          (0x1)
+#define EXT_CSD_PCFG_ACC_BOOT1          (0x2)
+
 #define EXT_CSD_CMD_SET_NORMAL		(1<<0)
 #define EXT_CSD_CMD_SET_SECURE		(1<<1)
 #define EXT_CSD_CMD_SET_CPSECURE	(1<<2)
-- 
1.7.0.4

