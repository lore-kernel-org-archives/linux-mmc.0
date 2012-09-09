From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: sdhci-pxav3: dt: Support "power-gpios" property
Date: Sat, 08 Sep 2012 23:06:57 -0400
Message-ID: <87ligjzyge.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53840 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab2IIDHO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 8 Sep 2012 23:07:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Tested on OLPC XO-4/MMP3, where the card power for two of the
controllers is a sideband GPIO.  The third cell in the power-gpios
property controls whether the GPIO is active high/active low.

(Also, pass host_caps2 through from platdata to the mmc host.)

Signed-off-by: Chris Ball <cjb@laptop.org>
---
This patch depends on "mmc: slot-gpio: Add support for power gpios"

 drivers/mmc/host/sdhci-pxav3.c          | 25 +++++++++++++++++++++++++
 include/linux/platform_data/pxa_sdhci.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 8a9b367..0bdb326 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -24,12 +24,14 @@
 #include <linux/gpio.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/platform_data/pxa_sdhci.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
@@ -182,6 +184,7 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 	struct device_node *np = dev->of_node;
 	u32 bus_width;
 	u32 clk_delay_cycles;
+	enum of_gpio_flags gpio_flags;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -204,6 +207,10 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 	if (of_find_property(np, "wp-inverted", NULL))
 		pdata->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
+	pdata->power_gpio = of_get_named_gpio_flags(np, "power-gpios", 0, &gpio_flags);
+	if (gpio_flags != OF_GPIO_ACTIVE_LOW)
+		pdata->host_caps2 |= MMC_CAP2_PWR_ACTIVE_HIGH;
+
 	return pdata;
 }
 #else
@@ -272,8 +279,19 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 			host->quirks |= pdata->quirks;
 		if (pdata->host_caps)
 			host->mmc->caps |= pdata->host_caps;
+		if (pdata->host_caps2)
+			host->mmc->caps2 |= pdata->host_caps2;
 		if (pdata->pm_caps)
 			host->mmc->pm_caps |= pdata->pm_caps;
+
+		if (gpio_is_valid(pdata->power_gpio)) {
+			ret = mmc_gpio_request_pwr(host->mmc, pdata->power_gpio);
+			if (ret) {
+				dev_err(mmc_dev(host->mmc),
+					"failed to allocate power gpio\n");
+				goto err_power_req;
+			}
+		}
 	}
 
 	host->ops = &pxav3_sdhci_ops;
@@ -291,6 +309,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 err_add_host:
 	clk_disable_unprepare(clk);
 	clk_put(clk);
+	mmc_gpio_free_pwr(host->mmc);
+err_power_req:
 err_clk_get:
 	sdhci_pltfm_free(pdev);
 	kfree(pxa);
@@ -300,6 +320,7 @@ err_clk_get:
 static int __devexit sdhci_pxav3_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = pltfm_host->priv;
 
@@ -307,6 +328,10 @@ static int __devexit sdhci_pxav3_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
+
+	if (gpio_is_valid(pdata->power_gpio))
+		mmc_gpio_free_pwr(host->mmc);
+
 	sdhci_pltfm_free(pdev);
 	kfree(pxa);
 
diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
index 51ad099..e08ffc2 100644
--- a/include/linux/platform_data/pxa_sdhci.h
+++ b/include/linux/platform_data/pxa_sdhci.h
@@ -47,8 +47,10 @@ struct sdhci_pxa_platdata {
 	bool		clk_delay_enable;
 	unsigned int	ext_cd_gpio;
 	bool		ext_cd_gpio_invert;
+	unsigned int	power_gpio;
 	unsigned int	max_speed;
 	unsigned int	host_caps;
+	unsigned int	host_caps2;
 	unsigned int	quirks;
 	unsigned int	pm_caps;
 };
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
