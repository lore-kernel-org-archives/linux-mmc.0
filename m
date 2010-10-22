From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Fri, 22 Oct 2010 10:58:14 +0100
Message-ID: <20101022095814.GA13073@void.printf.net>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com> <20101021141302.GA11912@void.printf.net> <20101021145249.GA13095@void.printf.net> <AANLkTik8=HXEG4h2toVf7ut8TGk04HMv1DR_BxoevOC0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39352 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606Ab0JVJ6Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Oct 2010 05:58:16 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik8=HXEG4h2toVf7ut8TGk04HMv1DR_BxoevOC0@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <w.sang@pengutronix.de>, "eric.y.miao" <eric.y.miao@gmail.com>, Matt Fleming <matt@console-pimps.org>

Hi Russell,

On Fri, Oct 22, 2010 at 04:44:07PM +0800, Haojian Zhuang wrote:
> I'm fine on this. Please merge it via the MMC tree.

I'm planning on merging this patch via the MMC tree, please let me know
if you object.  Thanks.


From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 20 Sep 2010 10:51:28 -0400
Subject: [PATCH] mmc: add new sdhci-pxa driver for Marvell SoCs

Support Marvell PXA168/PXA910/MMP2 SD Host Controller.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Acked-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   32 ++++
 drivers/mmc/host/Kconfig               |   12 ++
 drivers/mmc/host/Makefile              |    1 +
 drivers/mmc/host/sdhci-pxa.c           |  258 ++++++++++++++++++++++++++++++++
 4 files changed, 303 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
 create mode 100644 drivers/mmc/host/sdhci-pxa.c

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
new file mode 100644
index 0000000..3e3c728
--- /dev/null
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -0,0 +1,32 @@
+/* linux/arch/arm/plat-pxa/include/plat/sdhci.h
+ *
+ * Copyright 2010 Marvell
+ *	Zhangfei Gao <zhangfei.gao@marvell.com>
+ *
+ * PXA Platform - SDHCI platform data definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __PLAT_PXA_SDHCI_H
+#define __PLAT_PXA_SDHCI_H
+
+/* pxa specific flag */
+/* Require clock free running */
+#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
+
+/**
+ * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
+ * @max_speed: the maximum speed supported
+ * @quirks: quirks of specific device
+ * @flags: flags for platform requirement
+*/
+struct sdhci_pxa_platdata {
+	unsigned int	max_speed;
+	unsigned int	quirks;
+	unsigned int	flags;
+};
+
+#endif /* __PLAT_PXA_SDHCI_H */
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index c9c2520..40b0fb9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -155,6 +155,18 @@ config MMC_SDHCI_S3C
 
 	  If unsure, say N.
 
