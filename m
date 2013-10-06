From: Axel Lin <axel.lin@ingics.com>
Subject: Question about commit "mmc: core: Support aggressive power
 management for (e)MMC/SD"
Date: Sun, 06 Oct 2013 12:07:03 +0800
Message-ID: <1381032423.7156.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36488 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab3JFEHJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Oct 2013 00:07:09 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so5750068pdi.28
        for <linux-mmc@vger.kernel.org>; Sat, 05 Oct 2013 21:07:08 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Ulf,

While reading the code, I don't figure out why we need a nested mmc_claim_host
/mmc_release_host calls and additional mmc_power_off/mmc_power_up calls in
commit c4d770d72.

The implementation of mmc_suspend/mmc_resume and mmc_sd_suspend/mmc_sd_resume
already calls mmc_claim_host/mmc_release_host and mmc_power_off/mmc_power_up.

I don't have a hardware handy to test it at this moment.
I'm wondering if it still works with below diff:

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
 


