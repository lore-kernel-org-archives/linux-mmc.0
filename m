From: Andy Ross <andy.ross@windriver.com>
Subject: Re: [PATCH] Fix sd/sdio/mmc initialization frequency retries
Date: Mon, 03 Jan 2011 10:36:56 -0800
Message-ID: <4D221748.5040701@windriver.com>
References: <4D1A1B19.8000902@windriver.com> <20101231044942.GC19122@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from li44-10.members.linode.com ([72.14.181.10]:35110 "EHLO
	plausible.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848Ab1ACSg7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Jan 2011 13:36:59 -0500
In-Reply-To: <20101231044942.GC19122@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Hein Tibosch <hein_tibosch@yahoo.es>, Pierre Ossman <pierre@ossman.eu>, Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, Matt Fleming <matt@console-pimps.org>

[Combined response to Chris and Hein, hope that's not too confusing.
And sorry about the delay, had to wait until this morning to have
access to my board to test.]

Chris Ball wrote:
> This patch doesn't apply against mmc-next, which makes it hard to review
> properly;

Yeah.  And you got the pre-checkpatch version too, thus the syntax
goofs.  Apologies, I do kernel stuff only occasionally.  New patch
below.   Applies and builds vs. mmc-next, tested on my board this
morning with the problematic eMMC device and a sdhc card.

> Let's leave these in -- I think we're depending on the side-effect
> of mmc_bus_put() clearing out host->bus_ops.  I'll check and submit
> a separate patch adding a comment there explaining what's going on.

OK, I put exactly that text in as a placeholder. :)

> Space after if, and perhaps let's use !mmc_attach_*() rather than ==
> 0 for brevity.  I guess we could also consider:
>     if (mmc_attach_sdio(host) && mmc_attach_sd(host) &&

Personally, I use the "== 0" syntax because my brain wants to read "!"
as a test for failure, not success.  But I'm fine with whatever.  I
didn't do the folded test though -- that not only flips my internal
sense of the boolean, it makes me think through the short circuit
behavior of "&&" in the transformed gauge.

Hein Tibosch wrote:
> Suppose f_min > 400 Khz, no initialization will ever take place?

Uh... yeah.  That's a bug.  Fixed in this version; I split out the
"try_freq" step so the loop contains only the frequency selection
logic.  Hopefully this is even clearer.

> The "else" after break is syntactically redundant, this would do the
> same:

Quibble: the else is *semantically* redundant. :)

The syntactic meaning of "if ... if" vs. "if ... else if" is
definitely different, and the only reason those two cases are
equivalent is because of the special behavior of the break statement
*inside* the if expressions.  I like mine for this reason (it's robust
against changes to the code inside the block), but I'm not the
maintainer.  Fixed.

> Don't know why all these additions of claim/release?  In some cases
> it will lead to unnecessary releases, just because later in the
> branch claim will be called.

It's voodoo, basically, because I didn't want to break something.  The
original code for these functions was called with the claim held, and
released it before returning.  This confused me terribly and made the
exit conditions complicated in mmc_rescan(), so I modified the
functions to hold the cookie across the call.

But some of the calls in the original were made after the release, so
I do an explicit release/claim around the calls that did *not* hold
the lock in the original because I wasn't sure what the assumptions
were.  I'm pretty sure it preserves the original semantics, but I'm
not expert enough to know whether it can be optimized.

Andy

>From 411a58a232e4266877d0af4840226661dd687474 Mon Sep 17 00:00:00 2001
From: Andy Ross <andy.ross@windriver.com>
Date: Mon, 3 Jan 2011 10:30:23 -0800
Subject: [PATCH] Fix sd/sdio/mmc initialization frequency retries

Rewrite and clean up mmc_rescan() to properly retry frequencies lower
than 400kHz.  Failures can happen both in sd_send_* calls and
mmc_attach_*.  Break out "mmc_rescan_try_freq" from the frequency
selection loop.  Symmetrize claim/release logic in mmc_attach_* API,
and move the sd_send_* calls there to make mmc_rescan easier to read.

Signed-off-by: Andy Ross <andy.ross@windriver.com>
---
 drivers/mmc/core/core.c |  124 +++++++++++++++--------------------------------
 drivers/mmc/core/core.h |    6 +-
 drivers/mmc/core/mmc.c  |   13 +++--
 drivers/mmc/core/sd.c   |   11 +++-
 drivers/mmc/core/sdio.c |   18 +++++--
 5 files changed, 71 insertions(+), 101 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a8e89f3..ef7f8cc 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1485,25 +1485,41 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 }
 EXPORT_SYMBOL(mmc_set_blocklen);

