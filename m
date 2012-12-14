From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 1/2] mmc: mmci: Convert to use mmc_regulator_get_supply
Date: Fri, 14 Dec 2012 15:30:28 +0100
Message-ID: <1355495429-12510-2-git-send-email-ulf.hansson@stericsson.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:57716 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753579Ab2LNObL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 09:31:11 -0500
In-Reply-To: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

By using the mmc_regulator_get_supply API we are able to do some
cleanups of the regulator code. Additionally let the regulator
API handle the error printing.

Cc: Chris Ball <cjb@laptop.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   54 ++++++++++-------------------------------------
 drivers/mmc/host/mmci.h |    1 -
 2 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index aa04b42..9da5f24 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1086,7 +1086,6 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct variant_data *variant = host->variant;
 	u32 pwr = 0;
 	unsigned long flags;
-	int ret;
 
 	pm_runtime_get_sync(mmc_dev(mmc));
 
@@ -1096,23 +1095,13 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
-		if (host->vcc)
-			ret = mmc_regulator_set_ocr(mmc, host->vcc, 0);
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 		break;
 	case MMC_POWER_UP:
-		if (host->vcc) {
-			ret = mmc_regulator_set_ocr(mmc, host->vcc, ios->vdd);
-			if (ret) {
-				dev_err(mmc_dev(mmc), "unable to set OCR\n");
-				/*
-				 * The .set_ios() function in the mmc_host_ops
-				 * struct return void, and failing to set the
-				 * power should be rare so we print an error
-				 * and return here.
-				 */
-				goto out;
-			}
-		}
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+
 		/*
 		 * The ST Micro variant doesn't have the PL180s MCI_PWR_UP
 		 * and instead uses MCI_PWR_ON so apply whatever value is
@@ -1161,7 +1150,6 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
- out:
 	pm_runtime_mark_last_busy(mmc_dev(mmc));
 	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
@@ -1384,29 +1372,13 @@ static int mmci_probe(struct amba_device *dev,
 	} else
 		dev_warn(&dev->dev, "could not get default pinstate\n");
 
-#ifdef CONFIG_REGULATOR
-	/* If we're using the regulator framework, try to fetch a regulator */
-	host->vcc = regulator_get(&dev->dev, "vmmc");
-	if (IS_ERR(host->vcc))
-		host->vcc = NULL;
-	else {
-		int mask = mmc_regulator_get_ocrmask(host->vcc);
-
-		if (mask < 0)
-			dev_err(&dev->dev, "error getting OCR mask (%d)\n",
-				mask);
-		else {
-			host->mmc->ocr_avail = (u32) mask;
-			if (plat->ocr_mask)
-				dev_warn(&dev->dev,
-				 "Provided ocr_mask/setpower will not be used "
-				 "(using regulator instead)\n");
-		}
-	}
-#endif
-	/* Fall back to platform data if no regulator is found */
-	if (host->vcc == NULL)
+	/* Get regulators and the supported OCR mask */
+	mmc_regulator_get_supply(mmc);
+	if (!mmc->ocr_avail)
 		mmc->ocr_avail = plat->ocr_mask;
+	else if (plat->ocr_mask)
+		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
+
 	mmc->caps = plat->capabilities;
 	mmc->caps2 = plat->capabilities2;
 
@@ -1585,10 +1557,6 @@ static int mmci_remove(struct amba_device *dev)
 		clk_disable_unprepare(host->clk);
 		clk_put(host->clk);
 
-		if (host->vcc)
-			mmc_regulator_set_ocr(mmc, host->vcc, 0);
-		regulator_put(host->vcc);
-
 		mmc_free_host(mmc);
 
 		amba_release_regions(dev);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index d34d8c0..a22213e 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -193,7 +193,6 @@ struct mmci_host {
 	/* pio stuff */
 	struct sg_mapping_iter	sg_miter;
 	unsigned int		size;
-	struct regulator	*vcc;
 
 	/* pinctrl handles */
 	struct pinctrl		*pinctrl;
-- 
1.7.10

