From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH 4/6] mmc: sd: Add new CONFIG_MMC_PARANOID_SD_INIT for enabling retries during SD detection
Date: Fri, 22 Apr 2011 18:01:40 -0700
Message-ID: <1303520502-32171-5-git-send-email-john.stultz@linaro.org>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:36483 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757054Ab1DWBBz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 21:01:55 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3N0pCCb003108
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 20:51:12 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p3N11sfK081168
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 21:01:54 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p3ML1gxh025171
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 18:01:42 -0300
In-Reply-To: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: San Mehat <san@google.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Dima Zavin <dima@android.com>, John Stultz <john.stultz@linaro.org>

From: San Mehat <san@google.com>

CC: Chris Ball <cjb@laptop.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Dima Zavin <dima@android.com>
Signed-off-by: San Mehat <san@google.com>
[Add depends on EXPERIMENTAL -jstultz]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/mmc/core/Kconfig |    9 +++++++++
 drivers/mmc/core/sd.c    |   22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index ef10387..ffc671e 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -27,3 +27,12 @@ config MMC_CLKGATE
 	  support handling this in order for it to be of any use.
 
 	  If unsure, say N.
+
+config MMC_PARANOID_SD_INIT
+	bool "Enable paranoid SD card initialization (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  If you say Y here, the MMC layer will be extra paranoid
+	  about re-trying SD init requests. This can be a useful
+	  work-around for buggy controllers and hardware. Enable
+	  if you are experiencing issues with SD detection.
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6dac89f..c0f14cb 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -403,6 +403,9 @@ struct device_type sd_type = {
 int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
 {
 	int err;
+#ifdef CONFIG_MMC_PARANOID_SD_INIT
+	int retries;
+#endif
 
 	/*
 	 * Since we're changing the OCR value, we seem to
@@ -482,7 +485,26 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 		/*
 		 * Fetch switch information from card.
 		 */
+#ifdef CONFIG_MMC_PARANOID_SD_INIT
+		for (retries = 1; retries <= 3; retries++) {
+			err = mmc_read_switch(card);
+			if (!err) {
+				if (retries > 1) {
+					printk(KERN_WARNING
+					       "%s: recovered\n",
+					       mmc_hostname(host));
+				}
+				break;
+			} else {
+				printk(KERN_WARNING
+				       "%s: read switch failed (attempt %d)\n",
+				       mmc_hostname(host), retries);
+			}
+		}
+#else
 		err = mmc_read_switch(card);
+#endif
+
 		if (err)
 			return err;
 	}
-- 
1.7.3.2.146.gca209

