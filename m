From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 1/3] MMC: allow get_card_status() to return error status
Date: Mon, 20 Jun 2011 20:10:08 +0100
Message-ID: <E1QYjrM-0007zx-Ex@rmk-PC.arm.linux.org.uk>
References: <20110620190945.GK26089@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110620190945.GK26089@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

If the MMC_SEND_STATUS command is not successful, we should not return
a zero status word, but instead allow the caller to know positively
that an error occurred.

Convert the open-coded get_card_status() to use the helper function,
and provide definitions for the card state field.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/card/block.c |   33 +++++++++------------------------
 include/linux/mmc/mmc.h  |   10 ++++++++++
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 71da564..022edc3 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -525,7 +525,7 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	return result;
 }
 
-static u32 get_card_status(struct mmc_card *card, struct request *req)
+static int get_card_status(struct mmc_card *card, u32 *status, int retries)
 {
 	struct mmc_command cmd = {0};
 	int err;
@@ -534,11 +534,10 @@ static u32 get_card_status(struct mmc_card *card, struct request *req)
 	if (!mmc_host_is_spi(card->host))
 		cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
-	err = mmc_wait_for_cmd(card->host, &cmd, 0);
-	if (err)
-		printk(KERN_ERR "%s: error %d sending status command",
-		       req->rq_disk->disk_name, err);
-	return cmd.resp[0];
+	err = mmc_wait_for_cmd(card->host, &cmd, retries);
+	if (err == 0)
+		*status = cmd.resp[0];
+	return err;
 }
 
 static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
@@ -686,7 +685,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		(md->flags & MMC_BLK_REL_WR);
 
 	do {
-		struct mmc_command cmd = {0};
 		u32 readcmd, writecmd, status = 0;
 
 		memset(&brq, 0, sizeof(struct mmc_blk_request));
@@ -817,7 +815,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 				disable_multi = 1;
 				continue;
 			}
-			status = get_card_status(card, req);
+			get_card_status(card, &status, 0);
 		}
 
 		if (brq.sbc.error) {
@@ -854,12 +852,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 
 		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
 			do {
-				int err;
-
-				cmd.opcode = MMC_SEND_STATUS;
-				cmd.arg = card->rca << 16;
-				cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
-				err = mmc_wait_for_cmd(card->host, &cmd, 5);
+				int err = get_card_status(card, &status, 5);
 				if (err) {
 					printk(KERN_ERR "%s: error %d requesting status\n",
 					       req->rq_disk->disk_name, err);
@@ -870,16 +863,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 				 * so make sure to check both the busy
 				 * indication and the card state.
 				 */
-			} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
-				(R1_CURRENT_STATE(cmd.resp[0]) == 7));
-
-#if 0
-			if (cmd.resp[0] & ~0x00000900)
-				printk(KERN_ERR "%s: status = %08x\n",
-				       req->rq_disk->disk_name, cmd.resp[0]);
-			if (mmc_decode_status(cmd.resp))
-				goto cmd_err;
-#endif
+			} while (!(status & R1_READY_FOR_DATA) ||
+				 (R1_CURRENT_STATE(status) == R1_STATE_PRG));
 		}
 
 		if (brq.cmd.error || brq.stop.error || brq.data.error) {
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index ac26a68..8e425ab 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -140,6 +140,16 @@ static inline bool mmc_op_multi(u32 opcode)
 #define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
 #define R1_APP_CMD		(1 << 5)	/* sr, c */
 
+#define R1_STATE_IDLE	0
+#define R1_STATE_READY	1
+#define R1_STATE_IDENT	2
+#define R1_STATE_STBY	3
+#define R1_STATE_TRAN	4
+#define R1_STATE_DATA	5
+#define R1_STATE_RCV	6
+#define R1_STATE_PRG	7
+#define R1_STATE_DIS	8
+
 /*
  * MMC/SD in SPI mode reports R1 status always, and R2 for SEND_STATUS
  * R1 is the low order byte; R2 is the next highest byte, when present.
-- 
1.7.4.4
