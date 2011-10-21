From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: boot partition ro lock support
Date: Fri, 21 Oct 2011 15:17:23 +0200
Message-ID: <1319203043-29388-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:45618 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325Ab1JUNSS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2011 09:18:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, John Beckett <john.beckett@stericsson.com>

From: Johan Rudholm <johan.rudholm@stericsson.com>

Enable boot partitions to be power and permanently read-only locked via
a sysfs entry. There will be one sysfs entry for the main mmc device:

/sys/block/mmcblkX/boot_partition_ro_lock

and one for each boot partition:

/sys/block/mmcblkXbootY/ro_lock

The boot partitions are power or permanently locked by writing "pwr_ro"
or "perm_ro" to one of the files.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: John Beckett <john.beckett@stericsson.com>
Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
 drivers/mmc/card/block.c |  124 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/core/mmc.c   |   15 +++++-
 include/linux/mmc/card.h |    9 +++-
 include/linux/mmc/mmc.h  |    6 ++
 4 files changed, 143 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index b2c76bb..f6084b7 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -107,6 +107,8 @@ struct mmc_blk_data {
 	 */
 	unsigned int	part_curr;
 	struct device_attribute force_ro;
+	struct device_attribute boot_partition_ro_lock;
+	int	area_type;
 };
 
 static DEFINE_MUTEX(open_lock);
@@ -165,6 +167,80 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	mutex_unlock(&open_lock);
 }
 
+#define EXT_CSD_BOOT_WP_PWR_WP_TEXT "pwr_ro"
+#define EXT_CSD_BOOT_WP_PERM_WP_TEXT "perm_ro"
+#define EXT_CSD_BOOT_WP_WP_DISABLED_TEXT "rw"
+static ssize_t boot_partition_ro_lock_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	int ret;
+	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
+	struct mmc_card *card = md->queue.card;
+	const char *out_text;
+
+	if (card->ext_csd.boot_locked
+			& EXT_CSD_BOOT_WP_B_PERM_WP_EN)
+		out_text = EXT_CSD_BOOT_WP_PERM_WP_TEXT;
+	else if (card->ext_csd.boot_locked
+			& EXT_CSD_BOOT_WP_B_PWR_WP_EN)
+		out_text = EXT_CSD_BOOT_WP_PWR_WP_TEXT;
+	else
+		out_text = EXT_CSD_BOOT_WP_WP_DISABLED_TEXT;
+
+	ret = snprintf(buf, PAGE_SIZE, "%s\n", out_text);
+
+	return ret;
+}
+
+static ssize_t boot_partition_ro_lock_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+	struct mmc_blk_data *md, *part_md;
+	struct mmc_card *card;
+	u8 set = 0;
+
+	md = mmc_blk_get(dev_to_disk(dev));
+	card = md->queue.card;
+
+	if (!strncmp(buf, EXT_CSD_BOOT_WP_PWR_WP_TEXT,
+				strlen(EXT_CSD_BOOT_WP_PWR_WP_TEXT)))
+		set = EXT_CSD_BOOT_WP_B_PWR_WP_EN;
+	else if (!strncmp(buf, EXT_CSD_BOOT_WP_PERM_WP_TEXT,
+				strlen(EXT_CSD_BOOT_WP_PERM_WP_TEXT)))
+		set = EXT_CSD_BOOT_WP_B_PERM_WP_EN;
+
+	if (set) {
+		mmc_claim_host(card->host);
+
+		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_BOOT_WP,
+				set,
+				card->ext_csd.part_time);
+		if (ret)
+			pr_err("Boot Partition Lock failed: %d", ret);
+		else
+			card->ext_csd.boot_locked = set;
+
+		mmc_release_host(card->host);
+
+		if (!ret)
+			list_for_each_entry(part_md, &md->part, part)
+				if (part_md->area_type ==
+						MMC_BLK_DATA_AREA_BOOT) {
+					pr_info("%s: Locking boot partition "
+						"%s",
+						part_md->disk->disk_name,
+						buf);
+					set_disk_ro(part_md->disk, 1);
+				}
+	}
+	ret = count;
+
+	mmc_blk_put(md);
+	return ret;
+}
+
 static ssize_t force_ro_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -1329,7 +1405,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      struct device *parent,
 					      sector_t size,
 					      bool default_ro,
