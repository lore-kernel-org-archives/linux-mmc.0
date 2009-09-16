From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 2/3] [MMC] propagate error codes back from bus drivers'
 suspend/resume methods
Date: Tue, 15 Sep 2009 23:51:48 -0400
Message-ID: <1253073109-13849-3-git-send-email-nico@fluxnic.net>
References: <1253073109-13849-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:61396 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbZIPDvu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2009 23:51:50 -0400
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQ100870PEFU890@VL-MO-MR001.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 15 Sep 2009 23:51:53 -0400 (EDT)
In-reply-to: <1253073109-13849-1-git-send-email-nico@fluxnic.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-mmc@vger.kernel.org

Especially for SDIO drivers which may have special conditions/errors
to report, it is a good thing to relay the returned error code back to
upper layers.

This also allows for the rationalization of the resume path where code
to "remove" a no-longer-existing or replaced card was duplicated into
the MMC, SD and SDIO bus drivers.

In the SDIO case, if a function suspend method returns an error, then
all previously suspended functions are resumed and the error returned.
An exception is made for -ENOSYS which the core interprets as "we don't
support suspend so just kick the card out for suspend and return success".

When resuming SDIO cards, the core code only validates the manufacturer
and product IDs to make sure the same kind of card is still present
before invoking functions resume methods.  It's the function driver's
responsibility to perform further tests to confirm that the actual same
card is present (same MAC address, etc.) and return an error otherwise.

Signed-off-by: Nicolas Pitre <nico@marvell.com>
---
 drivers/mmc/core/core.c |   35 ++++++++++++++++++++++++------
 drivers/mmc/core/core.h |    4 +-
 drivers/mmc/core/mmc.c  |   15 ++++--------
 drivers/mmc/core/sd.c   |   15 ++++--------
 drivers/mmc/core/sdio.c |   54 +++++++++++++++++++++++++---------------------
 5 files changed, 69 insertions(+), 54 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2649117..2853f58 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -958,27 +958,34 @@ void mmc_stop_host(struct mmc_host *host)
  */
 int mmc_suspend_host(struct mmc_host *host, pm_message_t state)
 {
+	int err = 0;
+
 	cancel_delayed_work(&host->detect);
 	mmc_flush_scheduled_work();
 
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
 		if (host->bus_ops->suspend)
-			host->bus_ops->suspend(host);
-		if (!host->bus_ops->resume) {
+			err = host->bus_ops->suspend(host);
+		if (err == -ENOSYS || !host->bus_ops->resume) {
+			/*
+			 * We simply "remove" the card in this case.
+			 * It will be redetected on resume.
+			 */
 			if (host->bus_ops->remove)
 				host->bus_ops->remove(host);
-
 			mmc_claim_host(host);
 			mmc_detach_bus(host);
 			mmc_release_host(host);
+			err = 0;
 		}
 	}
 	mmc_bus_put(host);
 
-	mmc_power_off(host);
+	if (!err)
+		mmc_power_off(host);
 
-	return 0;
+	return err;
 }
 
 EXPORT_SYMBOL(mmc_suspend_host);
@@ -989,12 +996,26 @@ EXPORT_SYMBOL(mmc_suspend_host);
  */
 int mmc_resume_host(struct mmc_host *host)
 {
+	int err = 0;
+
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
 		mmc_power_up(host);
 		mmc_select_voltage(host, host->ocr);
 		BUG_ON(!host->bus_ops->resume);
-		host->bus_ops->resume(host);
+		err = host->bus_ops->resume(host);
+		if (err) {
+			printk(KERN_WARNING "%s: error %d during resume "
+					    "(card was removed?)\n",
+					    mmc_hostname(host), err);
+			if (host->bus_ops->remove)
+				host->bus_ops->remove(host);
+			mmc_claim_host(host);
+			mmc_detach_bus(host);
+			mmc_release_host(host);
+			/* no need to bother upper layers */
+			err = 0;
+		}
 	}
 	mmc_bus_put(host);
 
@@ -1004,7 +1025,7 @@ int mmc_resume_host(struct mmc_host *host)
 	 */
 	mmc_detect_change(host, 1);
 
