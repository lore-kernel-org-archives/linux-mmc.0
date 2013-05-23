From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH v2 1/3] mmc: omap_hsmmc: Enable SDIO IRQ using a
 GPIO in idle mode.
Date: Thu, 23 May 2013 12:23:16 -0700
Message-ID: <20130523192315.GG13507@atomide.com>
References: <1368607516-2789-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1368607516-2789-2-git-send-email-andreas.fenkart@streamunlimited.com>
 <20130520205815.GJ10378@atomide.com>
 <20130521024946.GM10378@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="E39vaYmALEf/7YXx"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13816 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759175Ab3EWTXX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 May 2013 15:23:23 -0400
Content-Disposition: inline
In-Reply-To: <20130521024946.GM10378@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: cjb@laptop.org, balajitk@ti.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, svenkatr@ti.com


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [130520 19:55]:
> * Tony Lindgren <tony@atomide.com> [130520 14:03]:
> > * Andreas Fenkart <andreas.fenkart@streamunlimited.com> [130515 01:51]:
> > > Without functional clock the omap_hsmmc module can't forward SDIO IRQs to
> > > the system. This patch reconfigures dat1 line as a gpio while the fclk is
> > > off. When the fclk is present it uses the standard SDIO IRQ detection of
> > > the module.
> > > 
> > > The gpio irq is managed via the 'disable_depth' ref counter of the irq
> > > subsystem, this driver simply calls enable_irq/disable_irq when needed.
> > > 
> > >                       sdio irq    sdio irq
> > >                       unmasked     masked
> > >    -----------------------------------------
> > >     runtime default  |    1     |   2
> > >     runtime suspend  |    0     |   1
> > > 
> > >                   irq disable depth
> > > 
> > > 
> > > only when sdio irq is enabled AND the module is idle, the reference
> > > count drops to zero and the gpio irq is effectively armed.
> > > 
> > > Patch was tested on AM335x/Stream800. Test setup was two modules
> > > with sdio wifi cards. Modules where connected to a dual-band AP, each
> > > module using a different band. One of module was running iperf as server
> > > the other as client connecting to the server in a while true loop. Test
> > > was running for 4+ weeks. There were about 60 Mio. suspend/resume
> > > transitions. Test was shut down regularly.
> > 
> > Looks like this somehow breaks detecting of eMMC on mmc2 for me at least
> > with the non-dt legacyboot. For a removable mmc1 still keeps working.
> > 
> > For mmc2 I have .nonremovable = true and no gpio_cd or gpio_wp.
> 
> Looks like that's because gpio0 is considered valid. But for these pins
> gpio0 is not valid, so let's cut the dependency to updating the pdata
> and ignore gpio0.
> 
> We should also have three pinmux states: default, active and idle to
> avoid remuxing all the pins unnecessarily. The default pins should
> contain the fixed pins, active mmc_dat1, and idle the gpio pin.
> 
> I've attempted to fix up these issues, did not add the wake-up events
> from Steve Sakoman's patch for the non-muxed case:
> 
> http://www.sakoman.com/cgi-bin/gitweb.cgi?p=linux.git;a=commitdiff_plain;h=010810d22f6f49ac03da4ba384969432e0320453
> 
> Based on the patch above, sounds like the wake-up events won't work
> for deeper idle states though. But we should probably still support
> those as most people run without the deeper idle states anyways.

Actually, let's go with your patch with the pinmuxing changed. Then
the active state support can be added later on. And let's not add
any pinmuxing callbacks to the legacy booting mode, now there's at
least some reason for people to move on to device tree based booting.
 
> Can you check if the following changes on top of your patch still
> work for you? Note that you need to update your .dts file for the
> new pinctrl states.

Here's your original patch updated for the muxing for the default,
active and idle states.

Regards,

Tony



--E39vaYmALEf/7YXx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="andreas-mux-fixed.patch"

