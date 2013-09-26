From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 12/27] mmc: tifm_sd: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:37 +0200
Message-ID: <1380207292-16968-13-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:54581 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab3IZOzj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 10:55:39 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so598355eaj.26
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 07:55:38 -0700 (PDT)
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alex Dubov <oakad@yahoo.com>

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Alex Dubov <oakad@yahoo.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tifm_sd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index 43d9628..d1760eb 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -1030,7 +1030,7 @@ static void tifm_sd_remove(struct tifm_dev *sock)
 
 static int tifm_sd_suspend(struct tifm_dev *sock, pm_message_t state)
 {
-	return mmc_suspend_host(tifm_get_drvdata(sock));
+	return 0;
 }
 
 static int tifm_sd_resume(struct tifm_dev *sock)
@@ -1044,8 +1044,6 @@ static int tifm_sd_resume(struct tifm_dev *sock)
 
 	if (rc)
 		host->eject = 1;
-	else
-		rc = mmc_resume_host(mmc);
 
 	return rc;
 }
-- 
1.7.9.5

