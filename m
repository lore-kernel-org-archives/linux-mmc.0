From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2] mmc: block: Use __mmc_send_status() and drop get_card_status()
Date: Mon, 22 May 2017 10:23:58 +0200
Message-ID: <1495441438-5129-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33615 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbdEVIYD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 04:24:03 -0400
Received: by mail-lf0-f52.google.com with SMTP id m18so26583005lfj.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2017 01:24:02 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

The only reason to why the mmc block device driver needs to implements its
own version of how to get the status of the card, is that it needs to
specify a different amount of retries.

Therefore add a new exported function which allows the caller to specify
the number of retries and convert everybody to use it, as this simplifies
the code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Allow callers to specify retries.

---
 drivers/mmc/core/block.c   | 22 +++-------------------
 drivers/mmc/core/mmc_ops.c | 10 ++++++++--
 drivers/mmc/core/mmc_ops.h |  1 +
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e973798..8263859 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -127,7 +127,6 @@ MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
 
 static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      struct mmc_blk_data *md);
-static int get_card_status(struct mmc_card *card, u32 *status, int retries);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -385,7 +384,7 @@ static int ioctl_rpmb_card_status_poll(struct mmc_card *card, u32 *status,
 		return -EINVAL;
 
 	do {
-		err = get_card_status(card, status, 5);
+		err = __mmc_send_status(card, status, 5);
 		if (err)
 			break;
 
@@ -885,21 +884,6 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	return 0;
 }
 
-static int get_card_status(struct mmc_card *card, u32 *status, int retries)
-{
-	struct mmc_command cmd = {};
-	int err;
-
-	cmd.opcode = MMC_SEND_STATUS;
-	if (!mmc_host_is_spi(card->host))
-		cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
-	err = mmc_wait_for_cmd(card->host, &cmd, retries);
-	if (err == 0)
-		*status = cmd.resp[0];
-	return err;
-}
-
 static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 		bool hw_busy_detect, struct request *req, bool *gen_err)
 {
@@ -908,7 +892,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 	u32 status;
 
 	do {
-		err = get_card_status(card, &status, 5);
+		err = __mmc_send_status(card, &status, 5);
 		if (err) {
 			pr_err("%s: error %d requesting status\n",
 			       req->rq_disk->disk_name, err);
@@ -1076,7 +1060,7 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 	 * we can't be sure the returned status is for the r/w command.
 	 */
 	for (retry = 2; retry >= 0; retry--) {
-		err = get_card_status(card, &status, 0);
+		err = __mmc_send_status(card, &status, 0);
 		if (!err)
 			break;
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 78f75f0..ae1fc48 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -54,7 +54,7 @@ static const u8 tuning_blk_pattern_8bit[] = {
 	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
 };
 
-int mmc_send_status(struct mmc_card *card, u32 *status)
+int __mmc_send_status(struct mmc_card *card, u32 *status, unsigned int retries)
 {
 	int err;
 	struct mmc_command cmd = {};
@@ -64,7 +64,7 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 		cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
 
-	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
+	err = mmc_wait_for_cmd(card->host, &cmd, retries);
 	if (err)
 		return err;
 
@@ -76,6 +76,12 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__mmc_send_status);
+
+int mmc_send_status(struct mmc_card *card, u32 *status)
+{
+	return __mmc_send_status(card, status, MMC_CMD_RETRIES);
+}
 
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 978bd2e..b8d0552 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -25,6 +25,7 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
+int __mmc_send_status(struct mmc_card *card, u32 *status, unsigned int retries);
 int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
-- 
2.7.4

