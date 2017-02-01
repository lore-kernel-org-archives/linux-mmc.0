From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/10] mmc: block: return errorcode from mmc_sd_num_wr_blocks()
Date: Wed,  1 Feb 2017 13:47:57 +0100
Message-ID: <20170201124800.13865-8-linus.walleij@linaro.org>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33885 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdBAMtG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:49:06 -0500
Received: by mail-lf0-f45.google.com with SMTP id v186so227911708lfa.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:49:05 -0800 (PST)
In-Reply-To: <20170201124800.13865-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

mmc_sd_num_wr_blocks() has an interesting construction that
saves one return argument by casting (u32)-1 as error code
if something goes wrong.

This is however a bit confusing when the normal kernel
pattern is to return an int error code on success.

So instead pass a variable "blocks" that the function can
fill in with the number of successfully transfered blocks
and return an integer as error code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1ac7fec03c97..91d506b37024 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -768,7 +768,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 	return 0;
 }
 
-static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
+static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 {
 	int err;
 	u32 result;
@@ -786,9 +786,9 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err)
-		return (u32)-1;
+		return err;
 	if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
-		return (u32)-1;
+		return err;
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
@@ -808,7 +808,7 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 
 	blocks = kmalloc(4, GFP_KERNEL);
 	if (!blocks)
-		return (u32)-1;
+		return -ENOMEM;
 
 	sg_init_one(&sg, blocks, 4);
 
@@ -818,9 +818,11 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	kfree(blocks);
 
 	if (cmd.error || data.error)
-		result = (u32)-1;
+		return -EIO;
 
-	return result;
+	*written_blocks = result;
+
+	return 0;
 }
 
 static int get_card_status(struct mmc_card *card, u32 *status, int retries)
@@ -1581,9 +1583,10 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 	 */
 	if (mmc_card_sd(card)) {
 		u32 blocks;
+		int err;
 
-		blocks = mmc_sd_num_wr_blocks(card);
-		if (blocks != (u32)-1) {
+		err = mmc_sd_num_wr_blocks(card, &blocks);
+		if (!err) {
 			ret = blk_end_request(req, 0, blocks << 9);
 		}
 	} else {
-- 
2.9.3

