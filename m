From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC] mmc: core: check also R1 response for stop commands
Date: Sat, 18 Feb 2017 00:13:54 +0100
Message-ID: <20170217231354.7441-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Introduce a helper function to not only check the error value but also
error bits of a R1 response. Use the helper for the stop command.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

So, here is a first draft of what we talked about recenlty. Let me know what
you think...

 drivers/mmc/core/block.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 985477cdcb3ea4..b96477b689e457 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1292,9 +1292,18 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 	 R1_ADDRESS_ERROR |	/* Misaligned address */		\
 	 R1_BLOCK_LEN_ERROR |	/* Transferred block length incorrect */\
 	 R1_WP_VIOLATION |	/* Tried to write to protected block */	\
+	 R1_CARD_ECC_FAILED |	/* Card ECC failed */			\
 	 R1_CC_ERROR |		/* Card controller error */		\
 	 R1_ERROR)		/* General/unknown error */
 
+static bool mmc_blk_has_cmd_err(struct mmc_command *cmd)
+{
+	if (!cmd->error && cmd->resp[0] & CMD_ERRORS)
+		cmd->error = -EIO;
+
+	return cmd->error;
+}
+
 static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 					     struct mmc_async_req *areq)
 {
@@ -1316,7 +1325,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 	 * stop.error indicates a problem with the stop command.  Data
 	 * may have been transferred, or may still be transferring.
 	 */
-	if (brq->sbc.error || brq->cmd.error || brq->stop.error ||
+	if (brq->sbc.error || brq->cmd.error || mmc_blk_has_cmd_err(&brq->stop) ||
 	    brq->data.error) {
 		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err)) {
 		case ERR_RETRY:
-- 
2.11.0
