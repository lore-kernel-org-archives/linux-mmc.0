From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH v2] mmc: boot partition ro lock support
Date: Tue, 22 Nov 2011 13:15:55 +0100
Message-ID: <1321964155-8275-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:35633 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752595Ab1KVMQl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 07:16:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, John Beckett <john.beckett@stericsson.com>

Enable boot partitions to be read-only locked until next power on via
a sysfs entry. There will be one sysfs entry for each boot partition:

/sys/block/mmcblkXbootY/ro_lock_until_next_power_on

Both boot partitions are locked by writing 1 to one of the files.

Signed-off-by: John Beckett <john.beckett@stericsson.com>
Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
 Documentation/mmc/mmc-dev-parts.txt |   13 ++++
 drivers/mmc/card/block.c            |  126 ++++++++++++++++++++++++++++++++--
 drivers/mmc/core/mmc.c              |   14 +++-
 include/linux/mmc/card.h            |   10 +++-
 include/linux/mmc/mmc.h             |    6 ++
 5 files changed, 158 insertions(+), 11 deletions(-)

diff --git a/Documentation/mmc/mmc-dev-parts.txt b/Documentation/mmc/mmc-dev-parts.txt
index 2db28b8..f08d078 100644
--- a/Documentation/mmc/mmc-dev-parts.txt
+++ b/Documentation/mmc/mmc-dev-parts.txt
@@ -25,3 +25,16 @@ echo 0 > /sys/block/mmcblkXbootY/force_ro
 To re-enable read-only access:
 
 echo 1 > /sys/block/mmcblkXbootY/force_ro
+
+The boot partitions can also be locked read only until the next power on,
+with:
+
+echo 1 > /sys/block/mmcblkXbootY/ro_lock_until_next_power_on
+
+This is a feature of the card and not of the kernel. If the card does
+not support boot partition locking, the file will not exist. If the
+feature has been disabled on the card, the file will be read-only.
+
+The boot partitions can also be locked permanently, but this feature is
+not accessible through sysfs in order to avoid accidental or malicious
+bricking.
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e0acf2a..2d318b7 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -107,6 +107,8 @@ struct mmc_blk_data {
 	 */
 	unsigned int	part_curr;
 	struct device_attribute force_ro;
+	struct device_attribute power_ro_lock;
+	int	area_type;
 };
 
 static DEFINE_MUTEX(open_lock);
@@ -165,6 +167,74 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	mutex_unlock(&open_lock);
 }
 
+static ssize_t power_ro_lock_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	int ret;
+	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
+	struct mmc_card *card = md->queue.card;
+	int locked = 0;
+
+	if (card->ext_csd.boot_ro_lock
+			& EXT_CSD_BOOT_WP_B_PERM_WP_EN)
+		locked = 2;
+	else if (card->ext_csd.boot_ro_lock
+			& EXT_CSD_BOOT_WP_B_PWR_WP_EN)
+		locked = 1;
+
+	ret = snprintf(buf, PAGE_SIZE, "%d\n", locked);
+
+	return ret;
+}
+
+static ssize_t power_ro_lock_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+	struct mmc_blk_data *md, *part_md;
+	struct mmc_card *card;
+	unsigned long set;
+
+	if (kstrtoul(buf, 0, &set))
+		return -EINVAL;
+
+	if (set != 1)
+		return count;
+
+	md = mmc_blk_get(dev_to_disk(dev));
+	card = md->queue.card;
+
+	mmc_claim_host(card->host);
+
+	ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
+				card->ext_csd.boot_ro_lock |
+				EXT_CSD_BOOT_WP_B_PWR_WP_EN,
+				card->ext_csd.part_time);
+	if (ret)
+		pr_err("%s: Locking boot partition ro until next power on "
+				"failed: %d\n", md->disk->disk_name, ret);
+	else
+		card->ext_csd.boot_ro_lock |= EXT_CSD_BOOT_WP_B_PWR_WP_EN;
+
+	mmc_release_host(card->host);
+
+	if (!ret) {
+		pr_info("%s: %s\n", md->disk->disk_name, BOOT_PART_MSG);
+		set_disk_ro(md->disk, 1);
+
+		list_for_each_entry(part_md, &md->part, part)
+			if (part_md->area_type == MMC_BLK_DATA_AREA_BOOT) {
+				pr_info("%s: Locking boot partition ro "
+					"until next power on\n",
+					part_md->disk->disk_name);
+				set_disk_ro(part_md->disk, 1);
+			}
+	}
+
+	mmc_blk_put(md);
+	return count;
+}
+
 static ssize_t force_ro_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -1347,7 +1417,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      struct device *parent,
 					      sector_t size,
 					      bool default_ro,
-					      const char *subname)
+					      const char *subname,
+					      int area_type)
 {
 	struct mmc_blk_data *md;
 	int devidx, ret;
@@ -1372,11 +1443,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
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
@@ -1470,7 +1542,8 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 		size = card->csd.capacity << (card->csd.read_blkbits - 9);
 	}
 
