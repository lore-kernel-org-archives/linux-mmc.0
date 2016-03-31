From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] Revert "mmc: core: Remove redundant ->power_restore() callback"
Date: Thu, 31 Mar 2016 13:25:31 -0700
Message-ID: <1459455931-19538-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36248 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791AbcCaUZv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2016 16:25:51 -0400
Received: by mail-pa0-f42.google.com with SMTP id tt10so73454796pab.3
        for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2016 13:25:50 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

This reverts commit 364549ddc29d ("mmc: core: Remove redundant
->power_restore() callback for MMC")
and commit 3056c49c35c1 ("mmc: core: Remove redundant
 ->power_restore() callback for SD")

->power_restore() is called by mmc_host_power_restore(). For MMC, We can
not use mmc_reset() instead, because the device may not have
RST_n_FUNCTION set up.
However we have to call mmc_init_card when we power back eMMC card,
and it is only possible through a call to ->power_restore().

For symmetry, also reinstantiate the function for SD.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mmc/core/mmc.c | 14 +++++++++++++-
 drivers/mmc/core/sd.c  | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index bf49e44..97fbe50 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1942,6 +1942,17 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
+static int mmc_power_restore(struct mmc_host *host)
+{
+	int ret;
+
+	mmc_claim_host(host);
+	ret = mmc_init_card(host, host->card->ocr, host->card);
+	mmc_release_host(host);
+
+	return ret;
+}
+
 int mmc_can_reset(struct mmc_card *card)
 {
 	u8 rst_n_function;
@@ -1970,7 +1981,7 @@ static int mmc_reset(struct mmc_host *host)
 	/* Set initial state and call mmc_set_ios */
 	mmc_set_initial_state(host);
 
-	return mmc_init_card(host, card->ocr, card);
+	return mmc_power_restore(host);
 }
 
 static const struct mmc_bus_ops mmc_ops = {
@@ -1980,6 +1991,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.resume = mmc_resume,
 	.runtime_suspend = mmc_runtime_suspend,
 	.runtime_resume = mmc_runtime_resume,
+	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
 	.reset = mmc_reset,
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index bb39a29..c7ee77d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1177,10 +1177,21 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
+static int mmc_sd_power_restore(struct mmc_host *host)
+{
+	int ret;
+
+	mmc_claim_host(host);
+	ret = mmc_sd_init_card(host, host->card->ocr, host->card);
+	mmc_release_host(host);
+
+	return ret;
+}
+
 static int mmc_sd_reset(struct mmc_host *host)
 {
 	mmc_power_cycle(host, host->card->ocr);
-	return mmc_sd_init_card(host, host->card->ocr, host->card);
+	return mmc_sd_power_restore(host);
 }
 
 static const struct mmc_bus_ops mmc_sd_ops = {
@@ -1190,6 +1201,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.runtime_resume = mmc_sd_runtime_resume,
 	.suspend = mmc_sd_suspend,
 	.resume = mmc_sd_resume,
+	.power_restore = mmc_sd_power_restore,
 	.alive = mmc_sd_alive,
 	.shutdown = mmc_sd_suspend,
 	.reset = mmc_sd_reset,
-- 
2.8.0.rc3.226.g39d4020

