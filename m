From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] mmc: block: prevent propagating R1_OUT_OF_RANGE for open-ending mode
Date: Tue,  8 Aug 2017 08:27:25 +0800
Message-ID: <1502152045-150457-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:55352 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHHA2G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 20:28:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Shawn Lin <shawn.lin@rock-chips.com>

We to some extent should tolerate R1_OUT_OF_RANGE for open-ending
mode as it is expected behaviour and most of the backup partition
tables should be located near some of the last blocks which will
always make open-ending read exceed the capacity of cards.

Fixes: 9820a5b11101 ("mmc: core: for data errors, take response of stop cmd into account")
Fixes: a04e6bae9e6f ("mmc: core: check also R1 response for stop commands")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Shawn Guo <shawnguo@kernel.org>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---

Changes in v2:
- fix a typo and introduce STOP_ERROR
- reword the comment and always include a description from the spec if possible

 drivers/mmc/core/block.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a11bead..38267a0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1360,18 +1360,34 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 	}
 }
 
-#define CMD_ERRORS							\
-	(R1_OUT_OF_RANGE |	/* Command argument out of range */	\
-	 R1_ADDRESS_ERROR |	/* Misaligned address */		\
+#define STOP_ERRORS							\
+	(R1_ADDRESS_ERROR |	/* Misaligned address */		\
 	 R1_BLOCK_LEN_ERROR |	/* Transferred block length incorrect */\
 	 R1_WP_VIOLATION |	/* Tried to write to protected block */	\
 	 R1_CARD_ECC_FAILED |	/* Card ECC failed */			\
 	 R1_CC_ERROR |		/* Card controller error */		\
 	 R1_ERROR)		/* General/unknown error */
 
-static bool mmc_blk_has_cmd_err(struct mmc_command *cmd)
+#define CMD_ERRORS (STOP_ERRORS | \
+		    R1_OUT_OF_RANGE) /* Command argument out of range */
+
+static bool mmc_blk_has_cmd_err(struct mmc_card *card, struct mmc_command *cmd)
 {
-	if (!cmd->error && cmd->resp[0] & CMD_ERRORS)
+	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
+	u32 error = (md->flags & MMC_BLK_CMD23) ? CMD_ERRORS : STOP_ERRORS;
+
+	/*
+	 * Per the SD specification(physical layer version 4.10),
+	 * section 4.3.3, it explicitly states that "When the last
+	 * block of user area is read using CMD18, the host should
+	 * ignore OUT_OF_RANGE error that may occur even the sequence
+	 * is correct". And JESD84-B51 for eMMC also has a similar
+	 * statement on section 6.8.3. As CMD23 is optional for either
+	 * cards or hosts, so we need to check the MMC_BLK_CMD23 flag
+	 * to prevent the OUT_OF_RANGE error for open-ending multiple
+	 * block operations as it's normal behaviour.
+	 */
+	if (!cmd->error && cmd->resp[0] & error)
 		cmd->error = -EIO;
 
 	return cmd->error;
@@ -1398,8 +1414,8 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
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


