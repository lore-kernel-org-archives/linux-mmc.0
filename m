From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2] mmc: Kill block requests if card is removed
Date: Fri, 25 Nov 2011 13:28:26 +0200
Message-ID: <4ECF7BDA.8020801@intel.com>
References: <1321959418-26864-1-git-send-email-sthumma@codeaurora.org> <4ECE5A3D.6060004@intel.com> <4ECF6D73.7080302@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060806010209010902070507"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4ECF6D73.7080302@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, per.lkml@gmail.com, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------060806010209010902070507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 25/11/11 12:26, Sujit Reddy Thumma wrote:
> Hi Adrian,
> 
> On 11/24/2011 8:22 PM, Adrian Hunter wrote:
>> Hi
>>
>> Here is a way to allow mmc block to determine immediately
>> if a card has been removed while preserving the present rules
>> and keeping card detection in the bus_ops.
>>
>> Untested I'm afraid.
>>
>> Regards
>> Adrian
>>
>>
>>
>>  From 2c6c9535b94c07fa3d12af26e9b6de500cb29970 Mon Sep 17 00:00:00 2001
>> From: Adrian Hunter<adrian.hunter@intel.com>
>> Date: Thu, 24 Nov 2011 16:32:34 +0200
>> Subject: [PATCH] mmc: allow upper layers to determine immediately if a
>> card has been removed
>>
>> Add a function mmc_card_removed() which upper layers can use
>> to determine immediately if a card has been removed.  This
>> function should be called after an I/O request fails so that
>> all queued I/O requests can be errored out immediately
>> instead of waiting for the card device to be removed.
>>
>> Signed-off-by: Adrian Hunter<adrian.hunter@intel.com>
>> ---
>>   drivers/mmc/core/core.c  |   32 ++++++++++++++++++++++++++++++++
>>   drivers/mmc/core/core.h  |    3 +++
>>   drivers/mmc/core/mmc.c   |   12 +++++++++++-
>>   drivers/mmc/core/sd.c    |   12 +++++++++++-
>>   drivers/mmc/core/sdio.c  |   11 ++++++++++-
>>   include/linux/mmc/card.h |    1 +
>>   include/linux/mmc/core.h |    2 ++
>>   7 files changed, 70 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 271efea..c317564 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2049,6 +2049,38 @@ static int mmc_rescan_try_freq(struct mmc_host
>> *host, unsigned freq)
>>       return -EIO;
>>   }
>>
>> +int _mmc_card_removed(struct mmc_host *host, int detect_change)
>> +{
>> +    int ret;
>> +
>> +    if (!(host->caps&  MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
>> +        return 0;
>> +
>> +    if (!host->card || (host->card->state&  MMC_CARD_REMOVED))
>> +        return 1;
>> +
>> +    /*
>> +     * The card will be considered alive unless we have been asked to detect
>> +     * a change or host requires polling to provide card detection.
>> +     */
>> +    if (!detect_change&&  !(host->caps&  MMC_CAP_NEEDS_POLL))
>> +        return 0;
>> +
>> +    ret = host->bus_ops->alive(host);
>> +    if (ret)
>> +        host->card->state |= MMC_CARD_REMOVED;
>> +
>> +    return ret;
>> +}
>> +
> 
> The patch itself looks good to me, but can't we decide this in the block
> layer itself when we issue get_card_status() when the ongoing request fails?
> 
> ----------------------------------------------
>         for (retry = 2; retry >= 0; retry--) {
>                 err = get_card_status(card, &status, 0);
>                 if (!err)
>                         break;
> 
>                 prev_cmd_status_valid = false;
>                 pr_err("%s: error %d sending status command, %sing\n",
>                        req->rq_disk->disk_name, err, retry ? "retry" :
> "abort");
>         }
> 
> 
>      /* We couldn't get a response from the card.  Give up. */
> -    if (err)
> +    if (err) {
> +        /*
> +         * If the card didn't respond to status command,
> +         * it is likely that card is gone. Flag it as removed,
> +         * mmc_detect_change() cleans the rest.
> +         */
> +        mmc_card_set_removed(card);
>          return ERR_ABORT;
> +    }
> ------------------------------------------------
> 
> The V2 patch I have posted takes care of this. Please let me know if it not
> good to decide in the block layer itself. Essentially, both the
> implementations are sending CMD13 to know the status of the card.

I think it is better to have the decision over whether or not the card
has been removed in only one place.  Also, never flagging
MMC_CAP_NONREMOVABLE cards as removed nor if the HC driver has not called
mmc_detect_change.

But the block change is essentially the same:

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c80bb6d..32590c3 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -632,6 +632,8 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card,
struct request *req,
 	u32 status, stop_status = 0;
 	int err, retry;

+	if (mmc_card_removed(card))
+		return ERR_ABORT;
 	/*
 	 * Try to get card status which indicates both the card state
 	 * and why there was no response.  If the first attempt fails,
@@ -648,8 +650,10 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card,
struct request *req,
 	}

 	/* We couldn't get a response from the card.  Give up. */
-	if (err)
+	if (err) {
+		mmc_detect_card_removed(card->host);
 		return ERR_ABORT;
+	}

 	/* Flag ECC errors */
 	if ((status & R1_CARD_ECC_FAILED) ||

I attached a revised version of the patch adding -ENOMEDIUM
errors from __mmc_start_request as you and Per discussed.

--------------060806010209010902070507
Content-Type: text/x-patch;
 name="0001-mmc-allow-upper-layers-to-determine-immediately-if-a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-mmc-allow-upper-layers-to-determine-immediately-if-a.pa";
 filename*1="tch"

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Thu, 24 Nov 2011 16:32:34 +0200
Subject: [PATCH V2] mmc: allow upper layers to determine immediately if a card has been removed

Add a function mmc_detect_card_removed() which upper layers
can use to determine immediately if a card has been removed.
This function should be called after an I/O request fails so
that all queued I/O requests can be errored out immediately
instead of waiting for the card device to be removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c  |   44 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/core/core.h  |    3 +++
 drivers/mmc/core/mmc.c   |   12 +++++++++++-
 drivers/mmc/core/sd.c    |   12 +++++++++++-
 drivers/mmc/core/sdio.c  |   11 ++++++++++-
 include/linux/mmc/card.h |    3 +++
 include/linux/mmc/core.h |    2 ++
 7 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 271efea..74463ef 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -140,7 +140,7 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 			cmd->retries = 0;
 	}
 
-	if (err && cmd->retries) {
+	if (err && cmd->retries && !mmc_card_removed(host->card)) {
 		/*
 		 * Request starter must handle retries - see
 		 * mmc_wait_for_req_done().
@@ -247,6 +247,11 @@ static void __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	init_completion(&mrq->completion);
 	mrq->done = mmc_wait_done;
+	if (mmc_card_removed(host->card)) {
+		mrq->cmd->error = -ENOMEDIUM;
+		complete(&mrq->completion);
+		return;
+	}
 	mmc_start_request(host, mrq);
 }
 
@@ -259,7 +264,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		wait_for_completion(&mrq->completion);
 
 		cmd = mrq->cmd;
-		if (!cmd->error || !cmd->retries)
+		if (!cmd->error || !cmd->retries ||
+		    mmc_card_removed(host->card))
 			break;
 
 		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
@@ -2049,6 +2055,40 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	return -EIO;
 }
 
+int _mmc_detect_card_removed(struct mmc_host *host, int detect_change)
+{
+	int ret;
+
+	if (!(host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
+		return 0;
+
+	if (!host->card || mmc_card_removed(host->card))
+		return 1;
+
+	/*
+	 * The card will be considered alive unless we have been asked to detect
+	 * a change or host requires polling to provide card detection.
+	 */
+	if (!detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
+		return 0;
+
+	ret = host->bus_ops->alive(host);
+	if (ret) {
+		mmc_card_set_removed(host->card);
+		pr_info("%s: card removed\n", mmc_hostname(host));
+	}
+
+	return ret;
+}
+
+int mmc_detect_card_removed(struct mmc_host *host)
+{
+	WARN_ON(!host->claimed);
+
+	return _mmc_detect_card_removed(host, work_pending(&host->detect.work));
+}
+EXPORT_SYMBOL(mmc_detect_card_removed);
+
 void mmc_rescan(struct work_struct *work)
 {
 	static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 14664f1..1d3fdfd 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -24,6 +24,7 @@ struct mmc_bus_ops {
 	int (*resume)(struct mmc_host *);
 	int (*power_save)(struct mmc_host *);
 	int (*power_restore)(struct mmc_host *);
+	int (*alive)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
@@ -59,6 +60,8 @@ void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
 
+int _mmc_detect_card_removed(struct mmc_host *host, int detect_change);
+
 int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
 int mmc_attach_sdio(struct mmc_host *host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a1223bd..4c2c6d5 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1104,6 +1104,14 @@ static void mmc_remove(struct mmc_host *host)
 }
 
 /*
+ * Card detection - card is alive.
+ */
+static int mmc_alive(struct mmc_host *host)
+{
+	return mmc_send_status(host->card, NULL);
+}
+
+/*
  * Card detection callback from host.
  */
 static void mmc_detect(struct mmc_host *host)
@@ -1118,7 +1126,7 @@ static void mmc_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_send_status(host->card, NULL);
+	err = _mmc_detect_card_removed(host, 1);
 
 	mmc_release_host(host);
 
@@ -1223,6 +1231,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.suspend = NULL,
 	.resume = NULL,
 	.power_restore = mmc_power_restore,
+	.alive = mmc_alive,
 };
 
 static const struct mmc_bus_ops mmc_ops_unsafe = {
@@ -1233,6 +1242,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
 	.power_restore = mmc_power_restore,
+	.alive = mmc_alive,
 };
 
 static void mmc_attach_bus_ops(struct mmc_host *host)
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1d5a3bd..9ed598b 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1018,6 +1018,14 @@ static void mmc_sd_remove(struct mmc_host *host)
 }
 
 /*
+ * Card detection - card is alive.
+ */
+static int mmc_sd_alive(struct mmc_host *host)
+{
+	return mmc_send_status(host->card, NULL);
+}
+
+/*
  * Card detection callback from host.
  */
 static void mmc_sd_detect(struct mmc_host *host)
@@ -1032,7 +1040,7 @@ static void mmc_sd_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_send_status(host->card, NULL);
+	err = _mmc_detect_card_removed(host, 1);
 
 	mmc_release_host(host);
 
@@ -1101,6 +1109,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.suspend = NULL,
 	.resume = NULL,
 	.power_restore = mmc_sd_power_restore,
+	.alive = mmc_sd_alive,
 };
 
 static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
@@ -1109,6 +1118,7 @@ static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
 	.suspend = mmc_sd_suspend,
 	.resume = mmc_sd_resume,
 	.power_restore = mmc_sd_power_restore,
+	.alive = mmc_sd_alive,
 };
 
 static void mmc_sd_attach_bus_ops(struct mmc_host *host)
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 8c04f7f..107c382 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -820,6 +820,14 @@ static void mmc_sdio_remove(struct mmc_host *host)
 }
 
 /*
+ * Card detection - card is alive.
+ */
+static int mmc_sdio_alive(struct mmc_host *host)
+{
+	return mmc_select_card(host->card);
+}
+
+/*
  * Card detection callback from host.
  */
 static void mmc_sdio_detect(struct mmc_host *host)
@@ -841,7 +849,7 @@ static void mmc_sdio_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_select_card(host->card);
+	err = _mmc_detect_card_removed(host, 1);
 
 	mmc_release_host(host);
 
@@ -1019,6 +1027,7 @@ static const struct mmc_bus_ops mmc_sdio_ops = {
 	.suspend = mmc_sdio_suspend,
 	.resume = mmc_sdio_resume,
 	.power_restore = mmc_sdio_power_restore,
+	.alive = mmc_sdio_alive,
 };
 
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 534974c..6402d92 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -209,6 +209,7 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
+#define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -370,6 +371,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_uhs(c)		((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_sd_card_uhs(c)	((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
+#define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -379,6 +381,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
+#define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 
 /*
  * Quirk add/remove for MMC products.
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 174a844..87a976c 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -180,6 +180,8 @@ extern int mmc_try_claim_host(struct mmc_host *host);
 
 extern int mmc_flush_cache(struct mmc_card *);
 
+extern int mmc_detect_card_removed(struct mmc_host *host);
+
 /**
  *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
-- 
1.7.6.4


--------------060806010209010902070507--
