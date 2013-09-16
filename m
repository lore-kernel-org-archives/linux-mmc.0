From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/7] mmc: core: Prevent violation of specs while initializing cards
Date: Mon, 16 Sep 2013 16:17:47 +0200
Message-ID: <1379341068-27097-7-git-send-email-ulf.hansson@linaro.org>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:36665 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab3IPOSS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2013 10:18:18 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so3078420lab.25
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2013 07:18:16 -0700 (PDT)
In-Reply-To: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

According to eMMC/SD/SDIO specs, the VDD (VCC) voltage level must be
maintained during the initialization sequence. If we want/need to tune
the voltage level, a complete power cycle of the card must be executed.

Most host drivers conforms to the specifications by only allowing to
change VDD voltage level at the MMC_POWER_UP state, but some also cares
about MMC_POWER_ON state, which they should'nt. This patch will not
break those drivers, but they could clean up code to better reflect
what is expected from the protocol layer.

A big re-work of the mmc_select_voltage function is done to only change
VDD voltage level if the host supports MMC_CAP2_FULL_PWR_CYCLE.
Otherwise only validation of the host and card ocr mask will be done.

A very nice side-effect of this patch is that we now don't need to
reset the negotiated ocr mask at the mmc_power_off function, since now
it will actually reflect the present voltage level, which safely can be
used at the next power up and re-initialization. Moreover, we then only
need to execute mmc_select_voltage from the attach sequence.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c |   31 +++++++++++--------------------
 drivers/mmc/core/mmc.c  |    1 -
 drivers/mmc/core/sd.c   |    1 -
 drivers/mmc/core/sdio.c |   17 ++---------------
 4 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4a1e3ca..0d89ccc 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1383,21 +1383,20 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 	int bit;
 
 	ocr &= host->ocr_avail;
+	if (!ocr) {
+		dev_warn(mmc_dev(host), "no support for card's volts\n");
+		return 0;
+	}
 
-	bit = ffs(ocr);
-	if (bit) {
-		bit -= 1;
-
+	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
+		bit = ffs(ocr) - 1;
 		ocr &= 3 << bit;
-
-		mmc_host_clk_hold(host);
-		host->ios.vdd = bit;
-		mmc_set_ios(host);
-		mmc_host_clk_release(host);
+		mmc_power_cycle(host, ocr);
 	} else {
-		pr_warning("%s: host doesn't support card's voltages\n",
-				mmc_hostname(host));
-		ocr = 0;
+		bit = fls(ocr) - 1;
+		ocr &= 3 << bit;
+		if (bit != host->ios.vdd)
+			dev_warn(mmc_dev(host), "exceeding card's volts\n");
 	}
 
 	return ocr;
@@ -1596,14 +1595,6 @@ void mmc_power_off(struct mmc_host *host)
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
-
-	/*
-	 * Reset ocr mask to be the highest possible voltage supported for
-	 * this card. This value will be used at next power up.
-	 */
-	if (host->card)
-		host->card->ocr = 1 << (fls(host->ocr_avail) - 1);
-
 	if (!mmc_host_is_spi(host)) {
 		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 		host->ios.chip_select = MMC_CS_DONTCARE;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index efc9f6f..9149eab 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1535,7 +1535,6 @@ static int mmc_resume(struct mmc_host *host)
 
 	mmc_claim_host(host);
 	mmc_power_up(host, host->card->ocr);
-	mmc_select_voltage(host, host->card->ocr);
 	err = mmc_init_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 398065c..53db60a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1103,7 +1103,6 @@ static int mmc_sd_resume(struct mmc_host *host)
 
 	mmc_claim_host(host);
 	mmc_power_up(host, host->card->ocr);
-	mmc_select_voltage(host, host->card->ocr);
 	err = mmc_sd_init_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
 
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index e0a135a..b7c19e8 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -987,7 +987,6 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	/* Restore power if needed */
 	if (!mmc_card_keep_power(host)) {
 		mmc_power_up(host, host->card->ocr);
-		mmc_select_voltage(host, host->card->ocr);
 		/*
 		 * Tell runtime PM core we just powered up the card,
 		 * since it still believes the card is powered off.
@@ -1045,7 +1044,6 @@ static int mmc_sdio_resume(struct mmc_host *host)
 static int mmc_sdio_power_restore(struct mmc_host *host)
 {
 	int ret;
-	u32 ocr, rocr;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
@@ -1067,28 +1065,17 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 	 * for OLPC SD8686 (which expects a [CMD5,5,3,7] init sequence), and
 	 * harmless in other situations.
 	 *
-	 * With these steps taken, mmc_select_voltage() is also required to
-	 * restore the correct voltage setting of the card.
 	 */
 
 	sdio_reset(host);
 	mmc_go_idle(host);
 	mmc_send_if_cond(host, host->ocr_avail);
 
-	ret = mmc_send_io_op_cond(host, 0, &ocr);
+	ret = mmc_send_io_op_cond(host, 0, NULL);
 	if (ret)
 		goto out;
 
-	if (host->ocr_avail_sdio)
-		host->ocr_avail = host->ocr_avail_sdio;
-
-	rocr = mmc_select_voltage(host, ocr & ~0x7F);
-	if (!rocr) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = mmc_sdio_init_card(host, rocr, host->card,
+	ret = mmc_sdio_init_card(host, host->card->ocr, host->card,
 				mmc_card_keep_power(host));
 	if (!ret && host->sdio_irqs)
 		mmc_signal_sdio_irq(host);
-- 
1.7.9.5

