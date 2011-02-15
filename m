From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [RFC] MMC: error handling improvements
Date: Tue, 15 Feb 2011 23:03:11 +0000
Message-ID: <20110215230311.GT4152@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59294 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070Ab1BOXD0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 18:03:26 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

This patch is for RFC only; it needs splitting up somewhat.  However, I
wanted to get it out there for some comment.

The patch basically improves all round the error handling with MMC block
transfers.  I've considered several scenarios, from lost or bad CRCs on
the initial commands (both causing no response from the card), lost stop
commands (which I've seen after a FIFO overrun), failed status commands
(also seen after a FIFO overrun), to data FIFO errors.

I've considered the case where the card becomes inaccessible, which
causes us to give up trying fairly quickly - this should avoid problems
with error recovery taking a very long time should the card disappear.

My motivation is primerily dealing with FIFO overruns on data transfers,
to allow the ARM MMCI primecell to run at a higher clock rate, while
allowing it to survive various interrupt loads (which invariably results
in not being able to service the FIFO quickly enough.)

The one obvious solution to this is the old SA_INTERRUPT stuff which used
to work.  As this has been ripped out of the kernel, we have no option but
to invent more weird and wacky solutions to work-around other interrupt
handlers taking their time.

With this solution below, I can increase the card clocking rate from
around 512Kbps to 4Mbps, which is about an 8 fold increase in throughput
which can not sanely be ignored.

The comments may not entirely reflect what the code is doing; they may
have aged a little bit since the code was written.  The adaptive clock
rate algorithm can probably do with a lot more work to avoid it up-
clocking to a rate which has proven to never work.  I'd actually go as
far as to say that the algorithm probably has a lot to be desired - but
it seems to work for my test scenarios.

Last couple of points:
1. it relies on hosts returning the number of bytes equivalent to the
number of blocks _successfully_ transferred and no more.  Returning zero
bytes on error is permitted, but untested, and may result in FIFO overruns
causing a faster reduction in clock rate.
2. it relies on MMC host drivers returning the right error codes, which
historically hasn't really mattered.  With this code diagnosing the reason
for the failure, it now matters that the correct error codes are used.

 drivers/mmc/card/block.c                       |  402 ++++++++++++++++++------
 drivers/mmc/core/core.c                        |   11 +
 drivers/mmc/core/core.h                        |    1 +
 drivers/mmc/core/mmc.c                         |    2 +-
 drivers/mmc/core/sd.c                          |    2 +-
 drivers/mmc/core/sdio.c                        |    4 +-
 drivers/mmc/host/mmci.c                        |    2 +-
 include/linux/mmc/host.h                       |    1 +
 include/linux/mmc/mmc.h                        |   10 +
 9 files changed, 336 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index bfc8a8a..8daf340 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -75,6 +75,9 @@ struct mmc_blk_data {
 
 	unsigned int	usage;
 	unsigned int	read_only;
+	unsigned int	clk_div;
+	unsigned int	fifo_ok[10];
+	unsigned int	fifo_fail[10];
 };
 
 static DEFINE_MUTEX(open_lock);
@@ -245,7 +248,21 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	return result;
 }
 
