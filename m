From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 6/6] mmc: mxs: use mmc_of_parse to parse devicetree properties
Date: Thu,  5 Dec 2013 14:34:51 +0100
Message-ID: <1386250491-4708-7-git-send-email-s.hauer@pengutronix.de>
References: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49787 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab3LENfK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 08:35:10 -0500
In-Reply-To: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

Use generic helper function. This also adds support for the cd-gpios and
max-frequency devicetree properties.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/mxs-mmc.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 13016e2..073e871 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -76,7 +76,11 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 {
 	struct mxs_mmc_host *host = mmc_priv(mmc);
 	struct mxs_ssp *ssp = &host->ssp;
-	int present;
+	int present, ret;
+
+	ret = mmc_gpio_get_cd(mmc);
+	if (ret >= 0)
+		return ret;
 
 	present = !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
 			BM_SSP_STATUS_CARD_DETECT);
@@ -564,15 +568,12 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
 			of_match_device(mxs_mmc_dt_ids, &pdev->dev);
-	struct device_node *np = pdev->dev.of_node;
 	struct mxs_mmc_host *host;
 	struct mmc_host *mmc;
 	struct resource *iores;
-	int ret = 0, irq_err, gpio;
+	int ret = 0, irq_err;
 	struct regulator *reg_vmmc;
-	enum of_gpio_flags flags;
 	struct mxs_ssp *ssp;
-	u32 bus_width = 0;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq_err = platform_get_irq(pdev, 0);
@@ -633,29 +634,13 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
 		    MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL;
 
-	of_property_read_u32(np, "bus-width", &bus_width);
-	if (bus_width == 4)
-		mmc->caps |= MMC_CAP_4_BIT_DATA;
-	else if (bus_width == 8)
-		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
-	if (of_property_read_bool(np, "broken-cd"))
-		mmc->caps |= MMC_CAP_NEEDS_POLL;
-	if (of_property_read_bool(np, "non-removable"))
-		mmc->caps |= MMC_CAP_NONREMOVABLE;
-	gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
-	if (gpio_is_valid(gpio)) {
-		ret = mmc_gpio_request_ro(mmc, gpio);
-		if (ret)
-			goto out_clk_disable;
-		if (!(flags & OF_GPIO_ACTIVE_LOW))
-			mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
-	}
-
-	if (of_property_read_bool(np, "cd-inverted"))
-		mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
-
 	mmc->f_min = 400000;
 	mmc->f_max = 288000000;
+
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto out_clk_disable;
+
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
 	mmc->max_segs = 52;
-- 
1.8.4.3

