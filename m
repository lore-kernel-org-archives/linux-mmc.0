From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/7] mmc: sdhci: make sdhci-pltfm device drivers self registered
Date: Thu,  5 May 2011 21:22:52 +0800
Message-ID: <1304601778-13837-2-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61055 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab1EENRu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 09:17:50 -0400
Received: by pvg12 with SMTP id 12so956820pvg.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 May 2011 06:17:49 -0700 (PDT)
In-Reply-To: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The patch turns the common stuff in sdhci-pltfm.c into functions, and
add device drivers their own .probe and .remove which in turn call
into the common functions, so that those sdhci-pltfm device drivers
register itself and keep all device specific things away from common
sdhci-pltfm file.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/mmc/host/Kconfig           |   32 ++++----
 drivers/mmc/host/Makefile          |   11 +--
 drivers/mmc/host/sdhci-cns3xxx.c   |   42 +++++++++-
 drivers/mmc/host/sdhci-dove.c      |   42 +++++++++-
 drivers/mmc/host/sdhci-esdhc-imx.c |  112 ++++++++++++++++++-------
 drivers/mmc/host/sdhci-pltfm.c     |  157 +++++++++---------------------------
 drivers/mmc/host/sdhci-pltfm.h     |   17 +++-
 drivers/mmc/host/sdhci-tegra.c     |  118 +++++++++++++++++++--------
 include/linux/mmc/sdhci-pltfm.h    |    6 --
 9 files changed, 317 insertions(+), 220 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index b981715..799e935 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -113,28 +113,27 @@ config MMC_SDHCI_OF_HLWD
 	  If unsure, say N.
 
 config MMC_SDHCI_PLTFM
-	tristate "SDHCI support on the platform specific bus"
+	bool
 	depends on MMC_SDHCI
 	help
-	  This selects the platform specific bus support for Secure Digital Host
-	  Controller Interface.
-
-	  If you have a controller with this interface, say Y or M here.
-
-	  If unsure, say N.
+	  This selects the platform common function support for Secure Digital
+	  Host Controller Interface.
 
 config MMC_SDHCI_CNS3XXX
-	bool "SDHCI support on the Cavium Networks CNS3xxx SoC"
+	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
 	depends on ARCH_CNS3XXX
-	depends on MMC_SDHCI_PLTFM
+	depends on MMC_SDHCI
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the SDHCI support for CNS3xxx System-on-Chip devices.
 
 	  If unsure, say N.
 
 config MMC_SDHCI_ESDHC_IMX
-	bool "SDHCI platform support for the Freescale eSDHC i.MX controller"
-	depends on MMC_SDHCI_PLTFM && (ARCH_MX25 || ARCH_MX35 || ARCH_MX5)
+	tristate "SDHCI platform support for the Freescale eSDHC i.MX controller"
+	depends on ARCH_MX25 || ARCH_MX35 || ARCH_MX5
+	depends on MMC_SDHCI
+	select MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Freescale eSDHC controller support on the platform
@@ -143,9 +142,10 @@ config MMC_SDHCI_ESDHC_IMX
 	  If unsure, say N.
 
 config MMC_SDHCI_DOVE
-	bool "SDHCI support on Marvell's Dove SoC"
+	tristate "SDHCI support on Marvell's Dove SoC"
 	depends on ARCH_DOVE
-	depends on MMC_SDHCI_PLTFM
+	depends on MMC_SDHCI
+	select MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface in
@@ -154,8 +154,10 @@ config MMC_SDHCI_DOVE
 	  If unsure, say N.
 
 config MMC_SDHCI_TEGRA
-	bool "SDHCI platform support for the Tegra SD/MMC Controller"
-	depends on MMC_SDHCI_PLTFM && ARCH_TEGRA
+	tristate "SDHCI platform support for the Tegra SD/MMC Controller"
+	depends on ARCH_TEGRA
+	depends on MMC_SDHCI
+	select MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Tegra SD/MMC controller. If you have a Tegra
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4f1df0a..95fddb8 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -43,12 +43,11 @@ obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_USHC)		+= ushc.o
 
-obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= sdhci-platform.o
-sdhci-platform-y				:= sdhci-pltfm.o
-sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+= sdhci-cns3xxx.o
-sdhci-platform-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
-sdhci-platform-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
-sdhci-platform-$(CONFIG_MMC_SDHCI_TEGRA)	+= sdhci-tegra.o
+obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
+obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
+obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
+obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
+obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
 
 obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
 sdhci-of-y				:= sdhci-of-core.o
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 9ebd1d7..ac4b26f 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -86,7 +86,7 @@ static struct sdhci_ops sdhci_cns3xxx_ops = {
 	.set_clock	= sdhci_cns3xxx_set_clock,
 };
 
-struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
+static struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
 	.ops = &sdhci_cns3xxx_ops,
 	.quirks = SDHCI_QUIRK_BROKEN_DMA |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
@@ -95,3 +95,43 @@ struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
 		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_NONSTANDARD_CLOCK,
 };
+
+static int __devinit sdhci_cns3xxx_probe(struct platform_device *pdev)
+{
+	return sdhci_pltfm_register(pdev, &sdhci_cns3xxx_pdata);
+}
+
+static int __devexit sdhci_cns3xxx_remove(struct platform_device *pdev)
+{
+	return sdhci_pltfm_unregister(pdev);
+}
+
+static struct platform_driver sdhci_cns3xxx_driver = {
+	.driver		= {
+		.name	= "sdhci-cns3xxx",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_cns3xxx_probe,
+	.remove		= __devexit_p(sdhci_cns3xxx_remove),
+#ifdef CONFIG_PM
+	.suspend	= sdhci_pltfm_suspend,
+	.resume		= sdhci_pltfm_resume,
+#endif
+};
+
+static int __init sdhci_cns3xxx_init(void)
+{
+	return platform_driver_register(&sdhci_cns3xxx_driver);
+}
+module_init(sdhci_cns3xxx_init);
+
+static void __exit sdhci_cns3xxx_exit(void)
+{
+	platform_driver_unregister(&sdhci_cns3xxx_driver);
+}
+module_exit(sdhci_cns3xxx_exit);
+
+MODULE_DESCRIPTION("SDHCI driver for CNS3xxx");
+MODULE_AUTHOR("Scott Shu, "
+	      "Anton Vorontsov <avorontsov@mvista.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 2aeef4f..49aa533 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -61,10 +61,50 @@ static struct sdhci_ops sdhci_dove_ops = {
 	.read_l	= sdhci_dove_readl,
 };
 
-struct sdhci_pltfm_data sdhci_dove_pdata = {
+static struct sdhci_pltfm_data sdhci_dove_pdata = {
 	.ops	= &sdhci_dove_ops,
 	.quirks	= SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
 		  SDHCI_QUIRK_NO_BUSY_IRQ |
 		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_FORCE_DMA,
 };
+
+static int __devinit sdhci_dove_probe(struct platform_device *pdev)
+{
+	return sdhci_pltfm_register(pdev, &sdhci_dove_pdata);
+}
+
+static int __devexit sdhci_dove_remove(struct platform_device *pdev)
+{
+	return sdhci_pltfm_unregister(pdev);
+}
+
+static struct platform_driver sdhci_dove_driver = {
+	.driver		= {
+		.name	= "sdhci-dove",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_dove_probe,
+	.remove		= __devexit_p(sdhci_dove_remove),
+#ifdef CONFIG_PM
+	.suspend	= sdhci_pltfm_suspend,
+	.resume		= sdhci_pltfm_resume,
+#endif
+};
+
+static int __init sdhci_dove_init(void)
+{
+	return platform_driver_register(&sdhci_dove_driver);
+}
+module_init(sdhci_dove_init);
+
+static void __exit sdhci_dove_exit(void)
+{
+	platform_driver_unregister(&sdhci_dove_driver);
+}
+module_exit(sdhci_dove_exit);
+
+MODULE_DESCRIPTION("SDHCI driver for Dove");
+MODULE_AUTHOR("Saeed Bishara <saeed@marvell.com>, "
+	      "Mike Rapoport <mike@compulab.co.il>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a19967d..8da57d4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -191,16 +191,6 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk) / 256 / 16;
 }
 
-static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
-{
-	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
-
-	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
-		return gpio_get_value(boarddata->wp_gpio);
-	else
-		return -ENOSYS;
-}
-
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -212,6 +202,23 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 };
 
+static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
+			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+	/* ADMA has issues. Might be fixable */
+	.ops = &sdhci_esdhc_ops,
+};
+
+static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
+{
+	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
+
+	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
+		return gpio_get_value(boarddata->wp_gpio);
+	else
+		return -ENOSYS;
+}
+
 static irqreturn_t cd_irq(int irq, void *data)
 {
 	struct sdhci_host *sdhost = (struct sdhci_host *)data;
@@ -220,30 +227,35 @@ static irqreturn_t cd_irq(int irq, void *data)
 	return IRQ_HANDLED;
 };
 
-static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pdata)
+static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_host *host;
+	struct esdhc_platform_data *boarddata;
 	struct clk *clk;
 	int err;
 	struct pltfm_imx_data *imx_data;
 
