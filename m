From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/7] mmc: core: Cleanup code for setting ocr mask for SDIO
Date: Mon, 16 Sep 2013 16:17:45 +0200
Message-ID: <1379341068-27097-5-git-send-email-ulf.hansson@linaro.org>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:47141 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab3IPOSL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2013 10:18:11 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so4216137lbi.15
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2013 07:18:10 -0700 (PDT)
In-Reply-To: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

At several places in mmc_sdio_init_card function the cached mask in
host->ocr were being updated. To simplify code, we make use of an
local ocr parameter instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 26b1316..9587d9f 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -593,23 +593,27 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	struct mmc_card *card;
 	int err;
 	int retries = 10;
+	u32 rocr = 0;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
+	/* to query card if 1.8V signalling is supported */
+	if (mmc_host_uhs(host))
+		ocr |= R4_18V_PRESENT;
+
 try_again:
 	if (!retries) {
 		pr_warning("%s: Skipping voltage switch\n",
 				mmc_hostname(host));
 		ocr &= ~R4_18V_PRESENT;
-		host->ocr &= ~R4_18V_PRESENT;
 	}
 
 	/*
 	 * Inform the card of the voltage
 	 */
 	if (!powered_resume) {
-		err = mmc_send_io_op_cond(host, host->ocr, &ocr);
+		err = mmc_send_io_op_cond(host, ocr, &rocr);
 		if (err)
 			goto err;
 	}
@@ -632,8 +636,8 @@ try_again:
 		goto err;
 	}
 
-	if ((ocr & R4_MEMORY_PRESENT) &&
-	    mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid, NULL) == 0) {
+	if ((rocr & R4_MEMORY_PRESENT) &&
+	    mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 0) {
 		card->type = MMC_TYPE_SD_COMBO;
 
 		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
@@ -663,9 +667,9 @@ try_again:
 	 * systems that claim 1.8v signalling in fact do not support
 	 * it.
 	 */
-	if (!powered_resume && (ocr & R4_18V_PRESENT) && mmc_host_uhs(host)) {
+	if (!powered_resume && (rocr & ocr & R4_18V_PRESENT)) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
-					host->ocr);
+					ocr);
 		if (err == -EAGAIN) {
 			sdio_reset(host);
 			mmc_go_idle(host);
@@ -675,12 +679,10 @@ try_again:
 			goto try_again;
 		} else if (err) {
 			ocr &= ~R4_18V_PRESENT;
-			host->ocr &= ~R4_18V_PRESENT;
 		}
 		err = 0;
 	} else {
 		ocr &= ~R4_18V_PRESENT;
-		host->ocr &= ~R4_18V_PRESENT;
 	}
 
 	/*
@@ -1084,10 +1086,6 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 		goto out;
 	}
 
-	if (mmc_host_uhs(host))
-		/* to query card if 1.8V signalling is supported */
-		host->ocr |= R4_18V_PRESENT;
-
 	ret = mmc_sdio_init_card(host, host->ocr, host->card,
 				mmc_card_keep_power(host));
 	if (!ret && host->sdio_irqs)
@@ -1170,10 +1168,6 @@ int mmc_attach_sdio(struct mmc_host *host)
 	/*
 	 * Detect and init the card.
 	 */
-	if (mmc_host_uhs(host))
-		/* to query card if 1.8V signalling is supported */
-		host->ocr |= R4_18V_PRESENT;
-
 	err = mmc_sdio_init_card(host, host->ocr, NULL, 0);
 	if (err)
 		goto err;
-- 
1.7.9.5

