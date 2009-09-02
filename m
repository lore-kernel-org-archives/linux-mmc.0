From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/4] [MMC] core SDIO suspend/resume support
Date: Wed, 02 Sep 2009 14:37:23 -0400
Message-ID: <1251916646-3537-2-git-send-email-nico@cam.org>
References: <1251916646-3537-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:47934 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbZIBSi7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2009 14:38:59 -0400
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KPC0068ZX3NZH50@VL-MO-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 02 Sep 2009 14:38:12 -0400 (EDT)
In-reply-to: <1251916646-3537-1-git-send-email-nico@cam.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Currently, all SDIO cards are virtually removed upon a suspend, and
completely reprobed upon a resume.  This adds the suspend and resume
methods to the SDIO bus driver so to be able to dispatch those events
to the actual SDIO function drivers for real suspend/resume instead.

All active functions on a card must have a driver with both a suspend
and a resume method though.  Failing that, we fall back to the current
behavior of simply "removing" the card when suspending.

When resuming, we make sure the same card is still inserted by comparing
the vendor and product IDs.  If there is a mismatch, or if there is simply
no card anymore in the slot, then the previous card is "removed" and the
new card is detected.

Signed-off-by: Nicolas Pitre <nico@marvell.com>
---
 drivers/mmc/core/sdio.c |  285 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 196 insertions(+), 89 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index fb99ccf..4c21b74 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -195,6 +195,134 @@ static int sdio_enable_hs(struct mmc_card *card)
 }
 
 /*
+ * Handle the detection and initialisation of a card.
+ *
+ * In the case of a resume, "oldcard" will contain the card
+ * we're trying to reinitialise.
+ */
+static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
+			      struct mmc_card *oldcard)
+{
+	struct mmc_card *card;
+	int err;
+
+	BUG_ON(!host);
+	WARN_ON(!host->claimed);
+
+	/*
+	 * Inform the card of the voltage
+	 */
+	err = mmc_send_io_op_cond(host, host->ocr, &ocr);
+	if (err)
+		goto err;
+
+	/*
+	 * For SPI, enable CRC as appropriate.
+	 */
+	if (mmc_host_is_spi(host)) {
+		err = mmc_spi_set_crc(host, use_spi_crc);
+		if (err)
+			goto err;
+	}
+
+	/*
+	 * Allocate card structure.
+	 */
+	card = mmc_alloc_card(host, NULL);
+	if (IS_ERR(card)) {
+		err = PTR_ERR(card);
+		goto err;
+	}
+
+	card->type = MMC_TYPE_SDIO;
+
+	/*
+	 * For native busses:  set card RCA and quit open drain mode.
+	 */
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_send_relative_addr(host, &card->rca);
+		if (err)
+			goto remove;
+
+		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+	}
+
+	/*
+	 * Select card, as all following commands rely on that.
+	 */
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_select_card(card);
+		if (err)
+			goto remove;
+	}
+
+	/*
+	 * Read the common registers.
+	 */
+	err = sdio_read_cccr(card);
+	if (err)
+		goto remove;
+
+	/*
+	 * Read the common CIS tuples.
+	 */
+	err = sdio_read_common_cis(card);
+	if (err)
+		goto remove;
+
+	if (oldcard) {
+		int same = (card->cis.vendor == oldcard->cis.vendor &&
+			    card->cis.device == oldcard->cis.device);
+		mmc_remove_card(card);
+		if (!same) {
+			err = -ENOENT;
+			goto err;
+		}
+		card = oldcard;
+	}
+
+	/*
+	 * Switch to high-speed (if supported).
+	 */
+	err = sdio_enable_hs(card);
+	if (err)
+		goto remove;
+
+	/*
+	 * Change to the card's maximum speed.
+	 */
+	if (mmc_card_highspeed(card)) {
+		/*
+		 * The SDIO specification doesn't mention how
+		 * the CIS transfer speed register relates to
+		 * high-speed, but it seems that 50 MHz is
+		 * mandatory.
+		 */
+		mmc_set_clock(host, 50000000);
+	} else {
+		mmc_set_clock(host, card->cis.max_dtr);
+	}
+
+	/*
+	 * Switch to wider bus (if supported).
+	 */
+	err = sdio_enable_wide(card);
+	if (err)
+		goto remove;
+
+	if (!oldcard)
+		host->card = card;
+	return 0;
+
+remove:
+	if (!oldcard)
+		mmc_remove_card(card);
+
+err:
+	return err;
+}
+
+/*
  * Host is being removed. Free up the current card.
  */
 static void mmc_sdio_remove(struct mmc_host *host)
@@ -243,10 +371,74 @@ static void mmc_sdio_detect(struct mmc_host *host)
 	}
 }
 
