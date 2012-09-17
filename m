From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v12] mmc: support BKOPS feature for eMMC
Date: Mon, 17 Sep 2012 17:42:02 +0900
Message-ID: <5056E25A.6070207@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28989 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab2IQImT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Sep 2012 04:42:19 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MAH00ME9K6A5Q20@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 17 Sep 2012 17:42:17 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MAH005RKK6GO9V0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 17 Sep 2012 17:42:17 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Maya Erez <merez@codeaurora.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Minchan Kim <minchan@kernel.org>

Enable eMMC background operations (BKOPS) feature.

If URGENT_BKOPS is set after a response, note that BKOPS
are required. Immediately run BKOPS if required.
read/write operations should be requested during BKOPS(LEVEL-1),
then issue HPI to interrupt the ongoing BKOPS 
and service the foreground operation.
(This patch is only control the LEVEL2/3.)

When repeating the writing 1GB data, at a certain time, performance is decreased.
At that time, card is also triggered the Level-3 or Level-2.
After running bkops, performance is recovered.

Future considerations
 * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
 * Interrupt ongoing BKOPS before powering off the card.
 * How get BKOPS_STATUS value.(periodically send ext_csd command?)
 * If use periodic bkops, also consider runtime_pm control.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
Reviewed-by: Maya Erez <merez@codeaurora.org>
---
Changelog v12:
	- use the kamlloc for allocating the ext_csd.
		: If use the periodic bkops, it should be modified.
Changelog v11:
	- removed the MMC_CAP2_BKOPS.
		: if card support and enable bkops, then use it.
Changelog v10:
	- Based on latest mmc-next
	- Only control the level-2/3.
		: If triggered upper than level2, immediately start bkops.
	- Remove the BKOPS_CAP2_INIT_BKOPS (move into mmc-util)
	- change use_busy_signal instead of waiting_for_prog_done for __mmc_switch
	- Remove the useless code.
	- Add the from_exception to prepare the periodic bkops.
Changelog V9:
	- Rebased on patch-v7.
	- Added Konstantin and Maya's patch
		: mmc:core: Define synchronous BKOPS timeout
		: mmc:core: eMMC4.5 BKOPS fixes
	- Removed periodic bkops
		: This feature will do in future work
	- Add __mmc_switch() for waiting_for_prod_done.
	
Changelog V8:
	- Remove host->lock spin lock reviewed by Adrian
	- Support periodic start bkops
	- when bkops_status is level-3, if timeout is set to 0, send hpi.
	- Move the start-bkops point
Changelog V7:
	- Use HPI command when issued URGENT_BKOPS
	- Recheck until clearing the bkops-status bit.
Changelog V6:
	- Add the flag of check-bkops-status.
	  (For fixing async_req problem)
	- Add the capability for MMC_CAP2_INIT_BKOPS.
	  (When unset the bkops_en bit in ext_csd register)
	- modify the wrong condition.
Changelog V5:
	- Rebase based on the latest mmc-next.
	- modify codes based-on Chris's comment
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
---
 drivers/mmc/core/core.c    |  157 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/mmc.c     |   11 +++
 drivers/mmc/core/mmc_ops.c |   26 ++++++-
 include/linux/mmc/card.h   |    8 ++
 include/linux/mmc/core.h   |    4 +
 include/linux/mmc/mmc.h    |   19 +++++
 6 files changed, 219 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index af2c4d2..4749557 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -26,6 +26,7 @@
 #include <linux/suspend.h>
 #include <linux/fault-inject.h>
 #include <linux/random.h>
+#include <linux/slab.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -41,6 +42,12 @@
 #include "sd_ops.h"
 #include "sdio_ops.h"
 
+/*
+ * The Background operation can take a long time, depends on the house keeping
+ * operations the card has to peform
+ */
+#define MMC_BKOPS_MAX_TIMEOUT	(4 * 60 * 1000) /* max time to wait in ms */
+
 static struct workqueue_struct *workqueue;
 static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
 
@@ -245,6 +252,70 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	host->ops->request(host, mrq);
 }
 
