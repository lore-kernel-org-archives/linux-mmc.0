From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/7] mmc: core: Move cached value of the negotiated ocr mask to card struct
Date: Mon, 16 Sep 2013 16:17:46 +0200
Message-ID: <1379341068-27097-6-git-send-email-ulf.hansson@linaro.org>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46285 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab3IPOSP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2013 10:18:15 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so4168394lbh.21
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2013 07:18:13 -0700 (PDT)
In-Reply-To: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

The negotiated ocr mask is directly related to the card. Once a card
gets removed, the mask shall be dropped. By moving the cache of the ocr
mask from the host struct to the card struct we have accomplished this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c  |    7 ++++---
 drivers/mmc/core/mmc.c   |   19 ++++++++++---------
 drivers/mmc/core/sd.c    |   22 ++++++++++++----------
 drivers/mmc/core/sdio.c  |   26 ++++++++++++++------------
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/host.h |    1 -
 6 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8f89e11..4a1e3ca 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1599,9 +1599,10 @@ void mmc_power_off(struct mmc_host *host)
 
 	/*
 	 * Reset ocr mask to be the highest possible voltage supported for
-	 * this mmc host. This value will be used at next power up.
+	 * this card. This value will be used at next power up.
 	 */
-	host->ocr = 1 << (fls(host->ocr_avail) - 1);
+	if (host->card)
+		host->card->ocr = 1 << (fls(host->ocr_avail) - 1);
 
 	if (!mmc_host_is_spi(host)) {
 		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
@@ -2575,7 +2576,7 @@ int mmc_power_restore_host(struct mmc_host *host)
 		return -EINVAL;
 	}
 
-	mmc_power_up(host, host->ocr);
+	mmc_power_up(host, host->card->ocr);
 	ret = host->bus_ops->power_restore(host);
 
 	mmc_bus_put(host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 56e1b04..efc9f6f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -934,6 +934,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			goto err;
 		}
 
+		card->ocr = ocr;
 		card->type = MMC_TYPE_MMC;
 		card->rca = 1;
 		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
