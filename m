From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH v2 1/3] mmc: omap_hsmmc: Enable SDIO IRQ using a
 GPIO in idle mode.
Date: Mon, 20 May 2013 19:49:47 -0700
Message-ID: <20130521024946.GM10378@atomide.com>
References: <1368607516-2789-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1368607516-2789-2-git-send-email-andreas.fenkart@streamunlimited.com>
 <20130520205815.GJ10378@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130520205815.GJ10378@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: cjb@laptop.org, arnd@arndb.de, svenkatr@ti.com, balajitk@ti.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, rob@landley.net, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, zonque@gmail.com
List-Id: linux-mmc@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130520 14:03]:
> * Andreas Fenkart <andreas.fenkart@streamunlimited.com> [130515 01:51]:
> > Without functional clock the omap_hsmmc module can't forward SDIO IRQs to
> > the system. This patch reconfigures dat1 line as a gpio while the fclk is
> > off. When the fclk is present it uses the standard SDIO IRQ detection of
> > the module.
> > 
> > The gpio irq is managed via the 'disable_depth' ref counter of the irq
> > subsystem, this driver simply calls enable_irq/disable_irq when needed.
> > 
> >                       sdio irq    sdio irq
> >                       unmasked     masked
> >    -----------------------------------------
> >     runtime default  |    1     |   2
> >     runtime suspend  |    0     |   1
> > 
> >                   irq disable depth
> > 
> > 
> > only when sdio irq is enabled AND the module is idle, the reference
> > count drops to zero and the gpio irq is effectively armed.
> > 
> > Patch was tested on AM335x/Stream800. Test setup was two modules
> > with sdio wifi cards. Modules where connected to a dual-band AP, each
> > module using a different band. One of module was running iperf as server
> > the other as client connecting to the server in a while true loop. Test
> > was running for 4+ weeks. There were about 60 Mio. suspend/resume
> > transitions. Test was shut down regularly.
> 
> Looks like this somehow breaks detecting of eMMC on mmc2 for me at least
> with the non-dt legacyboot. For a removable mmc1 still keeps working.
> 
> For mmc2 I have .nonremovable = true and no gpio_cd or gpio_wp.

Looks like that's because gpio0 is considered valid. But for these pins
gpio0 is not valid, so let's cut the dependency to updating the pdata
and ignore gpio0.

We should also have three pinmux states: default, active and idle to
avoid remuxing all the pins unnecessarily. The default pins should
contain the fixed pins, active mmc_dat1, and idle the gpio pin.

I've attempted to fix up these issues, did not add the wake-up events
from Steve Sakoman's patch for the non-muxed case:

http://www.sakoman.com/cgi-bin/gitweb.cgi?p=linux.git;a=commitdiff_plain;h=010810d22f6f49ac03da4ba384969432e0320453

Based on the patch above, sounds like the wake-up events won't work
for deeper idle states though. But we should probably still support
those as most people run without the deeper idle states anyways.

Can you check if the following changes on top of your patch still
work for you? Note that you need to update your .dts file for the
new pinctrl states.

Regards,

Tony


--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -186,7 +186,7 @@ struct omap_hsmmc_host {
 	struct omap_hsmmc_next	next_data;
 	bool			sdio_irq_en;
 	struct pinctrl		*pinctrl;
-	struct pinctrl_state	*active, *idle;
+	struct pinctrl_state	*fixed, *active, *idle;
 	bool			active_pinmux;
 
 	struct	omap_mmc_platform_data	*pdata;
@@ -434,7 +434,8 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
 	} else
 		pdata->slots[0].gpio_wp = -EINVAL;
 
-	if (gpio_is_valid(pdata->slots[0].gpio_cirq)) {
+	if (pdata->slots[0].gpio_cirq > 0 &&
+	    gpio_is_valid(pdata->slots[0].gpio_cirq)) {
 		pdata->slots[0].sdio_irq =
 				gpio_to_irq(pdata->slots[0].gpio_cirq);
 
@@ -1635,7 +1636,7 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	u32 irq_mask;
+	u32 irq_mask, con;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->irq_lock, flags);
@@ -2116,35 +2117,43 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_disable_irq(host);
 
+	mmc->caps |= MMC_CAP_SDIO_IRQ;
+
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(host->pinctrl)) {
-		ret = PTR_ERR(host->pinctrl);
-		goto err_pinctrl;
-	}
-
-	host->active = pinctrl_lookup_state(host->pinctrl,
-					    PINCTRL_STATE_DEFAULT);
-	if (IS_ERR(host->active)) {
-		dev_warn(mmc_dev(host->mmc), "Unable to lookup active pinmux\n");
-		ret = PTR_ERR(host->active);
-		goto err_pinctrl_state;
-	}
-
-	if (mmc_slot(host).sdio_irq) {
-		host->idle = pinctrl_lookup_state(host->pinctrl,
-						  PINCTRL_STATE_IDLE);
-		if (IS_ERR(host->idle)) {
-			dev_warn(mmc_dev(host->mmc), "Unable to lookup idle pinmux\n");
-			ret = PTR_ERR(host->idle);
-			goto err_pinctrl_state;
+	if (!IS_ERR(host->pinctrl)) {
+		host->fixed = pinctrl_lookup_state(host->pinctrl,
+						   PINCTRL_STATE_DEFAULT);
+		if (IS_ERR(host->fixed)) {
+			dev_warn(mmc_dev(host->mmc), "Unable to lookup default pinmux\n");
+		} else {
+			pinctrl_select_state(host->pinctrl, host->fixed);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc), "Unable to select default pins\n");
 		}
-		mmc->caps |= MMC_CAP_SDIO_IRQ;
-	}
 
