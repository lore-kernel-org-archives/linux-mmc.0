From: Hanumath Prasad <hanumath.prasad@stericsson.com>
Subject: [PATCH] mmc: enable background operations for emmc4.41 with HPI support
Date: Tue, 5 Jul 2011 17:57:20 +0530
Message-ID: <1309868840-15089-1-git-send-email-hanumath.prasad@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:53603 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755299Ab1GEMrJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 08:47:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linus.walleij@stericsson.com, per.forlin@linaro.org, chuanxiao.dong@intel.com

Background operations is an optional feature defined in eMMC4.41 spec.
The need for BKOPS will be checked after servicing each user request
in R1 response. If need for BKOPS flag is set, then start BKOPS when
request queue is idle. Once bkops is started and meanwhile any
user read/write request comes then the bkops will be interrupted by
issuing HPI, otherwise bkops keep going  until it gets finished.
This patch is based on the four patches submitted by Chuanxiao Dong
to linux-mmc.

Signed-off-by: Hanumath Prasad <hanumath.prasad@stericsson.com>
---
 drivers/mmc/card/block.c   |   14 +++++++-
 drivers/mmc/card/queue.c   |    1 +
 drivers/mmc/core/core.c    |   75 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c     |   52 +++++++++++++++++++++++++++++-
 drivers/mmc/core/mmc_ops.c |   33 +++++++++++++++++++
 drivers/mmc/core/mmc_ops.h |    1 +
 include/linux/mmc/card.h   |   14 ++++++++
 include/linux/mmc/core.h   |    3 +-
 include/linux/mmc/mmc.h    |    6 +++
 9 files changed, 195 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 71da564..26a87ca 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -799,6 +799,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 
 		mmc_queue_bounce_pre(mq);
 
+		if (mmc_card_doing_bkops(card)) {
+			if (mmc_interrupt_bkops(card))
+				goto cmd_err;
+		}
+
 		mmc_wait_for_req(card->host, &brq.mrq);
 
 		mmc_queue_bounce_post(mq);
@@ -897,10 +902,17 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 			goto cmd_err;
 		}
 
+		spin_lock_irq(&md->lock);
+		/*
+		 * Check BKOPS urgency from each R1 response
+		 */
+		if (mmc_card_mmc(card) &&
+			(brq.cmd.resp[0] & R1_URGENT_BKOPS))
+			mmc_card_set_need_bkops(card);
+
 		/*
 		 * A block was successfully transferred.
 		 */
-		spin_lock_irq(&md->lock);
 		ret = __blk_end_request(req, 0, brq.data.bytes_xfered);
 		spin_unlock_irq(&md->lock);
 	} while (ret);
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index c07322c..c491edd 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -64,6 +64,7 @@ static int mmc_queue_thread(void *d)
 				set_current_state(TASK_RUNNING);
 				break;
 			}
+			mmc_start_bkops(mq->card);
 			up(&mq->thread_sem);
 			schedule();
 			down(&mq->thread_sem);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 68091dd..e5e1d7c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -196,6 +196,48 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	host->ops->request(host, mrq);
 }
 