+	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+
+	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
+	if (!imx_data)
+		return -ENOMEM;
+	pltfm_host->priv = imx_data;
+
 	clk = clk_get(mmc_dev(host->mmc), NULL);
 	if (IS_ERR(clk)) {
 		dev_err(mmc_dev(host->mmc), "clk err\n");
-		return PTR_ERR(clk);
+		err = PTR_ERR(clk);
+		goto err_clk_get;
 	}
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
-	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
-	if (!imx_data) {
-		clk_disable(pltfm_host->clk);
-		clk_put(pltfm_host->clk);
-		return -ENOMEM;
-	}
-	pltfm_host->priv = imx_data;
-
 	if (!cpu_is_mx25())
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
@@ -257,6 +269,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	if (!(cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51()))
 		imx_data->flags |= ESDHC_FLAG_MULTIBLK_NO_INT;
 
+	boarddata = host->mmc->parent->platform_data;
 	if (boarddata) {
 		err = gpio_request_one(boarddata->wp_gpio, GPIOF_IN, "ESDHC_WP");
 		if (err) {
@@ -289,6 +302,10 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 	}
 
+	err = sdhci_add_host(host);
+	if (err)
+		goto err_add_host;
+
 	return 0;
 
  no_card_detect_irq:
@@ -297,14 +314,23 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	boarddata->cd_gpio = err;
  not_supported:
 	kfree(imx_data);
-	return 0;
+ err_add_host:
+	clk_disable(pltfm_host->clk);
+	clk_put(pltfm_host->clk);
+ err_clk_get:
+	sdhci_pltfm_free(pdev);
+	return err;
 }
 
-static void esdhc_pltfm_exit(struct sdhci_host *host)
+static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 {
+	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
+
+	sdhci_remove_host(host, dead);
 
 	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
 		gpio_free(boarddata->wp_gpio);
@@ -319,13 +345,37 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 	kfree(imx_data);
+
+	sdhci_pltfm_free(pdev);
+
+	return 0;
 }
 
-struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
-			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
-	/* ADMA has issues. Might be fixable */
-	.ops = &sdhci_esdhc_ops,
-	.init = esdhc_pltfm_init,
-	.exit = esdhc_pltfm_exit,
+static struct platform_driver sdhci_esdhc_imx_driver = {
+	.driver		= {
+		.name	= "sdhci-esdhc-imx",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_esdhc_imx_probe,
+	.remove		= __devexit_p(sdhci_esdhc_imx_remove),
+#ifdef CONFIG_PM
+	.suspend	= sdhci_pltfm_suspend,
+	.resume		= sdhci_pltfm_resume,
+#endif
 };
+ 
+static int __init sdhci_esdhc_imx_init(void)
+{
+	return platform_driver_register(&sdhci_esdhc_imx_driver);
+}
+module_init(sdhci_esdhc_imx_init);
+
+static void __exit sdhci_esdhc_imx_exit(void)
+{
+	platform_driver_unregister(&sdhci_esdhc_imx_driver);
+}
+module_exit(sdhci_esdhc_imx_exit);
+
+MODULE_DESCRIPTION("SDHCI driver for Freescale i.MX eSDHC");
+MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index dbab040..8ccf256 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -22,48 +22,22 @@
  * Inspired by sdhci-pci.c, by Pierre Ossman
  */
 
-#include <linux/delay.h>
-#include <linux/highmem.h>
-#include <linux/mod_devicetable.h>
-#include <linux/platform_device.h>
-
-#include <linux/mmc/host.h>
-
-#include <linux/io.h>
-#include <linux/mmc/sdhci-pltfm.h>
+#include <linux/err.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 
-/*****************************************************************************\
- *                                                                           *
- * SDHCI core callbacks                                                      *
- *                                                                           *
-\*****************************************************************************/
-
 static struct sdhci_ops sdhci_pltfm_ops = {
 };
 
-/*****************************************************************************\
- *                                                                           *
- * Device probing/removal                                                    *
- *                                                                           *
-\*****************************************************************************/
-
-static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
+struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
+				    struct sdhci_pltfm_data *pdata)
 {
-	const struct platform_device_id *platid = platform_get_device_id(pdev);
-	struct sdhci_pltfm_data *pdata;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct resource *iomem;
 	int ret;
 
-	if (platid && platid->driver_data)
-		pdata = (void *)platid->driver_data;
-	else
-		pdata = pdev->dev.platform_data;
-
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem) {
 		ret = -ENOMEM;
@@ -71,8 +45,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 	}
 
 	if (resource_size(iomem) < 0x100)
-		dev_err(&pdev->dev, "Invalid iomem size. You may "
-			"experience problems.\n");
+		dev_err(&pdev->dev, "Invalid iomem size!\n");
 
 	/* Some PCI-based MFD need the parent here */
 	if (pdev->dev.parent != &platform_bus)
@@ -87,7 +60,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 
-	host->hw_name = "platform";
+	host->hw_name = dev_name(&pdev->dev);
 	if (pdata && pdata->ops)
 		host->ops = pdata->ops;
 	else
@@ -110,126 +83,70 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 		goto err_remap;
 	}
 
-	if (pdata && pdata->init) {
-		ret = pdata->init(host, pdata);
-		if (ret)
-			goto err_plat_init;
-	}
-
-	ret = sdhci_add_host(host);
-	if (ret)
-		goto err_add_host;
-
 	platform_set_drvdata(pdev, host);
 
-	return 0;
+	return host;
 
-err_add_host:
-	if (pdata && pdata->exit)
-		pdata->exit(host);
-err_plat_init:
-	iounmap(host->ioaddr);
 err_remap:
 	release_mem_region(iomem->start, resource_size(iomem));
 err_request:
 	sdhci_free_host(host);
 err:
-	printk(KERN_ERR"Probing of sdhci-pltfm failed: %d\n", ret);
-	return ret;
+	dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
+	return ERR_PTR(ret);
 }
 
-static int __devexit sdhci_pltfm_remove(struct platform_device *pdev)
+void sdhci_pltfm_free(struct platform_device *pdev)
 {
-	struct sdhci_pltfm_data *pdata = pdev->dev.platform_data;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	int dead;
-	u32 scratch;
-
-	dead = 0;
-	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
-	if (scratch == (u32)-1)
-		dead = 1;
 
-	sdhci_remove_host(host, dead);
-	if (pdata && pdata->exit)
-		pdata->exit(host);
 	iounmap(host->ioaddr);
 	release_mem_region(iomem->start, resource_size(iomem));
 	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
+}
 
