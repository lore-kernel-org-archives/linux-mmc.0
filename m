From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: core: check also R1 response for stop commands
Date: Tue, 14 Mar 2017 11:15:01 +0100
Message-ID: <20170314101501.25463-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56221 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbdCNKPU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Mar 2017 06:15:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Introduce a helper function to not only check the error value but also
error bits of a R1 response. Use the helper for the stop command.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since RFC:
* rebased to v4.11-rc2 and retested

So, since I got no complaints about the RFC, I'll declare it a PATCH now :)
Shimoda-san, is it possible for you to test it with the SD tester you once had
access to? I could only test it by setting the ECC bit in the driver manually.

I guess the key question here is still if R1_CARD_ECC_FAILED can be that easily
added to CMD_ERRORS without side-effects?

 drivers/mmc/core/block.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1621fa08e20692..0e838b03709eb8 100644
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

