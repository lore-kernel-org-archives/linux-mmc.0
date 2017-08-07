From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: block: prevent propagating R1_OUT_OF_RANGE for open-ending mode
Date: Mon,  7 Aug 2017 09:32:45 +0800
Message-ID: <1502069565-114396-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:55981 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdHGBdX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Aug 2017 21:33:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Shawn Lin <shawn.lin@rock-chips.com>

We to some extent should tolerate R1_OUT_OF_RANGE for open-ending
mode as it is expected behaviour and most of the backup partition
tables should be located near some the last blocks which will always
make open-ending read exceed the capcity of cards.

Fixes: 9820a5b11101 ("mmc: core: for data errors, take response of stop cmd into account")
Fixes: a04e6bae9e6f (mmc: core: check also R1 response for stop commands)
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/block.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 40f0d59..25343aa 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1369,10 +1369,19 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 	 R1_CC_ERROR |		/* Card controller error */		\
 	 R1_ERROR)		/* General/unknown error */
 
-static bool mmc_blk_has_cmd_err(struct mmc_command *cmd)
+static bool mmc_blk_has_cmd_err(struct mmc_card *card, struct mmc_command *cmd)
 {
-	if (!cmd->error && cmd->resp[0] & CMD_ERRORS)
-		cmd->error = -EIO;
+	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
+
+	if (!cmd->error && cmd->resp[0] & CMD_ERRORS) {
+		/*
+		 * Prevent the OUT_OF_RANGE error for open-ending
+		 * multiple block operations as it's normal behaviour.
+		 */
+		if (!(!(md->flags & MMC_BLK_CMD23) &&
+		     cmd->resp[0] & R1_OUT_OF_RANGE))
+			cmd->error = -EIO;
+	}
 
 	return cmd->error;
 }
@@ -1398,8 +1407,8 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 	 * stop.error indicates a problem with the stop command.  Data
 	 * may have been transferred, or may still be transferring.
 	 */
-	if (brq->sbc.error || brq->cmd.error || mmc_blk_has_cmd_err(&brq->stop) ||
-	    brq->data.error) {
+	if (brq->sbc.error || brq->cmd.error ||
+	    mmc_blk_has_cmd_err(card, &brq->stop) || brq->data.error) {
 		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err)) {
 		case ERR_RETRY:
 			return MMC_BLK_RETRY;
-- 
1.9.1


