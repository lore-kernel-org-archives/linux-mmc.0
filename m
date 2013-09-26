From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/27] mmc: atmel-mci: Remove redundant suspend and resume callbacks
Date: Thu, 26 Sep 2013 16:54:26 +0200
Message-ID: <1380207292-16968-2-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:45803 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab3IZOzD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 10:55:03 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so630663eak.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 07:55:02 -0700 (PDT)
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>

Suspend and resume of cards are handled by the protocol layer and
consequently the mmc_suspend|resume_host APIs are marked as deprecated.

While moving away from using the deprecated APIs, there are nothing
left to be done for the suspend and resume callbacks, so remove them.

Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/atmel-mci.c |   61 ------------------------------------------
 1 file changed, 61 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 92c1877..2cbb451 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -255,7 +255,6 @@ struct atmel_mci_slot {
 #define ATMCI_CARD_PRESENT	0
 #define ATMCI_CARD_NEED_INIT	1
 #define ATMCI_SHUTDOWN		2
-#define ATMCI_SUSPENDED		3
 
 	int			detect_pin;
 	int			wp_pin;
@@ -2529,70 +2528,10 @@ static int __exit atmci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int atmci_suspend(struct device *dev)
-{
-	struct atmel_mci *host = dev_get_drvdata(dev);
-	int i;
-
-	 for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
-		struct atmel_mci_slot *slot = host->slot[i];
-		int ret;
-
-		if (!slot)
-			continue;
-		ret = mmc_suspend_host(slot->mmc);
-		if (ret < 0) {
-			while (--i >= 0) {
-				slot = host->slot[i];
-				if (slot
-				&& test_bit(ATMCI_SUSPENDED, &slot->flags)) {
-					mmc_resume_host(host->slot[i]->mmc);
-					clear_bit(ATMCI_SUSPENDED, &slot->flags);
-				}
-			}
-			return ret;
-		} else {
-			set_bit(ATMCI_SUSPENDED, &slot->flags);
-		}
-	}
-
-	return 0;
-}
-
-static int atmci_resume(struct device *dev)
-{
-	struct atmel_mci *host = dev_get_drvdata(dev);
-	int i;
-	int ret = 0;
-
-	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
-		struct atmel_mci_slot *slot = host->slot[i];
-		int err;
-
-		slot = host->slot[i];
-		if (!slot)
-			continue;
-		if (!test_bit(ATMCI_SUSPENDED, &slot->flags))
-			continue;
-		err = mmc_resume_host(slot->mmc);
-		if (err < 0)
-			ret = err;
-		else
-			clear_bit(ATMCI_SUSPENDED, &slot->flags);
-	}
-
-	return ret;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(atmci_pm, atmci_suspend, atmci_resume);
-
 static struct platform_driver atmci_driver = {
 	.remove		= __exit_p(atmci_remove),
 	.driver		= {
 		.name		= "atmel_mci",
-		.pm		= &atmci_pm,
 		.of_match_table	= of_match_ptr(atmci_dt_ids),
 	},
 };
-- 
1.7.9.5

