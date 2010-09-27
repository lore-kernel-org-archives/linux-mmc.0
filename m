From: Ethan Du <ethan.too@gmail.com>
Subject: [PATCH] MMC: Refine block layer waiting for card state
Date: Mon, 27 Sep 2010 11:32:19 +0800
Message-ID: <AANLkTi=E9imw9GQFU2_eMMPULKuWXMWeXdzCgjUFycD0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49158 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932620Ab0I0DcU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 23:32:20 -0400
Received: by qwh6 with SMTP id 6so3127872qwh.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 20:32:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

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
 drivers/mmc/card/block.c |   35 +++++++++++++++++++++++++++--------
 drivers/mmc/core/mmc.c   |    9 +++++++--
 drivers/mmc/core/sd.c    |    8 ++++++--
 include/linux/mmc/card.h |    3 +++
 include/linux/mmc/mmc.h  |    1 +
 5 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index d545f79..1d304a2 100644
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
@@ -541,6 +554,12 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
*mq, struct request *req)
 		ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
 	spin_unlock_irq(&md->lock);

+	card->err_count++;
+	if (card->err_count >= ERR_TRIGGER_REINIT) {
+		printk(KERN_WARNING "%s: re-init the card due to error\n",
+			req->rq_disk->disk_name);
+		mmc_detect_change(card->host, 0);
+	}
 	return 0;
 }

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6909a54..79c4759 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -535,6 +535,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,

 	if (!oldcard)
 		host->card = card;
+	else
+		oldcard->err_count = 0;

 	return 0;

@@ -563,17 +565,20 @@ static void mmc_remove(struct mmc_host *host)
  */
 static void mmc_detect(struct mmc_host *host)
 {
-	int err;
+	int err = 0;

 	BUG_ON(!host);
 	BUG_ON(!host->card);

 	mmc_claim_host(host);

+	if (host->card->err_count >= ERR_TRIGGER_REINIT)
+		err = mmc_init_card(host, host->ocr, host->card);
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_send_status(host->card, NULL);
+	if (!err)
+		err = mmc_send_status(host->card, NULL);

 	mmc_release_host(host);

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0f52410..820b0d1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -635,6 +635,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
 	}

+	card->err_count = 0;
 	host->card = card;
 	return 0;

@@ -662,17 +663,20 @@ static void mmc_sd_remove(struct mmc_host *host)
  */
 static void mmc_sd_detect(struct mmc_host *host)
 {
-	int err;
+	int err = 0;

 	BUG_ON(!host);
 	BUG_ON(!host->card);

 	mmc_claim_host(host);

+	if (host->card->err_count >= ERR_TRIGGER_REINIT)
+		err = mmc_sd_init_card(host, host->ocr, host->card);
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_send_status(host->card, NULL);
+	if (!err)
+		err = mmc_send_status(host->card, NULL);

 	mmc_release_host(host);

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
