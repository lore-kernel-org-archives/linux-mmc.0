From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 09/13] mmc: jz4740: Let the pinctrl driver configure the pins
Date: Wed, 18 Jan 2017 00:14:17 +0100
Message-ID: <20170117231421.16310-10-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
the pins being properly configured before the driver probes.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 59 ++-----------------------------------------
 1 file changed, 2 insertions(+), 57 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 819ad32964fc..28a8e0acd70a 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -27,7 +27,6 @@
 
 #include <linux/bitops.h>
 #include <linux/gpio.h>
-#include <asm/mach-jz4740/gpio.h>
 #include <asm/cacheflush.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -906,15 +905,6 @@ static const struct mmc_host_ops jz4740_mmc_ops = {
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
@@ -978,15 +968,6 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
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
@@ -1027,15 +1008,9 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
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
@@ -1091,10 +1066,9 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
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
 
@@ -1114,7 +1088,6 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 	free_irq(host->irq, host);
 
 	jz4740_mmc_free_gpios(pdev);
-	jz_gpio_bulk_free(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
 
 	if (host->use_dma)
 		jz4740_mmc_release_dma_channels(host);
@@ -1124,39 +1097,11 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-
-static int jz4740_mmc_suspend(struct device *dev)
-{
-	struct jz4740_mmc_host *host = dev_get_drvdata(dev);
-
-	jz_gpio_bulk_suspend(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
-
-	return 0;
-}
-
-static int jz4740_mmc_resume(struct device *dev)
-{
-	struct jz4740_mmc_host *host = dev_get_drvdata(dev);
-
-	jz_gpio_bulk_resume(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
-	jz4740_mmc_resume);
-#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
-#else
-#define JZ4740_MMC_PM_OPS NULL
-#endif
-
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
 	.remove = jz4740_mmc_remove,
 	.driver = {
 		.name = "jz4740-mmc",
-		.pm = JZ4740_MMC_PM_OPS,
 	},
 };
 
-- 
2.11.0