-					      const char *subname)
+					      const char *subname,
+					      int area_type)
 {
 	struct mmc_blk_data *md;
 	int devidx, ret;
@@ -1354,11 +1431,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	if (!subname) {
 		md->name_idx = find_first_zero_bit(name_use, max_devices);
 		__set_bit(md->name_idx, name_use);
-	}
-	else
+	} else
 		md->name_idx = ((struct mmc_blk_data *)
 				dev_to_disk(parent)->private_data)->name_idx;
 
+	md->area_type = area_type;
+
 	/*
 	 * Set the read-only status based on the supported commands
 	 * and the write protect switch.
@@ -1452,7 +1530,8 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 		size = card->csd.capacity << (card->csd.read_blkbits - 9);
 	}
 
-	md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL);
+	md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
+					MMC_BLK_DATA_AREA_MAIN);
 	return md;
 }
 
@@ -1461,13 +1540,14 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 			      unsigned int part_type,
 			      sector_t size,
 			      bool default_ro,
-			      const char *subname)
+			      const char *subname,
+			      int area_type)
 {
 	char cap_str[10];
 	struct mmc_blk_data *part_md;
 
 	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
-				    subname);
+				    subname, area_type);
 	if (IS_ERR(part_md))
 		return PTR_ERR(part_md);
 	part_md->part_type = part_type;
@@ -1500,7 +1580,8 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 				card->part[idx].part_cfg,
 				card->part[idx].size >> 9,
 				card->part[idx].force_ro,
-				card->part[idx].name);
+				card->part[idx].name,
+				card->part[idx].area_type);
 			if (ret)
 				return ret;
 		}
@@ -1532,6 +1613,10 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 	if (md) {
 		if (md->disk->flags & GENHD_FL_UP) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
+			if (md->area_type == MMC_BLK_DATA_AREA_MAIN ||
+					md->area_type == MMC_BLK_DATA_AREA_BOOT)
+				device_remove_file(disk_to_dev(md->disk),
+					&md->boot_partition_ro_lock);
 
 			/* Stop new requests from getting into the queue */
 			del_gendisk(md->disk);
@@ -1569,7 +1654,30 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
 	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
 	if (ret)
-		del_gendisk(md->disk);
+		goto force_ro_fail;
+
+	if (md->area_type == MMC_BLK_DATA_AREA_MAIN ||
+				md->area_type == MMC_BLK_DATA_AREA_BOOT) {
+		md->boot_partition_ro_lock.show = boot_partition_ro_lock_show;
+		md->boot_partition_ro_lock.store = boot_partition_ro_lock_store;
+		md->boot_partition_ro_lock.attr.mode = S_IRUGO | S_IWUSR;
+		if (md->area_type == MMC_BLK_DATA_AREA_MAIN)
+			md->boot_partition_ro_lock.attr.name =
+					"boot_partition_ro_lock";
+		else
+			md->boot_partition_ro_lock.attr.name =
+					"ro_lock";
+		ret = device_create_file(disk_to_dev(md->disk),
+				&md->boot_partition_ro_lock);
+		if (ret)
+			goto boot_partition_ro_lock_fail;
+	}
+	return ret;
+
+boot_partition_ro_lock_fail:
+	device_remove_file(disk_to_dev(md->disk), &md->force_ro);
+force_ro_fail:
+	del_gendisk(md->disk);
 
 	return ret;
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index fb5bf01..4c3d0df 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -339,6 +339,15 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.rel_sectors = ext_csd[EXT_CSD_REL_WR_SEC_C];
 
 		/*
+		 * Note that the call to mmc_part_add defaults to read
+		 * only. If this default assumption is changed, the call must
+		 * take into account the value of boot_locked below.
+		 */
+		card->ext_csd.boot_locked = ext_csd[EXT_CSD_BOOT_WP] &
+			(EXT_CSD_BOOT_WP_B_PERM_WP_EN |
+			 EXT_CSD_BOOT_WP_B_PWR_WP_EN);
+
+		/*
 		 * There are two boot regions of equal size, defined in
 		 * multiples of 128K.
 		 */
