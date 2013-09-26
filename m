From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/27] mmc: dw_mmc: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:31 +0200
Message-ID: <1380207292-16968-7-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:45134 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab3IZOzX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 10:55:23 -0400
Received: by mail-ee0-f47.google.com with SMTP id d49so600362eek.6
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 07:55:21 -0700 (PDT)
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c |   21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0a6a512..4bce0de 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2696,23 +2696,6 @@ EXPORT_SYMBOL(dw_mci_remove);
  */
 int dw_mci_suspend(struct dw_mci *host)
 {
-	int i, ret = 0;
-
-	for (i = 0; i < host->num_slots; i++) {
-		struct dw_mci_slot *slot = host->slot[i];
-		if (!slot)
-			continue;
-		ret = mmc_suspend_host(slot->mmc);
-		if (ret < 0) {
-			while (--i >= 0) {
-				slot = host->slot[i];
-				if (slot)
-					mmc_resume_host(host->slot[i]->mmc);
-			}
-			return ret;
-		}
-	}
-
 	if (host->vmmc)
 		regulator_disable(host->vmmc);
 
@@ -2765,10 +2748,6 @@ int dw_mci_resume(struct dw_mci *host)
 			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
 			dw_mci_setup_bus(slot, true);
 		}
-
-		ret = mmc_resume_host(host->slot[i]->mmc);
-		if (ret < 0)
-			return ret;
 	}
 	return 0;
 }
-- 
1.7.9.5