-	return 0;
+	return err;
 }
 
 EXPORT_SYMBOL(mmc_resume_host);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index c819eff..767d212 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -18,8 +18,8 @@
 struct mmc_bus_ops {
 	void (*remove)(struct mmc_host *);
 	void (*detect)(struct mmc_host *);
-	void (*suspend)(struct mmc_host *);
-	void (*resume)(struct mmc_host *);
+	int (*suspend)(struct mmc_host *);
+	int (*resume)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 06084db..188ae06 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -512,7 +512,7 @@ static void mmc_detect(struct mmc_host *host)
 /*
  * Suspend callback from host.
  */
-static void mmc_suspend(struct mmc_host *host)
+static int mmc_suspend(struct mmc_host *host)
 {
 	BUG_ON(!host);
 	BUG_ON(!host->card);
@@ -522,6 +522,8 @@ static void mmc_suspend(struct mmc_host *host)
 		mmc_deselect_cards(host);
 	host->card->state &= ~MMC_STATE_HIGHSPEED;
 	mmc_release_host(host);
+
+	return 0;
 }
 
 /*
@@ -530,7 +532,7 @@ static void mmc_suspend(struct mmc_host *host)
  * This function tries to determine if the same card is still present
  * and, if so, restore all state to it.
  */
-static void mmc_resume(struct mmc_host *host)
+static int mmc_resume(struct mmc_host *host)
 {
 	int err;
 
@@ -541,14 +543,7 @@ static void mmc_resume(struct mmc_host *host)
 	err = mmc_init_card(host, host->ocr, host->card);
 	mmc_release_host(host);
 
-	if (err) {
-		mmc_remove(host);
-
-		mmc_claim_host(host);
-		mmc_detach_bus(host);
-		mmc_release_host(host);
-	}
-
+	return err;
 }
 
 #else
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cd81c39..4539a46 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -566,7 +566,7 @@ static void mmc_sd_detect(struct mmc_host *host)
 /*
  * Suspend callback from host.
  */
-static void mmc_sd_suspend(struct mmc_host *host)
+static int mmc_sd_suspend(struct mmc_host *host)
 {
 	BUG_ON(!host);
 	BUG_ON(!host->card);
@@ -576,6 +576,8 @@ static void mmc_sd_suspend(struct mmc_host *host)
 		mmc_deselect_cards(host);
 	host->card->state &= ~MMC_STATE_HIGHSPEED;
 	mmc_release_host(host);
+
+	return 0;
 }
 
 /*
@@ -584,7 +586,7 @@ static void mmc_sd_suspend(struct mmc_host *host)
  * This function tries to determine if the same card is still present
  * and, if so, restore all state to it.
  */
-static void mmc_sd_resume(struct mmc_host *host)
+static int mmc_sd_resume(struct mmc_host *host)
 {
 	int err;
 
@@ -595,14 +597,7 @@ static void mmc_sd_resume(struct mmc_host *host)
 	err = mmc_sd_init_card(host, host->ocr, host->card);
 	mmc_release_host(host);
 
-	if (err) {
-		mmc_sd_remove(host);
-
-		mmc_claim_host(host);
-		mmc_detach_bus(host);
-		mmc_release_host(host);
-	}
-
+	return err;
 }
 
 #else
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4c21b74..7cc6517 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -279,6 +279,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 			goto err;
 		}
 		card = oldcard;
+		return 0;
 	}
 
 	/*
@@ -376,62 +377,65 @@ static void mmc_sdio_detect(struct mmc_host *host)
  * Therefore all registered functions must have drivers with suspend
  * and resume methods.  Failing that we simply remove the whole card.
  */
-static void mmc_sdio_suspend(struct mmc_host *host)
+static int mmc_sdio_suspend(struct mmc_host *host)
 {
-	int i;
+	int i, err = 0;
 
-	/* make sure all registered functions can suspend/resume */
 	for (i = 0; i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			struct dev_pm_ops *pmops = func->dev.driver->pm;
 			if (!pmops || !pmops->suspend || !pmops->resume) {
-				/* just remove the entire card in that case */
-				mmc_sdio_remove(host);
-				mmc_claim_host(host);
-				mmc_detach_bus(host);
-				mmc_release_host(host);
-				return;
-			}
+				/* force removal of entire card in that case */
+				err = -ENOSYS;
+			} else
+				err = pmops->suspend(&func->dev);
+			if (err)
+				break;
 		}
 	}
-
-	/* now suspend them */
-	for (i = 0; i < host->card->sdio_funcs; i++) {
+	while (err && --i >= 0) {
 		struct sdio_func *func = host->card->sdio_func[i];
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			struct dev_pm_ops *pmops = func->dev.driver->pm;
-			pmops->suspend(&func->dev);
+			pmops->resume(&func->dev);
 		}
 	}
+
+	return err;
 }
 
-static void mmc_sdio_resume(struct mmc_host *host)
+static int mmc_sdio_resume(struct mmc_host *host)
 {
 	int i, err;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
+	/* Basic card reinitialization. */
 	mmc_claim_host(host);
 	err = mmc_sdio_init_card(host, host->ocr, host->card);
 	mmc_release_host(host);
-	if (err) {
-		mmc_sdio_remove(host);
-		mmc_claim_host(host);
-		mmc_detach_bus(host);
-		mmc_release_host(host);
-		return;
-	}
 
-	/* resume all functions */
-	for (i = 0; i < host->card->sdio_funcs; i++) {
+	/*
+	 * If the card looked to be the same as before suspending, then
+	 * we proceed to resume all card functions.  If one of them returns
+	 * an error then we simply return that error to the core and the
+	 * card will be redetected as new.  It is the responsibility of
+	 * the function driver to perform further tests with the extra
+	 * knowledge it has of the card to confirm the card is indeed the
+	 * same as before suspending (same MAC address for network cards,
+	 * etc.) and return an error otherwise.
+	 */
+	for (i = 0; !err && i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			struct dev_pm_ops *pmops = func->dev.driver->pm;
-			pmops->resume(&func->dev);
+			err = pmops->resume(&func->dev);
 		}
 	}
+
+	return err;
 }
 
 static const struct mmc_bus_ops mmc_sdio_ops = {
-- 
1.6.5.rc0.164.g5f6b0

