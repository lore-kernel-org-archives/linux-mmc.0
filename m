From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/4] mmc: core: Remove redundant mmc_power_up|off at runtime callbacks
Date: Fri, 11 Oct 2013 14:28:16 +0200
Message-ID: <1381494498-16699-3-git-send-email-ulf.hansson@linaro.org>
References: <1381494498-16699-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:63659 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371Ab3JKM2o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Oct 2013 08:28:44 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so3291898lab.4
        for <linux-mmc@vger.kernel.org>; Fri, 11 Oct 2013 05:28:43 -0700 (PDT)
In-Reply-To: <1381494498-16699-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Colin Cross <ccross@android.com>, Android Kernel Team <kernel-team@android.com>, John Stultz <john.stultz@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

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
index f7722d2..907f0a0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1575,18 +1575,11 @@ static int mmc_runtime_suspend(struct mmc_host *host)
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
 
@@ -1600,15 +1593,11 @@ static int mmc_runtime_resume(struct mmc_host *host)
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
index ef302f3..2287ceb 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1130,18 +1130,11 @@ static int mmc_sd_runtime_suspend(struct mmc_host *host)
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
 
@@ -1155,15 +1148,11 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
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

