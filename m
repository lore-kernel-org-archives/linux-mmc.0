From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 1/2] mmc: core: check also R1 response for stop commands
Date: Sat,  8 Apr 2017 22:20:05 +0200
Message-ID: <20170408202006.27276-2-wsa+renesas@sang-engineering.com>
References: <20170408202006.27276-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170408202006.27276-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

To detect errors like ECC errors, we must parse the R1 response bits. Introduce
a helper function to also set the error value of a command when R1 error bits
are set. Add ECC error to list of flags checked. Use the new helper for the
stop command to call mmc_blk_recovery when detecting ECC errors which are only
flagged on the next command after multiblock.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---

If adding R1_CARD_ECC_FAILED to CMD_ERRORS is considered too risky for
side-effects, we could also introduce a new define NEXT_CMD_ERRORS maybe?
Yet, I believe it is OK to be done like this.


 drivers/mmc/core/block.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ff3da960c47361..bacaa255c4b16a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1287,9 +1287,18 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
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
@@ -1311,7 +1320,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
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
