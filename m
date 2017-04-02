From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 10/14] mmc: jz4740: Let the pinctrl driver configure the pins
Date: Sun,  2 Apr 2017 22:42:40 +0200
Message-ID: <20170402204244.14216-11-paul@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170402204244.14216-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
the pins being properly configured before the driver probes.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/jz4740_mmc.c | 44 +++++--------------------------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

 v2: Set pin sleep/default state in suspend/resume callbacks
 v3: No changes
 v4: Re-insert accidentally removed <linux/gpio.h> include

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 819ad32964fc..42b3ee566dc7 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
@@ -27,7 +28,6 @@
 
 #include <linux/bitops.h>
 #include <linux/gpio.h>
-#include <asm/mach-jz4740/gpio.h>
 #include <asm/cacheflush.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -906,15 +906,6 @@ static const struct mmc_host_ops jz4740_mmc_ops = {
 	.enable_sdio_irq = jz4740_mmc_enable_sdio_irq,
 };
 
-static const struct jz_gpio_bulk_request jz4740_mmc_pins[] = {
-	JZ_GPIO_BULK_PIN(MSC_CMD),
-	JZ_GPIO_BULK_PIN(MSC_CLK),
-	JZ_GPIO_BULK_PIN(MSC_DATA0),
-	JZ_GPIO_BULK_PIN(MSC_DATA1),
-	JZ_GPIO_BULK_PIN(MSC_DATA2),
-	JZ_GPIO_BULK_PIN(MSC_DATA3),
-};
-
 static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
 	const char *name, bool output, int value)
 {
@@ -978,15 +969,6 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
 		gpio_free(pdata->gpio_power);
 }
 
-static inline size_t jz4740_mmc_num_pins(struct jz4740_mmc_host *host)
-{
-	size_t num_pins = ARRAY_SIZE(jz4740_mmc_pins);
-	if (host->pdata && host->pdata->data_1bit)
-		num_pins -= 3;
-
-	return num_pins;
-}
-
 static int jz4740_mmc_probe(struct platform_device* pdev)
 {
 	int ret;
@@ -1027,15 +1009,9 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_free_host;
 	}
 
-	ret = jz_gpio_bulk_request(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request mmc pins: %d\n", ret);
-		goto err_free_host;
-	}
-
 	ret = jz4740_mmc_request_gpios(mmc, pdev);
 	if (ret)
-		goto err_gpio_bulk_free;
+		goto err_release_dma;
 
 	mmc->ops = &jz4740_mmc_ops;
 	mmc->f_min = JZ_MMC_CLK_RATE / 128;
@@ -1091,10 +1067,9 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	free_irq(host->irq, host);
 err_free_gpios:
 	jz4740_mmc_free_gpios(pdev);
-err_gpio_bulk_free:
+err_release_dma:
 	if (host->use_dma)
 		jz4740_mmc_release_dma_channels(host);
-	jz_gpio_bulk_free(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
 err_free_host:
 	mmc_free_host(mmc);
 
@@ -1114,7 +1089,6 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 	free_irq(host->irq, host);
 
 	jz4740_mmc_free_gpios(pdev);
-	jz_gpio_bulk_free(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
 
 	if (host->use_dma)
 		jz4740_mmc_release_dma_channels(host);
@@ -1128,20 +1102,12 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 
 static int jz4740_mmc_suspend(struct device *dev)
 {
-	struct jz4740_mmc_host *host = dev_get_drvdata(dev);
-
-	jz_gpio_bulk_suspend(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
-
-	return 0;
+	return pinctrl_pm_select_sleep_state(dev);
 }
 
 static int jz4740_mmc_resume(struct device *dev)
 {
-	struct jz4740_mmc_host *host = dev_get_drvdata(dev);
-
-	jz_gpio_bulk_resume(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
-
-	return 0;
+	return pinctrl_pm_select_default_state(dev);
 }
 
 static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
-- 
2.11.0
