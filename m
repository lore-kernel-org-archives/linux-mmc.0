From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH] mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in idle mode.
Date: Thu, 20 Dec 2012 23:12:12 +0100
Message-ID: <1356041532-919-1-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20121220220444.GA350@blumentopf>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:55928 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838Ab2LTWMb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 20 Dec 2012 17:12:31 -0500
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Lvvs3-1T2PNT26Ob-017oFo for
 <linux-mmc@vger.kernel.org>; Thu, 20 Dec 2012 23:12:30 +0100
In-Reply-To: <20121220220444.GA350@blumentopf>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com
Cc: cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, zonque@gmail.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Without functional clock the omap_hsmmc module can't forward
SDIO IRQs to the system. This patch reconfigures dat1 line
as a gpio while the fclk is off. And uses SDIO IRQ detection of
the module, while fclk is present.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   42 ++++
 arch/arm/plat-omap/include/plat/mmc.h              |    4 +
 drivers/mmc/host/omap_hsmmc.c                      |  219 ++++++++++++++++++--
 3 files changed, 247 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index d1b8932..4d57637 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -24,6 +24,29 @@ One tx and one rx pair is required.
 dma-names: DMA request names. These strings correspond 1:1 with
 the ordered pairs in dmas. The RX request must be "rx" and the
 TX request must be "tx".
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
 
 Examples:
 
@@ -53,3 +76,22 @@ Examples:
 			&edma 25>;
 		dma-names = "tx", "rx";
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
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 8b4e4f2..807676a 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -130,6 +130,7 @@ struct omap_mmc_platform_data {
 
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
+		int gpio_cirq;			/* gpio (card irq) */
 
 		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (*set_power)(struct device *dev, int slot,
@@ -160,6 +161,9 @@ struct omap_mmc_platform_data {
 		int card_detect_irq;
 		int (*card_detect)(struct device *dev, int slot);
 
+		/* SDIO IRQs */
+		int sdio_irq;
+
 		unsigned int ban_openended:1;
 
 	} slots[OMAP_MMC_MAX_SLOTS];
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 53703c6..1a48cb1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -108,6 +108,7 @@ static void apply_clk_hack(void)
 #define INT_EN_MASK		0x307F0033
 #define BWR_ENABLE		(1 << 4)
 #define BRR_ENABLE		(1 << 5)
+#define CIRQ_ENABLE		(1 << 8)
 #define DTO_ENABLE		(1 << 20)
 #define INIT_STREAM		(1 << 1)
 #define DP_SELECT		(1 << 21)
@@ -121,6 +122,7 @@ static void apply_clk_hack(void)
 #define CC			0x1
 #define TC			0x02
 #define OD			0x1
+#define CIRQ			(1 << 8)
 #define ERR			(1 << 15)
 #define CMD_TIMEOUT		(1 << 16)
 #define DATA_TIMEOUT		(1 << 20)
@@ -198,11 +200,25 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+	bool			active_pinmux;
+	bool			sdio_irq_en;
 	struct omap_hsmmc_next	next_data;
 
 	struct	omap_mmc_platform_data	*pdata;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *active, *idle;
+
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
@@ -437,10 +453,30 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
 	} else
 		pdata->slots[0].gpio_wp = -EINVAL;
 
+	if (gpio_is_valid(pdata->slots[0].gpio_cirq)) {
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
@@ -454,6 +490,8 @@ static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 		gpio_free(pdata->slots[0].gpio_wp);
 	if (gpio_is_valid(pdata->slots[0].switch_pin))
 		gpio_free(pdata->slots[0].switch_pin);
+	if (gpio_is_valid(pdata->slots[0].gpio_cirq))
+		gpio_free(pdata->slots[0].gpio_cirq);
 }
 
 /*
@@ -479,27 +517,46 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
 static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 				  struct mmc_command *cmd)
 {
-	unsigned int irq_mask;
+	u32 irq_mask = INT_EN_MASK;
+	unsigned long flags;
 
 	if (host->use_dma)
-		irq_mask = INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE);
-	else
-		irq_mask = INT_EN_MASK;
+		irq_mask &= ~(BRR_ENABLE | BWR_ENABLE);
 
 	/* Disable timeout for erases */
 	if (cmd->opcode == MMC_ERASE)
 		irq_mask &= ~DTO_ENABLE;
 
+	spin_lock_irqsave(&host->irq_lock, flags);
+
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+
+	/* latch pending CIRQ, but don't signal */
+	if (host->sdio_irq_en)
+		irq_mask |= CIRQ_ENABLE;
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
+	/* no transfer running, need to signal cirq */
+	if (host->sdio_irq_en && host->active_pinmux)
+		irq_mask |= CIRQ_ENABLE;
+
+	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 }
 
 /* Calculate divisor for the given clock frequency */
@@ -1044,8 +1101,13 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	int status;
 
 	status = OMAP_HSMMC_READ(host->base, STAT);