+/**
+ *	mmc_start_bkops - start BKOPS for supported cards
+ *	@card: MMC card to start BKOPS
+ *
+ *	Start background operations whenever requested.
+ *	when the urgent BKOPS bit is set in a R1 command response
+ *	then background operations should be started immediately.
+ */
+void mmc_start_bkops(struct mmc_card *card)
+{
+	int err;
+	unsigned long flags;
+
+	if (!card || !card->ext_csd.bkops_en)
+		return;
+	/*
+	 * If card is already doing bkops or need for
+	 * bkops flag is not set, then do nothing just
+	 * return
+	 */
+	if (mmc_card_doing_bkops(card)
+			|| !mmc_card_need_bkops(card))
+		return;
+
+	mmc_claim_host(card->host);
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_BKOPS_START, 1, 0);
+	if (err) {
+		printk(KERN_ERR "error %d starting bkops\n",
+				err);
+		mmc_card_clr_need_bkops(card);
+		goto out;
+	}
+	spin_lock_irqsave(&card->host->lock, flags);
+	mmc_card_clr_need_bkops(card);
+	mmc_card_set_doing_bkops(card);
+	spin_unlock_irqrestore(&card->host->lock, flags);
+out:
+	mmc_release_host(card->host);
+}
+EXPORT_SYMBOL(mmc_start_bkops);
+
 static void mmc_wait_done(struct mmc_request *mrq)
 {
 	complete(mrq->done_data);
@@ -254,6 +296,39 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
 EXPORT_SYMBOL(mmc_wait_for_cmd);
 
 /**
+ *	mmc_interrupt_bkops - interrupt ongoing BKOPS
+ *	@card: MMC card to check BKOPS
+ *
+ *	Send HPI command to interrupt ongoing background operations,
+ *	to allow rapid servicing of foreground operations,e.g. read/
+ *	writes. Wait until the card comes out of the programming state
+ *	to avoid errors in servicing read/write requests.
+ */
+int mmc_interrupt_bkops(struct mmc_card *card)
+{
+	int err;
+	unsigned long flags;
+	u32 status;
+
+	BUG_ON(!card);
+
+	/* send HPI to interrupt BKOPS. */
+	err = mmc_send_hpi_cmd(card, &status);
+	if (err || R1_CURRENT_STATE(status) == 7) {
+		do {
+			err = mmc_send_status(card, &status);
+			if (err)
+				return err;
+		} while (R1_CURRENT_STATE(status) == 7);
+	}
+	spin_lock_irqsave(&card->host->lock, flags);
+	mmc_card_clr_doing_bkops(card);
+	spin_unlock_irqrestore(&card->host->lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(mmc_interrupt_bkops);
+
+/**
  *	mmc_set_data_timeout - set the timeout for a data command
  *	@data: data phase for command
  *	@card: the MMC card associated with the data transfer
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2a7e43b..03dcbb3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -383,9 +383,23 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			ext_csd[EXT_CSD_TRIM_MULT];
 	}
 
-	if (card->ext_csd.rev >= 5)
+	if (card->ext_csd.rev >= 5) {
+		/* check whether the eMMC card support BKOPS */
+		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)
+			card->ext_csd.bkops = 1;
+		/* check whether the eMMC card support HPI */
+		if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
+			card->ext_csd.hpi = 1;
+			if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x2)
+				card->ext_csd.hpi_cmd =
+						MMC_STOP_TRANSMISSION;
+			else
+				card->ext_csd.hpi_cmd =
+						MMC_SEND_STATUS;
+		}
+
 		card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
-
+	}
 	if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
 		card->erased_byte = 0xFF;
 	else
@@ -702,6 +716,40 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * enable BKOPS feature (if supported)
+	 */
+	if (card->ext_csd.bkops) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_BKOPS_EN, 1, 0);
+		if (err && err != -EBADMSG)
+			goto free_card;
+
+		if (err) {
+			printk(KERN_WARNING "%s: Enabling BKOPS failed\n",
+				mmc_hostname(card->host));
+			err = 0;
+		} else
+			card->ext_csd.bkops_en = 1;
+	}
+
+	/*
+	 * Enable HPI feature (if supported)
+	 */
+	if (card->ext_csd.hpi) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_HPI_MGMT, 1, 0);
+		if (err && err != -EBADMSG)
+			goto free_card;
+
+		if (err) {
+			printk(KERN_WARNING "%s: Enabling HPI failed\n",
+				mmc_hostname(card->host));
+			err = 0;
+		} else
+			card->ext_csd.hpi_en = 1;
+	}
+
+	/*
 	 * Compute bus speed.
 	 */
 	max_dtr = (unsigned int)-1;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 845ce7c..a4accfb 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -398,6 +398,10 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (err)
 		return err;
 
+	/* No need to check card status in case of BKOPS switch*/
+	if (index == EXT_CSD_BKOPS_START)
+		return 0;
+
 	/* Must check status to be sure of no errors */
 	do {
 		err = mmc_send_status(card, &status);
@@ -547,3 +551,32 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width)
 	err = mmc_send_bus_test(card, card->host, MMC_BUS_TEST_R, width);
 	return err;
 }
