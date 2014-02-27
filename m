From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 2/4] mmc: omap_hsmmc: Remux SDIO pins within driver.
Date: Thu, 27 Feb 2014 13:42:23 -0800
Message-ID: <20140227214223.GN11654@atomide.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
 <1393331866-28307-3-git-send-email-afenkart@gmail.com>
 <20140227213625.GK11654@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47922 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750942AbaB0Vmh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Feb 2014 16:42:37 -0500
Content-Disposition: inline
In-Reply-To: <20140227213625.GK11654@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140227 13:40]:
> * Andreas Fenkart <afenkart@gmail.com> [140225 04:49]:
> > This is a preparation for the am335x workaround where we reconfigure
> > dat1 as GPIO before going to suspend. If you don't specify active/idle
> > pinctrl there should be no change.
> 
> I've updated this too, hope it still works for you. And there's no
> need for patch 3/4, that's merged into this one as well.

> -	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING)
> +	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
> +		if (!host->idle) {
> +			free_irq(host->wake_irq);

Oops, this one was missing some uncommitted changes. Updated patch below.

Tony

8< ----------------------------------------------
From: Andreas Fenkart <afenkart@gmail.com>
Date: Tue, 25 Feb 2014 13:37:44 +0100
Subject: [PATCH] mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on AM335x

The am335x can't detect pending cirq in PM runtime suspend.
This patch reconfigures dat1 as a GPIO before going to suspend.
SDIO interrupts are detected with the GPIO, the GPIO will only wake
the module from suspend, SDIO irq detection will still happen through the
IP block.

Idea of remuxing the pins and some minor changes by Tony Lindgren.

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 8c8908a..8e1195e 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -55,3 +55,53 @@ Examples:
 			&edma 25>;
 		dma-names = "tx", "rx";
 	};
+
+[workaround for missing swakeup on am33xx]
+
+This SOC is missing the swakeup line, it will not detect SDIO irq
+while in suspend.
+
+                             ------
+                             | PRCM |
+                              ------
+                               ^ |
+                       swakeup | | fclk
+                               | v
+       ------                -------               -----
+      | card | -- CIRQ -->  | hsmmc | -- IRQ -->  | CPU |
+       ------                -------               -----
+
+In suspend the fclk is off and the module is disfunctional. Even
+register reads will fail. A small logic in the host will request
+fclk restore, when an external event is detected. Once the clock
+is restored, the host detects the event normally. Since am33xx
+doesn't have this line it never wakes from suspend.
+
+The workaround is to reconfigure the dat1 line as a GPIO upon
+suspend. To make this work, we need to set 1) the named pinctrl
+states "default", "active" and "idle", 2) the gpio detecting
+sdio irq in suspend and 3) compatibe section, see example below.
+The MMC driver will then toggle between active and idle during
+the runtime. If configuration is incomplete, a warning message is
+emitted "falling back to polling".  Mind not every application
+needs SDIO irq, e.g. MMC cards Affected chips are am335x,
+probably others
+
+
+	mmc1: mmc@48060100 {
+		compatible = "ti,am33xx-hsmmc";
+		...
+		interrupts-extended = <&intc 64 &gpio2 28 0>;
+		...
+		pinctrl-names = "default", "active", "idle"
+		pinctrl-0 = <&mmc1_pins>;
+		pinctrl-1 = <&mmc1_pins>;
+		pinctrl-2 = <&mmc1_cirq_pin>;
+		...
+	};
+
+	mmc1_cirq_pin: pinmux_cirq_pin {
+		pinctrl-single,pins = <
+		        0x0f8 0x3f      /* GPIO2_28 */
+		>;
+	};
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e945060..2c1f128 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -196,6 +196,8 @@ struct omap_hsmmc_host {
 #define HSMMC_SDIO_IRQ_ENABLED	(1 << 0)        /* SDIO irq enabled */
 #define HSMMC_SWAKEUP_QUIRK	(1 << 1)
 	struct omap_hsmmc_next	next_data;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*fixed, *active, *idle;
 	struct	omap_mmc_platform_data	*pdata;
 };
 
@@ -452,6 +454,70 @@ static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
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
+		dev_warn(host->dev, "fixed pinctrl state failed %d\n", ret);
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
@@ -1675,8 +1741,14 @@ static int omap_hscmm_configure_wake_irq(struct omap_hsmmc_host *host)
 	 * Some omaps don't have wake-up path from deeper idle states
 	 * and need to remux SDIO DAT1 to GPIO for wake-up from idle.
 	 */
-	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING)
+	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
+		if (!host->idle) {
+			free_irq(host->wake_irq, host);
+			host->wake_irq = 0;
+			return -EINVAL;
+		}
 		host->flags |= HSMMC_SWAKEUP_QUIRK;
+	}
 
 	return 0;
 }
@@ -1890,7 +1962,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
-	struct pinctrl *pinctrl;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -2107,10 +2178,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_disable_irq(host);
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev,
-			"pins are not configured from the driver\n");
+	ret = omap_hsmmc_pin_init(host);
+	if (ret)
+		goto err_pinctrl_state;
 
 	/*
 	 * For now, only support SDIO interrupt if we have a separate
@@ -2150,7 +2220,10 @@ err_slot_name:
 	mmc_remove_host(mmc);
 	if (host->wake_irq)
 		free_irq(host->wake_irq, host);
-	if (mmc_slot(host).card_detect_irq)
+	if (host->pinctrl)
+		devm_pinctrl_put(host->pinctrl);
+err_pinctrl_state:
+	if ((mmc_slot(host).card_detect_irq))
 		free_irq(mmc_slot(host).card_detect_irq, host);
 err_irq_cd:
 	if (host->use_reg)
@@ -2205,6 +2278,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 		dma_release_channel(host->tx_chan);
 	if (host->rx_chan)
 		dma_release_channel(host->rx_chan);
+	if (host->pinctrl)
+		devm_pinctrl_put(host->pinctrl);
 
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
@@ -2314,6 +2389,11 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 		OMAP_HSMMC_WRITE(host->base, ISE, 0);
 		OMAP_HSMMC_WRITE(host->base, IE, 0);
 		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+		if (host->idle) {
+			ret = pinctrl_select_state(host->pinctrl, host->idle);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
+		}
 		hsmmc_enable_wake_irq(host);
 	}
 
@@ -2331,6 +2411,11 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 
 	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
 		hsmmc_disable_wake_irq(host);
+		if (host->active) {
+			ret = pinctrl_select_state(host->pinctrl, host->active);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
+		}
 		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 		OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
 		OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
