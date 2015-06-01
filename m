From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: core: Remove redundant ->power_restore() callback for MMC
Date: Mon,  1 Jun 2015 11:14:57 +0200
Message-ID: <1433150098-4995-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:33513 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbbFAJPL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2015 05:15:11 -0400
Received: by labpy14 with SMTP id py14so84731212lab.0
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jun 2015 02:15:09 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Since the ->reset() callback is implemented for MMC, the ->power_restore()
callback has become redundant, let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e519e31..e726903 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1910,17 +1910,6 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
-static int mmc_power_restore(struct mmc_host *host)
-{
-	int ret;
-
-	mmc_claim_host(host);
-	ret = mmc_init_card(host, host->card->ocr, host->card);
-	mmc_release_host(host);
-
-	return ret;
-}
-
 int mmc_can_reset(struct mmc_card *card)
 {
 	u8 rst_n_function;
@@ -1958,7 +1947,7 @@ static int mmc_reset(struct mmc_host *host)
 	mmc_set_initial_state(host);
 	mmc_host_clk_release(host);
 
-	return mmc_power_restore(host);
+	return mmc_init_card(host, card->ocr, card);
 }
 
 static const struct mmc_bus_ops mmc_ops = {
@@ -1968,7 +1957,6 @@ static const struct mmc_bus_ops mmc_ops = {
 	.resume = mmc_resume,
 	.runtime_suspend = mmc_runtime_suspend,
 	.runtime_resume = mmc_runtime_resume,
-	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
 	.reset = mmc_reset,
-- 
1.9.1