+
+int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
+{
+	struct mmc_command cmd;
+	unsigned int opcode;
+	unsigned int flags;
+	int err;
+
+	opcode = card->ext_csd.hpi_cmd;
+	if (opcode == MMC_STOP_TRANSMISSION)
+		flags = MMC_RSP_R1B | MMC_CMD_AC;
+	else if (opcode == MMC_SEND_STATUS)
+		flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	cmd.opcode = opcode;
+	cmd.arg = card->rca << 16 | 1;
+	cmd.flags = flags;
+	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	if (err) {
+		printk(KERN_ERR "error %d interrupting operation"
+			"HPI command response  %#x\n",
+				err, cmd.resp[0]);
+		return err;
+	}
+	if (status)
+		*status = cmd.resp[0];
+	return 0;
+}
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 9276946..d539f55 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -21,6 +21,7 @@ int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
 int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
 int mmc_send_status(struct mmc_card *card, u32 *status);
+int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index c6927a4..9bbfed2 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -64,6 +64,11 @@ struct mmc_ext_csd {
 	unsigned long long	enhanced_area_offset;	/* Units: Byte */
 	unsigned int		enhanced_area_size;	/* Units: KB */
 	unsigned int		boot_size;		/* in bytes */
+	bool			bkops;		/* background support bit */
+	bool			bkops_en;	/* background enable bit */
+	bool			hpi_en;		/*HPI enablebit */
+	bool			hpi;		/* HPI support bit */
+	unsigned int		hpi_cmd;	/* cmd used as HPI */
 };
 
 struct sd_scr {
@@ -164,6 +169,8 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
+#define MMC_STATE_NEED_BKOPS	(1<<7)		/* card need to do BKOPS */
+#define MMC_STATE_DOING_BKOPS	(1<<8)		/* card is doing BKOPS */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -301,6 +308,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
 #define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
+#define mmc_card_need_bkops(c)	((c)->state & MMC_STATE_NEED_BKOPS)
+#define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -309,6 +318,11 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
 #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
+#define mmc_card_set_need_bkops(c)	((c)->state |= MMC_STATE_NEED_BKOPS)
+#define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
+
+#define mmc_card_clr_need_bkops(c)	((c)->state &= ~MMC_STATE_NEED_BKOPS)
+#define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
 
 /*
  * Quirk add/remove for MMC products.
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b6718e5..53dca10 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -132,6 +132,7 @@ struct mmc_request {
 struct mmc_host;
 struct mmc_card;
 
+extern int mmc_interrupt_bkops(struct mmc_card *);
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
 extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
@@ -155,7 +156,7 @@ extern int mmc_can_trim(struct mmc_card *card);
 extern int mmc_can_secure_erase_trim(struct mmc_card *card);
 extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 				   unsigned int nr);
-
+extern void mmc_start_bkops(struct mmc_card *card);
 extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
 
 extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index ac26a68..98aa47d 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -138,6 +138,7 @@ static inline bool mmc_op_multi(u32 opcode)
 #define R1_CURRENT_STATE(x)	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
 #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
 #define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
+#define R1_URGENT_BKOPS		(1 << 6)	/* sx, a */
 #define R1_APP_CMD		(1 << 5)	/* sr, c */
 
 /*
@@ -262,6 +263,9 @@ struct _mmc_csd {
 
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
+#define EXT_CSD_HPI_MGMT		161	/* R/W */
+#define EXT_CSD_BKOPS_EN		163	/* R/W */
+#define EXT_CSD_BKOPS_START		164	/* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
@@ -283,6 +287,8 @@ struct _mmc_csd {
 #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
 #define EXT_CSD_TRIM_MULT		232	/* RO */
+#define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
+#define EXT_CSD_HPI_FEATURES		503	/* RO */
 
 /*
  * EXT_CSD field definitions
-- 
1.7.1