From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Date: Wed, 15 May 2013 10:45:14 +0200
Subject: [PATCH] mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in idle mode.

Without functional clock the omap_hsmmc module can't forward SDIO IRQs to
the system. This patch reconfigures dat1 line as a gpio while the fclk is
off. When the fclk is present it uses the standard SDIO IRQ detection of
the module.

The gpio irq is managed via the 'disable_depth' ref counter of the irq
subsystem, this driver simply calls enable_irq/disable_irq when needed.

                      sdio irq    sdio irq
                      unmasked     masked
   -----------------------------------------
    runtime default  |    1     |   2
    runtime suspend  |    0     |   1

                  irq disable depth


only when sdio irq is enabled AND the module is idle, the reference
count drops to zero and the gpio irq is effectively armed.

Patch was tested on AM335x/Stream800. Test setup was two modules
with sdio wifi cards. Modules where connected to a dual-band AP, each
module using a different band. One of module was running iperf as server
the other as client connecting to the server in a while true loop. Test
was running for 4+ weeks. There were about 60 Mio. suspend/resume
transitions. Test was shut down regularly.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
[tony@atomide.com: updated pin muxing and some comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index ed271fc..5a3df37 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -20,6 +20,29 @@ ti,dual-volt: boolean, supports dual voltage cards
 ti,non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
 ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
+ti,cirq-gpio: When omap_hsmmc module is suspended, its functional
+clock is turned off. Without fclk it can't forward SDIO IRQs to the
+system. For that to happen, it needs to tell the PRCM to restore
+its fclk, which is done through the swakeup line.
+
+                   ------
+                  | PRCM |
+                   ------
+                    | ^
+               fclk | | swakeup
+                    v |
+                  -------               ------
+      <-- IRQ -- | hsmmc | <-- CIRQ -- | card |
+                  -------               ------
+
+The problem is, that on the AM335x family the swakeup line is
+missing, it has not been routed from the module to the PRCM.
+The way to work around this, is to reconfigure the dat1 line as a
+GPIO upon suspend. Beyond this option you also need to set named
+states "default" and "idle "in the .dts file for the pins, using
+pinctrl-single.c. The MMC driver will then then toggle between
+default and idle during the runtime.
+
 
 Example:
 	mmc1: mmc@0x4809c000 {
@@ -31,3 +54,22 @@ Example:
 		vmmc-supply = <&vmmc>; /* phandle to regulator node */
 		ti,non-removable;
 	};
+
+[am335x with with gpio for sdio irq]
+
+	mmc1_cirq_pin: pinmux_cirq_pin {
+		pinctrl-single,pins = <
+			0x0f8 0x3f	/* MMC0_DAT1 as GPIO2_28 */
+		>;
+	};
+
+	mmc1: mmc@48060000 {
+		pinctrl-names = "default", "idle";
+		pinctrl-0 = <&mmc1_pins>;
+		pinctrl-1 = <&mmc1_cirq_pin>;
+		ti,cirq-gpio = <&gpio3 28 0>;
+		ti,non-removable;
+		bus-width = <4>;
+		vmmc-supply = <&ldo2_reg>;
+		vmmc_aux-supply = <&vmmc>;
+	};
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6a2949b..e33330d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -22,6 +22,7 @@
 #include <linux/dmaengine.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
@@ -102,6 +103,7 @@
 #define TC_EN			(1 << 1)
 #define BWR_EN			(1 << 4)
 #define BRR_EN			(1 << 5)
+#define CIRQ_EN			(1 << 8)
 #define ERR_EN			(1 << 15)
 #define CTO_EN			(1 << 16)
 #define CCRC_EN			(1 << 17)
@@ -182,10 +184,22 @@ struct omap_hsmmc_host {
 	int			use_reg;
 	int			req_in_progress;
 	struct omap_hsmmc_next	next_data;
+	bool			sdio_irq_en;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*fixed, *active, *idle;
+	bool			active_pinmux;
 
 	struct	omap_mmc_platform_data	*pdata;
 };
 
+static irqreturn_t omap_hsmmc_cirq(int irq, void *dev_id)
+{
+	struct omap_hsmmc_host *host = dev_id;
+
+	mmc_signal_sdio_irq(host->mmc);
+	return IRQ_HANDLED;
+}
+
 static int omap_hsmmc_card_detect(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
@@ -420,10 +434,31 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
 	} else
 		pdata->slots[0].gpio_wp = -EINVAL;
 
+	if (pdata->slots[0].gpio_cirq > 0 &&
+	    gpio_is_valid(pdata->slots[0].gpio_cirq)) {
+		pdata->slots[0].sdio_irq =
+				gpio_to_irq(pdata->slots[0].gpio_cirq);
+
+		ret = gpio_request(pdata->slots[0].gpio_cirq, "sdio_cirq");
+		if (ret)
+			goto err_free_ro;
+		ret = gpio_direction_input(pdata->slots[0].gpio_cirq);
+		if (ret)
+			goto err_free_cirq;
+
+	} else {
+		pdata->slots[0].gpio_cirq = -EINVAL;
+	}
+
+
 	return 0;
 
+err_free_cirq:
+	gpio_free(pdata->slots[0].gpio_cirq);
+err_free_ro:
+	if (gpio_is_valid(pdata->slots[0].gpio_wp))
 err_free_wp:
-	gpio_free(pdata->slots[0].gpio_wp);
+		gpio_free(pdata->slots[0].gpio_wp);
 err_free_cd:
 	if (gpio_is_valid(pdata->slots[0].switch_pin))
 err_free_sp:
@@ -437,6 +472,66 @@ static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 		gpio_free(pdata->slots[0].gpio_wp);
 	if (gpio_is_valid(pdata->slots[0].switch_pin))
 		gpio_free(pdata->slots[0].switch_pin);
+	if (gpio_is_valid(pdata->slots[0].gpio_cirq))
+		gpio_free(pdata->slots[0].gpio_cirq);
+}
+
+static int omap_hsmmc_pin_init(struct omap_hsmmc_host *host)
+{
+	int ret;
+
+	host->pinctrl = devm_pinctrl_get(host->dev);
+	if (IS_ERR(host->pinctrl)) {
+		dev_warn(host->dev,
+			 "pins are not configured from the driver\n");
+		return 0;
+	}
+
+	host->fixed = pinctrl_lookup_state(host->pinctrl,
+					   PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(host->fixed)) {
+		ret = PTR_ERR(host->fixed);
+		host->fixed = NULL;
+		goto err;
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
+	return ret;
 }
 
 /*
@@ -462,27 +557,46 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
 static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 				  struct mmc_command *cmd)
 {
-	unsigned int irq_mask;
+	u32 irq_mask = INT_EN_MASK;
+	unsigned long flags;
 
 	if (host->use_dma)
-		irq_mask = INT_EN_MASK & ~(BRR_EN | BWR_EN);
-	else
-		irq_mask = INT_EN_MASK;
+		irq_mask &= ~(BRR_EN | BWR_EN);
 
 	/* Disable timeout for erases */
 	if (cmd->opcode == MMC_ERASE)
 		irq_mask &= ~DTO_EN;
 
+	spin_lock_irqsave(&host->irq_lock, flags);
+
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+
+	/* latch pending CIRQ, but don't signal */
+	if (host->sdio_irq_en)
+		irq_mask |= CIRQ_EN;
+
 	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 }
 
 static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
 {
-	OMAP_HSMMC_WRITE(host->base, ISE, 0);
-	OMAP_HSMMC_WRITE(host->base, IE, 0);
+	u32 irq_mask = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+
+	/* no transfer running, need to signal cirq if */
+	if (host->sdio_irq_en)
+		irq_mask |= CIRQ_EN;
+
+	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 }
 
 /* Calculate divisor for the given clock frequency */
