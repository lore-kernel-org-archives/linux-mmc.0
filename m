From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH 6/6] mmc: sd: Add retries in re-detection
Date: Fri, 22 Apr 2011 18:01:42 -0700
Message-ID: <1303520502-32171-7-git-send-email-john.stultz@linaro.org>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:60716 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757118Ab1DWBB7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2011 21:01:59 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3N0nipm000693
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 18:49:44 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id p3N11ttH125688
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 19:01:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p3N11QtB030980
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 19:01:28 -0600
In-Reply-To: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: San Mehat <san@android.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Dima Zavin <dima@android.com>, John Stultz <john.stultz@linaro.org>

From: San Mehat <san@android.com>

Signed-off-by: San Mehat <san@android.com>

mmc: sd: Remove debugging printk

CC: Chris Ball <cjb@laptop.org>
CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dima Zavin <dima@android.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/mmc/core/sd.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 7b6cab2..24e1a85 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -403,9 +403,6 @@ struct device_type sd_type = {
 int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
 {
 	int err;
-#ifdef CONFIG_MMC_PARANOID_SD_INIT
-	int retries;
-#endif
 
 	/*
 	 * Since we're changing the OCR value, we seem to
@@ -459,6 +456,9 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	bool reinit)
 {
 	int err;
+#ifdef CONFIG_MMC_PARANOID_SD_INIT
+	int retries;
+#endif
 
 	if (!reinit) {
 		/*
@@ -685,7 +685,10 @@ static void mmc_sd_remove(struct mmc_host *host)
  */
 static void mmc_sd_detect(struct mmc_host *host)
 {
-	int err;
+	int err = 0;
+#ifdef CONFIG_MMC_PARANOID_SD_INIT
+        int retries = 5;
+#endif
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
@@ -695,8 +698,23 @@ static void mmc_sd_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
+#ifdef CONFIG_MMC_PARANOID_SD_INIT
+	while(retries) {
+		err = mmc_send_status(host->card, NULL);
+		if (err) {
+			retries--;
+			udelay(5);
+			continue;
+		}
+		break;
+	}
+	if (!retries) {
+		printk(KERN_ERR "%s(%s): Unable to re-detect card (%d)\n",
+		       __func__, mmc_hostname(host), err);
+	}
+#else
 	err = mmc_send_status(host->card, NULL);
-
+#endif
 	mmc_release_host(host);
 
 	if (err) {
@@ -810,6 +828,9 @@ int mmc_attach_sd(struct mmc_host *host)
 {
 	int err;
 	u32 ocr;
+#ifdef CONFIG_MMC_PARANOID_SD_INIT
+	int retries;
+#endif
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -865,9 +886,27 @@ int mmc_attach_sd(struct mmc_host *host)
 	/*
 	 * Detect and init the card.
 	 */
+#ifdef CONFIG_MMC_PARANOID_SD_INIT
+	retries = 5;
+	while (retries) {
+		err = mmc_sd_init_card(host, host->ocr, NULL);
+		if (err) {
+			retries--;
+			continue;
+		}
+		break;
+	}
+
+	if (!retries) {
+		printk(KERN_ERR "%s: mmc_sd_init_card() failure (err = %d)\n",
+		       mmc_hostname(host), err);
+		goto err;
+	}
+#else
 	err = mmc_sd_init_card(host, host->ocr, NULL);
 	if (err)
 		goto err;
+#endif
 
 	mmc_release_host(host);
 	err = mmc_add_card(host->card);
-- 
1.7.3.2.146.gca209