-	while (status & INT_EN_MASK && host->req_in_progress) {
-		omap_hsmmc_do_irq(host, status);
+	while (status & (INT_EN_MASK | CIRQ)) {
+
+		if (host->req_in_progress)
+			omap_hsmmc_do_irq(host, status);
+
+		if (status & CIRQ)
+			mmc_signal_sdio_irq(host->mmc);
 
 		/* Flush posted write */
 		OMAP_HSMMC_WRITE(host->base, STAT, status);
@@ -1561,6 +1623,44 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
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
+	host->sdio_irq_en = (enable != 0) ? true : false;
+
+	if (host->active_pinmux) {
+		irq_mask = OMAP_HSMMC_READ(host->base, ISE);
+		if (enable)
+			irq_mask |= CIRQ_ENABLE;
+		else
+			irq_mask &= ~CIRQ_ENABLE;
+		OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
+
+		if (!host->req_in_progress)
+			OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+
+#if 0
+		OMAP_HSMMC_READ(host->base, IE); /* flush posted write */
+#endif
+	}
+
+	if ((mmc_slot(host).sdio_irq)) {
+		/* enable/disable-irq uses depth counter, this allows
+		 * it to drop to zero in runtime suspend */
+		if (enable)
+			enable_irq(mmc_slot(host).sdio_irq);
+		else
+			disable_irq_nosync(mmc_slot(host).sdio_irq);
+	}
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
 	u32 hctl, capa, value;
@@ -1613,7 +1713,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
 	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1729,6 +1829,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	pdata->nr_slots = 1;
 	pdata->slots[0].switch_pin = of_get_named_gpio(np, "cd-gpios", 0);
 	pdata->slots[0].gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
+	pdata->slots[0].gpio_cirq = of_get_named_gpio(np, "ti,cirq-gpio", 0);
 
 	if (of_find_property(np, "ti,non-removable", NULL)) {
 		pdata->slots[0].nonremovable = true;
@@ -1766,7 +1867,6 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
-	struct pinctrl *pinctrl;
 
 	apply_clk_hack();
 
@@ -1818,6 +1918,8 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	host->dma_ch	= -1;
 	host->irq	= irq;
 	host->slot_id	= 0;
+	host->sdio_irq_en = false;
+	host->active_pinmux = true;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
@@ -1988,12 +2090,51 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 		pdata->resume = omap_hsmmc_resume_cdirq;
 	}
 
+	if ((mmc_slot(host).sdio_irq)) {
+		ret = request_irq(mmc_slot(host).sdio_irq, omap_hsmmc_cirq,
+				  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				  mmc_hostname(mmc), host);
+		if (ret) {
+			dev_dbg(mmc_dev(host->mmc),
+				"Unable to grab MMC SDIO IRQ\n");
+			goto err_irq_sdio;
+		}
+		disable_irq(mmc_slot(host).sdio_irq); /* active pinmux */
+		disable_irq(mmc_slot(host).sdio_irq); /* SDIO IRQ disabled */
+	}
+
 	omap_hsmmc_disable_irq(host);
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev,
-			"pins are not configured from the driver\n");
+	host->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(host->pinctrl)) {
+		ret = PTR_ERR(host->pinctrl);
+		goto err_pinctrl;
+	}
+
+	host->active = pinctrl_lookup_state(host->pinctrl,
+					    PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(host->active)) {
+		dev_warn(mmc_dev(host->mmc), "Unable to lookup active pinmux\n");
+		ret = PTR_ERR(host->active);
+		goto err_pinctrl_state;
+	}
+
+	if (mmc_slot(host).sdio_irq) {
+		host->idle = pinctrl_lookup_state(host->pinctrl,
+						  PINCTRL_STATE_IDLE);
+		if (IS_ERR(host->idle)) {
+			dev_warn(mmc_dev(host->mmc), "Unable to lookup idle pinmux\n");
+			ret = PTR_ERR(host->idle);
+			goto err_pinctrl_state;
+		}
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
+	}
+
+	ret = pinctrl_select_state(host->pinctrl, host->active);
+	if (ret < 0) {
+		dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
+		goto err_pinctrl_state;
+	}
 
 	omap_hsmmc_protect_card(host);
 
@@ -2019,6 +2160,12 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
+err_pinctrl_state:
+	devm_pinctrl_put(host->pinctrl);
+err_pinctrl:
+	if ((mmc_slot(host).sdio_irq))
+		free_irq(mmc_slot(host).sdio_irq, host);
+err_irq_sdio:
 	free_irq(mmc_slot(host).card_detect_irq, host);
 err_irq_cd:
 	if (host->use_reg)
@@ -2065,13 +2212,15 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
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
@@ -2188,23 +2337,57 @@ static int omap_hsmmc_resume(struct device *dev)
 static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	unsigned long flags;
+	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_save(host);
 	dev_dbg(dev, "disabled\n");
 
-	return 0;
+	if (mmc_slot(host).sdio_irq && host->pinctrl) {
+
+		spin_lock_irqsave(&host->irq_lock, flags);
+		host->active_pinmux = false;
+		spin_unlock_irqrestore(&host->irq_lock, flags);
+
+		omap_hsmmc_disable_irq(host);
+
+		ret = pinctrl_select_state(host->pinctrl, host->idle);
+		if (ret < 0) {
+			dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
+			return ret;
+		}
+
+		enable_irq(mmc_slot(host).sdio_irq);
+	}
+
+	return ret;
 }
 
 static int omap_hsmmc_runtime_resume(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	unsigned long flags;
+	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_restore(host);
 	dev_dbg(dev, "enabled\n");
 
-	return 0;
+	if (mmc_slot(host).sdio_irq && host->pinctrl) {
+		spin_lock_irqsave(&host->irq_lock, flags);
+		host->active_pinmux = true;
+		spin_unlock_irqrestore(&host->irq_lock, flags);
+
+		disable_irq_nosync(mmc_slot(host).sdio_irq);
+
+		ret = pinctrl_select_state(host->pinctrl, host->active);
+		if (ret < 0) {
+			dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
+			return ret;
+		}
+	}
+	return ret;
 }
 
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
-- 
1.7.10.4

