From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Keep host claimed while invoking mmc_power_off|up()
Date: Fri, 11 Sep 2015 14:41:55 +0200
Message-ID: <1441975315-30387-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34586 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbIKMmC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2015 08:42:02 -0400
Received: by lbbmp1 with SMTP id mp1so38906541lbb.1
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2015 05:42:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>

As mmc_claim_host() invokes pm_runtime_get_sync() for the mmc host device,
it's important that the host is kept claimed for *all* accesses to it via
the host_ops callbacks.

In some code paths for SDIO, particularly related to the PM support,
mmc_power_off|up() is invoked without keeping the host claimed. Let's fix
these.

Moreover, mmc_start|stop_host() also invokes mmc_power_off|up() without
claiming the host, let's fix these as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c |  6 ++++++
 drivers/mmc/core/sdio.c | 20 +++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0520064..ed5f4ad 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2631,10 +2631,14 @@ void mmc_start_host(struct mmc_host *host)
 	host->f_init = max(freqs[0], host->f_min);
 	host->rescan_disable = 0;
 	host->ios.power_mode = MMC_POWER_UNDEFINED;
+
+	mmc_claim_host(host);
 	if (host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)
 		mmc_power_off(host);
 	else
 		mmc_power_up(host, host->ocr_avail);
+	mmc_release_host(host);
+
 	mmc_gpiod_request_cd_irq(host);
 	_mmc_detect_change(host, 0, false);
 }
@@ -2672,7 +2676,9 @@ void mmc_stop_host(struct mmc_host *host)
 
 	BUG_ON(host->card);
 
+	mmc_claim_host(host);
 	mmc_power_off(host);
+	mmc_release_host(host);
 }
 
 int mmc_power_save_host(struct mmc_host *host)
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b91abed..95bc101 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -897,11 +897,10 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
  */
 static int mmc_sdio_suspend(struct mmc_host *host)
 {
-	if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
-		mmc_claim_host(host);
+	mmc_claim_host(host);
+
+	if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host))
 		sdio_disable_wide(host->card);
-		mmc_release_host(host);
-	}
 
 	if (!mmc_card_keep_power(host)) {
 		mmc_power_off(host);
@@ -910,6 +909,8 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 		mmc_retune_needed(host);
 	}
 
+	mmc_release_host(host);
+
 	return 0;
 }
 
@@ -1018,15 +1019,24 @@ out:
 static int mmc_sdio_runtime_suspend(struct mmc_host *host)
 {
 	/* No references to the card, cut the power to it. */
+	mmc_claim_host(host);
 	mmc_power_off(host);
+	mmc_release_host(host);
+
 	return 0;
 }
 
 static int mmc_sdio_runtime_resume(struct mmc_host *host)
 {
+	int ret;
+
 	/* Restore power and re-initialize. */
+	mmc_claim_host(host);
 	mmc_power_up(host, host->card->ocr);
-	return mmc_sdio_power_restore(host);
+	ret = mmc_sdio_power_restore(host);
+	mmc_release_host(host);
+
+	return ret;
 }
 
 static int mmc_sdio_reset(struct mmc_host *host)
-- 
1.9.1