-	return 0;
+int sdhci_pltfm_register(struct platform_device *pdev,
+			 struct sdhci_pltfm_data *pdata)
+{
+	struct sdhci_host *host;
+	int ret = 0;
+
+	host = sdhci_pltfm_init(pdev, pdata);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		sdhci_pltfm_free(pdev);
+
+	return ret;
 }
 
-static const struct platform_device_id sdhci_pltfm_ids[] = {
-	{ "sdhci", },
-#ifdef CONFIG_MMC_SDHCI_CNS3XXX
-	{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdata },
-#endif
-#ifdef CONFIG_MMC_SDHCI_ESDHC_IMX
-	{ "sdhci-esdhc-imx", (kernel_ulong_t)&sdhci_esdhc_imx_pdata },
-#endif
-#ifdef CONFIG_MMC_SDHCI_DOVE
-	{ "sdhci-dove", (kernel_ulong_t)&sdhci_dove_pdata },
-#endif
-#ifdef CONFIG_MMC_SDHCI_TEGRA
-	{ "sdhci-tegra", (kernel_ulong_t)&sdhci_tegra_pdata },
-#endif
-	{ },
-};
-MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
+int sdhci_pltfm_unregister(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
+
+	sdhci_remove_host(host, dead);
+	sdhci_pltfm_free(pdev);
+
+	return 0;
+}
 
 #ifdef CONFIG_PM
-static int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t state)
+int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
 
 	return sdhci_suspend_host(host, state);
 }
 
-static int sdhci_pltfm_resume(struct platform_device *dev)
+int sdhci_pltfm_resume(struct platform_device *dev)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
 
 	return sdhci_resume_host(host);
 }
-#else
-#define sdhci_pltfm_suspend	NULL
-#define sdhci_pltfm_resume	NULL
 #endif	/* CONFIG_PM */
-
-static struct platform_driver sdhci_pltfm_driver = {
-	.driver = {
-		.name	= "sdhci",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= sdhci_pltfm_probe,
-	.remove		= __devexit_p(sdhci_pltfm_remove),
-	.id_table	= sdhci_pltfm_ids,
-	.suspend	= sdhci_pltfm_suspend,
-	.resume		= sdhci_pltfm_resume,
-};
-
-/*****************************************************************************\
- *                                                                           *
- * Driver init/exit                                                          *
- *                                                                           *
-\*****************************************************************************/
-
-static int __init sdhci_drv_init(void)
-{
-	return platform_driver_register(&sdhci_pltfm_driver);
-}
-
-static void __exit sdhci_drv_exit(void)
-{
-	platform_driver_unregister(&sdhci_pltfm_driver);
-}
-
-module_init(sdhci_drv_init);
-module_exit(sdhci_drv_exit);
-
-MODULE_DESCRIPTION("Secure Digital Host Controller Interface platform driver");
-MODULE_AUTHOR("Mocean Laboratories <info@mocean-labs.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 2b37016..ff4b7eb 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/types.h>
+#include <linux/platform_device.h>
 #include <linux/mmc/sdhci-pltfm.h>
 
 struct sdhci_pltfm_host {
@@ -20,9 +21,17 @@ struct sdhci_pltfm_host {
 	void *priv; /* to handle quirks across io-accessor calls */
 };
 
-extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
-extern struct sdhci_pltfm_data sdhci_esdhc_imx_pdata;
-extern struct sdhci_pltfm_data sdhci_dove_pdata;
-extern struct sdhci_pltfm_data sdhci_tegra_pdata;
+extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
+					   struct sdhci_pltfm_data *pdata);
+extern void sdhci_pltfm_free(struct platform_device *pdev);
+
+extern int sdhci_pltfm_register(struct platform_device *pdev,
+				struct sdhci_pltfm_data *pdata);
+extern int sdhci_pltfm_unregister(struct platform_device *pdev);
+
+#ifdef CONFIG_PM
+extern int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t state);
+extern int sdhci_pltfm_resume(struct platform_device *dev);
+#endif
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 343c97e..95fce3d 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -116,20 +116,42 @@ static int tegra_sdhci_8bit(struct sdhci_host *host, int bus_width)
 	return 0;
 }
 
