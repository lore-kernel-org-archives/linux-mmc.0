From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v1] mmc: block: Fix coding style issues
Date: Wed, 12 Aug 2015 13:07:27 +0800
Message-ID: <1439356047-10660-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.138]:39971 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbbHLFLW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2015 01:11:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following issues reported by checkpatch.pl:
- Missing a blank line after declarations
- line over 80 characters
- use kstrtoul instead of simple_strtoul to fix warning massage:
  "simple_strtoul is obsolete, use kstrtoul instead"
- unnecessary braces {} for single statement blocks
- remove else statement to fix warning massage:
  "else is not generally useful after a break or return"
- put open brace { on the previous line to fix warning massage:
  "that open brace { should be on the previous line"

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/card/block.c | 62 ++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a58287e..98b85a4 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -102,9 +102,12 @@ struct mmc_blk_data {
 	struct list_head part;
 
 	unsigned int	flags;
-#define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
-#define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
-#define MMC_BLK_PACKED_CMD	(1 << 2)	/* MMC packed command support */
+/* Can do SET_BLOCK_COUNT for multiblock */
+#define MMC_BLK_CMD23	(1 << 0)
+/* MMC Reliable write support */
+#define MMC_BLK_REL_WR	(1 << 1)
+/* MMC packed command support */
+#define MMC_BLK_PACKED_CMD	(1 << 2)
 
 	unsigned int	usage;
 	unsigned int	read_only;
@@ -186,6 +189,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	md->usage--;
 	if (md->usage == 0) {
 		int devidx = mmc_get_devidx(md->disk);
+
 		blk_cleanup_queue(md->queue.queue);
 
 		__clear_bit(devidx, dev_use);
@@ -240,7 +244,8 @@ static ssize_t power_ro_lock_store(struct device *dev,
 				EXT_CSD_BOOT_WP_B_PWR_WP_EN,
 				card->ext_csd.part_time);
 	if (ret)
-		pr_err("%s: Locking boot partition ro until next power on failed: %d\n", md->disk->disk_name, ret);
+		pr_err("%s: Locking boot partition ro until next power on failed: %d\n",
+		       md->disk->disk_name, ret);
 	else
 		card->ext_csd.boot_ro_lock |= EXT_CSD_BOOT_WP_B_PWR_WP_EN;
 
@@ -253,7 +258,8 @@ static ssize_t power_ro_lock_store(struct device *dev,
 
 		list_for_each_entry(part_md, &md->part, part)
 			if (part_md->area_type == MMC_BLK_DATA_AREA_BOOT) {
-				pr_info("%s: Locking boot partition ro until next power on\n", part_md->disk->disk_name);
+				pr_info("%s: Locking boot partition ro until next power on\n",
+					part_md->disk->disk_name);
 				set_disk_ro(part_md->disk, 1);
 			}
 	}
@@ -279,10 +285,12 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	int ret;
-	char *end;
+	int err;
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
-	unsigned long set = simple_strtoul(buf, &end, 0);
-	if (end == buf) {
+	unsigned long set;
+
+	err = kstrtoul(buf, 0, &set);
+	if (err) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -580,7 +588,8 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	 * issuing the command.
 	 */
 	if (idata->ic.postsleep_min_us)
-		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
+		usleep_range(idata->ic.postsleep_min_us,
+			     idata->ic.postsleep_max_us);
 
 	if (copy_to_user(&(ic_ptr->response), cmd.resp, sizeof(cmd.resp))) {
 		err = -EFAULT;
@@ -588,8 +597,9 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	}
 
 	if (!idata->ic.write_flag) {
-		if (copy_to_user((void __user *)(unsigned long) idata->ic.data_ptr,
-						idata->buf, idata->buf_bytes)) {
+		if (copy_to_user((void __user *)(unsigned long)
+				  idata->ic.data_ptr, idata->buf,
+				  idata->buf_bytes)) {
 			err = -EFAULT;
 			goto cmd_rel_host;
 		}
@@ -622,6 +632,7 @@ static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	int ret = -EINVAL;
+
 	if (cmd == MMC_IOC_CMD)
 		ret = mmc_blk_ioctl_cmd(bdev, (struct mmc_ioc_cmd __user *)arg);
 	return ret;
@@ -1227,7 +1238,8 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	 */
 	if (brq->sbc.error || brq->cmd.error || brq->stop.error ||
 	    brq->data.error) {
-		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err)) {
+		switch (mmc_blk_cmd_recovery(card, req, brq,
+					     &ecc_err, &gen_err)) {
 		case ERR_RETRY:
 			return MMC_BLK_RETRY;
 		case ERR_ABORT:
@@ -1356,8 +1368,7 @@ static int mmc_blk_packed_err_check(struct mmc_card *card,
 				  ext_csd[EXT_CSD_PACKED_FAILURE_INDEX] - 1;
 				check = MMC_BLK_PARTIAL;
 			}
-			pr_err("%s: packed cmd failed, nr %u, sectors %u, "
-			       "failure index: %d\n",
+			pr_err("%s: packed cmd failed, nr %u, sectors %u, failure index: %d\n",
 			       req->rq_disk->disk_name, packed->nr_entries,
 			       packed->blocks, packed->idx_failure);
 		}
@@ -1744,6 +1755,7 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 			   int ret)
 {
 	struct mmc_queue_req *mq_rq;
+
 	mq_rq = container_of(brq, struct mmc_queue_req, brq);
 
 	/*
@@ -1758,9 +1770,8 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 		u32 blocks;
 
 		blocks = mmc_sd_num_wr_blocks(card);
-		if (blocks != (u32)-1) {
+		if (blocks != (u32)-1)
 			ret = blk_end_request(req, 0, blocks << 9);
-		}
 	} else {
 		if (!mmc_packed_cmd(mq_rq->cmd_type))
 			ret = blk_end_request(req, 0, brq->data.bytes_xfered);
@@ -1905,11 +1916,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			if (mmc_packed_cmd(mq_rq->cmd_type)) {
 				ret = mmc_blk_end_packed_req(mq_rq);
 				break;
-			} else {
-				ret = blk_end_request(req, 0,
-						brq->data.bytes_xfered);
 			}
 
+			ret = blk_end_request(req, 0, brq->data.bytes_xfered);
+
 			/*
 			 * If the blk_end_request function returns non-zero even
 			 * though all data has been transferred and no errors
@@ -2047,9 +2057,9 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
-		if (req) {
+		if (req)
 			blk_end_request_all(req, -EIO);
-		}
+
 		ret = 0;
 		goto out;
 	}
@@ -2255,8 +2265,8 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 	char cap_str[10];
 	struct mmc_blk_data *part_md;
 
-	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
-				    subname, area_type);
+	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size,
+				    default_ro, subname, area_type);
 	if (IS_ERR(part_md))
 		return PTR_ERR(part_md);
 	part_md->part_type = part_type;
@@ -2314,7 +2324,8 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		if (md->flags & MMC_BLK_PACKED_CMD)
 			mmc_packed_clean(&md->queue);
 		if (md->disk->flags & GENHD_FL_UP) {
-			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
+			device_remove_file(disk_to_dev(md->disk),
+					   &md->force_ro);
 			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
 					card->ext_csd.boot_ro_lockable)
 				device_remove_file(disk_to_dev(md->disk),
@@ -2390,8 +2401,7 @@ force_ro_fail:
 #define CID_MANFID_MICRON	0x13
 #define CID_MANFID_SAMSUNG	0x15
 
-static const struct mmc_fixup blk_fixups[] =
-{
+static const struct mmc_fixup blk_fixups[] = {
 	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
 		  MMC_QUIRK_INAND_CMD38),
 	MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
-- 
2.3.7