@@ -1056,8 +1170,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	int status;
 
 	status = OMAP_HSMMC_READ(host->base, STAT);
-	while (status & INT_EN_MASK && host->req_in_progress) {
-		omap_hsmmc_do_irq(host, status);
+	while (status & (INT_EN_MASK | CIRQ_EN)) {
+		if (host->req_in_progress)
+			omap_hsmmc_do_irq(host, status);
+
+		if (status & CIRQ_EN)
+			mmc_signal_sdio_irq(host->mmc);
 
 		/* Flush posted write */
 		OMAP_HSMMC_WRITE(host->base, STAT, status);
@@ -1573,6 +1691,51 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 		mmc_slot(host).init_card(card);
 }
 
+static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	u32 irq_mask;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+
+	if (host->sdio_irq_en == enable) {
+		dev_dbg(host->dev, "en/disable:%d already set", enable);
+		spin_unlock_irqrestore(&host->irq_lock, flags);
+		return;
+	}
+
+	host->sdio_irq_en = (enable != 0) ? true : false;
+
+	if (host->active_pinmux) { /* register access fails without fclk */
+		irq_mask = OMAP_HSMMC_READ(host->base, ISE);
+		if (enable)
+			irq_mask |= CIRQ_EN;
+		else
+			irq_mask &= ~CIRQ_EN;
+		OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
+
+		if (!host->req_in_progress)
+			OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+
+		/*
+		 * evtl. need to flush posted write
+		 * OMAP_HSMMC_READ(host->base, IE);
+		 */
+	}
+
+	if ((mmc_slot(host).sdio_irq)) {
+		if (enable) {
+			enable_irq(mmc_slot(host).sdio_irq);
+		} else {
+			/* _nosync, see mmc_signal_sdio_irq */
+			disable_irq_nosync(mmc_slot(host).sdio_irq);
+		}
+	}
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
 	u32 hctl, capa, value;
@@ -1625,7 +1788,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
 	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1736,6 +1899,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	pdata->nr_slots = 1;
 	pdata->slots[0].switch_pin = cd_gpio;
 	pdata->slots[0].gpio_wp = wp_gpio;
+	pdata->slots[0].gpio_cirq = of_get_named_gpio(np, "ti,cirq-gpio", 0);
 
 	if (of_find_property(np, "ti,non-removable", NULL)) {
 		pdata->slots[0].nonremovable = true;
@@ -1776,7 +1940,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
-	struct pinctrl *pinctrl;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -1828,6 +1991,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->dma_ch	= -1;
 	host->irq	= irq;
 	host->slot_id	= 0;
+	host->sdio_irq_en = false;
+	host->active_pinmux = true;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
@@ -1985,12 +2150,41 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		pdata->resume = omap_hsmmc_resume_cdirq;
 	}
 
+	if ((mmc_slot(host).sdio_irq)) {
+		/* prevent auto-enabling of IRQ */
+		irq_set_status_flags(mmc_slot(host).sdio_irq, IRQ_NOAUTOEN);
+		ret = request_irq(mmc_slot(host).sdio_irq, omap_hsmmc_cirq,
+				  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				  mmc_hostname(mmc), host);
+		if (ret) {
+			dev_dbg(mmc_dev(host->mmc),
+				"Unable to grab MMC SDIO IRQ\n");
+			goto err_irq_sdio;
+		}
+
+		/*
+		 * sdio_irq is managed with ref count
+		 * - omap_hsmmc_enable_sdio_irq will +1/-1
+		 * - pm_suspend/pm_resume will +1/-1
+		 * only when sdio irq is enabled AND module will go to runtime
+		 * suspend the ref count will drop to zero and the irq is
+		 * effectively enabled. starting with ref count equal 2
+		 */
+		disable_irq(mmc_slot(host).sdio_irq);
+	}
+
 	omap_hsmmc_disable_irq(host);
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev,
-			"pins are not configured from the driver\n");
+	/*
+	 * For now, only support SDIO interrupt if we are doing dynamic
+	 * remuxing of dat1. This is because the supposedly the wake-up
+	 * events for CTPL don't work from deeper idle states.
+	 */
+	ret = omap_hsmmc_pin_init(host);
+	if (ret)
+		goto err_pinctrl_state;
+	else if (host->idle && mmc_slot(host).sdio_irq)
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
 
 	omap_hsmmc_protect_card(host);
 