-static u32 get_card_status(struct mmc_card *card, struct request *req)
+static int send_stop(struct mmc_card *card, u32 *status)
+{
+	struct mmc_command cmd;
+	int err;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	cmd.opcode = MMC_STOP_TRANSMISSION;
+	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(card->host, &cmd, 5);
+	if (err == 0)
+		*status = cmd.resp[0];
+	return err;
+}
+
+static int get_card_status(struct mmc_card *card, u32 *status)
 {
 	struct mmc_command cmd;
 	int err;
@@ -256,10 +273,134 @@ static u32 get_card_status(struct mmc_card *card, struct request *req)
 		cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	if (err == 0)
+		*status = cmd.resp[0];
+	return err;
+}
+
+#define ERR_RETRY	2
+#define ERR_ABORT	1
+#define ERR_CONTINUE	0
+
+/*
+ * Initial r/w and stop cmd error recovery.
+ * We don't know whether the card received the r/w cmd or not, so try to
+ * restore things back to a sane state.  Essentially, we do this as follows:
+ * - Obtain card status.  If the first attempt to obtain card status fails,
+ *   the status word will reflect the failed status cmd, not the failed
+ *   r/w cmd.  If we fail to obtain card status, it suggests we can no
+ *   longer communicate with the card.
+ * - Check the card state.  If the card received the cmd but there was a
+ *   transient problem with the response, it might still be in a data transfer
+ *   mode.  Try to send it a stop command.  If this fails, we can't recover.
+ * - If the r/w cmd failed due to a response CRC error, it was probably
+ *   transient, so retry the cmd.
+ * - If the r/w cmd timed out, but we didn't get the r/w cmd status, retry.
+ * - If the r/w cmd timed out, and the r/w cmd failed due to CRC error or
+ *   illegal cmd, retry.
+ * Otherwise we don't understand what happened, so abort.
+ */
+static int mmc_blk_cmd_recovery(struct mmc_card *card, struct mmc_blk_request *brq,
+	struct request *req)
+{
+	bool rwcmd_status = true;
+	u32 status, stop_status = 0;
+	int err, retry;
+
+	/*
+	 * Try to get card status which indicates both the card state
+	 * and why there was no response.  If the first attempt fails,
+	 * we can't be sure the returned status is for the r/w command.
+	 */
+	for (retry = 2; retry >= 0; retry--) {
+		err = get_card_status(card, &status);
+		if (!err)
+			break;
+
+		rwcmd_status = false;
+		pr_err("%s: error %d sending status command, %sing\n",
+		       req->rq_disk->disk_name, err, retry ? "retry" : "abort");
+	}
+
+	/* We couldn't get a response from the card.  Give up. */
 	if (err)
-		printk(KERN_ERR "%s: error %d sending status command",
-		       req->rq_disk->disk_name, err);
-	return cmd.resp[0];
+		return ERR_ABORT;
+
+	/*
+	 * Check the current card state.  If it is in some data transfer
+	 * mode, tell it to stop (and hopefully transition back to TRAN.)
+	 */
+	if (R1_CURRENT_STATE(status) == R1_STATE_DATA ||
+	    R1_CURRENT_STATE(status) == R1_STATE_RCV) {
+		err = send_stop(card, &stop_status);
+		if (err)
+			pr_err("%s: error %d sending stop command\n",
+			       req->rq_disk->disk_name, err);
+
+		/*
+		 * If the stop cmd also timed out, the card is
+		 * probably not present, so abort.
+		 */
+		if (err == -ETIMEDOUT)
+			return ERR_ABORT;
+	}
+
+	/* Check for initial command errors */
+	switch (brq->cmd.error) {
+	case 0:
+		/* no error */
+		break;
+
+	case -EILSEQ:
+		/* response crc error, retry the r/w cmd */
+		pr_err("%s: %s sending %s command, card status %#x\n",
+			req->rq_disk->disk_name,
+			"response CRC error", "read/write",
+			status);
+		return ERR_RETRY;
+
+	case -ETIMEDOUT:
+		pr_err("%s: %s sending %s command, card status %#x\n",
+			req->rq_disk->disk_name,
+			"timed out", "read/write",
+			status);
+
+		if (!rwcmd_status) {
+			/* Status cmd initially failed, retry the r/w cmd */
+			return ERR_RETRY;
+		}
+		if (status & (R1_COM_CRC_ERROR | R1_ILLEGAL_COMMAND)) {
+			/*
+			 * if it was a r/w cmd crc error, or illegal command
+			 * (eg, issued in wrong state) then retry - we should
+			 * have corrected the state problem above.
+			 */
+			return ERR_RETRY;
+		}
+
+	default:
+		/* we don't understand the error code the driver gave us */
+		pr_err("%s: unknown error %d sending read/write command, card status %#x\n",
+		       req->rq_disk->disk_name, brq->cmd.error, status);
+		return ERR_ABORT;
+	}
+
+	/*
+	 * Now for stop errors.  These aren't fatal to the transfer.
+	 */
+	pr_err("%s: error %d sending stop command, original cmd response %#x, card status %#x\n",
+	       req->rq_disk->disk_name, brq->stop.error,
+	       brq->cmd.resp[0], status);
+
+	/*
+	 * Subsitute in our own stop status as this will give the error
+	 * state which happened during the execution of the r/w command.
+	 */
+	if (stop_status) {
+		brq->stop.resp[0] = stop_status;
+		brq->stop.error = 0;
+	}
+	return ERR_CONTINUE;
 }
 
 static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
