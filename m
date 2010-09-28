From: Ethan Du <ethan.too@gmail.com>
Subject: [PATCH v2] MMC: Refine block layer waiting for card state
Date: Tue, 28 Sep 2010 19:10:50 +0800
Message-ID: <AANLkTikRY_wi1R1kcp1M1AtBW3XCRRTmGcW0FjhEYOUq@mail.gmail.com>
References: <AANLkTi=E9imw9GQFU2_eMMPULKuWXMWeXdzCgjUFycD0@mail.gmail.com>
	<4CA1905D.5010701@nokia.com>
	<AANLkTi=UGy-Q=LZRPUnGqojTCcMOVDGHFJW5hhAWr50a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62833 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab0I1LKv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 07:10:51 -0400
Received: by gxk9 with SMTP id 9so1864040gxk.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 04:10:50 -0700 (PDT)
In-Reply-To: <AANLkTi=UGy-Q=LZRPUnGqojTCcMOVDGHFJW5hhAWr50a@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@nokia.com>

    The while loop when handling rw request may become deadloop in
case of bad card
    I've seen mmcqd gets blocked forever after a single error message:

mmcblk0: error -110 sending read/write command, response 0x900, card
status 0x80e00

    Also there was case of card reports status without error

mmcblk0: error -110 sending read/write command, response 0x900, card
status 0xe00

    After this error, the card can stay in prg state, and never comes back,
    and may not report any error further. So a break out condition
    should be set in mmc block layer:
* should not enter the waiting loop in case of error
* should break out from the waiting loop, if card response with error
* should break out from the waiting loop when timeout

    These will not help with the card, one more thing to do:
* re-init the card in case of too many errors

Signed-off-by: Ethan Du <ethan.too@gmail.com>
---

Changes since v1:
       * Use mmc_reinit_host instead of mmc_detect_change

 drivers/mmc/card/block.c |   36 ++++++++++++++++++++++++++++--------
 drivers/mmc/core/core.c  |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |    3 +++
 include/linux/mmc/host.h |    1 +
 include/linux/mmc/mmc.h  |    1 +
 5 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index d545f79..cc28a20 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -316,12 +316,14 @@ out:
 	return err ? 0 : 1;
 }

+#define BUSY_TIMEOUT_MS (16 * 1024)
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request brq;
 	int ret = 1, disable_multi = 0;
+	unsigned long timeout = 0;

 	mmc_claim_host(card->host);

@@ -453,7 +455,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
*mq, struct request *req)
 			       brq.stop.resp[0], status);
 		}

-		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
+		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ &&
+		    !brq.cmd.error && !brq.data.error && !brq.stop.error) {
+			timeout = jiffies + msecs_to_jiffies(BUSY_TIMEOUT_MS);
 			do {
 				int err;

@@ -466,13 +470,22 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
*mq, struct request *req)
 					       req->rq_disk->disk_name, err);
 					goto cmd_err;
 				}
+				if (cmd.resp[0] & R1_ERROR_MASK) {
+					printk(KERN_ERR "%s: card err %#x\n",
+						req->rq_disk->disk_name,
+						cmd.resp[0]);
+					goto cmd_err;
+				}
 				/*
 				 * Some cards mishandle the status bits,
 				 * so make sure to check both the busy
 				 * indication and the card state.
 				 */
-			} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
-				(R1_CURRENT_STATE(cmd.resp[0]) == 7));
+				if ((cmd.resp[0] & R1_READY_FOR_DATA) &&
+				    (R1_CURRENT_STATE(cmd.resp[0]) != 7))
+					break;
+			} while (time_before(jiffies, timeout));
+			/* Ignore timeout out */

 #if 0
 			if (cmd.resp[0] & ~0x00000900)
@@ -510,11 +523,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
*mq, struct request *req)

 	return 1;

- cmd_err:
- 	/*
- 	 * If this is an SD card and we're writing, we can first
- 	 * mark the known good sectors as ok.
- 	 *
+cmd_err:
+	/*
+	 * If this is an SD card and we're writing, we can first
+	 * mark the known good sectors as ok.
+	 *
 	 * If the card is not SD, we can still ok written sectors
 	 * as reported by the controller (which might be less than
 	 * the real number of written sectors, but never more).
@@ -534,6 +547,13 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
*mq, struct request *req)
 		spin_unlock_irq(&md->lock);
 	}

+	card->err_count++;
+	if (card->err_count >= ERR_TRIGGER_REINIT) {
+		card->err_count = 0;
+		printk(KERN_WARNING "%s: re-init the card due to error\n",
+			md->disk->disk_name);
+		mmc_reinit_host(card->host);
+	}
 	mmc_release_host(card->host);

 	spin_lock_irq(&md->lock);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5db49b1..b61de33 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1671,6 +1671,44 @@ int mmc_resume_host(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_resume_host);

+/**
+ *	mmc_reinit_host - reinit a host
+ *	@host: mmc host
+ */
+int mmc_reinit_host(struct mmc_host *host)
+{
+	int err = 0;
+
+	mmc_bus_get(host);
+
+	if (!host->bus_ops->resume)
+		return 0;
+
+	if (host->bus_ops && !host->bus_dead) {
+		if (!(host->pm_flags & MMC_PM_KEEP_POWER)) {
+			mmc_power_up(host);
+			mmc_select_voltage(host, host->ocr);
+		}
+		err = host->bus_ops->resume(host);
+		if (err) {
+			printk(KERN_WARNING "%s: error %d during resume "
+					    "(card was removed?)\n",
+					    mmc_hostname(host), err);
+			err = 0;
+		}
+	}
+	mmc_bus_put(host);
+
+	/*
+	 * We add a slight delay here so that resume can progress
+	 * in parallel.
+	 */
+	mmc_detect_change(host, 1);
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_reinit_host);
+
 /* Do the card removal on suspend if card is assumed removeable
  * Do that in pm notifier while userspace isn't yet frozen, so we will be able
    to sync the card.
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6b75250..178de17 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -143,6 +143,9 @@ struct mmc_card {
 	const char		**info;		/* info strings */
 	struct sdio_func_tuple	*tuples;	/* unknown common tuples */

+	unsigned int		err_count;
+#define ERR_TRIGGER_REINIT 1024
+
 	struct dentry		*debugfs_root;
 };

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1575b52..cff9c69 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -235,6 +235,7 @@ static inline void *mmc_priv(struct mmc_host *host)

 extern int mmc_suspend_host(struct mmc_host *);
 extern int mmc_resume_host(struct mmc_host *);
+extern int mmc_reinit_host(struct mmc_host *);

 extern void mmc_power_save_host(struct mmc_host *host);
 extern void mmc_power_restore_host(struct mmc_host *host);
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index dd11ae5..3b979a1 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -122,6 +122,7 @@
 #define R1_UNDERRUN		(1 << 18)	/* ex, c */
 #define R1_OVERRUN		(1 << 17)	/* ex, c */
 #define R1_CID_CSD_OVERWRITE	(1 << 16)	/* erx, c, CID/CSD overwrite */
+#define R1_ERROR_MASK		0xffff0000
 #define R1_WP_ERASE_SKIP	(1 << 15)	/* sx, c */
 #define R1_CARD_ECC_DISABLED	(1 << 14)	/* sx, a */
 #define R1_ERASE_RESET		(1 << 13)	/* sr, c */
-- 
1.5.6.5