+config MMC_SDHCI_PXA
+	tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
+	depends on ARCH_PXA || ARCH_MMP
+	select MMC_SDHCI
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
+	  If you have a PXA168/PXA910/MMP2 platform with SD Host Controller
+	  and a card slot, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_SPEAR
 	tristate "SDHCI support on ST SPEAr platform"
 	depends on MMC_SDHCI && PLAT_SPEAR
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 6c4ac67..7b645ff 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_MMC_IMX)		+= imxmmc.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
+obj-$(CONFIG_MMC_SDHCI_PXA)	+= sdhci-pxa.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
new file mode 100644
index 0000000..aeba3e3
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -0,0 +1,258 @@
+/* linux/drivers/mmc/host/sdhci-pxa.c
+ *
+ * Copyright (C) 2010 Marvell International Ltd.
+ *		Zhangfei Gao <zhangfei.gao@marvell.com>
+ *		Kevin Wang <dwang4@marvell.com>
+ *		Mingwei Wang <mwwang@marvell.com>
+ *		Philip Rakity <prakity@marvell.com>
+ *		Mark Brown <markb@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* Supports:
+ * SDHCI support for MMP2/PXA910/PXA168
+ *
+ * Refer to sdhci-s3c.c.
+ */
+
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <plat/sdhci.h>
+#include "sdhci.h"
+
+#define DRIVER_NAME	"sdhci-pxa"
+
+#define SD_FIFO_PARAM		0x104
+#define DIS_PAD_SD_CLK_GATE	0x400
+
+struct sdhci_pxa {
+	struct sdhci_host		*host;
+	struct sdhci_pxa_platdata	*pdata;
+	struct clk			*clk;
+	struct resource			*res;
+
+	u8 clk_enable;
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * SDHCI core callbacks                                                      *
+ *                                                                           *
+\*****************************************************************************/
+static void set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+	u32 tmp = 0;
+
+	if (clock == 0) {
+		if (pxa->clk_enable) {
+			clk_disable(pxa->clk);
+			pxa->clk_enable = 0;
+		}
+	} else {
+		if (0 == pxa->clk_enable) {
+			if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
+				tmp = readl(host->ioaddr + SD_FIFO_PARAM);
+				tmp |= DIS_PAD_SD_CLK_GATE;
+				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
+			}
+			clk_enable(pxa->clk);
+			pxa->clk_enable = 1;
+		}
+	}
+}
+
+static struct sdhci_ops sdhci_pxa_ops = {
+	.set_clock = set_clock,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Device probing/removal                                                    *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
+{
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct sdhci_host *host = NULL;
+	struct resource *iomem = NULL;
+	struct sdhci_pxa *pxa = NULL;
+	int ret, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "no irq specified\n");
+		return irq;
+	}
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iomem) {
+		dev_err(dev, "no memory specified\n");
+		return -ENOENT;
+	}
+
+	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pxa));
+	if (IS_ERR(host)) {
+		dev_err(dev, "failed to alloc host\n");
+		return PTR_ERR(host);
+	}
+
+	pxa = sdhci_priv(host);
+	pxa->host = host;
+	pxa->pdata = pdata;
+	pxa->clk_enable = 0;
+
+	pxa->clk = clk_get(dev, "PXA-SDHCLK");
+	if (IS_ERR(pxa->clk)) {
+		dev_err(dev, "failed to get io clock\n");
+		ret = PTR_ERR(pxa->clk);
+		goto out;
+	}
+
+	pxa->res = request_mem_region(iomem->start, resource_size(iomem),
+				      mmc_hostname(host->mmc));
+	if (!pxa->res) {
+		dev_err(&pdev->dev, "cannot request region\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
+	if (!host->ioaddr) {
+		dev_err(&pdev->dev, "failed to remap registers\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	host->hw_name = "MMC";
+	host->ops = &sdhci_pxa_ops;
+	host->irq = irq;
+	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
+	if (pdata->quirks)
+		host->quirks |= pdata->quirks;
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add host\n");
+		goto out;
+	}
+
+	if (pxa->pdata->max_speed)
+		host->mmc->f_max = pxa->pdata->max_speed;
+
+	platform_set_drvdata(pdev, host);
+
+	return 0;
+out:
+	if (host) {
+		clk_put(pxa->clk);
+		if (host->ioaddr)
+			iounmap(host->ioaddr);
+		if (pxa->res)
+			release_mem_region(pxa->res->start,
+					   resource_size(pxa->res));
+		sdhci_free_host(host);
+	}
+
+	return ret;
+}
+
+static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+	int dead = 0;
+	u32 scratch;
+
+	if (host) {
+		scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
+		if (scratch == (u32)-1)
+			dead = 1;
+
+		sdhci_remove_host(host, dead);
+
+		if (host->ioaddr)
+			iounmap(host->ioaddr);
+		if (pxa->res)
+			release_mem_region(pxa->res->start,
+					   resource_size(pxa->res));
+		if (pxa->clk_enable) {
+			clk_disable(pxa->clk);
+			pxa->clk_enable = 0;
+		}
+		clk_put(pxa->clk);
+
+		sdhci_free_host(host);
+		platform_set_drvdata(pdev, NULL);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sdhci_pxa_suspend(struct platform_device *dev)
+{
+	struct sdhci_host *host = platform_get_drvdata(to_platform_device(dev));
+
+	return sdhci_suspend_host(host, state);
+}
+
+static int sdhci_pxa_resume(struct platform_device *dev)
+{
+	struct sdhci_host *host = platform_get_drvdata(to_platform_device(dev));
+
+	return sdhci_resume_host(host);
+}
+#else
+#define sdhci_pxa_suspend	NULL
+#define sdhci_pxa_resume	NULL
+#endif
+
+static const struct dev_pm_ops sdhci_pxa_pm_ops = {
+	.suspend	= sdhci_pxa_suspend,
+	.resume		= sdhci_pxa_resume,
+};
+
+
+static struct platform_driver sdhci_pxa_driver = {
+	.probe		= sdhci_pxa_probe,
+	.remove		= __devexit_p(sdhci_pxa_remove),
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+		.pm = &sdhci_pxa_pm_ops,
+	},
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __init sdhci_pxa_init(void)
+{
+	return platform_driver_register(&sdhci_pxa_driver);
+}
+
+static void __exit sdhci_pxa_exit(void)
+{
+	platform_driver_unregister(&sdhci_pxa_driver);
+}
+
+module_init(sdhci_pxa_init);
+module_exit(sdhci_pxa_exit);
+
+MODULE_DESCRIPTION("SDH controller driver for PXA168/PXA910/MMP2");
+MODULE_AUTHOR("Zhangfei Gao <zhangfei.gao@marvell.com>");
+MODULE_LICENSE("GPL v2");
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