@@ -347,7 +356,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 				part_size = ext_csd[EXT_CSD_BOOT_MULT] << 17;
 				mmc_part_add(card, part_size,
 					EXT_CSD_PART_CONFIG_ACC_BOOT0 + idx,
-					"boot%d", idx, true);
+					"boot%d", idx, true,
+					MMC_BLK_DATA_AREA_BOOT);
 			}
 		}
 	}
@@ -434,7 +444,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 					hc_wp_grp_sz);
 				mmc_part_add(card, part_size << 19,
 					EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
-					"gp%d", idx, false);
+					"gp%d", idx, false,
+					MMC_BLK_DATA_AREA_GP);
 			}
 		}
 		card->ext_csd.sec_trim_mult =
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6e04e10..3ed333f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -71,6 +71,7 @@ struct mmc_ext_csd {
 	bool			hpi_en;			/* HPI enablebit */
 	bool			hpi;			/* HPI support bit */
 	unsigned int		hpi_cmd;		/* cmd used as HPI */
+	unsigned int		boot_locked;
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_erased_mem_count;	/* 181 */
 	u8			raw_ext_csd_structure;	/* 194 */
@@ -184,6 +185,10 @@ struct mmc_part {
 	unsigned int	part_cfg;	/* partition type */ 
 	char	name[MAX_MMC_PART_NAME_LEN];
 	bool	force_ro;	/* to make boot parts RO by default */
+	int	area_type;
+#define MMC_BLK_DATA_AREA_MAIN	0
+#define MMC_BLK_DATA_AREA_BOOT	1
+#define MMC_BLK_DATA_AREA_GP	2
 };
 
 /*
@@ -260,12 +265,14 @@ struct mmc_card {
  * This function fill contents in mmc_part.
  */
 static inline void mmc_part_add(struct mmc_card *card, unsigned int size,
-			unsigned int part_cfg, char *name, int idx, bool ro)
+			unsigned int part_cfg, char *name, int idx, bool ro,
+			int area_type)
 {
 	card->part[card->nr_parts].size = size;
 	card->part[card->nr_parts].part_cfg = part_cfg;
 	sprintf(card->part[card->nr_parts].name, name, idx);
 	card->part[card->nr_parts].force_ro = ro;
+	card->part[card->nr_parts].area_type = area_type;
 	card->nr_parts++;
 }
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 0e71356..665548e 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -280,6 +280,7 @@ struct _mmc_csd {
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_SANITIZE_START		165     /* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
+#define EXT_CSD_BOOT_WP			173	/* R/W */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
@@ -321,6 +322,11 @@ struct _mmc_csd {
 
 #define EXT_CSD_WR_REL_PARAM_EN		(1<<2)
 
+#define EXT_CSD_BOOT_WP_B_PWR_WP_DIS	(0x40)
+#define EXT_CSD_BOOT_WP_B_PERM_WP_DIS	(0x10)
+#define EXT_CSD_BOOT_WP_B_PERM_WP_EN	(0x04)
+#define EXT_CSD_BOOT_WP_B_PWR_WP_EN	(0x01)
+
 #define EXT_CSD_PART_CONFIG_ACC_MASK	(0x7)
 #define EXT_CSD_PART_CONFIG_ACC_BOOT0	(0x1)
 #define EXT_CSD_PART_CONFIG_ACC_GP0	(0x4)
-- 
1.7.5.4

