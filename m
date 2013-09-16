From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/7] mmc: core: Collect common code for card ocr validation
Date: Mon, 16 Sep 2013 16:17:48 +0200
Message-ID: <1379341068-27097-8-git-send-email-ulf.hansson@linaro.org>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:62765 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab3IPOSV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2013 10:18:21 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so4161016lbd.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2013 07:18:20 -0700 (PDT)
In-Reply-To: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

Since mmc_select_voltage now only gets called from the attach sequence,
it makes sense to move the out of spec validations of the card ocr into
this function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c |   10 ++++++++++
 drivers/mmc/core/mmc.c  |   11 -----------
 drivers/mmc/core/sd.c   |   19 -------------------
 drivers/mmc/core/sdio.c |   10 ----------
 4 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0d89ccc..5806bfc 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1382,6 +1382,16 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 {
 	int bit;
 
+	/*
+	 * Sanity check the voltages that the card claims to
+	 * support.
+	 */
+	if (ocr & 0x7F) {
+		dev_warn(mmc_dev(host),
+		"card claims to support voltages below defined range\n");
+		ocr &= ~0x7F;
+	}
+
 	ocr &= host->ocr_avail;
 	if (!ocr) {
 		dev_warn(mmc_dev(host), "no support for card's volts\n");
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 9149eab..69398f4 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1666,17 +1666,6 @@ int mmc_attach_mmc(struct mmc_host *host)
 			goto err;
 	}
 
-	/*
-	 * Sanity check the voltages that the card claims to
-	 * support.
-	 */
-	if (ocr & 0x7F) {
-		pr_warning("%s: card claims to support voltages "
-		       "below the defined range. These will be ignored.\n",
-		       mmc_hostname(host));
-		ocr &= ~0x7F;
-	}
-
 	rocr = mmc_select_voltage(host, ocr);
 
 	/*
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 53db60a..6ef84d0 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1231,25 +1231,6 @@ int mmc_attach_sd(struct mmc_host *host)
 			goto err;
 	}
 
-	/*
-	 * Sanity check the voltages that the card claims to
-	 * support.
-	 */
-	if (ocr & 0x7F) {
-		pr_warning("%s: card claims to support voltages "
-		       "below the defined range. These will be ignored.\n",
-		       mmc_hostname(host));
-		ocr &= ~0x7F;
-	}
-
-	if ((ocr & MMC_VDD_165_195) &&
-	    !(host->ocr_avail_sd & MMC_VDD_165_195)) {
-		pr_warning("%s: SD card claims to support the "
-		       "incompletely defined 'low voltage range'. This "
-		       "will be ignored.\n", mmc_hostname(host));
-		ocr &= ~MMC_VDD_165_195;
-	}
-
 	rocr = mmc_select_voltage(host, ocr);
 
 	/*
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b7c19e8..4d721c6 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1133,16 +1133,6 @@ int mmc_attach_sdio(struct mmc_host *host)
 	if (host->ocr_avail_sdio)
 		host->ocr_avail = host->ocr_avail_sdio;
 
-	/*
-	 * Sanity check the voltages that the card claims to
-	 * support.
-	 */
-	if (ocr & 0x7F) {
-		pr_warning("%s: card claims to support voltages "
-		       "below the defined range. These will be ignored.\n",
-		       mmc_hostname(host));
-		ocr &= ~0x7F;
-	}
 
 	rocr = mmc_select_voltage(host, ocr);
 
-- 
1.7.9.5