+static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
+{
+	host->f_init = freq;
+
+#ifdef CONFIG_MMC_DEBUG
+	pr_info("%s: %s: trying to init card at %u Hz\n",
+		mmc_hostname(host), __func__, host->f_init);
+#endif
+	mmc_power_up(host);
+	sdio_reset(host);
+	mmc_go_idle(host);
+
+	mmc_send_if_cond(host, host->ocr_avail);
+
+	/* Order's important: probe SDIO, then SD, then MMC */
+	if (!mmc_attach_sdio(host))
+		return 0;
+	if (!mmc_attach_sd(host))
+		return 0;
+	if (!mmc_attach_mmc(host))
+		return 0;
+
+	mmc_power_off(host);
+	return -EIO;
+}
+
 void mmc_rescan(struct work_struct *work)
 {
+	static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
 	struct mmc_host *host =
 		container_of(work, struct mmc_host, detect.work);
-	u32 ocr;
-	int err;
-	unsigned long flags;
 	int i;
-	const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
-
-	spin_lock_irqsave(&host->lock, flags);

-	if (host->rescan_disable) {
-		spin_unlock_irqrestore(&host->lock, flags);
+	if (host->rescan_disable)
 		return;
-	}
-
-	spin_unlock_irqrestore(&host->lock, flags);
-

 	mmc_bus_get(host);

@@ -1515,9 +1531,10 @@ void mmc_rescan(struct work_struct *work)
 	    && mmc_card_is_removable(host))
 		host->bus_ops->detect(host);

+	/* "Let's leave these in -- I think we're depending on the
+	 * side-effect of mmc_bus_put() clearing out host->bus_ops."
+	 * -cjb 2010-12-30 */
 	mmc_bus_put(host);
-
-
 	mmc_bus_get(host);

 	/* if there still is a card present, stop here */
@@ -1526,8 +1543,6 @@ void mmc_rescan(struct work_struct *work)
 		goto out;
 	}

-	/* detect a newly inserted card */
-
 	/*
 	 * Only we can add a new handler, so it's safe to
 	 * release the lock here.
@@ -1537,77 +1552,16 @@ void mmc_rescan(struct work_struct *work)
 	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
 		goto out;

+	mmc_claim_host(host);
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
-		mmc_claim_host(host);
-
-		if (freqs[i] >= host->f_min)
-			host->f_init = freqs[i];
-		else if (!i || freqs[i-1] > host->f_min)
-			host->f_init = host->f_min;
-		else {
-			mmc_release_host(host);
-			goto out;
-		}
-#ifdef CONFIG_MMC_DEBUG
-		pr_info("%s: %s: trying to init card at %u Hz\n",
-			mmc_hostname(host), __func__, host->f_init);
-#endif
-		mmc_power_up(host);
-		sdio_reset(host);
-		mmc_go_idle(host);
-
-		mmc_send_if_cond(host, host->ocr_avail);
-
-		/*
-		 * First we search for SDIO...
-		 */
-		err = mmc_send_io_op_cond(host, 0, &ocr);
-		if (!err) {
-			if (mmc_attach_sdio(host, ocr)) {
-				mmc_claim_host(host);
-				/*
-				 * Try SDMEM (but not MMC) even if SDIO
-				 * is broken.
-				 */
-				mmc_power_up(host);
-				sdio_reset(host);
-				mmc_go_idle(host);
-				mmc_send_if_cond(host, host->ocr_avail);
-
-				if (mmc_send_app_op_cond(host, 0, &ocr))
-					goto out_fail;
-
-				if (mmc_attach_sd(host, ocr))
-					mmc_power_off(host);
-			}
-			goto out;
-		}
-
-		/*
-		 * ...then normal SD...
-		 */
-		err = mmc_send_app_op_cond(host, 0, &ocr);
-		if (!err) {
-			if (mmc_attach_sd(host, ocr))
-				mmc_power_off(host);
-			goto out;
-		}
-
-		/*
-		 * ...and finally MMC.
-		 */
-		err = mmc_send_op_cond(host, 0, &ocr);
-		if (!err) {
-			if (mmc_attach_mmc(host, ocr))
-				mmc_power_off(host);
-			goto out;
-		}
-
-out_fail:
-		mmc_release_host(host);
-		mmc_power_off(host);
+		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
+			break;
+		if (freqs[i] < host->f_min)
+			break;
 	}
-out:
+	mmc_release_host(host);
+
+ out:
 	if (host->caps & MMC_CAP_NEEDS_POLL)
 		mmc_schedule_delayed_work(&host->detect, HZ);
 }
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 026c975..ca1fdde 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -57,9 +57,9 @@ void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);

