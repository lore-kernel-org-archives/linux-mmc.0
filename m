From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Remove redundant mmc_power_up|off at runtime callbacks
Date: Thu,  3 Oct 2013 11:59:38 +0200
Message-ID: <1380794378-4308-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:36740 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab3JCJ7n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2013 05:59:43 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so953611eaj.25
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2013 02:59:41 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Commit "mmc: core: Push common suspend|resume code into each bus_ops"
moved the responsibility for doing mmc_power_up|off into each
suspend/resume bus_ops. When using MMC_CAP_AGGRESSIVE_PM, through the
runtime callbacks, calls to mmc_power_up|off became redundant.

When removing them, we are also able to remove the calls to
mmc_claim|release_host, thus simplifing code a bit more.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c |   13 +------------
 drivers/mmc/core/sd.c  |   13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6d02012..f0dcc53 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1552,18 +1552,11 @@ static int mmc_runtime_suspend(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	mmc_claim_host(host);
-
 	err = mmc_suspend(host);
-	if (err) {
+	if (err)
 		pr_err("%s: error %d doing aggessive suspend\n",
 			mmc_hostname(host), err);
-		goto out;
-	}
-	mmc_power_off(host);
 
-out:
-	mmc_release_host(host);
 	return err;
 }
 
@@ -1577,15 +1570,11 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	mmc_claim_host(host);
-
-	mmc_power_up(host);
 	err = mmc_resume(host);
 	if (err)
 		pr_err("%s: error %d doing aggessive resume\n",
 			mmc_hostname(host), err);
 
-	mmc_release_host(host);
 	return 0;
 }
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 5e8823d..0f2a1f9 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1117,18 +1117,11 @@ static int mmc_sd_runtime_suspend(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	mmc_claim_host(host);
-
 	err = mmc_sd_suspend(host);
-	if (err) {
+	if (err)
 		pr_err("%s: error %d doing aggessive suspend\n",
 			mmc_hostname(host), err);
-		goto out;
-	}
-	mmc_power_off(host);
 
-out:
-	mmc_release_host(host);
 	return err;
 }
 
@@ -1142,15 +1135,11 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	mmc_claim_host(host);
-
-	mmc_power_up(host);
 	err = mmc_sd_resume(host);
 	if (err)
 		pr_err("%s: error %d doing aggessive resume\n",
 			mmc_hostname(host), err);
 
-	mmc_release_host(host);
 	return 0;
 }
 
-- 
1.7.9.5

