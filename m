From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v7 2/4] mmc: omap_hsmmc: Remux SDIO pins within driver.
Date: Tue, 25 Feb 2014 13:37:44 +0100
Message-ID: <1393331866-28307-3-git-send-email-afenkart@gmail.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:38381 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaBYMqY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 07:46:24 -0500
In-Reply-To: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

This is a preparation for the am335x workaround where we reconfigure
dat1 as GPIO before going to suspend. If you don't specify active/idle
pinctrl there should be no change.

Idea of remuxing the pins by Tony Lindgren as well as the intial
implementation of omap_hsmmc_pin_init. All bugs are mine.

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bd3bb0c..5e60925 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -220,6 +220,8 @@ struct omap_hsmmc_host {
 #define HSMMC_SDIO_IRQ_ENABLED	(1 << 0)        /* SDIO irq enabled */
 
 	struct omap_hsmmc_next	next_data;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*fixed, *active, *idle;
 	struct	omap_mmc_platform_data	*pdata;
 };
 
@@ -476,6 +478,70 @@ static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 		gpio_free(pdata->slots[0].switch_pin);
 }
 
+static int omap_hsmmc_pin_init(struct omap_hsmmc_host *host)
+{
+	struct pinctrl *_pinctrl;
+	int ret;
+
+	_pinctrl = devm_pinctrl_get(host->dev);
+	if (IS_ERR(_pinctrl)) {
+		/* okay, if the bootloader set it up right */
+		dev_warn(host->dev, "no pinctrl handle\n");
+		return 0;
+	}
+
+	host->fixed = pinctrl_lookup_state(_pinctrl,
+					   PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(host->fixed)) {
+		dev_info(host->dev,
+			 "pins are not configured from the driver\n");
+		host->fixed = NULL;
+		devm_pinctrl_put(_pinctrl);
+		return 0;
+	}
+
+	ret = pinctrl_select_state(_pinctrl, host->fixed);
+	if (ret < 0) {
+		dev_warn(host->dev, "select fixed pinctrl state failed %d\n", ret);
+		goto err;
+	}
+
+	/* For most cases we don't have wake-ups, and exit after this */
+	host->active = pinctrl_lookup_state(_pinctrl, "active");
+	if (IS_ERR(host->active)) {
+		ret = PTR_ERR(host->active);
+		host->active = NULL;
+		goto done;
+	}
+
+	host->idle = pinctrl_lookup_state(_pinctrl, PINCTRL_STATE_IDLE);
+	if (IS_ERR(host->idle)) {
+		ret = PTR_ERR(host->idle);
+		host->idle = NULL;
+		goto err;
+	}
+
+	/* Let's make sure the active and idle states work */
+	ret = pinctrl_select_state(_pinctrl, host->idle);
+	if (ret < 0)
+		goto err;
+
+	ret = pinctrl_select_state(_pinctrl, host->active);
+	if (ret < 0)
+		goto err;
+
+	dev_info(mmc_dev(host->mmc), "pins configured for wake-up events\n");
+
+done:
+	host->pinctrl = _pinctrl;
+	return 0;
+
+err:
+	dev_err(mmc_dev(host->mmc), "pins configuration error: %i\n", ret);
+	devm_pinctrl_put(_pinctrl);
+	return ret;
+}
+
 /*
  * Start clock to the card
  */
@@ -1858,7 +1924,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
-	struct pinctrl *pinctrl;
 
 	apply_clk_hack(&pdev->dev);
 
@@ -2083,10 +2148,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_disable_irq(host);
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev,
-			"pins are not configured from the driver\n");
+	ret = omap_hsmmc_pin_init(host);
+	if (ret)
+		goto err_pinctrl_state;
 
 	/*
 	 * For now, only support SDIO interrupt if we are booted with
@@ -2127,7 +2191,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
-	free_irq(mmc_slot(host).card_detect_irq, host);
+	if (host->pinctrl)
+		devm_pinctrl_put(host->pinctrl);
+err_pinctrl_state:
+	if ((mmc_slot(host).card_detect_irq))
+		free_irq(mmc_slot(host).card_detect_irq, host);
 err_irq_cd:
 	if (host->use_reg)
 		omap_hsmmc_reg_put(host);
@@ -2179,6 +2247,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 		dma_release_channel(host->tx_chan);
 	if (host->rx_chan)
 		dma_release_channel(host->rx_chan);
+	if (host->pinctrl)
+		devm_pinctrl_put(host->pinctrl);
 
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
-- 
1.7.10.4

