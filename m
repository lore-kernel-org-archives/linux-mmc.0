From: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
Subject: [PATCH 5/5] drivers: mmc: card: Fixed warning line over 80 characters in file block
Date: Mon,  2 Feb 2015 01:37:02 +0530
Message-ID: <1422821222-24079-6-git-send-email-sheetal.tigadoli@gmail.com>
References: <1422821222-24079-1-git-send-email-sheetal.tigadoli@gmail.com>
 <1422821222-24079-2-git-send-email-sheetal.tigadoli@gmail.com>
 <1422821222-24079-3-git-send-email-sheetal.tigadoli@gmail.com>
 <1422821222-24079-4-git-send-email-sheetal.tigadoli@gmail.com>
 <1422821222-24079-5-git-send-email-sheetal.tigadoli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422821222-24079-5-git-send-email-sheetal.tigadoli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net
Cc: joe@perches.com, linux-mmc@vger.kernel.org, ben@decadent.org.uk, kuninori.morimoto.gx@renesas.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This patch fixes the following warning mesg from file block.c

        drivers/mmc/card/block.c:102: WARNING: line over 80 characters
        drivers/mmc/card/block.c:578: WARNING: line over 80 characters
        drivers/mmc/card/block.c:586: WARNING: line over 80 characters
        drivers/mmc/card/block.c:1209: WARNING: line over 80 characters
        drivers/mmc/card/block.c:2226: WARNING: line over 80 characters

Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
---
 drivers/mmc/card/block.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index fe47297..43edecb 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -99,7 +99,8 @@ struct mmc_blk_data {
 	struct list_head part;
 
 	unsigned int	flags;
-#define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
+#define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for
+					   multiblock */
 #define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
 #define MMC_BLK_PACKED_CMD	(1 << 2)	/* MMC packed command support */
 
@@ -575,7 +576,8 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	 * issuing the command.
 	 */
 	if (idata->ic.postsleep_min_us)
-		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
+		usleep_range(idata->ic.postsleep_min_us,
+			     idata->ic.postsleep_max_us);
 
 	if (copy_to_user(&(ic_ptr->response), cmd.resp, sizeof(cmd.resp))) {
 		err = -EFAULT;
@@ -583,8 +585,9 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	}
 
 	if (!idata->ic.write_flag) {
-		if (copy_to_user((void __user *)(unsigned long) idata->ic.data_ptr,
-						idata->buf, idata->buf_bytes)) {
+		if (copy_to_user(
+		      (void __user *)(unsigned long) idata->ic.data_ptr,
+		      idata->buf, idata->buf_bytes)) {
 			err = -EFAULT;
 			goto cmd_rel_host;
 		}
@@ -1207,7 +1210,10 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	 */
 	if (brq->sbc.error || brq->cmd.error || brq->stop.error ||
 	    brq->data.error) {
-		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err)) {
+		int err;
+
+		err = mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err);
+		switch (err) {
 		case ERR_RETRY:
 			return MMC_BLK_RETRY;
 		case ERR_ABORT:
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
-- 
1.7.9.5
