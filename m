From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH 5/6] mmc: sd: When resuming, try a little harder to init the card
Date: Fri, 22 Apr 2011 18:01:41 -0700
Message-ID: <1303520502-32171-6-git-send-email-john.stultz@linaro.org>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:43611 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161Ab1DWBB7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2011 21:01:59 -0400
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3N0on0P029026
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 18:50:49 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p3N11sBD114056
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 19:01:54 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p3N11rWr019713
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 19:01:54 -0600
In-Reply-To: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: San Mehat <san@android.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Dima Zavin <dima@android.com>, John Stultz <john.stultz@linaro.org>

From: San Mehat <san@android.com>

CC: Chris Ball <cjb@laptop.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Dima Zavin <dima@android.com>
Signed-off-by: San Mehat <san@android.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/mmc/core/sd.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c0f14cb..7b6cab2 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -734,12 +734,31 @@ static int mmc_sd_suspend(struct mmc_host *host)
 static int mmc_sd_resume(struct mmc_host *host)
 {
 	int err;
+#ifdef CONFIG_MMC_PARANOID_SD_INIT
+	int retries;
+#endif
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
+#ifdef CONFIG_MMC_PARANOID_SD_INIT
+	retries = 5;
+	while (retries) {
+		err = mmc_sd_init_card(host, host->ocr, host->card);
+
+		if (err) {
+			printk(KERN_ERR "%s: Re-init card rc = %d (retries = %d)\n",
+			       mmc_hostname(host), err, retries);
+			mdelay(5);
+			retries--;
+			continue;
+		}
+		break;
+	}
+#else
 	err = mmc_sd_init_card(host, host->ocr, host->card);
+#endif
 	mmc_release_host(host);
 
 	return err;
-- 
1.7.3.2.146.gca209

