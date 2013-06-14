From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] mmc: omap_hsmmc: Remux pins to support SDIO
 interrupt and PM runtime
Date: Fri, 14 Jun 2013 00:40:09 -0700
Message-ID: <20130614074009.GC20992@atomide.com>
References: <20130607214557.18581.75288.stgit@localhost>
 <20130607214957.18581.90624.stgit@localhost>
 <CACRpkdZ5CUvULBFpdHZ_AMotqfUdBcAQ63+8cT+r6TZ77bUWOA@mail.gmail.com>
 <20130610162356.GL8164@atomide.com>
 <CACRpkdaEjLzXfA3HX5mra0Mjheia4e2O3kbvikeZQRsNczS7kg@mail.gmail.com>
 <20130612132144.GP8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130612132144.GP8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, Andreas Fenkart <afenkart@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-mmc@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130612 06:27]:
> * Linus Walleij <linus.walleij@linaro.org> [130611 01:00]:
> > If we can agree on this I will add the active state to the
> > state table and add a container in the core for this as well
> > as pinctrl_pm_select_active_state() so we can skip all the
> > pointless boilerplate also in the OMAP drivers, plus increase
> > the readability and portability quite a bit.
> 
> Sounds good to me as long as we don't always need to select
> the default pins over and over in PM runtime_resume.

Here's this patch updated for pinctrl next with the active state
added. This patch should be merged separately towards the end
of the merge window once pinctrl code has been merged. The other
three patches can be merged independently.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 13 Jun 2013 23:19:09 -0700
Subject: [PATCH] mmc: omap_hsmmc: Remux pins to support SDIO interrupt and PM runtime

On some omaps we need to remux MMC pins for PM, and for some omaps
we need to remux the SDIO IRQ pin.

Based on an earlier patch by Andreas Fenkart <afenkart@gmail.com>.

Cc: Andreas Fenkart <afenkart@gmail.com>
Cc: Balaji T K <balajitk@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6377836..7029d34 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -475,6 +475,39 @@ static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 		gpio_free(pdata->slots[0].gpio_cirq);
 }
 
+static int omap_hsmmc_pinctrl_init(struct omap_hsmmc_host *host)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	int res, found = 0;
+
+	if (!dev->pins)
+		return 0;
+
+	/*
+	 * The active and idle pins are optional, and used for
+	 * SDIO interrupt, or eMMC pulls for off-idle.
+	 */
+	if (IS_ERR(dev->pins->active_state) ||
+	    IS_ERR(dev->pins->idle_state)) {
+		return 0;
+	}
+
+	/* Let's make sure the idle and active states work */
+	res = pinctrl_pm_select_idle_state(dev);
+	if (res < 0)
+		return -ENODEV;
+	found++;
+
+	res = pinctrl_pm_select_active_state(dev);
+	if (res < 0)
+		return -ENODEV;
+	found++;
+
+	dev_info(mmc_dev(dev), "pins configured for dynamic remuxing\n");
+
+	return found;
+}
+
 /*
  * Start clock to the card
  */
@@ -1868,7 +1901,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
-	struct pinctrl *pinctrl;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -2101,21 +2133,19 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
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
+		ret = omap_hsmmc_pinctrl_init(host);
+		if (ret < 0)
+			goto err_pinctrl_state;
+		else if (ret > 1 && mmc_slot(host).sdio_irq)
 			mmc->caps |= MMC_CAP_SDIO_IRQ;
 	}
 
@@ -2143,6 +2173,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
+err_pinctrl_state:
 	if ((mmc_slot(host).sdio_irq))
 		free_irq(mmc_slot(host).sdio_irq, host);
 err_irq_sdio:
@@ -2337,6 +2368,10 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 		spin_unlock_irqrestore(&host->irq_lock, flags);
 
+		ret = pinctrl_pm_select_idle_state(dev);
+		if (ret < 0)
+			dev_err(dev, "Unable to select idle pinmux\n");
+
 		if (mmc_slot(host).sdio_irq)
 			enable_irq(mmc_slot(host).sdio_irq);
 	}
@@ -2360,6 +2395,10 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 		if (mmc_slot(host).sdio_irq)
 			disable_irq(mmc_slot(host).sdio_irq);
 
+		ret = pinctrl_pm_select_active_state(dev);
+		if (ret < 0)
+			dev_err(dev, "Unable to select active pinmux\n");
+
 		spin_lock_irqsave(&host->irq_lock, flags);
 		host->active_pinmux = true;
 
