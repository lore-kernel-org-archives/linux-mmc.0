From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v4] mmc: support BKOPS feature for eMMC
Date: Mon, 02 Jan 2012 10:44:58 +0900
Message-ID: <4F010C1A.2000503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45946 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab2ABBpB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Jan 2012 20:45:01 -0500
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LX500AFWE6PMW80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 02 Jan 2012 10:45:00 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LX500JN5E6Z4930@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 02 Jan 2012 10:44:59 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per Forlin <per.lkml@gmail.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

Enable eMMC background operations (BKOPS) feature.

If URGENT_BKOPS is set after a response, note that BKOPS
are required. After all I/O requests are finished, run
BKOPS if required. Should read/write operations be requested
during BKOPS, first issue HPI to interrupt the ongoing BKOPS
and then service the request.

If you want to enable this feature, set MMC_CAP2_BKOPS.

Future considerations
 * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
 * Interrupt ongoing BKOPS before powering off the card.
 * How get BKOPS_STATUS value.(periodically send ext_csd command?)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changelog V4:
	- Add mmc_read_bkops_status
	- When URGENT_BKOPS(level2-3), didn't use HPI command.
	- In mmc_switch(), use R1B/R1 according to level.
Changelog V3:
	- move the bkops setting's location in mmc_blk_issue_rw_rq
	- modify condition checking
	- bkops_en is assigned ext_csd[EXT_CSD_BKOPS_EN] instead of "1"
	- remove the unused code
	- change pr_debug instead of pr_warn in mmc_send_hpi_cmd
	- Add the Future consideration suggested by Per
	
Changelog V2:
	- Use EXCEPTION_STATUS instead of URGENT_BKOPS
	- Add function to check Exception_status(for eMMC4.5)

 drivers/mmc/card/block.c   |   10 ++++
 drivers/mmc/card/queue.c   |    3 +
 drivers/mmc/core/core.c    |  104 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c     |    8 +++
 drivers/mmc/core/mmc_ops.c |   12 +++++-
 include/linux/mmc/card.h   |   14 ++++++
 include/linux/mmc/core.h   |    4 ++
 include/linux/mmc/host.h   |    1 +
 include/linux/mmc/mmc.h    |   19 ++++++++
 9 files changed, 174 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 0cad48a..9c214e4 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1273,6 +1273,16 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
 		mmc_queue_bounce_post(mq_rq);
 