@@ -331,18 +472,29 @@ out:
 	return err ? 0 : 1;
 }
 
+extern void mmc_set_clock(struct mmc_host *host, unsigned int hz);
+
+#define CMD_ERRORS	\
+	(R1_OUT_OF_RANGE	/* Command argument out of range */	|\
+	 R1_ADDRESS_ERROR	/* Misaligned address */		|\
+	 R1_BLOCK_LEN_ERROR	/* Transferred block length incorrect */ |\
+	 R1_WP_VIOLATION	/* Tried to write to protected block */	|\
+	 R1_CC_ERROR		/* Card controller error */		|\
+	 R1_ERROR		/* General/unknown error */		)
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
+	struct mmc_host *host = card->host;
 	struct mmc_blk_request brq;
-	int ret = 1, disable_multi = 0;
+	int ret = 1, disable_multi = 0, retry = 0;
 
-	mmc_claim_host(card->host);
+	mmc_claim_host(host);
 
 	do {
-		struct mmc_command cmd;
-		u32 readcmd, writecmd, status = 0;
+		u32 readcmd, writecmd;
+		unsigned int bytes_xfered;
 
 		memset(&brq, 0, sizeof(struct mmc_blk_request));
 		brq.mrq.cmd = &brq.cmd;
@@ -426,55 +578,46 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 
 		mmc_queue_bounce_post(mq);
 
-		/*
-		 * Check for errors here, but don't jump to cmd_err
-		 * until later as we need to wait for the card to leave
-		 * programming mode even when things go wrong.
-		 */
-		if (brq.cmd.error || brq.data.error || brq.stop.error) {
-			if (brq.data.blocks > 1 && rq_data_dir(req) == READ) {
-				/* Redo read one sector at a time */
-				printk(KERN_WARNING "%s: retrying using single "
-				       "block read\n", req->rq_disk->disk_name);
-				disable_multi = 1;
-				continue;
+		if (brq.cmd.error || brq.stop.error) {
+			/*
+			 * cmd.error indicates a problem with the r/w
+			 * command.  No data will have been transferred.
+			 *
+			 * stop.error indicates a problem with the stop
+			 * command.  Data may have been transferred, or
+			 * may still be transferring.
+			 */
+			switch (mmc_blk_cmd_recovery(card, &brq, req)) {
+			case ERR_RETRY:
+				if (retry++ < 5)
+					goto cmd_err;
+			case ERR_ABORT:
+				goto cmd_err;
+			case ERR_CONTINUE:
+				break;
 			}
-			status = get_card_status(card, req);
 		}
 
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
-		}
+		/*
+		 * Check for errors relating to the execution of
+		 * the initial command - such as address errors.
+		 */
+		if (brq.cmd.resp[0] & CMD_ERRORS) {
+			pr_err("%s: r/w command failed, status = %#x\n",
+				req->rq_disk->disk_name, brq.cmd.resp[0]);
+			goto cmd_err;
+		}			
 
+		/*
+		 * Everthing else is either success, or a data error of some
+		 * kind.  If it was a write, we may have transitioned to
+		 * program mode, which we have to wait for it to complete.
+		 */
 		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
+			u32 status;
 			do {
-				int err;
-
-				cmd.opcode = MMC_SEND_STATUS;
-				cmd.arg = card->rca << 16;
-				cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
-				err = mmc_wait_for_cmd(card->host, &cmd, 5);
+				int err = get_card_status(card, &status);
+				/* If -EILSEQ, retry? */
 				if (err) {
 					printk(KERN_ERR "%s: error %d requesting status\n",
 					       req->rq_disk->disk_name, err);
@@ -485,20 +628,121 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
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
+			    (R1_CURRENT_STATE(status) == R1_STATE_PRG));
+		}
+
+		/*
+		 * If this is an SD card and we're writing, we can first mark
+		 * the known good sectors as ok.
+		 *
+		 * If the card is not SD, we can still ok written sectors as
+		 * reported by the controller (which may be less than the real
+		 * number of written sectors, but never more).
+		 */
+		bytes_xfered = brq.data.bytes_xfered;
+		if (mmc_card_sd(card) && rq_data_dir(req) != READ) {
+			u32 blocks = mmc_sd_num_wr_blocks(card);
+			if (blocks != (u32)-1)
+				bytes_xfered = blocks << 9;
 		}
 
-		if (brq.cmd.error || brq.stop.error || brq.data.error) {
+		if (bytes_xfered) {
+			/*
+			 * Data was transferred.  Let the block layer know
+			 * how much was successfully transferred, so we
+			 * don't retry this.  Hosts which can't report the
+			 * number of successful bytes better return zero on
+			 * error.
+			 */
+			spin_lock_irq(&md->lock);
+			ret = __blk_end_request(req, 0, bytes_xfered);
+			spin_unlock_irq(&md->lock);
+		} else {
+			ret = 1;
+		}
+
+		if (brq.data.error)
+			pr_err("%s: error %d transferring data, sector %u, nr %u, cmd response %#x, card status %#x\n",
+			       req->rq_disk->disk_name, brq.data.error,
+			       (unsigned)blk_rq_pos(req), (unsigned)blk_rq_sectors(req),
+			       brq.cmd.resp[0], brq.stop.resp[0]);
+
+		if (brq.data.error == -EIO) {
+			/* fifo underrun/overrun */
+
+			/* increment error count for this rate */
+			md->fifo_fail[md->clk_div]++;
+
+			/* if we progressed, just retry. */
+			if (bytes_xfered && retry++ < 5)
+				continue;
+
+			/* retry once in case of transients */
+			if (retry++ < 1)
+				continue;
+
+			/* drop the error rate */
+			if (host->ios.clock > host->f_init && md->clk_div < 9) {
+				unsigned int clock;
+
+				md->clk_div++;
+				md->fifo_fail[md->clk_div] = 0;
+				md->fifo_ok[md->clk_div] = 0;
+
+				pr_err("%s: retrying with slower /%u clock rate\n",
+					req->rq_disk->disk_name,
+					1 << md->clk_div);
+
+				clock = host->clock_max >> md->clk_div;
+				mmc_set_clock(host, clock);
+				continue;
+			}
+		} else {
+			unsigned this_err_rate, next_err_rate = 100;
+			unsigned idx = md->clk_div;
+
+			md->fifo_ok[idx]++;
+
+			if (md->fifo_ok[idx] + md->fifo_fail[idx] > 100) {
+
+			if (idx > 0) {
+				unsigned total = md->fifo_fail[idx - 1] + md->fifo_ok[idx - 1];
+
+				next_err_rate = total ?
+					md->fifo_fail[idx - 1] / total : 0;
+			}
+
+			this_err_rate = md->fifo_fail[idx] /
+					(md->fifo_fail[idx] + md->fifo_ok[idx]);
+
+			if (this_err_rate < 5 && next_err_rate < 30) {
+				unsigned clock;
+				md->clk_div--;
+
+				md->fifo_ok[md->clk_div] = 0;
+				md->fifo_fail[md->clk_div] = 0;
+
+				pr_err("%s: increasing to /%u clock rate\n",
+					req->rq_disk->disk_name,
+					1 << md->clk_div);
+
+				clock = host->clock_max >> md->clk_div;
+				mmc_set_clock(host, clock);
+			}
+			}
+		}
+
+		if (brq.data.error) {
 			if (rq_data_dir(req) == READ) {
+				if (brq.data.blocks > 1) {
+					/* Redo read one sector at a time */
+					pr_warning("%s: retrying using single "
+						"block read\n", req->rq_disk->disk_name);
+					disable_multi = 1;
+					continue;
+				}
+
 				/*
 				 * After an error, we redo I/O one sector at a
 				 * time, so we only reach here after trying to
@@ -507,17 +751,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 				spin_lock_irq(&md->lock);
 				ret = __blk_end_request(req, -EIO, brq.data.blksz);
 				spin_unlock_irq(&md->lock);
-				continue;
+			} else {
+				goto cmd_err;
 			}
-			goto cmd_err;
 		}
-
-		/*
-		 * A block was successfully transferred.
-		 */
-		spin_lock_irq(&md->lock);
-		ret = __blk_end_request(req, 0, brq.data.bytes_xfered);
-		spin_unlock_irq(&md->lock);
 	} while (ret);
 
 	mmc_release_host(card->host);
@@ -525,29 +762,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	return 1;
 
  cmd_err:
- 	/*
- 	 * If this is an SD card and we're writing, we can first
- 	 * mark the known good sectors as ok.
- 	 *
-	 * If the card is not SD, we can still ok written sectors
-	 * as reported by the controller (which might be less than
-	 * the real number of written sectors, but never more).
-	 */
-	if (mmc_card_sd(card)) {
-		u32 blocks;
-
-		blocks = mmc_sd_num_wr_blocks(card);
-		if (blocks != (u32)-1) {
-			spin_lock_irq(&md->lock);
-			ret = __blk_end_request(req, 0, blocks << 9);
-			spin_unlock_irq(&md->lock);
-		}
-	} else {
-		spin_lock_irq(&md->lock);
-		ret = __blk_end_request(req, 0, brq.data.bytes_xfered);
-		spin_unlock_irq(&md->lock);
-	}
-
 	mmc_release_host(card->host);
 
 	spin_lock_irq(&md->lock);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6625c05..b3ffd99 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -648,6 +648,17 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
 	mmc_set_ios(host);
 }
 
+void mmc_set_clock_max(struct mmc_host *host, unsigned int hz)
+{
+	WARN_ON(hz < host->f_min);
+
+	if (hz > host->f_max)
+		hz = host->f_max;
+
+	host->ios.clock = host->clock_max = hz;
+	mmc_set_ios(host);
+}
+
 #ifdef CONFIG_MMC_CLKGATE
 /*
  * This gates the clock by setting it to 0 Hz.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index ca1fdde..412113c 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -33,6 +33,7 @@ void mmc_init_erase(struct mmc_card *card);
 
 void mmc_set_chip_select(struct mmc_host *host, int mode);
 void mmc_set_clock(struct mmc_host *host, unsigned int hz);
+void mmc_set_clock_max(struct mmc_host *host, unsigned int hz);
 void mmc_gate_clock(struct mmc_host *host);
 void mmc_ungate_clock(struct mmc_host *host);
 void mmc_set_ungated(struct mmc_host *host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 16006ef..4fe515a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -515,7 +515,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		max_dtr = card->csd.max_dtr;
 	}
 
-	mmc_set_clock(host, max_dtr);
+	mmc_set_clock_max(host, max_dtr);
 
 	/*
 	 * Indicate DDR mode (if supported).
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d18c32b..576b320 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -621,7 +621,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Set bus speed.
 	 */
-	mmc_set_clock(host, mmc_sd_get_max_clock(card));
+	mmc_set_clock_max(host, mmc_sd_get_max_clock(card));
 
 	/*
 	 * Switch to wider bus (if supported).
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5c4a54d..fb41db6 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -425,7 +425,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		 * It's host's responsibility to fill cccr and cis
 		 * structures in init_card().
 		 */
-		mmc_set_clock(host, card->cis.max_dtr);
+		mmc_set_clock_max(host, card->cis.max_dtr);
 
 		if (card->cccr.high_speed) {
 			mmc_card_set_highspeed(card);
@@ -491,7 +491,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Change to the card's maximum speed.
 	 */
-	mmc_set_clock(host, mmc_sdio_get_max_clock(card));
+	mmc_set_clock_max(host, mmc_sdio_get_max_clock(card));
 
 	/*
 	 * Switch to wider bus (if supported).
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8a29c9f..dcbe9c4 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -38,7 +38,7 @@
 
 #define DRIVER_NAME "mmci-pl18x"
 
-static unsigned int fmax = 515633;
+static unsigned int fmax = 4000000;
 
 /**
  * struct variant_data - MMCI variant-specific quirks
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..76df335 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -199,6 +199,7 @@ struct mmc_host {
 
 	struct mmc_ios		ios;		/* current io bus settings */
 	u32			ocr;		/* the current OCR setting */
+	unsigned int		clock_max;	/* maximum clock rate */
 
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 612301f..9d067ee 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -133,6 +133,16 @@
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
