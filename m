From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: core: Remove redundant ->power_restore() callback for SD
Date: Mon,  1 Jun 2015 11:14:58 +0200
Message-ID: <1433150098-4995-2-git-send-email-ulf.hansson@linaro.org>
References: <1433150098-4995-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36701 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbbFAJPN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2015 05:15:13 -0400
Received: by lbbqq2 with SMTP id qq2so80192998lbb.3
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jun 2015 02:15:11 -0700 (PDT)
In-Reply-To: <1433150098-4995-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Since the ->reset() callback is implemented for SD, the ->power_restore()
callback has become redundant, let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index b99e25b..4e7366a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1164,21 +1164,10 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
-static int mmc_sd_power_restore(struct mmc_host *host)
-{
-	int ret;
-
-	mmc_claim_host(host);
-	ret = mmc_sd_init_card(host, host->card->ocr, host->card);
-	mmc_release_host(host);
-
-	return ret;
-}
-
 static int mmc_sd_reset(struct mmc_host *host)
 {
 	mmc_power_cycle(host, host->card->ocr);
-	return mmc_sd_power_restore(host);
+	return mmc_sd_init_card(host, host->card->ocr, host->card);
 }
 
 static const struct mmc_bus_ops mmc_sd_ops = {
@@ -1188,7 +1177,6 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.runtime_resume = mmc_sd_runtime_resume,
 	.suspend = mmc_sd_suspend,
 	.resume = mmc_sd_resume,
-	.power_restore = mmc_sd_power_restore,
 	.alive = mmc_sd_alive,
 	.shutdown = mmc_sd_suspend,
 	.reset = mmc_sd_reset,
-- 
1.9.1

