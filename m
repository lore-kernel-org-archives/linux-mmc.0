From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: RFC: improved error recovery
Date: Sat, 8 Jan 2011 00:13:42 +0000
Message-ID: <20110108001342.GA31708@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38638 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1AHANz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jan 2011 19:13:55 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

This is my patch to improve error recovery.

Note that in MMC mode, if a command fails as indicated by cmd->error
being non-zero, that means we didn't get a valid response from the
card, which in turn means that cmd->resp[] is invalid, and all other
state should be ignored.  (The way we set things up, we expect hosts
to avoid touching ->error on the data and stop command.)

If data->error is set, it means the previous command completed, but
there was some problem while transferring data to/from the card.
cmd->resp[] for the preceding command contains the status at that
point, which may be relevent if no data was transferred.  (Here we
expect the host to transfer the stop commadn whatever.)

If the stop cmd->error is set, we failed to get a response to the stop
command, and like the preceding command, cmd->resp[] is invalid.

For error recovery, in all cases, we issue a SEND_STATUS command to
retrieve the most up to date status from the card - particularly the
state bits which are only returned for state at the point the command
was received, not the state which the command left the card in.

We always report the error status - this is useful even if switching
to single block transfers fixes the problem, as repeated occurances
may be indicative of some problem with the driver.

If the card is still in a data transfer mode (receive or data mode)
we send a stop command as the first action in all cases - we can't
issue any further data transfer commands until we're out of the data
transfer modes.

We then check the r/w command error bits retrieved from the SEND_STATUS
(which is where they're reported).
- if it was a CRC error, presumably that's an electrical transient on
  the command signal, so retry to see if that solves it.
- if it was 'illegal command' that means the card was in the wrong state
  to accept the command - eg, already in a data transfer state.  As we've
  already sent a stop command, hopefully that went through so retry the
  command as is.

If that fails after a couple of retries, fall back to single block
transfers.

Note that this may make error recovery as a whole take longer... it
depends exactly what happens when people see card errors.  At least
with the changed error reporting we can see the real status information
describing the error(s) and start to make some sensible decisions about
it.

For me, this seems to allow MMC to continue working through host FIFO
errors and other weirdnesses - I've seen command CRC errors occasionally
when USB goes screwy, and also seen the card get stuck in 'data' state
(iow, it's still sending data to the host inspite of a stop command
being sent after the data error.)

With this in place, I've yet to need a reboot to recover from an error
with rootfs on a SD card.

No idea how this affects SPI mode stuff.  Also, I do want to try it on my
OMAP3 platform which spits out a stream of 'retrying with single block'
messages.

No sign-off yet as I don't think it's ready.

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 217f820..5a8c749 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -245,6 +245,20 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	return result;
 }
 
+static void send_stop(struct mmc_card *card, struct request *req)
+{
+	struct mmc_command cmd;
+	int err;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	cmd.opcode = MMC_STOP_TRANSMISSION;
+	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	if (err)
+		pr_err("%s: error %d sending stop command\n",
+		       req->rq_disk->disk_name, err);
+}
+
 static u32 get_card_status(struct mmc_card *card, struct request *req)
 {
 	struct mmc_command cmd;
@@ -255,9 +269,9 @@ static u32 get_card_status(struct mmc_card *card, struct request *req)
 	if (!mmc_host_is_spi(card->host))
 		cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
-	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	err = mmc_wait_for_cmd(card->host, &cmd, 2);
 	if (err)
-		printk(KERN_ERR "%s: error %d sending status comand",
+		pr_err("%s: error %d sending status command\n",
 		       req->rq_disk->disk_name, err);
 	return cmd.resp[0];
 }
@@ -336,7 +350,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request brq;
-	int ret = 1, disable_multi = 0;
+	int ret = 1, disable_multi = 0, retry = 0;
 
 	mmc_claim_host(card->host);
 
@@ -432,6 +446,53 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		 * programming mode even when things go wrong.
 		 */
 		if (brq.cmd.error || brq.data.error || brq.stop.error) {
+			status = get_card_status(card, req);
+
+			/* First print what's up */
+			if (brq.cmd.error)
+				pr_err("%s: error %d sending read/write command, card status %#x\n",
+				       req->rq_disk->disk_name, brq.cmd.error,
+				       status);
+
+			if (brq.data.error)
+				pr_err("%s: error %d transferring data, sector %u, nr %u, cmd response %#x, card status %#x\n",
+				       req->rq_disk->disk_name, brq.data.error,
+				       (unsigned)blk_rq_pos(req),
+				       (unsigned)blk_rq_sectors(req),
+				       brq.cmd.resp[0], status);
+
+			if (brq.stop.error)
+				pr_err("%s: error %d sending stop command, original cmd response %#x, card status %#x\n",
+				       req->rq_disk->disk_name, brq.stop.error,
+				       brq.cmd.resp[0], status);
+
+			/*
+			 * Now check the current card state.  If it is
+			 * in some data transfer mode, tell it to stop
+			 * (and hopefully transition back to TRAN.)
+			 */
+			if (R1_CURRENT_STATE(status) == R1_STATE_DATA ||
+			    R1_CURRENT_STATE(status) == R1_STATE_RCV)
+				send_stop(card, req);
+
+			/*
+			 * r/w cmd failure - get_card_status() should
+			 * tell us why the command was not accepted
+			 */
+			if (brq.cmd.error && retry < 2) {
+				/*
+				 * if it was a r/w cmd crc error, or illegal
+				 * command (eg, issued in wrong state) then
+				 * retry - we should have corrected the
+				 * state problem above.
+				 */
+				if (status & (R1_COM_CRC_ERROR |
+					      R1_ILLEGAL_COMMAND)) {
+					retry++;
+					continue;
+				}
+			}
+
 			if (brq.data.blocks > 1 && rq_data_dir(req) == READ) {
 				/* Redo read one sector at a time */
 				printk(KERN_WARNING "%s: retrying using single "
@@ -439,32 +500,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 				disable_multi = 1;
 				continue;
 			}
-			status = get_card_status(card, req);
-		}
-
-		if (brq.cmd.error) {
-			printk(KERN_ERR "%s: error %d sending read/write "
-			       "command, response %#x, card status %#x\n",
-			       req->rq_disk->disk_name, brq.cmd.error,
-			       brq.cmd.resp[0], status);
-		}
-
-		if (brq.data.error) {
-			if (brq.data.error == -ETIMEDOUT && brq.mrq.stop)
-				/* 'Stop' response contains card status */
-				status = brq.mrq.stop->resp[0];
-			printk(KERN_ERR "%s: error %d transferring data,"
-			       " sector %u, nr %u, card status %#x\n",
-			       req->rq_disk->disk_name, brq.data.error,
-			       (unsigned)blk_rq_pos(req),
-			       (unsigned)blk_rq_sectors(req), status);
-		}
-
-		if (brq.stop.error) {
-			printk(KERN_ERR "%s: error %d sending stop command, "
-			       "response %#x, card status %#x\n",
-			       req->rq_disk->disk_name, brq.stop.error,
-			       brq.stop.resp[0], status);
 		}
 
 		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
@@ -486,7 +521,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 				 * indication and the card state.
 				 */
 			} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
-				(R1_CURRENT_STATE(cmd.resp[0]) == 7));
+			    (R1_CURRENT_STATE(cmd.resp[0]) == R1_STATE_PRG));
 
 #if 0
 			if (cmd.resp[0] & ~0x00000900)
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 956fbd8..8b34bbc 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -131,6 +131,16 @@
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
