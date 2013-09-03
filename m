From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V3 1/4] mmc: mmci: Adapt to new pinctrl handling
Date: Tue,  3 Sep 2013 11:29:33 +0200
Message-ID: <1378200576-13413-2-git-send-email-ulf.hansson@linaro.org>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:36329 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610Ab3ICJ35 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 05:29:57 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so2834213eae.38
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 02:29:56 -0700 (PDT)
In-Reply-To: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

There is no need for every driver to fetch a pinctrl handle and to
select the default state. Instead this is handled by the device driver
core, thus we can remove this piece of code from mmci.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   17 -----------------
 drivers/mmc/host/mmci.h |    4 ----
 2 files changed, 21 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c3785ed..5dffbbd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1510,23 +1510,6 @@ static int mmci_probe(struct amba_device *dev,
 		mmc->f_max = min(host->mclk, fmax);
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
 
-	host->pinctrl = devm_pinctrl_get(&dev->dev);
-	if (IS_ERR(host->pinctrl)) {
-		ret = PTR_ERR(host->pinctrl);
-		goto clk_disable;
-	}
-
-	host->pins_default = pinctrl_lookup_state(host->pinctrl,
-			PINCTRL_STATE_DEFAULT);
-
-	/* enable pins to be muxed in and configured */
-	if (!IS_ERR(host->pins_default)) {
-		ret = pinctrl_select_state(host->pinctrl, host->pins_default);
-		if (ret)
-			dev_warn(&dev->dev, "could not set default pins\n");
-	} else
-		dev_warn(&dev->dev, "could not get default pinstate\n");
-
 	/* Get regulators and the supported OCR mask */
 	mmc_regulator_get_supply(mmc);
 	if (!mmc->ocr_avail)
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 69080fa..168bc72 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -200,10 +200,6 @@ struct mmci_host {
 	struct sg_mapping_iter	sg_miter;
 	unsigned int		size;
 
-	/* pinctrl handles */
-	struct pinctrl		*pinctrl;
-	struct pinctrl_state	*pins_default;
-
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	struct dma_chan		*dma_current;
-- 
1.7.9.5

