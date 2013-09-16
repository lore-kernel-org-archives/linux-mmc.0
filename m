From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/7] mmc: core: Let mmc_power_up|cycle take ocr as parameter
Date: Mon, 16 Sep 2013 16:17:42 +0200
Message-ID: <1379341068-27097-2-git-send-email-ulf.hansson@linaro.org>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:59592 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab3IPOSA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2013 10:18:00 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so3298746lab.28
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2013 07:17:59 -0700 (PDT)
In-Reply-To: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

As a step to fixup the setup of the negotiated ocr mask, we need the
mmc_power_up|cycle functions to take the ocr as a parameter.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c |   24 ++++++++----------------
 drivers/mmc/core/core.h |    4 ++--
 drivers/mmc/core/mmc.c  |    4 ++--
 drivers/mmc/core/sd.c   |    4 ++--
 drivers/mmc/core/sdio.c |    4 ++--
 5 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b9b9fb6..07e83c5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1504,7 +1504,7 @@ power_cycle:
 	if (err) {
 		pr_debug("%s: Signal voltage switch failed, "
 			"power cycling card\n", mmc_hostname(host));
-		mmc_power_cycle(host);
+		mmc_power_cycle(host, host->ocr);
 	}
 
 	mmc_host_clk_release(host);
@@ -1545,22 +1545,14 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
  * If a host does all the power sequencing itself, ignore the
  * initial MMC_POWER_UP stage.
  */
-void mmc_power_up(struct mmc_host *host)
+void mmc_power_up(struct mmc_host *host, u32 ocr)
 {
-	int bit;
-
 	if (host->ios.power_mode == MMC_POWER_ON)
 		return;
 
 	mmc_host_clk_hold(host);
 
-	/* If ocr is set, we use it */
-	if (host->ocr)
-		bit = ffs(host->ocr) - 1;
-	else
-		bit = fls(host->ocr_avail) - 1;
-
-	host->ios.vdd = bit;
+	host->ios.vdd = fls(ocr) - 1;
 	if (mmc_host_is_spi(host))
 		host->ios.chip_select = MMC_CS_HIGH;
 	else
@@ -1630,12 +1622,12 @@ void mmc_power_off(struct mmc_host *host)
 	mmc_host_clk_release(host);
 }
 
-void mmc_power_cycle(struct mmc_host *host)
+void mmc_power_cycle(struct mmc_host *host, u32 ocr)
 {
 	mmc_power_off(host);
 	/* Wait at least 1 ms according to SD spec */
 	mmc_delay(1);
-	mmc_power_up(host);
+	mmc_power_up(host, ocr);
 }
 
 /*
@@ -2334,7 +2326,7 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	pr_info("%s: %s: trying to init card at %u Hz\n",
 		mmc_hostname(host), __func__, host->f_init);
 #endif
-	mmc_power_up(host);
+	mmc_power_up(host, host->ocr_avail);
 
 	/*
 	 * Some eMMCs (with VCCQ always on) may not be reset after power up, so
@@ -2504,7 +2496,7 @@ void mmc_start_host(struct mmc_host *host)
 	if (host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)
 		mmc_power_off(host);
 	else
-		mmc_power_up(host);
+		mmc_power_up(host, host->ocr_avail);
 	mmc_detect_change(host, 0);
 }
 
@@ -2583,7 +2575,7 @@ int mmc_power_restore_host(struct mmc_host *host)
 		return -EINVAL;
 	}
 
-	mmc_power_up(host);
+	mmc_power_up(host, host->ocr);
 	ret = host->bus_ops->power_restore(host);
 
 	mmc_bus_put(host);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 5345d15..502769a 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -46,9 +46,9 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
-void mmc_power_up(struct mmc_host *host);
+void mmc_power_up(struct mmc_host *host, u32 ocr);
 void mmc_power_off(struct mmc_host *host);
-void mmc_power_cycle(struct mmc_host *host);
+void mmc_power_cycle(struct mmc_host *host, u32 ocr);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6d02012..56e1b04 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1533,7 +1533,7 @@ static int mmc_resume(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	mmc_power_up(host);
+	mmc_power_up(host, host->ocr);
 	mmc_select_voltage(host, host->ocr);
 	err = mmc_init_card(host, host->ocr, host->card);
 	mmc_release_host(host);
@@ -1579,7 +1579,7 @@ static int mmc_runtime_resume(struct mmc_host *host)
 
 	mmc_claim_host(host);
 
-	mmc_power_up(host);
+	mmc_power_up(host, host->ocr);
 	err = mmc_resume(host);
 	if (err)
 		pr_err("%s: error %d doing aggessive resume\n",
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 5e8823d..af55e9e 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1099,7 +1099,7 @@ static int mmc_sd_resume(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	mmc_power_up(host);
+	mmc_power_up(host, host->ocr);
 	mmc_select_voltage(host, host->ocr);
 	err = mmc_sd_init_card(host, host->ocr, host->card);
 	mmc_release_host(host);
@@ -1144,7 +1144,7 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 
 	mmc_claim_host(host);
 
-	mmc_power_up(host);
+	mmc_power_up(host, host->ocr);
 	err = mmc_sd_resume(host);
 	if (err)
 		pr_err("%s: error %d doing aggessive resume\n",
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 80d89cff..355c952 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -981,7 +981,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 
 	/* Restore power if needed */
 	if (!mmc_card_keep_power(host)) {
-		mmc_power_up(host);
+		mmc_power_up(host, host->ocr);
 		mmc_select_voltage(host, host->ocr);
 		/*
 		 * Tell runtime PM core we just powered up the card,
@@ -1108,7 +1108,7 @@ static int mmc_sdio_runtime_suspend(struct mmc_host *host)
 static int mmc_sdio_runtime_resume(struct mmc_host *host)
 {
 	/* Restore power and re-initialize. */
-	mmc_power_up(host);
+	mmc_power_up(host, host->ocr);
 	return mmc_sdio_power_restore(host);
 }
 
-- 
1.7.9.5

