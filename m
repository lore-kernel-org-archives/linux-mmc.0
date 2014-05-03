From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] mmc: mxcmmc: Use mmc_regulator_get_supply() API
Date: Sat,  3 May 2014 10:55:17 +0400
Message-ID: <1399100117-6978-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:50045 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaECGzh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 3 May 2014 02:55:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Shiyan <shc_work@mail.ru>

This patch replaces regulator manipulation with
mmc_regulator_get_supply() function from MMC core.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/mmc/host/mxcmmc.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 86401c0..ed1cb93 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -153,8 +153,6 @@ struct mxcmci_host {
 	struct work_struct	datawork;
 	spinlock_t		lock;
 
-	struct regulator	*vcc;
-
 	int			burstlen;
 	int			dmareq;
 	struct dma_slave_config dma_slave_config;
@@ -240,30 +238,15 @@ static inline void mxcmci_writew(struct mxcmci_host *host, u16 val, int reg)
 
 static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
 
-static void mxcmci_init_ocr(struct mxcmci_host *host)
+static void mxcmci_set_power(struct mxcmci_host *host, unsigned int vdd)
 {
-	host->vcc = devm_regulator_get(mmc_dev(host->mmc), "vmmc");
-	if (IS_ERR(host->vcc)) {
-		if (host->pdata && host->pdata->ocr_avail)
-			host->mmc->ocr_avail = host->pdata->ocr_avail;
-		else
-			host->mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-	} else {
-		host->mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vcc);
-		if (host->pdata && host->pdata->ocr_avail)
-			dev_warn(mmc_dev(host->mmc),
-				"pdata->ocr_avail will not be used\n");
-	}
-}
-
-static void mxcmci_set_power(struct mxcmci_host *host, unsigned char power_mode,
-			     unsigned int vdd)
-{
-	if (!IS_ERR(host->vcc)) {
-		if (power_mode == MMC_POWER_UP)
-			mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
-		else if (power_mode == MMC_POWER_OFF)
-			mmc_regulator_set_ocr(host->mmc, host->vcc, 0);
+	if (!IS_ERR(host->mmc->supply.vmmc)) {
+		if (host->power_mode == MMC_POWER_UP)
+			mmc_regulator_set_ocr(host->mmc,
+					      host->mmc->supply.vmmc, vdd);
+		else if (host->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(host->mmc,
+					      host->mmc->supply.vmmc, 0);
 	}
 
 	if (host->pdata && host->pdata->setpower)
@@ -902,8 +885,8 @@ static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->cmdat &= ~CMD_DAT_CONT_BUS_WIDTH_4;
 
 	if (host->power_mode != ios->power_mode) {
-		mxcmci_set_power(host, ios->power_mode, ios->vdd);
 		host->power_mode = ios->power_mode;
+		mxcmci_set_power(host, ios->vdd);
 
 		if (ios->power_mode == MMC_POWER_ON)
 			host->cmdat |= CMD_DAT_CONT_INIT;
@@ -1100,7 +1083,14 @@ static int mxcmci_probe(struct platform_device *pdev)
 			&& !of_property_read_bool(pdev->dev.of_node, "cd-gpios"))
 		dat3_card_detect = true;
 
-	mxcmci_init_ocr(host);
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret) {
+		if (pdata && ret != -EPROBE_DEFER)
+			mmc->ocr_avail = pdata->ocr_avail ? :
+				MMC_VDD_32_33 | MMC_VDD_33_34;
+		else
+			goto out_free;
+	}
 
 	if (dat3_card_detect)
 		host->default_irq_mask =
-- 
1.8.3.2

