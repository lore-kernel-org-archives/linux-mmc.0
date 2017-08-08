From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC/RFT PATCH] mmc: core: activate pre-erased multiple write support for sd card
Date: Tue,  8 Aug 2017 19:44:59 +0800
Message-ID: <1502192699-9612-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:34712 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbdHHLpm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 07:45:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Per SD specification version 4.10, section 4.3.4, it says "pre-erased
(ACMD23) will make a following Multiple Block Write operation faster
compared to the same operation without preceding ACMD23". ACMD23 is
mandatory for all sd cards and the spec also says "Command STOP_TRAN
(CMD12) shall be used to stop the transmission in Write Multiple Block
whether or not the preerase (ACMD23) feature is used."

However current code only check to see if CMD23 is available. If not,
it would fallback to open-ending mode. So this catch-all RFC patch
is trying to activate ACMD23 support for SD cards when doing multiple
write.

I have been testing it for while with all different kinds of SD cards
. But what makes me hesitate to submit a formal patch is that

(1)
If the SD card does support CMD23 as well as the host, then we don't
use ACMD23 as I don't see *obvious* write performance boost for
ACMD23 vs CMD23 when doing multiple write for most of the cards,
although some of them do improve a little. So this makes me though that
the behaviour of dealing with ACMD23 or CMD23 depends on the firmware
designed.

(2)
If enabling ACMD23 for SD cards, I did see a interesting thing that
some of the cards fail to return to tran state even when the host
fires CMD12 which meets the requirement of spec. When debugging, I saw
these buggy cards was still in recv state and never changed. So I did
some hack to trace the card status and fire CMD12 again if possible.

(3)
I test all of my SD cards at hand, and try to figure out if we benefit
from ACMD23 vs open-ending multiple write. When using ACMD23, we fire
extra ACMD23 which would lower the write performance theoretically,
although I also didn't see any *obviuos* thoughput drop. The only
visible benefit is that pre-erased multiple write is more 'stable'
than open-ending multiple write, just as the same reason for why we
prefer to use CMD23 instead of open-ending mode.

Any thought?

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/core/block.c    | 46 +++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/core/core.c     |  6 ++++++
 drivers/mmc/core/mmc_test.c | 10 ++++++----
 drivers/mmc/host/cavium.c   |  3 ++-
 include/linux/mmc/core.h    |  2 ++
 5 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 38267a0..0c0f879 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -97,8 +97,9 @@ struct mmc_blk_data {
 	struct list_head part;
 
 	unsigned int	flags;
-#define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
-#define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
+#define MMC_BLK_CMD23	BIT(0)	/* Can do SET_BLOCK_COUNT for multiblock */
+#define MMC_BLK_REL_WR	BIT(1)	/* MMC Reliable write support */
+#define MMC_BLK_ACMD23	BIT(2)	/* Can do pre-erased before myltiblock write */
 
 	unsigned int	usage;
 	unsigned int	read_only;
@@ -856,7 +857,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 }
 
 static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
-		bool hw_busy_detect, struct request *req, bool *gen_err)
+		bool hw_busy_detect, struct request *req, bool *gen_err,
+		u32 *card_status)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	int err = 0;
@@ -900,6 +902,9 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 	} while (!(status & R1_READY_FOR_DATA) ||
 		 (R1_CURRENT_STATE(status) == R1_STATE_PRG));
 
+	if (card_status)
+		*card_status = status;
+
 	return err;
 }
 
@@ -945,7 +950,7 @@ static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
 		*gen_err = true;
 	}
 
-	return card_busy_detect(card, timeout_ms, use_r1b_resp, req, gen_err);
+	return card_busy_detect(card, timeout_ms, use_r1b_resp, req, gen_err, NULL);
 }
 
 #define ERR_NOMEDIUM	3
@@ -1446,6 +1451,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 	 */
 	if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
 		int err;
+		u32 stop_status;
 
 		/* Check stop command response */
 		if (brq->stop.resp[0] & R1_ERROR) {
@@ -1456,9 +1462,20 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 		}
 
 		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req,
-					&gen_err);
+					&gen_err, &stop_status);
 		if (err)
 			return MMC_BLK_CMD_ERR;
+
+		if (brq->sbc.flags & MMC_CMD_SD_APP &&
+		    R1_CURRENT_STATE(stop_status) == R1_STATE_RCV) {
+			err = send_stop(card,
+					DIV_ROUND_UP(brq->data.timeout_ns, 1000000),
+					req, &gen_err, &stop_status);
+			if (err)
+				return MMC_BLK_CMD_ERR;
+		}
+
+
 	}
 
 	/* if general error occurs, retry the write operation. */
@@ -1615,6 +1632,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	struct request *req = mmc_queue_req_to_req(mqrq);
 	struct mmc_blk_data *md = mq->blkdata;
 	bool do_rel_wr, do_data_tag;
+	bool need_acmd23;
 
 	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
 
@@ -1655,11 +1673,17 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	 * that for hosts that don't expose MMC_CAP_CMD23, no
 	 * change of behavior will be observed.
 	 *
