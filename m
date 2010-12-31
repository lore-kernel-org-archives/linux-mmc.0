From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH] Fix sd/sdio/mmc initialization frequency retries
Date: Sat, 01 Jan 2011 04:43:48 +0800
Message-ID: <4D1E4084.3080601@yahoo.es>
References: <4D1A1B19.8000902@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout04.eigbox.net ([66.96.187.4]:57002 "EHLO
	bosmailout04.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab0LaVY3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Dec 2010 16:24:29 -0500
Received: from bosmailscan06.eigbox.net ([10.20.15.6])
	by bosmailout04.eigbox.net with esmtp (Exim)
	id 1PYlpq-0006O6-Ld
	for linux-mmc@vger.kernel.org; Fri, 31 Dec 2010 15:44:26 -0500
In-Reply-To: <4D1A1B19.8000902@windriver.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>, Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, Matt Fleming <matt@console-pimps.org>

Hi Andy,

It looks like a good cleanup!

On 29-12-2010 01:15, Andy Ross wrote:
> I'm working with a eMMC device that broke after this commit:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=88ae8b86648
>
> The older hack I'd been given hard-coded the initialisation frequency
> at 200kHz (instead of 400kHz in the original upstream) and works fine.
>
> But the new code tries to dynamically detect the highest frequency
> that will work, but as far as I can tell the logic is wrong.  It will
> continue trying after failed mmc_send_*_cond() calls, but *not* after
> failures later on in mmc_attach_{sd,sdio,mmc}.  My boards (at 400kHz)
> are getting successful returns from mmc_send_op_cond(), but failing in
> mmc_attach_mmc().  If I retry at 300, it works.
>
> Tested on the same controller using a sdhc card.  No idea how the
> extra retries will affect other hardware (though as the original code
> was fixed at 400, presumably very few devices will care?).

And before the fixed 400 Khz, it went like this:

    host->ios.clock = host->f_min;

So with the older versions, your card(s) would have initialized fine,
and mine as well.

> The attached patch fixes that error, and does some rewriting that
> should hopefully make review easier:
>
> + The freqs array should be static
> + No need for locking around atomic rescan_disable test
> + Remove adjacent bus_put/get calls.
> + Move repeated claim/release host calls out of mmc_rescan loop
> + Hopefully clearer iteration logic for f_init
> + Remove duplicate mmc_attach_sd() logic after sdio failures
> + Move mmc_send_*_cond() calls into mmc_attach_*() functions, as they
>   are only called from one place and are the only consumers of the ocr
>   return value.
> + Make mmc_attach_*() functions symmetric with respect to
>   mmc_claim/release_host().  The existing code is called with the lock
>   and releases it before returning, which was really confusing to me
>   when debugging this issue.  They now hold the lock throughout,
>   releasing across some interior calls to preserve existing behavior.
>
> >From 0357d0d07d4985de43c814a9fea02d13753c121c Mon Sep 17 00:00:00 2001
> From: Andy Ross <andy.ross@windriver.com>
> Date: Tue, 28 Dec 2010 09:04:10 -0800
> Subject: [PATCH] Fix sd/sdio/mmc initialization frequency retries
>
> Rewrite and clean up mmc_rescan() to properly retry frequencies lower
> than 400kHz.  Failures can happen both in sd_send_* calls and
> mmc_attach_*.  Symmetrize claim/release logic in mmc_attach_* API, and
> move the sd_send_* calls there to make mmc_rescan easier to read.
>
> Signed-off-by: Andy Ross <andy.ross@windriver.com>
> ---
>  drivers/mmc/core/core.c |   86 ++++++++--------------------------------------
>  drivers/mmc/core/core.h |    6 ++--
>  drivers/mmc/core/mmc.c  |   12 ++++--
>  drivers/mmc/core/sd.c   |   10 ++++--
>  drivers/mmc/core/sdio.c |   17 ++++++---
>  5 files changed, 44 insertions(+), 87 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 31ae07a..c92de04 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1426,23 +1426,13 @@ EXPORT_SYMBOL(mmc_set_blocklen);
>
>  void mmc_rescan(struct work_struct *work)
>  {
> +	static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>  	struct mmc_host *host =
>  		container_of(work, struct mmc_host, detect.work);
> -	u32 ocr;
> -	int err;
> -	unsigned long flags;
>  	int i;
> -	const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>
> -	spin_lock_irqsave(&host->lock, flags);
> -
> -	if (host->rescan_disable) {
> -		spin_unlock_irqrestore(&host->lock, flags);
> +	if (host->rescan_disable)
>  		return;
> -	}
> -
> -	spin_unlock_irqrestore(&host->lock, flags);
> -
>
>  	mmc_bus_get(host);
>
> @@ -1450,19 +1440,12 @@ void mmc_rescan(struct work_struct *work)
>  	if ((host->bus_ops != NULL) && host->bus_ops->detect && !host->bus_dead)
>  		host->bus_ops->detect(host);
>
> -	mmc_bus_put(host);
> -
> -
> -	mmc_bus_get(host);
> -
>  	/* if there still is a card present, stop here */
>  	if (host->bus_ops != NULL) {
>  		mmc_bus_put(host);
>  		goto out;
>  	}
>
> -	/* detect a newly inserted card */
> -
>  	/*
>  	 * Only we can add a new handler, so it's safe to
>  	 * release the lock here.
> @@ -1472,17 +1455,11 @@ void mmc_rescan(struct work_struct *work)
>  	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
>  		goto out;
>
> -	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> -		mmc_claim_host(host);
> +	mmc_claim_host(host);
> +	host->f_init = freqs[0];
> +	for (i=0; i<ARRAY_SIZE(freqs) && host->f_init > host->f_min; i++) {

Suppose f_min > 400 Khz, no initialization will ever take place?

Can't you change it to:

+	for (i=0;
+		i<ARRAY_SIZE(freqs) && (host->f_init > host->f_min || !i);
+		i++) {

ans so at least f_min will be tried?

> +		host->f_init = max(freqs[i], host->f_min);
>
> -		if (freqs[i] >= host->f_min)
> -			host->f_init = freqs[i];
> -		else if (!i || freqs[i-1] > host->f_min)
> -			host->f_init = host->f_min;
> -		else {
> -			mmc_release_host(host);
> -			goto out;
> -		}
>  #ifdef CONFIG_MMC_DEBUG
>  		pr_info("%s: %s: trying to init card at %u Hz\n",
>  			mmc_hostname(host), __func__, host->f_init);
> @@ -1493,50 +1470,17 @@ void mmc_rescan(struct work_struct *work)
>
>  		mmc_send_if_cond(host, host->ocr_avail);
>
> -		/*
> -		 * First we search for SDIO...
> -		 */
> -		err = mmc_send_io_op_cond(host, 0, &ocr);
> -		if (!err) {
> -			if (mmc_attach_sdio(host, ocr)) {
> -				mmc_claim_host(host);
> -				/*
> -				 * Try SDMEM (but not MMC) even if SDIO
> -				 * is broken.
> -				 */
> -				if (mmc_send_app_op_cond(host, 0, &ocr))
> -					goto out_fail;
> -
> -				if (mmc_attach_sd(host, ocr))
> -					mmc_power_off(host);
> -			}
> -			goto out;
> -		}
> -
> -		/*
> -		 * ...then normal SD...
> -		 */
> -		err = mmc_send_app_op_cond(host, 0, &ocr);
> -		if (!err) {
> -			if (mmc_attach_sd(host, ocr))
> -				mmc_power_off(host);
> -			goto out;
> -		}
> -
> -		/*
> -		 * ...and finally MMC.
> -		 */
> -		err = mmc_send_op_cond(host, 0, &ocr);
> -		if (!err) {
> -			if (mmc_attach_mmc(host, ocr))
> -				mmc_power_off(host);
> -			goto out;
> -		}
> +		/* Try SDIO, then SD, then MMC */
> +		if(mmc_attach_sdio(host) == 0)
> +			break;
> +		else if(mmc_attach_sd(host) == 0)
> +			break;
> +		else if(mmc_attach_mmc(host) == 0)
> +			break;
>
The "else" after break is syntactically redundant, this would do the same:

+		if (!mmc_attach_sdio(host))
+			break;
+		if (!mmc_attach_sd(host))
+			break;
+		if (!mmc_attach_mmc(host))
+			break;


> -out_fail:
> -		mmc_release_host(host);
> -		mmc_power_off(host);
> +                mmc_power_off(host);
>  	}
> +	mmc_release_host(host);
>  out:
>  	if (host->caps & MMC_CAP_NEEDS_POLL)
>  		mmc_schedule_delayed_work(&host->detect, HZ);
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 77240cd..54de886 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -54,9 +54,9 @@ void mmc_rescan(struct work_struct *work);
>  void mmc_start_host(struct mmc_host *host);
>  void mmc_stop_host(struct mmc_host *host);
>
> -int mmc_attach_mmc(struct mmc_host *host, u32 ocr);
> -int mmc_attach_sd(struct mmc_host *host, u32 ocr);
> -int mmc_attach_sdio(struct mmc_host *host, u32 ocr);
> +int mmc_attach_mmc(struct mmc_host *host);
> +int mmc_attach_sd(struct mmc_host *host);
> +int mmc_attach_sdio(struct mmc_host *host);
>
>  /* Module parameters */
>  extern int use_spi_crc;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 77f93c3..cad2eaf 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -737,13 +737,17 @@ static void mmc_attach_bus_ops(struct mmc_host *host)
>  /*
>   * Starting point for MMC card init.
>   */
> -int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
> +int mmc_attach_mmc(struct mmc_host *host)
>  {
>  	int err;
> +	u32 ocr;
>
>  	BUG_ON(!host);
>  	WARN_ON(!host->claimed);
>
> + 	if((err = mmc_send_op_cond(host, 0, &ocr)))
> +		return err;
> +
>  	mmc_attach_bus_ops(host);
>
>  	/*
> @@ -784,20 +788,20 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
>  		goto err;
>
>  	mmc_release_host(host);
> -
>  	err = mmc_add_card(host->card);
> +	mmc_claim_host(host);
>  	if (err)
>  		goto remove_card;
>
>  	return 0;
>
>  remove_card:
> +	mmc_release_host(host);
>  	mmc_remove_card(host->card);
> -	host->card = NULL;
>  	mmc_claim_host(host);
> +	host->card = NULL;
>  err:
>  	mmc_detach_bus(host);
> -	mmc_release_host(host);
>
>  	printk(KERN_ERR "%s: error %d whilst initialising MMC card\n",
>  		mmc_hostname(host), err);
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 49da4df..9fad37a 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -764,13 +764,17 @@ static void mmc_sd_attach_bus_ops(struct mmc_host *host)
>  /*
>   * Starting point for SD card init.
>   */
> -int mmc_attach_sd(struct mmc_host *host, u32 ocr)
> +int mmc_attach_sd(struct mmc_host *host)
>  {
>  	int err;
> +	u32 ocr;
>
>  	BUG_ON(!host);
>  	WARN_ON(!host->claimed);
>
> +	if((err = mmc_send_app_op_cond(host, 0, &ocr)))
> +		return err;
> +
>  	mmc_sd_attach_bus_ops(host);
>
>  	/*
> @@ -820,20 +824,20 @@ int mmc_attach_sd(struct mmc_host *host, u32 ocr)
>  		goto err;
>
>  	mmc_release_host(host);
> -
>  	err = mmc_add_card(host->card);
>  	return 0;
>
>  remove_card:
> +	mmc_release_host(host);
>  	mmc_remove_card(host->card);
>  	host->card = NULL;
>  	mmc_claim_host(host);
>  err:
>  	mmc_detach_bus(host);
> -	mmc_release_host(host);
>
>  	printk(KERN_ERR "%s: error %d whilst initialising SD card\n",
>  		mmc_hostname(host), err);
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index efef5f9..5d2f33d 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -690,15 +690,18 @@ static const struct mmc_bus_ops mmc_sdio_ops = {
>  /*
>   * Starting point for SDIO card init.
>   */
> -int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
> +int mmc_attach_sdio(struct mmc_host *host)
>  {
> -	int err;
> -	int i, funcs;
> +	int err, i, funcs;
> +	u32 ocr;
>  	struct mmc_card *card;
>
>  	BUG_ON(!host);
>  	WARN_ON(!host->claimed);
>
> +	if((err =mmc_send_io_op_cond(host, 0, &ocr)))
> +		return err;
> +
>  	mmc_attach_bus(host, &mmc_sdio_ops);
>
>  	/*
> @@ -769,12 +772,12 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
>  			pm_runtime_enable(&card->sdio_func[i]->dev);
>  	}
>
> -	mmc_release_host(host);
> -
>  	/*
>  	 * First add the card to the driver model...
>  	 */
> +	mmc_release_host(host);
>  	err = mmc_add_card(host->card);
> +	mmc_claim_host(host);
>  	if (err)
>  		goto remove_added;
>
> @@ -792,15 +795,17 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
>
>  remove_added:
>  	/* Remove without lock if the device has been added. */
> +	mmc_release_host(host);
>  	mmc_sdio_remove(host);
>  	mmc_claim_host(host);
>  remove:
>  	/* And with lock if it hasn't been added. */
> +	mmc_release_host(host);
>  	if (host->card)
>  		mmc_sdio_remove(host);
> +	mmc_claim_host(host);
>  err:
>  	mmc_detach_bus(host);
> -	mmc_release_host(host);
>
>  	printk(KERN_ERR "%s: error %d whilst initialising SDIO card\n",
>  		mmc_hostname(host), err);

Don't know why all these additions of claim/release?
In some cases it will lead to unnecessary releases, just because
later in the branch claim will be called.

I think in all 3 cases (sd/sdio/mmc) the change can be much simpler.
For instance for sd.c I would do this:

---
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 49da4df..18331eb
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -764,13 +764,17 @@ static void mmc_sd_attach_bus_ops(struct mmc_host *host)
 /*
  * Starting point for SD card init.
  */
-int mmc_attach_sd(struct mmc_host *host, u32 ocr)
+int mmc_attach_sd(struct mmc_host *host)
 {
 	int err;
+	u32 ocr;

 	BUG_ON(!host);
 	WARN_ON(!host->claimed);

+	if((err = mmc_send_app_op_cond(host, 0, &ocr)))
+		return err;
+
 	mmc_sd_attach_bus_ops(host);

 	/*
@@ -825,6 +829,7 @@ int mmc_attach_sd(struct mmc_host *host, u32 ocr)
 	if (err)
 		goto remove_card;

+	mmc_claim_host(host);
 	return 0;

 remove_card:
@@ -833,7 +838,6 @@ remove_card:
 	mmc_claim_host(host);
 err:
 	mmc_detach_bus(host);
-	mmc_release_host(host);

 	printk(KERN_ERR "%s: error %d whilst initialising SD card\n",
 		mmc_hostname(host), err);
--

Or in other words: add a claim before "return 0" and remove release
after "err".

In the next days I'll test your patch on my system, which also had
problems with the fixed 400 Khz. SD-cards will initialize at less
than 280 Khz.


Hein Tibosch
