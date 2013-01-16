From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 4/5] mmc: mvsdio: implement a Device Tree binding
Date: Wed, 16 Jan 2013 14:13:59 +0100
Message-ID: <1358342040-7130-5-git-send-email-andrew@lunn.ch>
References: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:49293 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108Ab3APNOo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Jan 2013 08:14:44 -0500
In-Reply-To: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This patch adds a simple Device Tree binding for the mvsdio driver, as
well as the necessary documentation for it. Compatibility with non-DT
platforms is preserved, by keeping the platform_data based
initialization.

We introduce a small difference between non-DT and DT platforms: DT
platforms are required to provide a clocks = <...> property, which the
driver uses to get the frequency of the clock that goes to the SDIO
IP. The behaviour on non-DT platforms is kept unchanged: a clock
reference is not mandatory, but the clock frequency must be passed in
the "clock" field of the mvsdio_platform_data structure.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Stefan Peter <s.peter@mpl.ch>
Tested-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 .../devicetree/bindings/mmc/orion-sdio.txt         |   17 ++++++
 drivers/mmc/host/mvsdio.c                          |   62 +++++++++++++++-----
 2 files changed, 64 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt

diff --git a/Documentation/devicetree/bindings/mmc/orion-sdio.txt b/Documentation/devicetree/bindings/mmc/orion-sdio.txt
new file mode 100644
index 0000000..84f0ebd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/orion-sdio.txt
@@ -0,0 +1,17 @@
+* Marvell orion-sdio controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the orion-sdio driver.
+
+- compatible: Should be "marvell,orion-sdio"
+- clocks: reference to the clock of the SDIO interface
+
+Example:
+
+	mvsdio@d00d4000 {
+		compatible = "marvell,orion-sdio";
+		reg = <0xd00d4000 0x200>;
+		interrupts = <54>;
+		clocks = <&gateclk 17>;
+		status = "disabled";
+	};
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 704b7a3..5ea0b96 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -21,6 +21,8 @@
 #include <linux/irq.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
 
@@ -681,17 +683,17 @@ mv_conf_mbus_windows(struct mvsd_host *host,
 
 static int __init mvsd_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct mmc_host *mmc = NULL;
 	struct mvsd_host *host = NULL;
-	const struct mvsdio_platform_data *mvsd_data;
 	const struct mbus_dram_target_info *dram;
 	struct resource *r;
 	int ret, irq;
+	int gpio_card_detect, gpio_write_protect;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	mvsd_data = pdev->dev.platform_data;
-	if (!r || irq < 0 || !mvsd_data)
+	if (!r || irq < 0)
 		return -ENXIO;
 
 	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
@@ -703,8 +705,37 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->dev = &pdev->dev;
-	host->base_clock = mvsd_data->clock / 2;
-	host->clk = ERR_PTR(-EINVAL);
+
+	/* Some non-DT platforms do not pass a clock, and the clock
+	   frequency is passed through platform_data. On DT platforms,
+	   a clock must always be passed, even if there is no gatable
+	   clock associated to the SDIO interface (it can simply be a
+	   fixed rate clock). */
+	host->clk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(host->clk))
+		clk_prepare_enable(host->clk);
+
+	if (np) {
+		if (IS_ERR(host->clk)) {
+			dev_err(&pdev->dev, "DT platforms must have a clock associated\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		host->base_clock = clk_get_rate(host->clk) / 2;
+		gpio_card_detect = of_get_named_gpio(np, "cd-gpios", 0);
+		gpio_write_protect = of_get_named_gpio(np, "wp-gpios", 0);
+	} else {
+		const struct mvsdio_platform_data *mvsd_data;
+		mvsd_data = pdev->dev.platform_data;
+		if (!mvsd_data) {
+			ret = -ENXIO;
+			goto out;
+		}
+		host->base_clock = mvsd_data->clock / 2;
+		gpio_card_detect = mvsd_data->gpio_card_detect;
+		gpio_write_protect = mvsd_data->gpio_write_protect;
+	}
 
 	mmc->ops = &mvsd_ops;
 
@@ -743,20 +774,14 @@ static int __init mvsd_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	/* Not all platforms can gate the clock, so it is not
-	   an error if the clock does not exists. */
-	host->clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(host->clk))
-		clk_prepare_enable(host->clk);
-
-	if (gpio_is_valid(mvsd_data->gpio_card_detect)) {
-		ret = mmc_gpio_request_cd(mmc, mvsd_data->gpio_card_detect);
+	if (gpio_is_valid(gpio_card_detect)) {
+		ret = mmc_gpio_request_cd(mmc, gpio_card_detect);
 		if (ret)
 			goto out;
 	} else
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
-	mmc_gpio_request_ro(mmc, mvsd_data->gpio_write_protect);
+	mmc_gpio_request_ro(mmc, gpio_write_protect);
 
 	setup_timer(&host->timer, mvsd_timeout_timer, (unsigned long)host);
 	platform_set_drvdata(pdev, mmc);
@@ -768,7 +793,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 			   mmc_hostname(mmc), DRIVER_NAME);
 	if (!(mmc->caps & MMC_CAP_NEEDS_POLL))
 		printk("using GPIO %d for card detection\n",
-		       mvsd_data->gpio_card_detect);
+		       gpio_card_detect);
 	else
 		printk("lacking card detect (fall back to polling)\n");
 	return 0;
@@ -832,12 +857,19 @@ static int mvsd_resume(struct platform_device *dev)
 #define mvsd_resume	NULL
 #endif
 
+static const struct of_device_id mvsdio_dt_ids[] = {
+	{ .compatible = "marvell,orion-sdio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mvsdio_dt_ids);
+
 static struct platform_driver mvsd_driver = {
 	.remove		= __exit_p(mvsd_remove),
 	.suspend	= mvsd_suspend,
 	.resume		= mvsd_resume,
 	.driver		= {
 		.name	= DRIVER_NAME,
+		.of_match_table = mvsdio_dt_ids,
 	},
 };
 
-- 
1.7.10.4