+/**
+ *	mmc_start_bkops - start BKOPS for supported cards
+ *	@card: MMC card to start BKOPS
+ *	@form_exception: A flags to indicate if this function was
+ *			called due to an exception raised by the card
+ *
+ *	Start background operations whenever requested.
+ *	when the urgent BKOPS bit is set in a R1 command response
+ *	then background operations should be started immediately.
+*/
+void mmc_start_bkops(struct mmc_card *card, bool from_exception)
+{
+	int err;
+	int timeout;
+	bool use_busy_signal;
+
+	BUG_ON(!card);
+
+	if (!card->ext_csd.bkops_en || mmc_card_doing_bkops(card))
+		return;
+
+	err = mmc_read_bkops_status(card);
+	if (err) {
+		pr_err("%s: Didn't read bkops status : %d\n",
+		       mmc_hostname(card->host), err);
+		return;
+	}
+
+	if (!card->ext_csd.raw_bkops_status)
+		return;
+
+	if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2
+	    && (from_exception))
+		return;
+
+	mmc_claim_host(card->host);
+	if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2) {
+		timeout = MMC_BKOPS_MAX_TIMEOUT;
+		use_busy_signal = true;
+	} else {
+		timeout = 0;
+		use_busy_signal = false;
+	}
+
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_BKOPS_START, 1, timeout, use_busy_signal);
+	if (err) {
+		pr_warn("%s: error %d starting bkops\n",
+			   mmc_hostname(card->host), err);
+		goto out;
+	}
+
+	/*
+	 * For urgent bkops status (LEVEL_2 and more)
+	 * bkops executed synchronously, otherwise
+	 * the operation is in progress
+	 */
+	if (!use_busy_signal)
+		mmc_card_set_doing_bkops(card);
+out:
+	mmc_release_host(card->host);
+}
+EXPORT_SYMBOL(mmc_start_bkops);
+
 static void mmc_wait_done(struct mmc_request *mrq)
 {
 	complete(&mrq->completion);
@@ -354,6 +425,14 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	if (host->areq) {
 		mmc_wait_for_req_done(host, host->areq->mrq);
 		err = host->areq->err_check(host->card, host->areq);
+		/*
+		 * Check BKOPS urgency for each R1 response
+		 */
+		if (host->card && mmc_card_mmc(host->card) &&
+		((mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1) ||
+		 (mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1B)) &&
+		(host->areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT))
+			mmc_start_bkops(host->card, true);
 	}
 
 	if (!err && areq)
@@ -490,6 +569,64 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
 EXPORT_SYMBOL(mmc_wait_for_cmd);
 
 /**
+ *	mmc_stop_bkops - stop ongoing BKOPS
+ *	@card: MMC card to check BKOPS
+ *
+ *	Send HPI command to stop ongoing background operations,
+ *	to allow rapid servicing of foreground operations,e.g. read/
+ *	writes. Wait until the card comes out of the programming state
+ *	to avoid errors in servicing read/write requests.
+ */
+int mmc_stop_bkops(struct mmc_card *card)
+{
+	int err = 0;
+
+	BUG_ON(!card);
+	err = mmc_interrupt_hpi(card);
+
+	/*
+	 * if err is EINVAL, it's status that can't issue HPI.
+	 * it should complete the BKOPS.
+	 */
+	if (!err || (err == -EINVAL)) {
+		mmc_card_clr_doing_bkops(card);
+		err = 0;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_stop_bkops);
+
+int mmc_read_bkops_status(struct mmc_card *card)
+{
+	int err;
+	u8 *ext_csd;
+
+	/*
+	 * In future work, we should be consider storing the entire ext_csd.
+	 */
+	ext_csd = kmalloc(512, GFP_KERNEL);
+	if (!ext_csd) {
+		pr_err("%s: could not allocate a buffer to "
+			"receive the ext_csd.\n", mmc_hostname(card->host));
+		return -ENOMEM;
+	}
+
+	mmc_claim_host(card->host);
+	err = mmc_send_ext_csd(card, ext_csd);
+	mmc_release_host(card->host);
+	if (err)
+		goto out;
+
+	card->ext_csd.raw_bkops_status = ext_csd[EXT_CSD_BKOPS_STATUS];
+	card->ext_csd.raw_exception_status = ext_csd[EXT_CSD_EXP_EVENTS_STATUS];
+out:
+	kfree(ext_csd);
+	return err;
+}
+EXPORT_SYMBOL(mmc_read_bkops_status);
+
+/**
  *	mmc_set_data_timeout - set the timeout for a data command
  *	@data: data phase for command
  *	@card: the MMC card associated with the data transfer
@@ -2334,7 +2471,13 @@ int mmc_suspend_host(struct mmc_host *host)
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
 
-		if (host->bus_ops->suspend)
+		if (host->bus_ops->suspend) {
+			if (mmc_card_doing_bkops(host->card)) {
+				err = mmc_stop_bkops(host->card);
+				if (err)
+					goto out;
+			}
+		}
 			err = host->bus_ops->suspend(host);
 
 		if (err == -ENOSYS || !host->bus_ops->resume) {
@@ -2417,11 +2560,21 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 	struct mmc_host *host = container_of(
 		notify_block, struct mmc_host, pm_notify);
 	unsigned long flags;
-
+	int err = 0;
 
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+		if (host->card && mmc_card_mmc(host->card) &&
+				mmc_card_doing_bkops(host->card)) {
+			err = mmc_stop_bkops(host->card);
+			if (err) {
+				pr_err("%s didn't stop bkops\n",
+					mmc_hostname(host));
+				return err;
+			}
+			mmc_card_clr_doing_bkops(host->card);
+		}
 
 		spin_lock_irqsave(&host->lock, flags);
 		host->rescan_disable = 1;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 396b258..9c5caa6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -463,6 +463,17 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	}
 
 	if (card->ext_csd.rev >= 5) {
+		/* check whether the eMMC card support BKOPS */
+		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
+			card->ext_csd.bkops = 1;
+			card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
+			card->ext_csd.raw_bkops_status =
+				ext_csd[EXT_CSD_BKOPS_STATUS];
+			if (!card->ext_csd.bkops_en)
+				pr_info("%s: Didn't set BKOPS_EN bit!\n",
+						mmc_hostname(card->host));
+		}
+
 		/* check whether the eMMC card supports HPI */
 		if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
 			card->ext_csd.hpi = 1;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 0ed2cc5..be0a98c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -367,18 +367,19 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
 }
 
 /**
- *	mmc_switch - modify EXT_CSD register
+ *	__mmc_switch - modify EXT_CSD register
  *	@card: the MMC card associated with the data transfer
  *	@set: cmd set values
  *	@index: EXT_CSD register index
  *	@value: value to program into EXT_CSD register
  *	@timeout_ms: timeout (ms) for operation performed by register write,
  *                   timeout of zero implies maximum possible timeout
+ *	@use_busy_signal: use the busy signal as response type
  *
  *	Modifies the EXT_CSD register for selected card.
  */