-int mmc_attach_mmc(struct mmc_host *host, u32 ocr);
-int mmc_attach_sd(struct mmc_host *host, u32 ocr);
-int mmc_attach_sdio(struct mmc_host *host, u32 ocr);
+int mmc_attach_mmc(struct mmc_host *host);
+int mmc_attach_sd(struct mmc_host *host);
+int mmc_attach_sdio(struct mmc_host *host);

 /* Module parameters */
 extern int use_spi_crc;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c86dd73..16006ef 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -755,13 +755,18 @@ static void mmc_attach_bus_ops(struct mmc_host *host)
 /*
  * Starting point for MMC card init.
  */
-int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
+int mmc_attach_mmc(struct mmc_host *host)
 {
 	int err;
+	u32 ocr;

 	BUG_ON(!host);
 	WARN_ON(!host->claimed);

+	err = mmc_send_op_cond(host, 0, &ocr);
+	if (err)
+		return err;
+
 	mmc_attach_bus_ops(host);
 	if (host->ocr_avail_mmc)
 		host->ocr_avail = host->ocr_avail_mmc;
@@ -804,20 +809,20 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
 		goto err;

 	mmc_release_host(host);
-
 	err = mmc_add_card(host->card);
+	mmc_claim_host(host);
 	if (err)
 		goto remove_card;

 	return 0;

 remove_card:
+	mmc_release_host(host);
 	mmc_remove_card(host->card);
-	host->card = NULL;
 	mmc_claim_host(host);
+	host->card = NULL;
 err:
 	mmc_detach_bus(host);
-	mmc_release_host(host);

 	printk(KERN_ERR "%s: error %d whilst initialising MMC card\n",
 		mmc_hostname(host), err);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index de062eb..d18c32b 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -764,13 +764,18 @@ static void mmc_sd_attach_bus_ops(struct mmc_host *host)
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

+	err = mmc_send_app_op_cond(host, 0, &ocr);
+	if (err)
+		return err;
+
 	mmc_sd_attach_bus_ops(host);
 	if (host->ocr_avail_sd)
 		host->ocr_avail = host->ocr_avail_sd;
@@ -823,20 +828,20 @@ int mmc_attach_sd(struct mmc_host *host, u32 ocr)
 		goto err;

 	mmc_release_host(host);
-
 	err = mmc_add_card(host->card);
+	mmc_claim_host(host);
 	if (err)
 		goto remove_card;

 	return 0;

 remove_card:
+	mmc_release_host(host);
 	mmc_remove_card(host->card);
 	host->card = NULL;
 	mmc_claim_host(host);
 err:
 	mmc_detach_bus(host);
-	mmc_release_host(host);

 	printk(KERN_ERR "%s: error %d whilst initialising SD card\n",
 		mmc_hostname(host), err);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 82f4b90..5c4a54d 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -702,15 +702,19 @@ static const struct mmc_bus_ops mmc_sdio_ops = {
 /*
  * Starting point for SDIO card init.
  */
-int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
+int mmc_attach_sdio(struct mmc_host *host)
 {
-	int err;
-	int i, funcs;
+	int err, i, funcs;
+	u32 ocr;
 	struct mmc_card *card;

 	BUG_ON(!host);
 	WARN_ON(!host->claimed);

+	err = mmc_send_io_op_cond(host, 0, &ocr);
+	if (err)
+		return err;
+
 	mmc_attach_bus(host, &mmc_sdio_ops);
 	if (host->ocr_avail_sdio)
 		host->ocr_avail = host->ocr_avail_sdio;
@@ -783,12 +787,12 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 			pm_runtime_enable(&card->sdio_func[i]->dev);
 	}

-	mmc_release_host(host);
-
 	/*
 	 * First add the card to the driver model...
 	 */
+	mmc_release_host(host);
 	err = mmc_add_card(host->card);
+	mmc_claim_host(host);
 	if (err)
 		goto remove_added;

@@ -806,15 +810,17 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)

 remove_added:
 	/* Remove without lock if the device has been added. */
+	mmc_release_host(host);
 	mmc_sdio_remove(host);
 	mmc_claim_host(host);
 remove:
 	/* And with lock if it hasn't been added. */
+	mmc_release_host(host);
 	if (host->card)
 		mmc_sdio_remove(host);
+	mmc_claim_host(host);
 err:
 	mmc_detach_bus(host);
-	mmc_release_host(host);

 	printk(KERN_ERR "%s: error %d whilst initialising SDIO card\n",
 		mmc_hostname(host), err);
-- 
1.7.1

