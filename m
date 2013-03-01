From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 1/3] mmc: core: Remove power_restore bus_ops for mmc and sd
Date: Fri, 1 Mar 2013 13:47:13 +0100
Message-ID: <1362142035-8403-2-git-send-email-ulf.hansson@stericsson.com>
References: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:48898 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709Ab3CAMsG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Mar 2013 07:48:06 -0500
In-Reply-To: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

The mmc_power_restore|save_host API is only used by SDIO func drivers. SDIO
func drivers are also moving towards use of runtime pm to accomplish the
the same operation and since this API is not used for mmc and sd it makes
sense to remove the corresponding bus_ops.

Moreover, at least for eMMC the mmc bus_ops is broken, since no consideration
is taken for mmc sleep and mmc power off notify.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c |   14 --------------
 drivers/mmc/core/sd.c  |   14 --------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c8f3d6e..edc6bc4 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1445,18 +1445,6 @@ static int mmc_resume(struct mmc_host *host)
 	return err;
 }
 
-static int mmc_power_restore(struct mmc_host *host)
-{
-	int ret;
-
-	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
-	mmc_claim_host(host);
-	ret = mmc_init_card(host, host->ocr, host->card);
-	mmc_release_host(host);
-
-	return ret;
-}
-
 static int mmc_sleep(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
@@ -1494,7 +1482,6 @@ static const struct mmc_bus_ops mmc_ops = {
 	.detect = mmc_detect,
 	.suspend = NULL,
 	.resume = NULL,
-	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
 };
 
@@ -1505,7 +1492,6 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.detect = mmc_detect,
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
-	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
 };
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 9e645e1..b71d906 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1095,24 +1095,11 @@ static int mmc_sd_resume(struct mmc_host *host)
 	return err;
 }
 
-static int mmc_sd_power_restore(struct mmc_host *host)
-{
-	int ret;
-
-	host->card->state &= ~MMC_STATE_HIGHSPEED;
-	mmc_claim_host(host);
-	ret = mmc_sd_init_card(host, host->ocr, host->card);
-	mmc_release_host(host);
-
-	return ret;
-}
-
 static const struct mmc_bus_ops mmc_sd_ops = {
 	.remove = mmc_sd_remove,
 	.detect = mmc_sd_detect,
 	.suspend = NULL,
 	.resume = NULL,
-	.power_restore = mmc_sd_power_restore,
 	.alive = mmc_sd_alive,
 };
 
@@ -1121,7 +1108,6 @@ static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
 	.detect = mmc_sd_detect,
 	.suspend = mmc_sd_suspend,
 	.resume = mmc_sd_resume,
-	.power_restore = mmc_sd_power_restore,
 	.alive = mmc_sd_alive,
 };
 
-- 
1.7.10