+		/*
+		 * Check BKOPS urgency from each R1 response
+		 */
+		if (mmc_card_mmc(card) && ((brq->cmd.flags == MMC_RSP_R1B) ||
+			 (brq->cmd.flags == MMC_RSP_R1)) &&
+			(brq->cmd.resp[0] & R1_EXCEPTION_EVENT)) {
+			if (mmc_is_exception_event(card, EXT_CSD_URGENT_BKOPS))
+				mmc_card_set_need_bkops(card);
+		}
+
 		switch (status) {
 		case MMC_BLK_SUCCESS:
 		case MMC_BLK_PARTIAL:
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 2517547..fd11a31 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -66,6 +66,8 @@ static int mmc_queue_thread(void *d)
 		spin_unlock_irq(q->queue_lock);
 
 		if (req || mq->mqrq_prev->req) {
+			if (mmc_card_doing_bkops(mq->card))
+				mmc_interrupt_bkops(mq->card);
 			set_current_state(TASK_RUNNING);
 			mq->issue_fn(mq, req);
 		} else {
@@ -73,6 +75,7 @@ static int mmc_queue_thread(void *d)
 				set_current_state(TASK_RUNNING);
 				break;
 			}
+			mmc_start_bkops(mq->card);
 			up(&mq->thread_sem);
 			schedule();
 			down(&mq->thread_sem);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a2aa860..627697a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -238,6 +238,51 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
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
+	BUG_ON(!card);
+	if ((!card->ext_csd.bkops_en) ||
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
+	if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2)
+		mmc_card_set_doing_bkops(card);
+	spin_unlock_irqrestore(&card->host->lock, flags);
+out:
+	mmc_release_host(card->host);
+}
+EXPORT_SYMBOL(mmc_start_bkops);
+
 static void mmc_wait_done(struct mmc_request *mrq)
 {
 	complete(&mrq->completion);
@@ -472,6 +517,65 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
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
+	int err = 0;
+	unsigned long flags;
+
+	BUG_ON(!card);
+
+	err = mmc_interrupt_hpi(card);
+
+	spin_lock_irqsave(&card->host->lock, flags);
+	mmc_card_clr_doing_bkops(card);
+	spin_unlock_irqrestore(&card->host->lock, flags);
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_interrupt_bkops);
+
+int mmc_read_bkops_status(struct mmc_card *card)
+{
+	int err;
+	u8 ext_csd[512];
+
+	err = mmc_send_ext_csd(card, ext_csd);
+	if (err)
+		return err;
+
+	card->ext_csd.raw_bkops_status = ext_csd[EXT_CSD_BKOPS_STATUS];
+	card->ext_csd.raw_exception_status = ext_csd[EXT_CSD_EXCEPTION_STATUS];
+out:
+	return 0;
+}
+EXPORT_SYMBOL(mmc_read_bkops_status);
+
+int mmc_is_exception_event(struct mmc_card *card, unsigned int value)
+{
+	int err;
+
+	err = mmc_read_bkops_status(card);
+
+	/* In eMMC 4.41, R1_EXCEPTION_EVENT is URGENT_BKOPS */
+	if (card->ext_csd.rev == 5)
+		return 1;
+
+	if (err)
+		return 0;
+
+	return (card->ext_csd.raw_exception_status & value) ? 1 : 0;
+}
+EXPORT_SYMBOL(mmc_is_exception_event);
+
+/**
  *	mmc_set_data_timeout - set the timeout for a data command
  *	@data: data phase for command
  *	@card: the MMC card associated with the data transfer
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f0a9f1f..94456b1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -459,6 +459,14 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	}
 
 	if (card->ext_csd.rev >= 5) {
+		/* check whether the eMMC card support BKOPS */
+		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
+			card->ext_csd.bkops = 1;
+			card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
+			card->ext_csd.raw_bkops_status =
+				ext_csd[EXT_CSD_BKOPS_STATUS];
+		}
+
 		/* check whether the eMMC card supports HPI */
 		if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
 			card->ext_csd.hpi = 1;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 4d41fa9..040f144 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -392,13 +392,23 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		  (index << 16) |
 		  (value << 8) |
 		  set;