-int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-	       unsigned int timeout_ms)
+int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
+	       unsigned int timeout_ms, bool use_busy_signal)
 {
 	int err;
 	struct mmc_command cmd = {0};
@@ -392,13 +393,23 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		  (index << 16) |
 		  (value << 8) |
 		  set;
-	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	cmd.flags = MMC_CMD_AC;
+	if (use_busy_signal)
+		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
+	else
+		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
+
+
 	cmd.cmd_timeout_ms = timeout_ms;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err)
 		return err;
 
+	/* No need to check card status in case of unblocking command */
+	if (!use_busy_signal)
+		return 0;
+
 	/* Must check status to be sure of no errors */
 	do {
 		err = mmc_send_status(card, &status);
@@ -423,6 +434,13 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__mmc_switch);
+
+int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
+		unsigned int timeout_ms)
+{
+	return __mmc_switch(card, set, index, value, timeout_ms, true);
+}
 EXPORT_SYMBOL_GPL(mmc_switch);
 
 int mmc_send_status(struct mmc_card *card, u32 *status)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 4b27f9f..78cc3be 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -76,10 +76,13 @@ struct mmc_ext_csd {
 	bool			hpi_en;			/* HPI enablebit */
 	bool			hpi;			/* HPI support bit */
 	unsigned int		hpi_cmd;		/* cmd used as HPI */
+	bool			bkops;		/* background support bit */
+	bool			bkops_en;	/* background enable bit */
 	unsigned int            data_sector_size;       /* 512 bytes or 4KB */
 	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
+	u8			raw_exception_status;	/* 53 */
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_erased_mem_count;	/* 181 */
 	u8			raw_ext_csd_structure;	/* 194 */
@@ -93,6 +96,7 @@ struct mmc_ext_csd {
 	u8			raw_sec_erase_mult;	/* 230 */
 	u8			raw_sec_feature_support;/* 231 */
 	u8			raw_trim_mult;		/* 232 */
+	u8			raw_bkops_status;	/* 246 */
 	u8			raw_sectors[4];		/* 212 - 4 bytes */
 
 	unsigned int            feature_support;
@@ -226,6 +230,7 @@ struct mmc_card {
 #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
 #define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
 #define MMC_STATE_SLEEP		(1<<9)		/* card is in sleep state */
+#define MMC_STATE_DOING_BKOPS	(1<<10)		/* card is doing BKOPS */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -393,6 +398,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_is_sleep(c)	((c)->state & MMC_STATE_SLEEP)
+#define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -405,7 +411,9 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_sleep(c)	((c)->state |= MMC_STATE_SLEEP)
+#define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
 
+#define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
 #define mmc_card_clr_sleep(c)	((c)->state &= ~MMC_STATE_SLEEP)
 /*
  * Quirk add/remove for MMC products.
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 1b431c7..9b9cdaf 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -134,6 +134,8 @@ struct mmc_host;
 struct mmc_card;
 struct mmc_async_req;
 
+extern int mmc_stop_bkops(struct mmc_card *);
+extern int mmc_read_bkops_status(struct mmc_card *);
 extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
 					   struct mmc_async_req *, int *);
 extern int mmc_interrupt_hpi(struct mmc_card *);
@@ -142,6 +144,8 @@ extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
 extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
+extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
+extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 
 #define MMC_ERASE_ARG		0x00000000
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d425cab..01e4b39 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -139,6 +139,7 @@ static inline bool mmc_op_multi(u32 opcode)
 #define R1_CURRENT_STATE(x)	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
 #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
 #define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
+#define R1_EXCEPTION_EVENT	(1 << 6)	/* sx, a */
 #define R1_APP_CMD		(1 << 5)	/* sr, c */
 
 #define R1_STATE_IDLE	0
@@ -274,12 +275,15 @@ struct _mmc_csd {
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
+#define EXT_CSD_EXP_EVENTS_STATUS	54	/* RO */
 #define EXT_CSD_DATA_SECTOR_SIZE	61	/* R */
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
@@ -313,11 +317,13 @@ struct _mmc_csd {
 #define EXT_CSD_PWR_CL_200_360		237	/* RO */
 #define EXT_CSD_PWR_CL_DDR_52_195	238	/* RO */
 #define EXT_CSD_PWR_CL_DDR_52_360	239	/* RO */
+#define EXT_CSD_BKOPS_STATUS		246	/* RO */
 #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
+#define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
 #define EXT_CSD_HPI_FEATURES		503	/* RO */
 
 /*
@@ -378,6 +384,19 @@ struct _mmc_csd {
 #define EXT_CSD_PWR_CL_8BIT_SHIFT	4
 #define EXT_CSD_PWR_CL_4BIT_SHIFT	0
 /*
+ * EXCEPTION_EVENT_STATUS field
+ */
+#define EXT_CSD_URGENT_BKOPS		BIT(0)
+#define EXT_CSD_DYNCAP_NEEDED		BIT(1)
+#define EXT_CSD_SYSPOOL_EXHAUSTED	BIT(2)
+#define EXT_CSD_PACKED_FAILURE		BIT(3)
+
+/*
+ * BKOPS status level
+ */
+#define EXT_CSD_BKOPS_LEVEL_2		0x2
+
+/*
  * MMC_SWITCH access modes
  */
 
-- 
1.7.4.1
