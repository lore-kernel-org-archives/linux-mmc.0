From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 2/3] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x.
Date: Fri, 20 Dec 2013 17:01:16 -0800
Message-ID: <20131221010115.GJ26054@atomide.com>
References: <1387193091-23218-1-git-send-email-afenkart@gmail.com>
 <1387193091-23218-3-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387193091-23218-3-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Andreas Fenkart <afenkart@gmail.com> [131216 03:29]:
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2098,8 +2186,28 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  	if (pdev->dev.of_node) {
>  		mmc->caps |= MMC_CAP_SDIO_IRQ;
>  		if (pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
> -			/* no wakeup from deeper power states, use polling */
> -			mmc->caps &= ~MMC_CAP_SDIO_IRQ;
> +			/* use GPIO to wakeup from deeper power states */
> +			if (!host->idle || !host->gpio_sdio_irq) {
> +				dev_warn(mmc_dev(host->mmc),
> +					 "Disable SDIO IRQ workaround, GPIO IRQ or pinctrl idle state missing, falling back to polling\n");
> +				mmc->caps &= ~MMC_CAP_SDIO_IRQ;
> +			} else {
> +				host->flags |= HSMMC_SWAKEUP_QUIRK;
> +
> +			}
> +		}
> +
> +		if (host->flags & HSMMC_SWAKEUP_QUIRK) {
> +			/* prevent auto-enabling of IRQ */
> +			irq_set_status_flags(host->gpio_sdio_irq, IRQ_NOAUTOEN);
> +			ret = request_irq(host->gpio_sdio_irq, omap_hsmmc_cirq,
> +					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					  mmc_hostname(mmc), host);
> +			if (ret) {
> +				dev_err(mmc_dev(host->mmc),
> +					"Unable to grab GPIO SDIO IRQ\n");
> +				goto err_irq_sdio;
> +			}
>  		}
>  	}
>  

FYI This part needs to be changed a bit for the omaps that have a working
wake-up interrupt. I tried on 3730 with the following patch, but so far it
gets stuck in an infinite SDIO interrupt loop. I'll try to take a look at
it more but may not get to it very soon with the holidays coming up. Also
changed the naming to use wakeirq to make it a bit shorter and generic.

Regards,

Tony

8< ---------------------------------------
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -48,7 +48,7 @@
 			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
 			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
 			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
-			0x12e (WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1.sdmmc2_dat1 */
+			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1.sdmmc2_dat1 */
 			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
 			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
 		>;
@@ -81,6 +81,7 @@
 };
 
 &mmc2 {
+	interrupts-extended = <&intc 86 &omap3_pmx_core 0x12e>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
 };
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -395,7 +395,7 @@
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap3-hsmmc";
 			reg = <0x480b4000 0x200>;
