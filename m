From: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
Subject: [PATCH] drivers: mmc: card: Fixing few coding style errors from file block.c
Date: Sat, 31 Jan 2015 23:37:47 +0530
Message-ID: <1422727667-15785-1-git-send-email-sheetal.tigadoli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net
Cc: joe@perches.com, linux-mmc@vger.kernel.org, ben@decadent.org.uk, kuninori.morimoto.gx@renesas.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The patch fixes some of the following error/warnings from the file block.c

./scripts/checkpatch.pl  --file --terse drivers/mmc/card/block.c
drivers/mmc/card/block.c:45: WARNING: Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
drivers/mmc/card/block.c:102: WARNING: line over 80 characters
drivers/mmc/card/block.c:186: WARNING: Missing a blank line after declarations
drivers/mmc/card/block.c:238: WARNING: line over 80 characters
drivers/mmc/card/block.c:251: WARNING: line over 80 characters
drivers/mmc/card/block.c:279: WARNING: simple_strtoul is obsolete, use kstrtoul instead
drivers/mmc/card/block.c:280: WARNING: Missing a blank line after declarations
drivers/mmc/card/block.c:578: WARNING: line over 80 characters
drivers/mmc/card/block.c:586: WARNING: line over 80 characters
drivers/mmc/card/block.c:620: WARNING: Missing a blank line after declarations
drivers/mmc/card/block.c:1209: WARNING: line over 80 characters
drivers/mmc/card/block.c:1333: WARNING: quoted string split across lines
drivers/mmc/card/block.c:1720: WARNING: Missing a blank line after declarations
drivers/mmc/card/block.c:1734: WARNING: braces {} are not necessary for single statement blocks
drivers/mmc/card/block.c:1881: WARNING: else is not generally useful after a break or return
drivers/mmc/card/block.c:2019: WARNING: braces {} are not necessary for single statement blocks
drivers/mmc/card/block.c:2226: WARNING: line over 80 characters
drivers/mmc/card/block.c:2285: WARNING: line over 80 characters
drivers/mmc/card/block.c:2362: ERROR: that open brace { should be on the previous line
  total: 1 errors, 18 warnings, 2587 lines checked

Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
---
 drivers/mmc/card/block.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c69afb5..2489f71 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -183,6 +183,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	md->usage--;
 	if (md->usage == 0) {
 		int devidx = mmc_get_devidx(md->disk);
+
 		blk_cleanup_queue(md->queue.queue);
 
 		__clear_bit(devidx, dev_use);
@@ -277,6 +278,7 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
 	char *end;
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
 	unsigned long set = simple_strtoul(buf, &end, 0);
+
 	if (end == buf) {
 		ret = -EINVAL;
 		goto out;
@@ -575,7 +577,8 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	 * issuing the command.
 	 */
 	if (idata->ic.postsleep_min_us)
-		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
+		usleep_range(idata->ic.postsleep_min_us,
+		    idata->ic.postsleep_max_us);
 
 	if (copy_to_user(&(ic_ptr->response), cmd.resp, sizeof(cmd.resp))) {
 		err = -EFAULT;
@@ -617,6 +620,7 @@ static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	int ret = -EINVAL;
+
 	if (cmd == MMC_IOC_CMD)
 		ret = mmc_blk_ioctl_cmd(bdev, (struct mmc_ioc_cmd __user *)arg);
 	return ret;
@@ -1206,7 +1210,10 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	 */
 	if (brq->sbc.error || brq->cmd.error || brq->stop.error ||
 	    brq->data.error) {
-		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err)) {
+		int err = mmc_blk_cmd_recovery(card, req, brq, &ecc_err,
+				&gen_err);
+
+		switch (err) {
 		case ERR_RETRY:
 			return MMC_BLK_RETRY;
 		case ERR_ABORT:
@@ -1717,6 +1724,7 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 			   int ret)
 {
 	struct mmc_queue_req *mq_rq;
+
 	mq_rq = container_of(brq, struct mmc_queue_req, brq);
 
 	/*
@@ -1731,9 +1739,8 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 		u32 blocks;
 
 		blocks = mmc_sd_num_wr_blocks(card);
-		if (blocks != (u32)-1) {
+		if (blocks != (u32)-1)
 			ret = blk_end_request(req, 0, blocks << 9);
-		}
 	} else {
 		if (!mmc_packed_cmd(mq_rq->cmd_type))
 			ret = blk_end_request(req, 0, brq->data.bytes_xfered);
@@ -2016,9 +2023,8 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
-		if (req) {
+		if (req)
 			blk_end_request_all(req, -EIO);
-		}
 		ret = 0;
 		goto out;
 	}
@@ -2223,8 +2229,8 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 	char cap_str[10];
 	struct mmc_blk_data *part_md;
 
-	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
-				    subname, area_type);
+	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size,
+				    default_ro, subname, area_type);
 	if (IS_ERR(part_md))
 		return PTR_ERR(part_md);
 	part_md->part_type = part_type;
@@ -2282,7 +2288,8 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		if (md->flags & MMC_BLK_PACKED_CMD)
 			mmc_packed_clean(&md->queue);
 		if (md->disk->flags & GENHD_FL_UP) {
-			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
+			device_remove_file(disk_to_dev(md->disk),
+				&md->force_ro);
 			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
 					card->ext_csd.boot_ro_lockable)
 				device_remove_file(disk_to_dev(md->disk),
@@ -2358,8 +2365,7 @@ force_ro_fail:
 #define CID_MANFID_MICRON	0x13
 #define CID_MANFID_SAMSUNG	0x15
 
-static const struct mmc_fixup blk_fixups[] =
-{
+static const struct mmc_fixup blk_fixups[] = {
 	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
 		  MMC_QUIRK_INAND_CMD38),
 	MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
-- 
1.7.9.5
