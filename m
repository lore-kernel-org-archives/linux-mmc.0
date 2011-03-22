From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCHv3] MMC: MMC boot partitions support.
Date: Mon, 21 Mar 2011 22:54:04 -0500
Message-ID: <1300766044-2206-1-git-send-email-andreiw@motorola.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og101.obsmtp.com ([64.18.0.141]:37666 "EHLO
	exprod5og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab1CVDMN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2011 23:12:13 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2M3CU38005544
	for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2011 23:12:30 -0400 (EDT)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2M3C8EK005379
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2011 23:12:30 -0400 (EDT)
Received: by mail-gw0-f42.google.com with SMTP id 17so4052765gwb.15
        for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2011 20:12:11 -0700 (PDT)
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
 drivers/mmc/card/block.c   |  208 +++++++++++++++++++++++++++++++++++---------
 drivers/mmc/core/mmc.c     |    5 +
 drivers/mmc/core/mmc_ops.h |    1 -
 include/linux/mmc/card.h   |    2 +
 include/linux/mmc/core.h   |    1 +
 include/linux/mmc/mmc.h    |    6 ++
 7 files changed, 199 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 86948f9..f05e283 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -14,6 +14,24 @@ config MMC_BLOCK
 	  mount the filesystem. Almost everyone wishing MMC support
 	  should say Y or M here.
 
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
index 7054fd5..ca18218 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -60,9 +60,18 @@ struct mmc_blk_data {
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
@@ -153,6 +162,28 @@ struct mmc_blk_request {
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
@@ -250,8 +281,6 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	unsigned int from, nr, arg;
 	int err = 0;
 
-	mmc_claim_host(card->host);
-
 	if (!mmc_can_erase(card)) {
 		err = -EOPNOTSUPP;
 		goto out;
@@ -271,8 +300,6 @@ out:
 	__blk_end_request(req, err, blk_rq_bytes(req));
 	spin_unlock_irq(&md->lock);
 
-	mmc_release_host(card->host);
-
 	return err ? 0 : 1;
 }
 
@@ -284,8 +311,6 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	unsigned int from, nr, arg;
 	int err = 0;
 
-	mmc_claim_host(card->host);
-
 	if (!mmc_can_secure_erase_trim(card)) {
 		err = -EOPNOTSUPP;
 		goto out;
@@ -307,8 +332,6 @@ out:
 	__blk_end_request(req, err, blk_rq_bytes(req));
 	spin_unlock_irq(&md->lock);
 
-	mmc_release_host(card->host);
-
 	return err ? 0 : 1;
 }
 
@@ -319,8 +342,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_blk_request brq;
 	int ret = 1, disable_multi = 0;
 
-	mmc_claim_host(card->host);
-
 	do {
 		struct mmc_command cmd;
 		u32 readcmd, writecmd, status = 0;
@@ -504,8 +525,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		spin_unlock_irq(&md->lock);
 	} while (ret);
 
-	mmc_release_host(card->host);
-
 	return 1;
 
  cmd_err:
@@ -532,8 +551,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		spin_unlock_irq(&md->lock);
 	}
 
-	mmc_release_host(card->host);
-
 	spin_lock_irq(&md->lock);
 	while (ret)
 		ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
@@ -547,6 +564,7 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card);
 
 static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 {
+	int ret;
 #ifdef CONFIG_MMC_BLOCK_DEFERRED_RESUME
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
@@ -557,14 +575,25 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	}
 #endif
 
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
@@ -573,7 +602,8 @@ static inline int mmc_blk_readonly(struct mmc_card *card)
 	       !(card->csd.cmdclass & CCC_BLOCK_WRITE);
 }
 
-static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
+static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
+					      sector_t size)
 {
 	struct mmc_blk_data *md;
 	int devidx, ret;
@@ -589,7 +619,6 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 		goto out;
 	}
 
-
 	/*
 	 * Set the read-only status based on the supported commands
 	 * and the write protect switch.
@@ -603,6 +632,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	}
 
 	spin_lock_init(&md->lock);
+	INIT_LIST_HEAD(&md->part);
 	md->usage = 1;
 
 	ret = mmc_init_queue(&md->queue, card, &md->lock);
@@ -635,29 +665,84 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	sprintf(md->disk->disk_name, "mmcblk%d", devidx);
 
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
@@ -686,9 +771,37 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
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
@@ -713,17 +826,23 @@ static int mmc_blk_probe(struct mmc_card *card)
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
 		cap_str, md->read_only ? "(ro)" : "");
 
+	if (mmc_blk_alloc_parts(card, md))
+		goto out;
+
 	mmc_set_drvdata(card, md);
 #ifdef CONFIG_MMC_BLOCK_DEFERRED_RESUME
 	mmc_set_bus_resume_policy(card->host, 1);
 #endif
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
 
@@ -731,15 +850,8 @@ static void mmc_blk_remove(struct mmc_card *card)
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
 #ifdef CONFIG_MMC_BLOCK_DEFERRED_RESUME
 	mmc_set_bus_resume_policy(card->host, 0);
@@ -749,23 +861,37 @@ static void mmc_blk_remove(struct mmc_card *card)
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
 #ifndef CONFIG_MMC_BLOCK_DEFERRED_RESUME
 		mmc_blk_set_blksize(md, card);
 #endif
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
index 6909a54..3d757aa 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -284,6 +284,11 @@ static int mmc_read_ext_csd(struct mmc_card *card)
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
index 653eb8e..b1a806f 100644
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
index fe9d7be..0911552 100644
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
@@ -53,6 +54,7 @@ struct mmc_ext_csd {
 	unsigned int		sec_trim_mult;	/* Secure trim multiplier  */
 	unsigned int		sec_erase_mult;	/* Secure erase multiplier */
 	unsigned int		trim_timeout;		/* In milliseconds */
+	unsigned int		boot_size;  /* in bytes */
 };
 
 struct sd_scr {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 7429033..a6cd7c3 100644
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
index dd11ae5..9442cbc 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -252,6 +252,7 @@ struct _mmc_csd {
  */
 
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
+#define EXT_CSD_PCFG			179	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
 #define EXT_CSD_HS_TIMING		185	/* R/W */
@@ -262,6 +263,7 @@ struct _mmc_csd {
 #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
 #define EXT_CSD_ERASE_TIMEOUT_MULT	223	/* RO */
 #define EXT_CSD_HC_ERASE_GRP_SIZE	224	/* RO */
+#define EXT_CSD_BOOT_MULT		226	/* RO */
 #define EXT_CSD_SEC_TRIM_MULT		229	/* RO */
 #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
@@ -271,6 +273,10 @@ struct _mmc_csd {
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