+static struct sdhci_ops tegra_sdhci_ops = {
+	.get_ro     = tegra_sdhci_get_ro,
+	.read_l     = tegra_sdhci_readl,
+	.read_w     = tegra_sdhci_readw,
+	.write_l    = tegra_sdhci_writel,
+	.platform_8bit_width = tegra_sdhci_8bit,
+};
+
+static struct sdhci_pltfm_data sdhci_tegra_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
+		  SDHCI_QUIRK_NO_HISPD_BIT |
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
+	.ops  = &tegra_sdhci_ops,
+};
 
-static int tegra_sdhci_pltfm_init(struct sdhci_host *host,
-				  struct sdhci_pltfm_data *pdata)
+static int __devinit sdhci_tegra_probe(struct platform_device *pdev)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct sdhci_pltfm_host *pltfm_host;
 	struct tegra_sdhci_platform_data *plat;
+	struct sdhci_host *host;
 	struct clk *clk;
 	int rc;
 
+	host = sdhci_pltfm_init(pdev, &sdhci_tegra_pdata);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+
 	plat = pdev->dev.platform_data;
+
 	if (plat == NULL) {
 		dev_err(mmc_dev(host->mmc), "missing platform data\n");
-		return -ENXIO;
+		rc = -ENXIO;
+		goto err_no_plat;
 	}
 
 	if (gpio_is_valid(plat->power_gpio)) {
@@ -137,7 +159,7 @@ static int tegra_sdhci_pltfm_init(struct sdhci_host *host,
 		if (rc) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to allocate power gpio\n");
-			goto out;
+			goto err_power_req;
 		}
 		tegra_gpio_enable(plat->power_gpio);
 		gpio_direction_output(plat->power_gpio, 1);
@@ -148,7 +170,7 @@ static int tegra_sdhci_pltfm_init(struct sdhci_host *host,
 		if (rc) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to allocate cd gpio\n");
-			goto out_power;
+			goto err_cd_req;
 		}
 		tegra_gpio_enable(plat->cd_gpio);
 		gpio_direction_input(plat->cd_gpio);
@@ -159,7 +181,7 @@ static int tegra_sdhci_pltfm_init(struct sdhci_host *host,
 
 		if (rc)	{
 			dev_err(mmc_dev(host->mmc), "request irq error\n");
-			goto out_cd;
+			goto err_cd_irq_req;
 		}
 
 	}
@@ -169,7 +191,7 @@ static int tegra_sdhci_pltfm_init(struct sdhci_host *host,
 		if (rc) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to allocate wp gpio\n");
-			goto out_irq;
+			goto err_wp_req;
 		}
 		tegra_gpio_enable(plat->wp_gpio);
 		gpio_direction_input(plat->wp_gpio);
@@ -179,7 +201,7 @@ static int tegra_sdhci_pltfm_init(struct sdhci_host *host,
 	if (IS_ERR(clk)) {
 		dev_err(mmc_dev(host->mmc), "clk err\n");
 		rc = PTR_ERR(clk);
-		goto out_wp;
+		goto err_clk_get;
 	}
 	clk_enable(clk);
 	pltfm_host->clk = clk;
@@ -189,38 +211,47 @@ static int tegra_sdhci_pltfm_init(struct sdhci_host *host,
 	if (plat->is_8bit)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+	rc = sdhci_add_host(host);
+	if (rc)
+		goto err_add_host;
+
 	return 0;
 
-out_wp:
+err_add_host:
+	clk_disable(pltfm_host->clk);
+	clk_put(pltfm_host->clk);
+err_clk_get:
 	if (gpio_is_valid(plat->wp_gpio)) {
 		tegra_gpio_disable(plat->wp_gpio);
 		gpio_free(plat->wp_gpio);
 	}
-
-out_irq:
+err_wp_req:
 	if (gpio_is_valid(plat->cd_gpio))
 		free_irq(gpio_to_irq(plat->cd_gpio), host);
-out_cd:
+err_cd_irq_req:
 	if (gpio_is_valid(plat->cd_gpio)) {
 		tegra_gpio_disable(plat->cd_gpio);
 		gpio_free(plat->cd_gpio);
 	}
-
-out_power:
+err_cd_req:
 	if (gpio_is_valid(plat->power_gpio)) {
 		tegra_gpio_disable(plat->power_gpio);
 		gpio_free(plat->power_gpio);
 	}
-
-out:
+err_power_req:
+err_no_plat:
+	sdhci_pltfm_free(pdev);
 	return rc;
 }
 
-static void tegra_sdhci_pltfm_exit(struct sdhci_host *host)
+static int __devexit sdhci_tegra_remove(struct platform_device *pdev)
 {
+	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
-	struct tegra_sdhci_platform_data *plat;
+ 	struct tegra_sdhci_platform_data *plat;
+	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
+
+	sdhci_remove_host(host, dead);
 
 	plat = pdev->dev.platform_data;
 
@@ -242,22 +273,37 @@ static void tegra_sdhci_pltfm_exit(struct sdhci_host *host)
 
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
+
+	sdhci_pltfm_free(pdev);
+
+	return 0;
 }
 
-static struct sdhci_ops tegra_sdhci_ops = {
-	.get_ro     = tegra_sdhci_get_ro,
-	.read_l     = tegra_sdhci_readl,
-	.read_w     = tegra_sdhci_readw,
-	.write_l    = tegra_sdhci_writel,
-	.platform_8bit_width = tegra_sdhci_8bit,
+static struct platform_driver sdhci_tegra_driver = {
+	.driver		= {
+		.name	= "sdhci-tegra",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_tegra_probe,
+	.remove		= __devexit_p(sdhci_tegra_remove),
+#ifdef CONFIG_PM
+	.suspend	= sdhci_pltfm_suspend,
+	.resume		= sdhci_pltfm_resume,
+#endif
 };
 
-struct sdhci_pltfm_data sdhci_tegra_pdata = {
-	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
-		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
-		  SDHCI_QUIRK_NO_HISPD_BIT |
-		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
-	.ops  = &tegra_sdhci_ops,
-	.init = tegra_sdhci_pltfm_init,
-	.exit = tegra_sdhci_pltfm_exit,
-};
+static int __init sdhci_tegra_init(void)
+{
+	return platform_driver_register(&sdhci_tegra_driver);
+}
+module_init(sdhci_tegra_init);
+ 
+static void __exit sdhci_tegra_exit(void)
+{
+	platform_driver_unregister(&sdhci_tegra_driver);
+}
+module_exit(sdhci_tegra_exit);
+
+MODULE_DESCRIPTION("SDHCI driver for Tegra");
+MODULE_AUTHOR(" Google, Inc.");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mmc/sdhci-pltfm.h b/include/linux/mmc/sdhci-pltfm.h
index 548d59d..f1c2ac3 100644
--- a/include/linux/mmc/sdhci-pltfm.h
+++ b/include/linux/mmc/sdhci-pltfm.h
@@ -15,21 +15,15 @@
 #define _SDHCI_PLTFM_H
 
 struct sdhci_ops;
-struct sdhci_host;
 
 /**
  * struct sdhci_pltfm_data - SDHCI platform-specific information & hooks
  * @ops: optional pointer to the platform-provided SDHCI ops
  * @quirks: optional SDHCI quirks
- * @init: optional hook that is called during device probe, before the
- *        driver tries to access any SDHCI registers
- * @exit: optional hook that is called during device removal
  */
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
-	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata);
-	void (*exit)(struct sdhci_host *host);
 };
 
 #endif /* _SDHCI_PLTFM_H */
-- 
1.7.4.1