-			interrupts = <86>;
+			interrupts-extended = <&intc 86>;
 			ti,hwmods = "mmc2";
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 78e7b80..7da1532 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -182,7 +182,7 @@ struct omap_hsmmc_host {
 	u32			sysctl;
 	u32			capa;
 	int			irq;
-	int			gpio_sdio_irq;
+	int			wakeirq;
 	int			use_dma, dma_ch;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
@@ -211,7 +211,7 @@ static irqreturn_t omap_hsmmc_cirq(int irq, void *dev_id)
 
 	spin_lock_irqsave(&host->irq_lock, flags);
 	if (host->flags & HSMMC_CIRQ_GPIO_ENABLED) {
-		disable_irq_nosync(host->gpio_sdio_irq);
+		disable_irq_nosync(host->wakeirq);
 		host->flags &= ~HSMMC_CIRQ_GPIO_ENABLED;
 	}
 	spin_unlock_irqrestore(&host->irq_lock, flags);
@@ -1159,7 +1159,8 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 			omap_hsmmc_do_irq(host, status);
 
 		if (status & CIRQ_EN)
-			mmc_signal_sdio_irq(host->mmc);
+			if (host->mmc->sdio_irq_thread)
+				mmc_signal_sdio_irq(host->mmc);
 
 		/* Flush posted write */
 		status = OMAP_HSMMC_READ(host->base, STAT);
@@ -1976,7 +1977,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->use_dma	= 1;
 	host->dma_ch	= -1;
 	host->irq	= irq;
-	host->gpio_sdio_irq = irq2;
+	host->wakeirq	= irq2;
 	host->slot_id	= 0;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
@@ -2153,20 +2154,19 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		mmc->caps |= MMC_CAP_SDIO_IRQ;
 		if (pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
 			/* use GPIO to wakeup from deeper power states */
-			if (!host->idle || !host->gpio_sdio_irq) {
+			if (!host->idle || !host->wakeirq) {
 				dev_warn(mmc_dev(host->mmc),
 					 "Disable SDIO IRQ workaround, GPIO IRQ or pinctrl idle state missing, falling back to polling\n");
 				mmc->caps &= ~MMC_CAP_SDIO_IRQ;
-			} else {
-				host->flags |= HSMMC_SWAKEUP_QUIRK;
-
 			}
 		}
 
-		if (host->flags & HSMMC_SWAKEUP_QUIRK) {
+		if (host->wakeirq) {
+			host->flags |= HSMMC_SWAKEUP_QUIRK;
+
 			/* prevent auto-enabling of IRQ */
-			irq_set_status_flags(host->gpio_sdio_irq, IRQ_NOAUTOEN);
-			ret = request_irq(host->gpio_sdio_irq, omap_hsmmc_cirq,
+			irq_set_status_flags(host->wakeirq, IRQ_NOAUTOEN);
+			ret = request_irq(host->wakeirq, omap_hsmmc_cirq,
 					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					  mmc_hostname(mmc), host);
 			if (ret) {
@@ -2201,8 +2201,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
-	if (host->gpio_sdio_irq)
-		free_irq(host->gpio_sdio_irq, host);
+	if (host->wakeirq)
+		free_irq(host->wakeirq, host);
 err_irq_sdio:
 	devm_pinctrl_put(host->pinctrl);
 err_pinctrl_state:
@@ -2252,8 +2252,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
 	free_irq(host->irq, host);
-	if ((host->gpio_sdio_irq))
-		free_irq(host->gpio_sdio_irq, host);
+	if ((host->wakeirq))
+		free_irq(host->wakeirq, host);
 	if (mmc_slot(host).card_detect_irq)
 		free_irq(mmc_slot(host).card_detect_irq, host);
 	if (host->tx_chan)
@@ -2317,7 +2317,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 	}
 
 	if (host->flags & HSMMC_SWAKEUP_QUIRK)
-		disable_irq(host->gpio_sdio_irq);
+		disable_irq(host->wakeirq);
 
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
@@ -2345,7 +2345,7 @@ static int omap_hsmmc_resume(struct device *dev)
 	omap_hsmmc_protect_card(host);
 
 	if (host->flags & HSMMC_SWAKEUP_QUIRK)
-		enable_irq(host->gpio_sdio_irq);
+		enable_irq(host->wakeirq);
 
 	pm_runtime_mark_last_busy(host->dev);
 	pm_runtime_put_autosuspend(host->dev);
@@ -2374,13 +2374,16 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 		OMAP_HSMMC_WRITE(host->base, IE, 0);
 		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 
-		ret = pinctrl_select_state(host->pinctrl, host->idle);
-		if (ret < 0)
-			dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
+		if (host->idle) {
+			ret = pinctrl_select_state(host->pinctrl, host->idle);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc),
+					 "Unable to select idle pinmux\n");
+		}
 
 		spin_lock_irqsave(&host->irq_lock, flags);
 		if (host->flags & HSMMC_SDIO_IRQ_ENABLED) {
-			enable_irq(host->gpio_sdio_irq);
+			enable_irq(host->wakeirq);
 			host->flags |= HSMMC_CIRQ_GPIO_ENABLED;
 		}
 		spin_unlock_irqrestore(&host->irq_lock, flags);
@@ -2403,14 +2406,17 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 
 		spin_lock_irqsave(&host->irq_lock, flags);
 		if (host->flags & HSMMC_CIRQ_GPIO_ENABLED) {
-			disable_irq_nosync(host->gpio_sdio_irq);
+			disable_irq_nosync(host->wakeirq);
 			host->flags &= ~HSMMC_CIRQ_GPIO_ENABLED;
 		}
 		spin_unlock_irqrestore(&host->irq_lock, flags);
 
-		ret = pinctrl_select_state(host->pinctrl, host->active);
-		if (ret < 0)
-			dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
+		if (host->active) {
+			ret = pinctrl_select_state(host->pinctrl, host->active);
+			if (ret < 0)
+				dev_warn(mmc_dev(host->mmc),
+					 "Unable to select active pinmux\n");
+		}
 
 		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 		OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
