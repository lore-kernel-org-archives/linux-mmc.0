From: Loic Pallardy <loic.pallardy-ext@stericsson.com>
Subject: [PATCH v3 5/5] mmc: card: Add RPMB support in IOCTL interface
Date: Mon, 6 Aug 2012 17:12:31 +0200
Message-ID: <1344265951-22437-6-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:43198 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932132Ab2HFPN2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Aug 2012 11:13:28 -0400
In-Reply-To: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Loic Pallardy <loic.pallardy-ext@stericsson.com>, Alex Macro <alex.macro@stericsson.com>, Loic Pallardy <loic.pallardy@stericsson.com>

RPMB partition is accessing though /dev/block/mmcXrpmb device
User callers can read and write entire data frame(s) as defined
by JEDEC Standard JESD84-A441, using standard IOCTL interface.

Signed-off-by: Alex Macro <alex.macro@stericsson.com>
Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
---
 drivers/mmc/card/block.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index d8edb8d..a9e1f1f 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -126,6 +126,10 @@ enum mmc_blk_status {
 module_param(perdev_minors, int, 0444);
 MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
 
+static inline int mmc_blk_part_switch(struct mmc_card *card,
+				      struct mmc_blk_data *md);
+static int get_card_status(struct mmc_card *card, u32 *status, int retries);
+
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
 	struct mmc_blk_data *md;
@@ -357,6 +361,38 @@ out:
 	return ERR_PTR(err);
 }
 
+static int ioctl_rpmb_card_status_poll(struct mmc_card *card, u32 *status,
+				       u32 retries_max)
+{
+	int err;
+	u32 retry_count = 0;
+
+	if (!status || !retries_max)
+		return -EINVAL;
+
+	do {
+		err = get_card_status(card, status, 5);
+		if (err)
+			break;
+
+		if (!R1_STATUS(*status) &&
+				(R1_CURRENT_STATE(*status) != R1_STATE_PRG))
+			break; /* RPMB programming operation complete */
+
+		/*
+		 * Rechedule to give the MMC device a chance to continue
+		 * processing the previous command without being polled too
+		 * frequently.
+		 */
+		usleep_range(1000, 5000);
+	} while (++retry_count < retries_max);
+
+	if (retry_count == retries_max)
+		err = -EPERM;
+
+	return err;
+}
+
 static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	struct mmc_ioc_cmd __user *ic_ptr)
 {
@@ -368,6 +404,8 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	struct mmc_request mrq = {NULL};
 	struct scatterlist sg;
 	int err;
+	int is_rpmb = false;
+	u32 status = 0;
 
 	/*
 	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
@@ -387,6 +425,9 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		goto cmd_err;
 	}
 
+	if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
+		is_rpmb = true;
+
 	card = md->queue.card;
 	if (IS_ERR(card)) {
 		err = PTR_ERR(card);
@@ -437,12 +478,23 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 
 	mmc_claim_host(card->host);
 
+	err = mmc_blk_part_switch(card, md);
+	if (err)
+		goto cmd_rel_host;
+
 	if (idata->ic.is_acmd) {
 		err = mmc_app_cmd(card->host, card);
 		if (err)
 			goto cmd_rel_host;
 	}
 
+	if (is_rpmb) {
+		err = mmc_set_blockcount(card, data.blocks,
+			idata->ic.write_flag & (1 << 31));
+		if (err)
+			goto cmd_rel_host;
+	}
+
 	mmc_wait_for_req(card->host, &mrq);
 
 	if (cmd.error) {
@@ -478,6 +530,18 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		}
 	}
 
+	if (is_rpmb) {
+		/*
+		 * Ensure RPMB command has completed by polling CMD13
+		 * "Send Status".
+		 */
+		err = ioctl_rpmb_card_status_poll(card, &status, 5);
+		if (err)
+			dev_err(mmc_dev(card->host),
+					"%s: Card Status=0x%08X, error %d\n",
+					__func__, status, err);
+	}
+
 cmd_rel_host:
 	mmc_release_host(card->host);
 
-- 
1.7.11.1

