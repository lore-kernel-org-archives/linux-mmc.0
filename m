From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: support BKOPS feature for eMMC
Date: Thu, 27 Oct 2011 20:10:00 +0900
Message-ID: <4EA93C08.9030009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:50497 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab1J0LKK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 07:10:10 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LTQ00CWG1OWR8P0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 27 Oct 2011 20:10:08 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LTQ005OD1OVPI30@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 27 Oct 2011 20:10:07 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>

Background operation(BKOPS) is one of eMMC's features.

If set the URGENT_BKOPS in response, we can notify that card nedd the BKOPS.
And all I/O request is done, then run background operation.
If request read/write operation during BKOPS, issue HPI interrupt.

If you want to use this feature, should be set MMC_CAP2_BKOPS.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
---
 drivers/mmc/card/block.c   |   13 +++++++-
 drivers/mmc/card/queue.c   |    1 +
 drivers/mmc/core/core.c    |   77 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c     |   21 ++++++++++++
 drivers/mmc/core/mmc_ops.c |    4 ++
 include/linux/mmc/card.h   |   11 ++++++
 include/linux/mmc/core.h   |    2 +
 include/linux/mmc/host.h   |    1 +
 include/linux/mmc/mmc.h    |    4 ++
 9 files changed, 133 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 4fd5723..edbed7a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1185,14 +1185,25 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
 		mmc_queue_bounce_post(mq_rq);
 
+		if (mmc_card_doing_bkops(card)) {
+			if (mmc_interrupt_bkops(card))
+				goto cmd_abort;
+		}
+
 		switch (status) {
 		case MMC_BLK_SUCCESS:
 		case MMC_BLK_PARTIAL:
+			spin_lock_irq(&md->lock);
+			/*
+			 * Check BKOPS urgency from each R1 response
+			 */
+			if (mmc_card_mmc(card) &&
+				(brq->cmd.resp[0] & R1_URGENT_BKOPS))
+				mmc_card_set_need_bkops(card);
 			/*
 			 * A block was successfully transferred.
 			 */
 			mmc_blk_reset_success(md, type);
-			spin_lock_irq(&md->lock);
 			ret = __blk_end_request(req, 0,
 						brq->data.bytes_xfered);
 			spin_unlock_irq(&md->lock);
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index dcad59c..31e5eca 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -68,6 +68,7 @@ static int mmc_queue_thread(void *d)
 				set_current_state(TASK_RUNNING);
 				break;
 			}
+			mmc_start_bkops(mq->card);
 			up(&mq->thread_sem);
 			schedule();
 			down(&mq->thread_sem);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5278ffb..7ef270d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -238,6 +238,50 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	host->ops->request(host, mrq);
 }
 
+/**
+ *	mmc_start_bkops - start BKOPS for supported cards
+ *	@card: MMC card to start BKOPS
+ *
+ *	Start background operations whenever requested.
+ *	when the urgent BKOPS bit is set in a R1 command response
+ *	then background operations should be started immediately.
+*/
+void mmc_start_bkops(struct mmc_card *card)
+{
+	int err;
+	unsigned long flags;
+
+	if ((!card || !card->ext_csd.bkops_en) &&
+			!(card->host->caps2 & MMC_CAP2_BKOPS))
+		return;
+
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
+		pr_warning("error %d starting bkops\n", err);
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
+
 static void mmc_wait_done(struct mmc_request *mrq)
 {
 	complete(&mrq->completion);
@@ -466,6 +510,39 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
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
index 3627044..b16db45 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -448,6 +448,10 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	}
 
 	if (card->ext_csd.rev >= 5) {
+		/* check whether the eMMC card support BKOPS */
+		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)
+			card->ext_csd.bkops = 1;
+
 		/* check whether the eMMC card supports HPI */
 		if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
 			card->ext_csd.hpi = 1;
@@ -909,6 +913,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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
+			pr_warning("%s: Enabling BKOPS failed\n",
+				mmc_hostname(card->host));
+			err = 0;
+		} else
+			card->ext_csd.bkops_en = 1;
+	}
+
+	/*
 	 * Enable HPI feature (if supported)
 	 */
 	if (card->ext_csd.hpi) {
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 007863e..7653e33 100644
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
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6e04e10..f4abb7c 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -71,6 +71,8 @@ struct mmc_ext_csd {
 	bool			hpi_en;			/* HPI enablebit */
 	bool			hpi;			/* HPI support bit */
 	unsigned int		hpi_cmd;		/* cmd used as HPI */
+	bool			bkops;		/* background support bit */
+	bool			bkops_en;	/* background enable bit */
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_erased_mem_count;	/* 181 */
 	u8			raw_ext_csd_structure;	/* 194 */
@@ -206,6 +208,8 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
+#define MMC_STATE_NEED_BKOPS	(1<<7)		/* card need to do BKOPS */
+#define MMC_STATE_DOING_BKOPS	(1<<8)		/* card is doing BKOPS */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -365,6 +369,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
 #define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
+#define mmc_card_need_bkops(c)	((c)->state & MMC_STATE_NEED_BKOPS)
+#define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -373,6 +379,11 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
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
index 174a844..600a177 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -134,6 +134,7 @@ struct mmc_host;
 struct mmc_card;
 struct mmc_async_req;
 
+extern int mmc_interrupt_bkops(struct mmc_card *);
 extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
 					   struct mmc_async_req *, int *);
 extern int mmc_interrupt_hpi(struct mmc_card *);
@@ -163,6 +164,7 @@ extern int mmc_can_sanitize(struct mmc_card *card);
 extern int mmc_can_secure_erase_trim(struct mmc_card *card);
 extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 				   unsigned int nr);
+extern void mmc_start_bkops(struct mmc_card *card);
 extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
 
 extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a3ac9c4..692e5f6 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -242,6 +242,7 @@ struct mmc_host {
 #define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control */
 #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)	/* Notify poweroff supported */
 #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
+#define MMC_CAP2_BKOPS		(1 << 4)	/* BKOPS supported */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 0e71356..283b848 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -138,6 +138,7 @@ static inline bool mmc_op_multi(u32 opcode)
 #define R1_CURRENT_STATE(x)	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
 #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
 #define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
+#define R1_URGENT_BKOPS		(1 << 6)	/* sx, a */
 #define R1_APP_CMD		(1 << 5)	/* sr, c */
 
 #define R1_STATE_IDLE	0
@@ -278,6 +279,8 @@ struct _mmc_csd {
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
 #define EXT_CSD_HPI_MGMT		161	/* R/W */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
+#define EXT_CSD_BKOPS_EN		163	/* R/W */
+#define EXT_CSD_BKOPS_START		164	/* W */
 #define EXT_CSD_SANITIZE_START		165     /* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
@@ -313,6 +316,7 @@ struct _mmc_csd {
 #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
+#define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
 #define EXT_CSD_HPI_FEATURES		503	/* RO */
 
 /*
