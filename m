From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/3] mmc: core: activate pre-erased multiple write support for sd card
Date: Wed,  1 Nov 2017 09:37:11 +0800
Message-ID: <1509500233-133821-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:57257 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbdKABjQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Oct 2017 21:39:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jan Glauber <jglauber@cavium.com>, Shawn Lin <shawn.lin@rock-chips.com>

Per SD specification version 4.10, section 4.3.4, it says "pre-erased
(ACMD23) will make a following Multiple Block Write operation faster
compared to the same operation without preceding ACMD23". ACMD23 is
mandatory for all sd cards and the spec also says "Command STOP_TRAN
(CMD12) shall be used to stop the transmission in Write Multiple Block
whether or not the preerase (ACMD23) feature is used."

However current code only check to see if CMD23 is available. If not, it
would fallback to open-ending mode. So this patch is trying to activate
ACMD23 support for SD cards when doing multiple write.

The policy is:
<1> If the sd card claims to support CMD23, the behaviour isn't
changed. So we still use CMD23 for both of multiple block read and
write as before.
<2> If the sd card *doesn't* claims to support CMD23, we force all
the multiple block write to use preceding ACMD23. The multiple read
behaviour is changed since ACMD23 is for write only, per spec.
<3> If the sd card *falsely* claims to support CMD23, and we add the
quirk, MMC_QUIRK_BLK_NO_CMD23. The behaviour is the same as <2>. And
one of the reports and test could be found at the bottom link.

Tested with the following cards:
Apacer High Speed SDHC 8GB
ADATA High Speed SDHC 4GB
ADATA Premier UHS-I SDHC 16GB
ez Share wifi-combo-SDHC 32GB
Kingston UHS-I micro SDHC 32GB
Toshiba High Speed micro SDHC 4GB
Toshiba High Speed micro SDHC 8GB
Toshiba Exceria UHS-I micro SDHC 32GB
PNY High Speed micro SDHC 32GB
Sandisk Ultra UHS-I micro SDHC 16GB
Sandisk Extreme Pro UHS-I micro SDXC 512GB
Samsung UHS-I micro SDHC 32GB
Sony SFUX UHS-I SDHC 32GB
Silicon Power High Speed SDHC 16GB
Transcend UHS-I SDXC 64GB
Topmore High Speed SDHC 8GB
Longsys UHS-I micro SDHC 32GB
Lexar Professional UHS-I micro SDHC 32GB
.....

More cards have been tested but not need to list here. Some of them
support CMD23 but some don't. All the test shows this patch work fine.

Link: https://patchwork.kernel.org/patch/9946125/
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Jan Glauber <jglauber@cavium.com>
---

Changes in v2:
- rebase on latest mmc tree

 drivers/mmc/core/block.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/core/core.c  |  6 ++++++
 include/linux/mmc/core.h |  2 ++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ea80ff4..c2b45cc 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -103,6 +103,7 @@ struct mmc_blk_data {
 	unsigned int	flags;
 #define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
 #define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
+#define MMC_BLK_ACMD23	(1 << 2)	/* Can do pre-erased multiblock write */
 
 	unsigned int	usage;
 	unsigned int	read_only;
@@ -905,7 +906,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 }
 
 static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
-		bool hw_busy_detect, struct request *req, bool *gen_err)
+		bool hw_busy_detect, struct request *req, bool *gen_err,
+		u32 *card_status)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	int err = 0;
@@ -949,6 +951,9 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 	} while (!(status & R1_READY_FOR_DATA) ||
 		 (R1_CURRENT_STATE(status) == R1_STATE_PRG));
 
+	if (card_status)
+		*card_status = status;
+
 	return err;
 }
 
@@ -994,7 +999,8 @@ static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
 		*gen_err = true;
 	}
 
-	return card_busy_detect(card, timeout_ms, use_r1b_resp, req, gen_err);
+	return card_busy_detect(card, timeout_ms, use_r1b_resp, req,
+				gen_err, NULL);
 }
 
 #define ERR_NOMEDIUM	3