+	 * Note that for SD cards, we prefer to use ACMD23 for
+	 * better write performance.
+	 *
 	 * N.B: Some MMC cards experience perf degradation.
 	 * We'll avoid using CMD23-bounded multiblock writes for
 	 * these, while retaining features like reliable writes.
 	 */
-	if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
+	need_acmd23 = brq->cmd.opcode == MMC_WRITE_MULTIPLE_BLOCK &&
+			md->flags & MMC_BLK_ACMD23;
+	if (((md->flags & MMC_BLK_CMD23) || need_acmd23) &&
+	     mmc_op_multi(brq->cmd.opcode) &&
 	    (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
 	     do_data_tag)) {
 		brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
@@ -1667,9 +1691,12 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			(do_rel_wr ? (1 << 31) : 0) |
 			(do_data_tag ? (1 << 29) : 0);
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		if (need_acmd23)
+			brq->sbc.flags |= MMC_CMD_SD_APP;
 		brq->mrq.sbc = &brq->sbc;
 	}
 
+
 	mqrq->areq.err_check = mmc_blk_err_check;
 }
 
@@ -2071,9 +2098,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	if (mmc_host_cmd23(card->host)) {
 		if ((mmc_card_mmc(card) &&
 		     card->csd.mmca_vsn >= CSD_SPEC_VER_3) ||
-		    (mmc_card_sd(card) &&
-		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
+		     (mmc_card_sd(card) &&
+		      card->scr.cmds & SD_SCR_CMD23_SUPPORT))
 			md->flags |= MMC_BLK_CMD23;
+
+		if (mmc_card_sd(card) && !(md->flags & MMC_BLK_CMD23))
+			md->flags |= MMC_BLK_ACMD23;
 	}
 
 	if (mmc_card_mmc(card) &&
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6177eb0..65425f2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -400,6 +400,12 @@ static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
 
 	mmc_wait_ongoing_tfr_cmd(host);
 
+	if (mrq && mrq->sbc && mrq->sbc->flags & MMC_CMD_SD_APP) {
+		err = mmc_app_cmd(host, host->card);
+		if (err)
+			return err;
+	}
+
 	mrq->done = mmc_wait_data_done;
 	mrq->host = host;
 
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 7a304a6..05f0801 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -190,8 +190,7 @@ static int mmc_test_set_blksize(struct mmc_test_card *test, unsigned size)
 
 static bool mmc_test_card_cmd23(struct mmc_card *card)
 {
-	return mmc_card_mmc(card) ||
-	       (mmc_card_sd(card) && card->scr.cmds & SD_SCR_CMD23_SUPPORT);
+	return mmc_card_mmc(card) || mmc_card_sd(card);
 }
 
 static void mmc_test_prepare_sbc(struct mmc_test_card *test,
@@ -199,9 +198,9 @@ static void mmc_test_prepare_sbc(struct mmc_test_card *test,
 {
 	struct mmc_card *card = test->card;
 
-	if (!mrq->sbc || !mmc_host_cmd23(card->host) ||
+	if (mrq->sbc && (!mmc_host_cmd23(card->host) ||
 	    !mmc_test_card_cmd23(card) || !mmc_op_multi(mrq->cmd->opcode) ||
-	    (card->quirks & MMC_QUIRK_BLK_NO_CMD23)) {
+	    (card->quirks & MMC_QUIRK_BLK_NO_CMD23))) {
 		mrq->sbc = NULL;
 		return;
 	}
@@ -209,6 +208,9 @@ static void mmc_test_prepare_sbc(struct mmc_test_card *test,
 	mrq->sbc->opcode = MMC_SET_BLOCK_COUNT;
 	mrq->sbc->arg = blocks;
 	mrq->sbc->flags = MMC_RSP_R1 | MMC_CMD_AC;
+	if (mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK &&
+	    mmc_card_sd(card))
+		mrq->sbc->flags |= MMC_CMD_SD_APP;
 }
 
 /*
diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 27fb625..a8e852f 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -637,7 +637,8 @@ static u64 prepare_ext_dma(struct mmc_host *mmc, struct mmc_request *mrq)
 	set_bus_id(&emm_dma, slot->bus_id);
 
 	if (mmc_card_mmc(mmc->card) || (mmc_card_sd(mmc->card) &&
-	    (mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT)))
+	    ((mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT) ||
+	      mrq->sbc->flags & MMC_CMD_SD_APP)))
 		emm_dma |= FIELD_PREP(MIO_EMM_DMA_MULTI, 1);
 
 	pr_debug("[%s] blocks: %u  multi: %d\n",
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index a0c63ea..0ad3375 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -46,6 +46,8 @@ struct mmc_command {
 #define MMC_CMD_BC	(2 << 5)
 #define MMC_CMD_BCR	(3 << 5)
 
+#define MMC_CMD_SD_APP	(1 << 6)		/* application cmd for SD cards */
+
 #define MMC_RSP_SPI_S1	(1 << 7)		/* one status byte */
 #define MMC_RSP_SPI_S2	(1 << 8)		/* second byte */
 #define MMC_RSP_SPI_B4	(1 << 9)		/* four data bytes */
-- 
1.9.1