@@ -2016,6 +2210,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
+err_pinctrl_state:
+	devm_pinctrl_put(host->pinctrl);
+	if ((mmc_slot(host).sdio_irq))
+		free_irq(mmc_slot(host).sdio_irq, host);
+err_irq_sdio:
 	free_irq(mmc_slot(host).card_detect_irq, host);
 err_irq_cd:
 	if (host->use_reg)
@@ -2062,13 +2261,15 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
 	free_irq(host->irq, host);
+	if ((mmc_slot(host).sdio_irq))
+		free_irq(mmc_slot(host).sdio_irq, host);
 	if (mmc_slot(host).card_detect_irq)
 		free_irq(mmc_slot(host).card_detect_irq, host);
-
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
 	if (host->rx_chan)
 		dma_release_channel(host->rx_chan);
+	devm_pinctrl_put(host->pinctrl);
 
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
@@ -2187,23 +2388,69 @@ static int omap_hsmmc_resume(struct device *dev)
 static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	struct mmc_host *mmc;
+	unsigned long flags;
+	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
+	mmc = host->mmc;
 	omap_hsmmc_context_save(host);
 	dev_dbg(dev, "disabled\n");
 
-	return 0;
+	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
+		spin_lock_irqsave(&host->irq_lock, flags);
+		host->active_pinmux = false;
+		OMAP_HSMMC_WRITE(host->base, ISE, 0);
+		OMAP_HSMMC_WRITE(host->base, IE, 0);
+		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+		spin_unlock_irqrestore(&host->irq_lock, flags);
+
+		if (host->pinctrl && host->idle) {
+			ret = pinctrl_select_state(host->pinctrl, host->idle);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
+		}
+
+		if (mmc_slot(host).sdio_irq)
+			enable_irq(mmc_slot(host).sdio_irq);
+	}
+
+	return ret;
 }
 
 static int omap_hsmmc_runtime_resume(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	struct mmc_host *mmc;
+	unsigned long flags;
+	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
+	mmc = host->mmc;
 	omap_hsmmc_context_restore(host);
 	dev_dbg(dev, "enabled\n");
 
-	return 0;
+	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
+		if (mmc_slot(host).sdio_irq)
+			disable_irq(mmc_slot(host).sdio_irq);
+
+		if (host->pinctrl && host->active) {
+			ret = pinctrl_select_state(host->pinctrl, host->active);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
+		}
+
+		spin_lock_irqsave(&host->irq_lock, flags);
+		host->active_pinmux = true;
+
+		if (host->sdio_irq_en) {
+			OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+			OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
+			OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
+		}
+		spin_unlock_irqrestore(&host->irq_lock, flags);
+	}
+	return ret;
 }
 
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index 2bf1b30..fd5fff5 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -115,6 +115,7 @@ struct omap_mmc_platform_data {
 
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
+		int gpio_cirq;			/* gpio (card irq) */
 
 		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (*set_power)(struct device *dev, int slot,
@@ -145,6 +146,9 @@ struct omap_mmc_platform_data {
 		int card_detect_irq;
 		int (*card_detect)(struct device *dev, int slot);
 
+		/* SDIO IRQs */
+		int sdio_irq;
+
 		unsigned int ban_openended:1;
 
 	} slots[OMAP_MMC_MAX_SLOTS];

--E39vaYmALEf/7YXx--