@@ -1520,6 +1526,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 	 */
 	if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
 		int err;
+		u32 stop_status;
 
 		/* Check stop command response */
 		if (brq->stop.resp[0] & R1_ERROR) {
@@ -1530,9 +1537,23 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 		}
 
 		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req,
-					&gen_err);
+					&gen_err, &stop_status);
 		if (err)
 			return MMC_BLK_CMD_ERR;
+
+		/*
+		 * Some sd cards still leave in recv state after sending CMD12
+		 * when preceding ACMD23 is used. But try again will fix that.
+		 */
+		if (brq->sbc.flags & MMC_CMD_SD_APP &&
+		    R1_CURRENT_STATE(stop_status) == R1_STATE_RCV) {
+			err = send_stop(card,
+					DIV_ROUND_UP(brq->data.timeout_ns,
+						     1000000),
+					req, &gen_err, &stop_status);
+			if (err)
+				return MMC_BLK_CMD_ERR;
+		}
 	}
 
 	/* if general error occurs, retry the write operation. */
@@ -1708,6 +1729,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	struct request *req = mmc_queue_req_to_req(mqrq);
 	struct mmc_blk_data *md = mq->blkdata;
 	bool do_rel_wr, do_data_tag;
+	bool need_acmd23;
 
 	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
 
@@ -1748,11 +1770,22 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	 * that for hosts that don't expose MMC_CAP_CMD23, no
 	 * change of behavior will be observed.
 	 *
+	 * Per sd spec, section 4.3.4, it suggests to use ACMD23
+	 * do achieve better write performance for those who can't
+	 * support CMD23. But also note that ACMD23 is for write only,
+	 * so we still need use CMD23 to do multiple block data transfer
+	 * if the card claims to support CMD23.
+	 *
 	 * N.B: Some MMC cards experience perf degradation.
 	 * We'll avoid using CMD23-bounded multiblock writes for
 	 * these, while retaining features like reliable writes.
 	 */
-	if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
+	need_acmd23 = !(md->flags & MMC_BLK_CMD23) &&
+		      brq->cmd.opcode == MMC_WRITE_MULTIPLE_BLOCK &&
+		      md->flags & MMC_BLK_ACMD23;
+
+	if (((md->flags & MMC_BLK_CMD23) || need_acmd23) &&
+	    mmc_op_multi(brq->cmd.opcode) &&
 	    (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
 	     do_data_tag)) {
 		brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
@@ -1760,6 +1793,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			(do_rel_wr ? (1 << 31) : 0) |
 			(do_data_tag ? (1 << 29) : 0);
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		if (need_acmd23)
+			brq->sbc.flags |= MMC_CMD_SD_APP;
 		brq->mrq.sbc = &brq->sbc;
 	}
 
@@ -2179,6 +2214,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		    (mmc_card_sd(card) &&
 		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
 			md->flags |= MMC_BLK_CMD23;
+
+		if (mmc_card_sd(card))
+			md->flags |= MMC_BLK_ACMD23;
 	}
 
 	if (mmc_card_mmc(card) &&
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 12b271c..90bbd30 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -408,6 +408,12 @@ static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
 
 	mmc_wait_ongoing_tfr_cmd(host);
 
+	if (mrq && mrq->sbc && mrq->sbc->flags & MMC_CMD_SD_APP) {
+		err = mmc_app_cmd(host, host->card);
+		if (err)
+			return err;
+	}
+
 	mrq->done = mmc_wait_data_done;
 	mrq->host = host;
 
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 9275193..dcb5783 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -46,6 +46,8 @@ struct mmc_command {
 #define MMC_CMD_BC	(2 << 5)
 #define MMC_CMD_BCR	(3 << 5)
 
+#define MMC_CMD_SD_APP	(1 << 6)		/* app cmd for SD cards */
+
 #define MMC_RSP_SPI_S1	(1 << 7)		/* one status byte */
 #define MMC_RSP_SPI_S2	(1 << 8)		/* second byte */
 #define MMC_RSP_SPI_B4	(1 << 9)		/* four data bytes */
-- 
1.9.1