-	ret = pinctrl_select_state(host->pinctrl, host->active);
-	if (ret < 0) {
-		dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
-		goto err_pinctrl_state;
+		if (mmc_slot(host).sdio_irq) {
+			host->active = pinctrl_lookup_state(host->pinctrl, "active");
+			if (IS_ERR(host->active)) {
+				dev_warn(mmc_dev(host->mmc), "Unable to lookup active pinmux\n");
+			} else {
+				ret = pinctrl_select_state(host->pinctrl, host->active);
+				if (ret < 0) {
+					dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
+					goto err_pinctrl_state;
+				}
+			}
+
+			host->idle = pinctrl_lookup_state(host->pinctrl,
+							  PINCTRL_STATE_IDLE);
+			if (IS_ERR(host->idle)) {
+				dev_warn(mmc_dev(host->mmc), "Unable to lookup idle pinmux\n");
+				ret = PTR_ERR(host->idle);
+				mmc->caps &= ~MMC_CAP_SDIO_IRQ;
+			}
+		}
+	} else {
+		dev_warn(&pdev->dev,
+			"pins are not configured from the driver\n");
 	}
 
 	omap_hsmmc_protect_card(host);
@@ -2173,7 +2182,6 @@ err_slot_name:
 	mmc_remove_host(mmc);
 err_pinctrl_state:
 	devm_pinctrl_put(host->pinctrl);
-err_pinctrl:
 	if ((mmc_slot(host).sdio_irq))
 		free_irq(mmc_slot(host).sdio_irq, host);
 err_irq_sdio:
@@ -2350,14 +2358,16 @@ static int omap_hsmmc_resume(struct device *dev)
 static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	struct mmc_host *mmc;
 	unsigned long flags;
 	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
+	mmc = host->mmc;
 	omap_hsmmc_context_save(host);
 	dev_dbg(dev, "disabled\n");
 
-	if (mmc_slot(host).sdio_irq && host->pinctrl) {
+	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
 		spin_lock_irqsave(&host->irq_lock, flags);
 		host->active_pinmux = false;
 		OMAP_HSMMC_WRITE(host->base, ISE, 0);
@@ -2365,13 +2375,14 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 		spin_unlock_irqrestore(&host->irq_lock, flags);
 
-		ret = pinctrl_select_state(host->pinctrl, host->idle);
-		if (ret < 0) {
-			dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
-			return ret;
+		if (host->pinctrl && host->idle) {
+			ret = pinctrl_select_state(host->pinctrl, host->idle);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
 		}
 
-		enable_irq(mmc_slot(host).sdio_irq);
+		if (mmc_slot(host).sdio_irq)
+			enable_irq(mmc_slot(host).sdio_irq);
 	}
 
 	return ret;
@@ -2380,20 +2391,24 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 static int omap_hsmmc_runtime_resume(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	struct mmc_host *mmc;
 	unsigned long flags;
 	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
+	mmc = host->mmc;
 	omap_hsmmc_context_restore(host);
 	dev_dbg(dev, "enabled\n");
 
-	if (mmc_slot(host).sdio_irq && host->pinctrl) {
-		disable_irq(mmc_slot(host).sdio_irq);
+	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
 
-		ret = pinctrl_select_state(host->pinctrl, host->active);
-		if (ret < 0) {
-			dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
-			return ret;
+		if (mmc_slot(host).sdio_irq)
+			disable_irq(mmc_slot(host).sdio_irq);
+
+		if (host->pinctrl && host->active) {
+			ret = pinctrl_select_state(host->pinctrl, host->active);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
 		}
 
 		spin_lock_irqsave(&host->irq_lock, flags);