-	md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL);
+	md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
+					MMC_BLK_DATA_AREA_MAIN);
 	return md;
 }
 
@@ -1479,13 +1552,14 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
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
@@ -1518,7 +1592,8 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 				card->part[idx].part_cfg,
 				card->part[idx].size >> 9,
 				card->part[idx].force_ro,
-				card->part[idx].name);
+				card->part[idx].name,
+				card->part[idx].area_type);
 			if (ret)
 				return ret;
 		}
@@ -1547,9 +1622,16 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
 
 static void mmc_blk_remove_req(struct mmc_blk_data *md)
 {
+	struct mmc_card *card;
+
 	if (md) {
+		card = md->queue.card;
 		if (md->disk->flags & GENHD_FL_UP) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
+			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
+					card->ext_csd.boot_ro_lockable)
+				device_remove_file(disk_to_dev(md->disk),
+					&md->power_ro_lock);
 
 			/* Stop new requests from getting into the queue */
 			del_gendisk(md->disk);
@@ -1578,6 +1660,7 @@ static void mmc_blk_remove_parts(struct mmc_card *card,
 static int mmc_add_disk(struct mmc_blk_data *md)
 {
 	int ret;
+	struct mmc_card *card = md->queue.card;
 
 	add_disk(md->disk);
 	md->force_ro.show = force_ro_show;
@@ -1587,7 +1670,34 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
 	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
 	if (ret)
-		del_gendisk(md->disk);
+		goto force_ro_fail;
+
+	if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
+					card->ext_csd.boot_ro_lockable) {
+		mode_t mode;
+
+		if (card->ext_csd.boot_ro_lock &
+					EXT_CSD_BOOT_WP_B_PWR_WP_DIS)
+			mode = S_IRUGO;
+		else
+			mode = S_IRUGO | S_IWUSR;
+
+		md->power_ro_lock.show = power_ro_lock_show;
+		md->power_ro_lock.store = power_ro_lock_store;
+		md->power_ro_lock.attr.mode = mode;
+		md->power_ro_lock.attr.name =
+					"ro_lock_until_next_power_on";
+		ret = device_create_file(disk_to_dev(md->disk),
+				&md->power_ro_lock);
+		if (ret)
+			goto power_ro_lock_fail;
+	}
+	return ret;
+
+power_ro_lock_fail:
+	device_remove_file(disk_to_dev(md->disk), &md->force_ro);
+force_ro_fail:
+	del_gendisk(md->disk);
 
 	return ret;
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index dbf421a..f19466f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -348,7 +348,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 				part_size = ext_csd[EXT_CSD_BOOT_MULT] << 17;
 				mmc_part_add(card, part_size,
 					EXT_CSD_PART_CONFIG_ACC_BOOT0 + idx,
-					"boot%d", idx, true);
+					"boot%d", idx, true,
+					MMC_BLK_DATA_AREA_BOOT);
 			}
 		}
 	}
@@ -435,7 +436,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 					hc_wp_grp_sz);
 				mmc_part_add(card, part_size << 19,
 					EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
-					"gp%d", idx, false);
+					"gp%d", idx, false,
+					MMC_BLK_DATA_AREA_GP);
 			}
 		}
 		card->ext_csd.sec_trim_mult =
@@ -446,6 +448,14 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT];
 		card->ext_csd.trim_timeout = 300 *
 			ext_csd[EXT_CSD_TRIM_MULT];
+
+		/*
+		 * Note that the call to mmc_part_add above defaults to read
+		 * only. If this default assumption is changed, the call must
+		 * take into account the value of boot_locked below.
+		 */
+		card->ext_csd.boot_ro_lock = ext_csd[EXT_CSD_BOOT_WP];
+		card->ext_csd.boot_ro_lockable = true;
 	}
 
 	if (card->ext_csd.rev >= 5) {
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 415f2db..9d78778 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -71,6 +71,8 @@ struct mmc_ext_csd {
 	bool			hpi_en;			/* HPI enablebit */
 	bool			hpi;			/* HPI support bit */
 	unsigned int		hpi_cmd;		/* cmd used as HPI */
+	unsigned int		boot_ro_lock;		/* ro lock support */
+	bool			boot_ro_lockable;
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_erased_mem_count;	/* 181 */
 	u8			raw_ext_csd_structure;	/* 194 */
@@ -184,6 +186,10 @@ struct mmc_part {
 	unsigned int	part_cfg;	/* partition type */
 	char	name[MAX_MMC_PART_NAME_LEN];
 	bool	force_ro;	/* to make boot parts RO by default */
+	unsigned int	area_type;
+#define MMC_BLK_DATA_AREA_MAIN	(1<<0)
+#define MMC_BLK_DATA_AREA_BOOT	(1<<1)
+#define MMC_BLK_DATA_AREA_GP	(1<<2)
 };
 
 /*
@@ -260,12 +266,14 @@ struct mmc_card {
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
1.7.7

