From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] mmc: omap_hsmmc: Remux pins to support SDIO interrupt
 and PM runtime
Date: Fri, 07 Jun 2013 14:49:57 -0700
Message-ID: <20130607214957.18581.90624.stgit@localhost>
References: <20130607214557.18581.75288.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14400 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab3FGVt7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jun 2013 17:49:59 -0400
In-Reply-To: <20130607214557.18581.75288.stgit@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: Balaji T K <balajitk@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On some omaps we need to remux MMC pins for PM, and for some omaps
we need to remux the SDIO IRQ pin.

Based on an earlier patch by Andreas Fenkart <afenkart@gmail.com>.

Cc: Andreas Fenkart <afenkart@gmail.com>
Cc: Balaji T K <balajitk@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   93 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7e28501..8ca08fb 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -185,6 +185,8 @@ struct omap_hsmmc_host {
 	int			req_in_progress;
 	struct omap_hsmmc_next	next_data;
 	bool			sdio_irq_en;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*fixed, *active, *idle;
 	bool			active_pinmux;
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -473,6 +475,67 @@ static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 		gpio_free(pdata->slots[0].gpio_cirq);
 }
 
+static int omap_hsmmc_pin_init(struct omap_hsmmc_host *host)
+{
+	int ret;
+
+	host->pinctrl = devm_pinctrl_get(host->dev);
+	if (IS_ERR(host->pinctrl)) {
+		dev_dbg(host->dev, "no pinctrl handle\n");
+		ret = 0;
+		goto out;
+	}
+
+	host->fixed = pinctrl_lookup_state(host->pinctrl,
+					   PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(host->fixed)) {
+		dev_dbg(host->dev,
+			 "pins are not configured from the driver\n");
+		host->fixed = NULL;
+		ret = 0;
+		goto out;
+	}
+
+	ret = pinctrl_select_state(host->pinctrl, host->fixed);
+	if (ret < 0)
+		goto err;
+
+	/* For most cases we don't have wake-ups, and exit after this */
+	host->active = pinctrl_lookup_state(host->pinctrl, "active");
+	if (IS_ERR(host->active)) {
+		ret = PTR_ERR(host->active);
+		host->active = NULL;
+		return 0;
+	}
+
+	host->idle = pinctrl_lookup_state(host->pinctrl,
+					  PINCTRL_STATE_IDLE);
+	if (IS_ERR(host->idle)) {
+		ret = PTR_ERR(host->idle);
+		host->idle = NULL;
+		goto err;
+	}
+
+	/* Let's make sure the active and idle states work */
+	ret = pinctrl_select_state(host->pinctrl, host->idle);
+	if (ret < 0)
+		goto err;
+
+	ret = pinctrl_select_state(host->pinctrl, host->active);
+	if (ret < 0)
+		goto err;
+
+	dev_info(mmc_dev(host->mmc), "pins configured for wake-up events\n");
+
+	return 0;
+
+err:
+	dev_err(mmc_dev(host->mmc), "pins configuration error: %i\n", ret);
+
+out:
+	return ret;
+}
+
 /*
  * Start clock to the card
  */
@@ -1854,7 +1917,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
-	struct pinctrl *pinctrl;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -2086,21 +2148,19 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_disable_irq(host);
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev,
-			"pins are not configured from the driver\n");
-
 	/*
-	 * For now, only support SDIO interrupt if we are doing
-	 * muxing of dat1 when booted with DT. This is because the
+	 * For now, only support SDIO interrupt if we are doing dynamic
+	 * remuxing of dat1 when booted with DT. This is because the
 	 * supposedly the wake-up events for CTPL don't work from deeper
 	 * idle states. And we don't want to add new legacy mux platform
 	 * init code callbacks any longer as we are moving to DT based
 	 * booting anyways.
 	 */
 	if (match) {
-		if (!IS_ERR(pinctrl) && mmc_slot(host).sdio_irq)
+		ret = omap_hsmmc_pin_init(host);
+		if (ret)
+			goto err_pinctrl_state;
+		else if (host->idle && mmc_slot(host).sdio_irq)
 			mmc->caps |= MMC_CAP_SDIO_IRQ;
 	}
 
@@ -2128,6 +2188,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
+err_pinctrl_state:
+	devm_pinctrl_put(host->pinctrl);
 	if ((mmc_slot(host).sdio_irq))
 		free_irq(mmc_slot(host).sdio_irq, host);
 err_irq_sdio:
@@ -2185,6 +2247,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 		dma_release_channel(host->tx_chan);
 	if (host->rx_chan)
 		dma_release_channel(host->rx_chan);
+	devm_pinctrl_put(host->pinctrl);
 
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
@@ -2320,6 +2383,12 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 		spin_unlock_irqrestore(&host->irq_lock, flags);
 
+		if (host->pinctrl && host->idle) {
+			ret = pinctrl_select_state(host->pinctrl, host->idle);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
+		}
+
 		if (mmc_slot(host).sdio_irq)
 			enable_irq(mmc_slot(host).sdio_irq);
 	}
@@ -2343,6 +2412,12 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 		if (mmc_slot(host).sdio_irq)
 			disable_irq(mmc_slot(host).sdio_irq);
 
+		if (host->pinctrl && host->active) {
+			ret = pinctrl_select_state(host->pinctrl, host->active);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
+		}
+
 		spin_lock_irqsave(&host->irq_lock, flags);
 		host->active_pinmux = true;
 

