From: dromede@gmail.com
Subject: [RFC][PATCH] pxamci: defining CONFIG_REGULATOR_DUMMY may break PXA MMC controller driver.
Date: Wed, 28 Nov 2012 23:08:38 +0100
Message-ID: <1354140518-13433-1-git-send-email-dromede@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61239 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663Ab2K1WKS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Nov 2012 17:10:18 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so6046816eek.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Nov 2012 14:10:17 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: drwyrm@gmail.com, broonie@opensource.wolfsonmicro.com, linux-mmc@vger.kernel.org, Marko Katic <dromede@gmail.com>

From: Marko Katic <dromede.gmail.com>

Here's an interesting scenario. The spitz machine has an
Intersil 6271A voltage regulator and an ADS7846 touchscreen
controller. The ADS7846 driver requires the use of the voltage regulator
or if not present, CONFIG_REGULATOR_DUMMY should be used for proper operation.
So to support both devices, CONFIG_REGULATOR and CONFIG REGULATOR_DUMMY have
to be defined.

However, enabling CONFIG_REGULATOR_DUMMY breaks pxamci in pxamci_init_ocr().
and pxamci_set_power() in the case when no vmmc regulator is present.

These functions don't handle the presence of a dummy regulator very well
since they expect a proper regulator when CONFIG_REGULATOR is defined or
no regulator at all. I've modified both to do more checking and to always
fall back to platform data if such data is present.

I should probably add some dev_warns somewhere, i would like some input
on that.

Signed-off-by: Marko Katic <dromede@gmail.com>
---
 drivers/mmc/host/pxamci.c |   36 ++++++++++++++++++++++--------------
 1 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index cb2dc0e..ffbf177 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -80,18 +80,24 @@ struct pxamci_host {
 static inline void pxamci_init_ocr(struct pxamci_host *host)
 {
 #ifdef CONFIG_REGULATOR
+	int ocr_mask;
 	host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
 
 	if (IS_ERR(host->vcc))
 		host->vcc = NULL;
 	else {
-		host->mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vcc);
-		if (host->pdata && host->pdata->ocr_mask)
+		ocr_mask = mmc_regulator_get_ocrmask(host->vcc);
+		if (ocr_mask <= 0)
+			host->mmc->ocr_avail = 0;
+		else
+			host->mmc->ocr_avail = ocr_mask;
+
+		if (host->pdata && host->pdata->ocr_mask && host->mmc->ocr_avail)
 			dev_warn(mmc_dev(host->mmc),
 				"ocr_mask/setpower will not be used\n");
 	}
 #endif
-	if (host->vcc == NULL) {
+	if (host->vcc == NULL || host->mmc->ocr_avail == 0) {
 		/* fall-back to platform data */
 		host->mmc->ocr_avail = host->pdata ?
 			host->pdata->ocr_mask :
@@ -104,27 +110,29 @@ static inline int pxamci_set_power(struct pxamci_host *host,
 				    unsigned int vdd)
 {
 	int on;
-
+
+#ifdef CONFIG_REGULATOR
 	if (host->vcc) {
-		int ret;
+		int ret = 0;
 
-		if (power_mode == MMC_POWER_UP) {
+		if (power_mode == MMC_POWER_UP)
 			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
-			if (ret)
-				return ret;
-		} else if (power_mode == MMC_POWER_OFF) {
+
+		if (power_mode == MMC_POWER_OFF)
 			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, 0);
-			if (ret)
-				return ret;
-		}
+
+		if (ret == 0)
+			return ret;
 	}
-	if (!host->vcc && host->pdata &&
+#endif
+
+	if (host->pdata &&
 	    gpio_is_valid(host->pdata->gpio_power)) {
 		on = ((1 << vdd) & host->pdata->ocr_mask);
 		gpio_set_value(host->pdata->gpio_power,
 			       !!on ^ host->pdata->gpio_power_invert);
 	}
-	if (!host->vcc && host->pdata && host->pdata->setpower)
+	if (host->pdata && host->pdata->setpower)
 		host->pdata->setpower(mmc_dev(host->mmc), vdd);
 
 	return 0;
-- 
1.7.4.1