@@ -1533,9 +1534,9 @@ static int mmc_resume(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	mmc_power_up(host, host->ocr);
-	mmc_select_voltage(host, host->ocr);
-	err = mmc_init_card(host, host->ocr, host->card);
+	mmc_power_up(host, host->card->ocr);
+	mmc_select_voltage(host, host->card->ocr);
+	err = mmc_init_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
 
 	return err;
@@ -1579,7 +1580,7 @@ static int mmc_runtime_resume(struct mmc_host *host)
 
 	mmc_claim_host(host);
 
-	mmc_power_up(host, host->ocr);
+	mmc_power_up(host, host->card->ocr);
 	err = mmc_resume(host);
 	if (err)
 		pr_err("%s: error %d doing aggessive resume\n",
@@ -1595,7 +1596,7 @@ static int mmc_power_restore(struct mmc_host *host)
 
 	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
 	mmc_claim_host(host);
-	ret = mmc_init_card(host, host->ocr, host->card);
+	ret = mmc_init_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
 
 	return ret;
@@ -1640,7 +1641,7 @@ static void mmc_attach_bus_ops(struct mmc_host *host)
 int mmc_attach_mmc(struct mmc_host *host)
 {
 	int err;
-	u32 ocr;
+	u32 ocr, rocr;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -1677,12 +1678,12 @@ int mmc_attach_mmc(struct mmc_host *host)
 		ocr &= ~0x7F;
 	}
 
-	host->ocr = mmc_select_voltage(host, ocr);
+	rocr = mmc_select_voltage(host, ocr);
 
 	/*
 	 * Can we support the voltage of the card?
 	 */
-	if (!host->ocr) {
+	if (!rocr) {
 		err = -EINVAL;
 		goto err;
 	}
@@ -1690,7 +1691,7 @@ int mmc_attach_mmc(struct mmc_host *host)
 	/*
 	 * Detect and init the card.
 	 */
-	err = mmc_init_card(host, host->ocr, NULL);
+	err = mmc_init_card(host, rocr, NULL);
 	if (err)
 		goto err;
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 5818887..398065c 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -721,6 +721,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	int err;
 	u32 max_current;
 	int retries = 10;
+	u32 pocr = ocr;
 
 try_again:
 	if (!retries) {
@@ -774,7 +775,7 @@ try_again:
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
-					host->ocr);
+					pocr);
 		if (err == -EAGAIN) {
 			retries--;
 			goto try_again;
@@ -936,6 +937,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		if (IS_ERR(card))
 			return PTR_ERR(card);
 
+		card->ocr = ocr;
 		card->type = MMC_TYPE_SD;
 		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
 	}
@@ -1100,9 +1102,9 @@ static int mmc_sd_resume(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	mmc_power_up(host, host->ocr);
-	mmc_select_voltage(host, host->ocr);
-	err = mmc_sd_init_card(host, host->ocr, host->card);
+	mmc_power_up(host, host->card->ocr);
+	mmc_select_voltage(host, host->card->ocr);
+	err = mmc_sd_init_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
 
 	return err;
@@ -1145,7 +1147,7 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 
 	mmc_claim_host(host);
 
-	mmc_power_up(host, host->ocr);
+	mmc_power_up(host, host->card->ocr);
 	err = mmc_sd_resume(host);
 	if (err)
 		pr_err("%s: error %d doing aggessive resume\n",
@@ -1161,7 +1163,7 @@ static int mmc_sd_power_restore(struct mmc_host *host)
 
 	host->card->state &= ~MMC_STATE_HIGHSPEED;
 	mmc_claim_host(host);
-	ret = mmc_sd_init_card(host, host->ocr, host->card);
+	ret = mmc_sd_init_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
 
 	return ret;
@@ -1206,7 +1208,7 @@ static void mmc_sd_attach_bus_ops(struct mmc_host *host)
 int mmc_attach_sd(struct mmc_host *host)
 {
 	int err;
-	u32 ocr;
+	u32 ocr, rocr;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -1249,12 +1251,12 @@ int mmc_attach_sd(struct mmc_host *host)
 		ocr &= ~MMC_VDD_165_195;
 	}
 
-	host->ocr = mmc_select_voltage(host, ocr);
+	rocr = mmc_select_voltage(host, ocr);
 
 	/*
 	 * Can we support the voltage(s) of the card(s)?
 	 */
-	if (!host->ocr) {
+	if (!rocr) {
 		err = -EINVAL;
 		goto err;
 	}
@@ -1262,7 +1264,7 @@ int mmc_attach_sd(struct mmc_host *host)
 	/*
 	 * Detect and init the card.
 	 */
-	err = mmc_sd_init_card(host, host->ocr, NULL);
+	err = mmc_sd_init_card(host, rocr, NULL);
 	if (err)
 		goto err;
 
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 9587d9f..e0a135a 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -594,6 +594,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	int err;
 	int retries = 10;
 	u32 rocr = 0;
+	u32 ocr_card = ocr;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -762,6 +763,7 @@ try_again:
 
 		card = oldcard;
 	}
+	card->ocr = ocr_card;
 	mmc_fixup_device(card, NULL);
 
 	if (card->type == MMC_TYPE_SD_COMBO) {
@@ -984,8 +986,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 
 	/* Restore power if needed */
 	if (!mmc_card_keep_power(host)) {
-		mmc_power_up(host, host->ocr);
-		mmc_select_voltage(host, host->ocr);
+		mmc_power_up(host, host->card->ocr);
+		mmc_select_voltage(host, host->card->ocr);
 		/*
 		 * Tell runtime PM core we just powered up the card,
 		 * since it still believes the card is powered off.
@@ -1003,7 +1005,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	if (mmc_card_is_removable(host) || !mmc_card_keep_power(host)) {
 		sdio_reset(host);
 		mmc_go_idle(host);
-		err = mmc_sdio_init_card(host, host->ocr, host->card,
+		err = mmc_sdio_init_card(host, host->card->ocr, host->card,
 					mmc_card_keep_power(host));
 	} else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
 		/* We may have switched to 1-bit mode during suspend */
@@ -1043,7 +1045,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 static int mmc_sdio_power_restore(struct mmc_host *host)
 {
 	int ret;
-	u32 ocr;
+	u32 ocr, rocr;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
@@ -1080,13 +1082,13 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 	if (host->ocr_avail_sdio)
 		host->ocr_avail = host->ocr_avail_sdio;
 
-	host->ocr = mmc_select_voltage(host, ocr & ~0x7F);
-	if (!host->ocr) {
+	rocr = mmc_select_voltage(host, ocr & ~0x7F);
+	if (!rocr) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = mmc_sdio_init_card(host, host->ocr, host->card,
+	ret = mmc_sdio_init_card(host, rocr, host->card,
 				mmc_card_keep_power(host));
 	if (!ret && host->sdio_irqs)
 		mmc_signal_sdio_irq(host);
@@ -1107,7 +1109,7 @@ static int mmc_sdio_runtime_suspend(struct mmc_host *host)
 static int mmc_sdio_runtime_resume(struct mmc_host *host)
 {
 	/* Restore power and re-initialize. */
-	mmc_power_up(host, host->ocr);
+	mmc_power_up(host, host->card->ocr);
 	return mmc_sdio_power_restore(host);
 }
 
@@ -1130,7 +1132,7 @@ static const struct mmc_bus_ops mmc_sdio_ops = {
 int mmc_attach_sdio(struct mmc_host *host)
 {
 	int err, i, funcs;
-	u32 ocr;
+	u32 ocr, rocr;
 	struct mmc_card *card;
 
 	BUG_ON(!host);
@@ -1155,12 +1157,12 @@ int mmc_attach_sdio(struct mmc_host *host)
 		ocr &= ~0x7F;
 	}
 
-	host->ocr = mmc_select_voltage(host, ocr);
+	rocr = mmc_select_voltage(host, ocr);
 
 	/*
 	 * Can we support the voltage(s) of the card(s)?
 	 */
-	if (!host->ocr) {
+	if (!rocr) {
 		err = -EINVAL;
 		goto err;
 	}
@@ -1168,7 +1170,7 @@ int mmc_attach_sdio(struct mmc_host *host)
 	/*
 	 * Detect and init the card.
 	 */
-	err = mmc_sdio_init_card(host, host->ocr, NULL, 0);
+	err = mmc_sdio_init_card(host, rocr, NULL, 0);
 	if (err)
 		goto err;
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 842de3e..2ebf743 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -240,6 +240,7 @@ struct mmc_part {
 struct mmc_card {
 	struct mmc_host		*host;		/* the host this device belongs to */
 	struct device		dev;		/* the device */
+	u32			ocr;		/* the current OCR setting */
 	unsigned int		rca;		/* relative card address of device */
 	unsigned int		type;		/* card type */
 #define MMC_TYPE_MMC		0		/* MMC card */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3b0c33a..1c91bbb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -309,7 +309,6 @@ struct mmc_host {
 	spinlock_t		lock;		/* lock for claim and bus ops */
 
 	struct mmc_ios		ios;		/* current io bus settings */
-	u32			ocr;		/* the current OCR setting */
 
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
-- 
1.7.9.5

