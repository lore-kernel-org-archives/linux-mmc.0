From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v7 3/4] mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on AM335x.
Date: Tue, 25 Feb 2014 13:37:45 +0100
Message-ID: <1393331866-28307-4-git-send-email-afenkart@gmail.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The am335x can't detect pending cirq in PM runtime suspend.
This patch reconfigures dat1 as a GPIO before going to suspend.
SDIO interrupts are detected with the GPIO, the GPIO will only wake
the module from suspend, SDIO irq detection will still happen through the
IP block.

Idea of remuxing the pins by Tony Lindgren, all bugs are mine.

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

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
index 5e60925..452c05a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -29,6 +29,7 @@
 #include <linux/timer.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
 #include <linux/omap-dma.h>
@@ -36,6 +37,7 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/mmc.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pinctrl/consumer.h>
@@ -206,6 +208,7 @@ struct omap_hsmmc_host {
 	u32			sysctl;
 	u32			capa;
 	int			irq;
+	int			gpio_sdio_irq;
 	int			use_dma, dma_ch;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
@@ -218,6 +221,8 @@ struct omap_hsmmc_host {
 	int			req_in_progress;
 	int                     flags;
 #define HSMMC_SDIO_IRQ_ENABLED	(1 << 0)        /* SDIO irq enabled */
+#define HSMMC_SWAKEUP_QUIRK	(1 << 1)
+#define HSMMC_CIRQ_GPIO_ENABLED (1 << 2)
 
 	struct omap_hsmmc_next	next_data;
 	struct pinctrl		*pinctrl;
@@ -225,6 +230,23 @@ struct omap_hsmmc_host {
 	struct	omap_mmc_platform_data	*pdata;
 };
 
+static irqreturn_t omap_hsmmc_cirq(int irq, void *dev_id)
+{
+	struct omap_hsmmc_host *host = dev_id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+	if (host->flags & HSMMC_CIRQ_GPIO_ENABLED) {
+		disable_irq_nosync(host->gpio_sdio_irq);
+		host->flags &= ~HSMMC_CIRQ_GPIO_ENABLED;
+	}
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+
+	pm_request_resume(host->dev); /* no use counter */
+
+	return IRQ_HANDLED;
+}
+
 static int omap_hsmmc_card_detect(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
@@ -1920,7 +1942,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
-	int ret, irq;
+	int ret, irq, _gpio_cirq;
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
@@ -1956,6 +1978,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL || irq < 0)
 		return -ENXIO;
 
+	_gpio_cirq = 0;
+	if (pdev->dev.of_node)
+		_gpio_cirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
+
 	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (res == NULL)
 		return -EBUSY;
@@ -1977,6 +2003,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->use_dma	= 1;
 	host->dma_ch	= -1;
 	host->irq	= irq;
+	host->gpio_sdio_irq = _gpio_cirq;
 	host->slot_id	= 0;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
@@ -2162,8 +2189,28 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		mmc->caps |= MMC_CAP_SDIO_IRQ;
 		if (pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
-			/* no wakeup from deeper power states, use polling */
-			mmc->caps &= ~MMC_CAP_SDIO_IRQ;
+			/* use GPIO to wakeup from deeper power states */
+			if (!host->idle || !host->gpio_sdio_irq) {
+				dev_warn(mmc_dev(host->mmc),
+					 "Disable SDIO IRQ workaround, GPIO IRQ or pinctrl idle state missing, falling back to polling\n");
+				mmc->caps &= ~MMC_CAP_SDIO_IRQ;
+			} else {
+				host->flags |= HSMMC_SWAKEUP_QUIRK;
+
+			}
+		}
+
+		if (host->flags & HSMMC_SWAKEUP_QUIRK) {
+			/* prevent auto-enabling of IRQ */
+			irq_set_status_flags(host->gpio_sdio_irq, IRQ_NOAUTOEN);
+			ret = request_irq(host->gpio_sdio_irq, omap_hsmmc_cirq,
+					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					  mmc_hostname(mmc), host);
+			if (ret) {
+				dev_err(mmc_dev(host->mmc),
+					"Unable to grab GPIO SDIO IRQ\n");
+				goto err_irq_sdio;
+			}
 		}
 	}
 
@@ -2191,6 +2238,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
+	if (host->gpio_sdio_irq)
+		free_irq(host->gpio_sdio_irq, host);
+err_irq_sdio:
 	if (host->pinctrl)
 		devm_pinctrl_put(host->pinctrl);
 err_pinctrl_state:
@@ -2240,6 +2290,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
 	free_irq(host->irq, host);
+	if ((host->gpio_sdio_irq))
+		free_irq(host->gpio_sdio_irq, host);
 	if (mmc_slot(host).card_detect_irq)
 		free_irq(mmc_slot(host).card_detect_irq, host);
 
@@ -2304,6 +2356,8 @@ static int omap_hsmmc_suspend(struct device *dev)
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 	}
 
+	if (host->flags & HSMMC_SWAKEUP_QUIRK)
+		disable_irq(host->gpio_sdio_irq);
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 
@@ -2329,6 +2383,9 @@ static int omap_hsmmc_resume(struct device *dev)
 
 	omap_hsmmc_protect_card(host);
 
+	if (host->flags & HSMMC_SWAKEUP_QUIRK)
+		enable_irq(host->gpio_sdio_irq);
+
 	pm_runtime_mark_last_busy(host->dev);
 	pm_runtime_put_autosuspend(host->dev);
 	return 0;
@@ -2344,23 +2401,61 @@ static int omap_hsmmc_resume(struct device *dev)
 static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	unsigned long flags;
+	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_save(host);
 	dev_dbg(dev, "disabled\n");
 
-	return 0;
+	if (host->flags & HSMMC_SWAKEUP_QUIRK) {
+		OMAP_HSMMC_WRITE(host->base, ISE, 0);
+		OMAP_HSMMC_WRITE(host->base, IE, 0);
+		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+
+		ret = pinctrl_select_state(host->pinctrl, host->idle);
+		if (ret < 0)
+			dev_warn(mmc_dev(host->mmc), "Unable to select idle pinmux\n");
+
+		spin_lock_irqsave(&host->irq_lock, flags);
+		if (host->flags & HSMMC_SDIO_IRQ_ENABLED) {
+			enable_irq(host->gpio_sdio_irq);
+			host->flags |= HSMMC_CIRQ_GPIO_ENABLED;
+		}
+		spin_unlock_irqrestore(&host->irq_lock, flags);
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
+	if (host->flags & HSMMC_SWAKEUP_QUIRK) {
+
+		spin_lock_irqsave(&host->irq_lock, flags);
+		if (host->flags & HSMMC_CIRQ_GPIO_ENABLED) {
+			disable_irq_nosync(host->gpio_sdio_irq);
+			host->flags &= ~HSMMC_CIRQ_GPIO_ENABLED;
+		}
+		spin_unlock_irqrestore(&host->irq_lock, flags);
+
+		ret = pinctrl_select_state(host->pinctrl, host->active);
+		if (ret < 0)
+			dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
+
+		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+		OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
+		OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
+	}
+	return ret;
 }
 
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
-- 
1.7.10.4

