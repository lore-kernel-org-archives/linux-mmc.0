From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] MMCI enable the use of a regulator
Date: Thu, 17 Sep 2009 00:17:21 +0200
Message-ID: <1253139441-10596-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:41013 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754836AbZIPWRf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Sep 2009 18:17:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@stericsson.com>

This enables the use of a regulator to power the MMCI/PL180
PrimeCell. The OCR mask is calculated and voltage is set using
the new MMC core functions for discovering voltage ranges
in regulators. The platform translate_vdd function which basically
controls the 4 lines out of the PL180 is disabled if you use a
regulator instead.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   50 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/mmci.h |    1 +
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 79205e5..3d1e532 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -23,6 +23,7 @@
 #include <linux/scatterlist.h>
 #include <linux/gpio.h>
 #include <linux/amba/mmci.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/cacheflush.h>
 #include <asm/div64.h>
@@ -452,13 +453,28 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	u32 pwr = 0;
 	unsigned long flags;
 
-	if (host->plat->translate_vdd)
-		pwr |= host->plat->translate_vdd(mmc_dev(mmc), ios->vdd);
-
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
+		if(host->vcc &&
+		   regulator_is_enabled(host->vcc))
+			regulator_disable(host->vcc);
 		break;
 	case MMC_POWER_UP:
+#ifdef CONFIG_REGULATOR
+		if (host->vcc)
+			/* This implicitly enables the regulator */
+			mmc_regulator_set_ocr(host->vcc, ios->vdd);
+#endif
+		/*
+		 * The translate_vdd function is not used if you have
+		 * an external regulator, or your design is really weird.
+		 * Using it would mean sending in power control BOTH using
+		 * a regulator AND the 4 MMCIPWR bits. If we don't have
+		 * a regulator, we might have some other platform specific
+		 * power control behind this translate function.
+		 */
+		if (!host->vcc && host->plat->translate_vdd)
+			pwr |= host->plat->translate_vdd(mmc_dev(mmc), ios->vdd);
 		/* The ST version does not have this, fall through to POWER_ON */
 		if (host->hw_designer != AMBA_VENDOR_ST) {
 			pwr |= MCI_PWR_UP;
@@ -603,7 +619,29 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	mmc->ops = &mmci_ops;
 	mmc->f_min = (host->mclk + 511) / 512;
 	mmc->f_max = min(host->mclk, fmax);
-	mmc->ocr_avail = plat->ocr_mask;
+#ifdef CONFIG_REGULATOR
+	/* If we're using the regulator framework, try to fetch a regulator */
+	host->vcc = regulator_get(&dev->dev, "vmmc");
+	if (IS_ERR(host->vcc))
+		host->vcc = NULL;
+	else {
+		int mask = mmc_regulator_get_ocrmask(host->vcc);
+
+		if (mask < 0)
+			dev_err(&dev->dev, "error getting OCR mask (%d)\n",
+				mask);
+		else {
+			host->mmc->ocr_avail = (u32) mask;
+			if (plat->ocr_mask)
+				dev_warn(&dev->dev,
+				 "Provided ocr_mask/setpower will not be used "
+				 "(using regulator instead)\n");
+		}
+	}
+#endif
+	/* Fall back to platform data if no regulator is found */
+	if (host->vcc == NULL)
+		mmc->ocr_avail = plat->ocr_mask;
 	mmc->caps = plat->capabilities;
 
 	/*
@@ -741,6 +779,10 @@ static int __devexit mmci_remove(struct amba_device *dev)
 		clk_disable(host->clk);
 		clk_put(host->clk);
 
+		if (regulator_is_enabled(host->vcc))
+			regulator_disable(host->vcc);
+		regulator_put(host->vcc);
+
 		mmc_free_host(mmc);
 
 		amba_release_regions(dev);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index a7f9a51..1ceb9a9 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -175,6 +175,7 @@ struct mmci_host {
 	struct scatterlist	*sg_ptr;
 	unsigned int		sg_off;
 	unsigned int		size;
+	struct regulator	*vcc;
 };
 
 static inline void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
-- 
1.6.2.1