-	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	cmd.flags = MMC_CMD_AC;
+	if (index == EXT_CSD_BKOPS_START &&
+		card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2)
+		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
+	else
+		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
+
 	cmd.cmd_timeout_ms = timeout_ms;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
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
index 9478a6b..b9e255f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -71,8 +71,11 @@ struct mmc_ext_csd {
 	bool			hpi_en;			/* HPI enablebit */
 	bool			hpi;			/* HPI support bit */
 	unsigned int		hpi_cmd;		/* cmd used as HPI */
+	bool			bkops;		/* background support bit */
+	bool			bkops_en;	/* background enable bit */
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
+	u8			raw_exception_status;	/* 53 */
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_erased_mem_count;	/* 181 */
 	u8			raw_ext_csd_structure;	/* 194 */
@@ -86,6 +89,7 @@ struct mmc_ext_csd {
 	u8			raw_sec_erase_mult;	/* 230 */
 	u8			raw_sec_feature_support;/* 231 */
 	u8			raw_trim_mult;		/* 232 */
+	u8			raw_bkops_status;	/* 246 */
 	u8			raw_sectors[4];		/* 212 - 4 bytes */
 
 	unsigned int            feature_support;
@@ -216,6 +220,9 @@ struct mmc_card {
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
 #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
+#define MMC_STATE_NEED_BKOPS	(1<<8)		/* card need to do BKOPS */
+#define MMC_STATE_DOING_BKOPS	(1<<9)		/* card is doing BKOPS */
+
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -380,6 +387,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_sd_card_uhs(c)	((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
+#define mmc_card_need_bkops(c)	((c)->state & MMC_STATE_NEED_BKOPS)
+#define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -390,6 +399,11 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
+#define mmc_card_set_need_bkops(c)	((c)->state |= MMC_STATE_NEED_BKOPS)
+#define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
+
+#define mmc_card_clr_need_bkops(c)	((c)->state &= ~MMC_STATE_NEED_BKOPS)
+#define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
 
 /*
  * Quirk add/remove for MMC products.
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 87a976c..45357c7 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -134,6 +134,9 @@ struct mmc_host;
 struct mmc_card;
 struct mmc_async_req;
 
+extern int mmc_interrupt_bkops(struct mmc_card *);
+extern int mmc_read_bkops_status(struct mmc_card *);
+extern int mmc_is_exception_event(struct mmc_card *, unsigned int);
 extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
 					   struct mmc_async_req *, int *);
 extern int mmc_interrupt_hpi(struct mmc_card *);
@@ -163,6 +166,7 @@ extern int mmc_can_sanitize(struct mmc_card *card);
 extern int mmc_can_secure_erase_trim(struct mmc_card *card);
 extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 				   unsigned int nr);
+extern void mmc_start_bkops(struct mmc_card *card);
 extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
 
 extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 742f0e1..02ef040 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -247,6 +247,7 @@ struct mmc_host {
 #define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control */
 #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)	/* Notify poweroff supported */
 #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
+#define MMC_CAP2_BKOPS		(1 << 4)	/* BKOPS supported */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 665548e..8cc1a03 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -138,6 +138,7 @@ static inline bool mmc_op_multi(u32 opcode)
 #define R1_CURRENT_STATE(x)	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
 #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
 #define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
+#define R1_EXCEPTION_EVENT	(1 << 6)	/* sx, a */
 #define R1_APP_CMD		(1 << 5)	/* sr, c */
 
 #define R1_STATE_IDLE	0
@@ -273,11 +274,14 @@ struct _mmc_csd {
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
+#define EXT_CSD_EXCEPTION_STATUS	54	/* RO */
 #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
 #define EXT_CSD_HPI_MGMT		161	/* R/W */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
+#define EXT_CSD_BKOPS_EN		163	/* R/W */
+#define EXT_CSD_BKOPS_START		164	/* W */
 #define EXT_CSD_SANITIZE_START		165     /* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_BOOT_WP			173	/* R/W */
@@ -311,9 +315,11 @@ struct _mmc_csd {
 #define EXT_CSD_PWR_CL_200_360		237	/* RO */
 #define EXT_CSD_PWR_CL_DDR_52_195	238	/* RO */
 #define EXT_CSD_PWR_CL_DDR_52_360	239	/* RO */
+#define EXT_CSD_BKOPS_STATUS		246	/* RO */
 #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
+#define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
 #define EXT_CSD_HPI_FEATURES		503	/* RO */
 
 /*
@@ -379,4 +385,17 @@ struct _mmc_csd {
 #define MMC_SWITCH_MODE_CLEAR_BITS	0x02	/* Clear bits which are 1 in value */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
 
+/*
+ * BKOPS status level
+ */
+#define EXT_CSD_BKOPS_LEVEL_2		0x2
+
+/*
+ * EXCEPTION_EVENT_STATUS field (eMMC4.5)
+ */
+#define EXT_CSD_URGENT_BKOPS		BIT(0)
+#define EXT_CSD_DYNCAP_NEEDED		BIT(1)
+#define EXT_CSD_SYSPOOL_EXHAUSTED	BIT(2)
+#define EXT_CSD_PACKED_FAILURE		BIT(3)
+
 #endif /* LINUX_MMC_MMC_H */