+/*
+ * SDIO suspend.  We need to suspend all functions separately.
+ * Therefore all registered functions must have drivers with suspend
+ * and resume methods.  Failing that we simply remove the whole card.
+ */
+static void mmc_sdio_suspend(struct mmc_host *host)
+{
+	int i;
+
+	/* make sure all registered functions can suspend/resume */
+	for (i = 0; i < host->card->sdio_funcs; i++) {
+		struct sdio_func *func = host->card->sdio_func[i];
+		if (func && sdio_func_present(func) && func->dev.driver) {
+			struct dev_pm_ops *pmops = func->dev.driver->pm;
+			if (!pmops || !pmops->suspend || !pmops->resume) {
+				/* just remove the entire card in that case */
+				mmc_sdio_remove(host);
+				mmc_claim_host(host);
+				mmc_detach_bus(host);
+				mmc_release_host(host);
+				return;
+			}
+		}
+	}
+
+	/* now suspend them */
+	for (i = 0; i < host->card->sdio_funcs; i++) {
+		struct sdio_func *func = host->card->sdio_func[i];
+		if (func && sdio_func_present(func) && func->dev.driver) {
+			struct dev_pm_ops *pmops = func->dev.driver->pm;
+			pmops->suspend(&func->dev);
+		}
+	}
+}
+
+static void mmc_sdio_resume(struct mmc_host *host)
+{
+	int i, err;
+
+	BUG_ON(!host);
+	BUG_ON(!host->card);
+
+	mmc_claim_host(host);
+	err = mmc_sdio_init_card(host, host->ocr, host->card);
+	mmc_release_host(host);
+	if (err) {
+		mmc_sdio_remove(host);
+		mmc_claim_host(host);
+		mmc_detach_bus(host);
+		mmc_release_host(host);
+		return;
+	}
+
+	/* resume all functions */
+	for (i = 0; i < host->card->sdio_funcs; i++) {
+		struct sdio_func *func = host->card->sdio_func[i];
+		if (func && sdio_func_present(func) && func->dev.driver) {
+			struct dev_pm_ops *pmops = func->dev.driver->pm;
+			pmops->resume(&func->dev);
+		}
+	}
+}
 
 static const struct mmc_bus_ops mmc_sdio_ops = {
 	.remove = mmc_sdio_remove,
 	.detect = mmc_sdio_detect,
+	.suspend = mmc_sdio_suspend,
+	.resume = mmc_sdio_resume,
 };
 
 
@@ -293,103 +485,18 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	}
 
 	/*
-	 * Inform the card of the voltage
+	 * Detect and init the card.
 	 */
-	err = mmc_send_io_op_cond(host, host->ocr, &ocr);
+	err = mmc_sdio_init_card(host, host->ocr, NULL);
 	if (err)
 		goto err;
-
-	/*
-	 * For SPI, enable CRC as appropriate.
-	 */
-	if (mmc_host_is_spi(host)) {
-		err = mmc_spi_set_crc(host, use_spi_crc);
-		if (err)
-			goto err;
-	}
+	card = host->card;
 
 	/*
 	 * The number of functions on the card is encoded inside
 	 * the ocr.
 	 */
-	funcs = (ocr & 0x70000000) >> 28;
-
-	/*
-	 * Allocate card structure.
-	 */
-	card = mmc_alloc_card(host, NULL);
-	if (IS_ERR(card)) {
-		err = PTR_ERR(card);
-		goto err;
-	}
-
-	card->type = MMC_TYPE_SDIO;
-	card->sdio_funcs = funcs;
-
-	host->card = card;
-
-	/*
-	 * For native busses:  set card RCA and quit open drain mode.
-	 */
-	if (!mmc_host_is_spi(host)) {
-		err = mmc_send_relative_addr(host, &card->rca);
-		if (err)
-			goto remove;
-
-		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
-	}
-
-	/*
-	 * Select card, as all following commands rely on that.
-	 */
-	if (!mmc_host_is_spi(host)) {
-		err = mmc_select_card(card);
-		if (err)
-			goto remove;
-	}
-
-	/*
-	 * Read the common registers.
-	 */
-	err = sdio_read_cccr(card);
-	if (err)
-		goto remove;
-
-	/*
-	 * Read the common CIS tuples.
-	 */
-	err = sdio_read_common_cis(card);
-	if (err)
-		goto remove;
-
-	/*
-	 * Switch to high-speed (if supported).
-	 */
-	err = sdio_enable_hs(card);
-	if (err)
-		goto remove;
-
-	/*
-	 * Change to the card's maximum speed.
-	 */
-	if (mmc_card_highspeed(card)) {
-		/*
-		 * The SDIO specification doesn't mention how
-		 * the CIS transfer speed register relates to
-		 * high-speed, but it seems that 50 MHz is
-		 * mandatory.
-		 */
-		mmc_set_clock(host, 50000000);
-	} else {
-		mmc_set_clock(host, card->cis.max_dtr);
-	}
-
-	/*
-	 * Switch to wider bus (if supported).
-	 */
-	err = sdio_enable_wide(card);
-	if (err)
-		goto remove;
+	card->sdio_funcs = funcs = (ocr & 0x70000000) >> 28;
 
 	/*
 	 * Initialize (but don't add) all present functions.
-- 
1.6.4.1.315.g5106d.dirty

