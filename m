From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH] mmc: core: reset sigal voltage on power up
Date: Tue, 10 Jul 2012 16:55:37 +0800
Message-ID: <1341910537-13647-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:11525
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752893Ab2GJJLM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 05:11:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Philip Rakity <prakity@marvell.com>, Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@amd.com>

Add a call to mmc_set_signal_voltage to set signal voltage to 3.3v in
mmc_power_up so that we do not need to touch signal voltage setting in
mmc/sd/sdio init functions and rescan function.

For mmc/sd cards, when doing a suspend/resume cycle, consider the unsafe
resume case, the card will lose its power and when powered on again, we
will set signal voltage to 3.3v in mmc_power_up before its resume function
gets called, which will re-init the card.

And for sdio cards, when doing a suspend/resume cycle, consider the unsafe
resume case, the card will either lose its power or not depending on if it
wants to wakeup the host. If power is not maintained, it is the same case as
mmc/sd cards. If power is maintained, mmc_power_up will not be called and
the card's signal voltage will remain at the last setting.

Signed-off-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/core/core.c | 6 +++---
 drivers/mmc/core/mmc.c  | 3 ---
 drivers/mmc/core/sd.c   | 3 ---
 drivers/mmc/core/sdio.c | 7 -------
 4 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9503cab..8ac5246 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1212,6 +1212,9 @@ static void mmc_power_up(struct mmc_host *host)
 	host->ios.timing = MMC_TIMING_LEGACY;
 	mmc_set_ios(host);
 
+	/* Set signal voltage to 3.3V */
+	mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, false);
+
 	/*
 	 * This delay should be sufficient to allow the power supply
 	 * to reach the minimum voltage.
@@ -1963,9 +1966,6 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	 */
 	mmc_hw_reset_for_init(host);
 
-	/* Initialization should be done at 3.3 V I/O voltage. */
-	mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
-
 	/*
 	 * sdio_reset sends CMD52 to reset card.  Since we do not know
 	 * if the card is being re-initialized, just send it.  CMD52
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4f4489a..396b258 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -818,9 +818,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (!mmc_host_is_spi(host))
 		mmc_set_bus_mode(host, MMC_BUSMODE_OPENDRAIN);
 
-	/* Initialization should be done at 3.3 V I/O voltage. */
-	mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
-
 	/*
 	 * Since we're changing the OCR value, we seem to
 	 * need to tell some cards to go back to the idle
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 312b78d..2182d92 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -892,9 +892,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
-	/* The initialization should be done at 3.3 V I/O voltage. */
-	mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
-
 	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
 	if (err)
 		return err;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 41c5fd8..d4619e2 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -591,9 +591,6 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * Inform the card of the voltage
 	 */
 	if (!powered_resume) {
-		/* The initialization should be done at 3.3 V I/O voltage. */
-		mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
-
 		err = mmc_send_io_op_cond(host, host->ocr, &ocr);
 		if (err)
 			goto err;
@@ -1006,10 +1003,6 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 	 * restore the correct voltage setting of the card.
 	 */
 
-	/* The initialization should be done at 3.3 V I/O voltage. */
-	if (!mmc_card_keep_power(host))
-		mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
-
 	sdio_reset(host);
 	mmc_go_idle(host);
 	mmc_send_if_cond(host, host->ocr_avail);
-- 
1.7.11.1.3.g4c8a9db


