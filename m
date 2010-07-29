From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH] mmc: add SDHCI driver for STM platforms.
Date: Thu, 29 Jul 2010 10:31:19 +0200
Message-ID: <1280392279-17406-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:34313 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754267Ab0G2I5V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2010 04:57:21 -0400
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BA9A235
	for <linux-mmc@vger.kernel.org>; Thu, 29 Jul 2010 08:31:27 +0000 (GMT)
Received: from mail3.ctn.st.com (mail3.ctn.st.com [164.130.116.150])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 608811BBA
	for <linux-mmc@vger.kernel.org>; Thu, 29 Jul 2010 08:31:26 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch adds the Arasan MMC/SD/SDIO driver
for the STM ST40 platforms. It is based on the
SDHCI driver.
It has been tested on the STx7106/STx7108/STx5289
platforms.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/Kconfig      |   12 +++
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/sdhci-stm.c  |  184 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/sdhci-stm.h |   40 +++++++++
 4 files changed, 237 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-stm.c
 create mode 100644 include/linux/mmc/sdhci-stm.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f06d06e..a5a3313 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -148,6 +148,18 @@ config MMC_SDHCI_SPEAR
 
 	  If unsure, say N.
 
+config MMC_SDHCI_STM
+	tristate "SDHCI support on STM platforms"
+	depends on MMC_SDHCI && CPU_SUBTYPE_ST40
+	help
+	  This selects the Secure Digital Host Controller Interface (SDHCI)
+	  often referrered to as the HSMMC block in some of the STM range
+	  of SoC (e.g. STx7106/STx7108/STx5289).
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_S3C_DMA
 	bool "DMA support on S3C SDHCI"
 	depends on MMC_SDHCI_S3C && EXPERIMENTAL
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e30c2ee..7b47e8d 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(CONFIG_MMC_SDHCI_PLTFM)	+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
+obj-$(CONFIG_MMC_SDHCI_STM)	+= sdhci-stm.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
diff --git a/drivers/mmc/host/sdhci-stm.c b/drivers/mmc/host/sdhci-stm.c
new file mode 100644
index 0000000..397ecf7
--- /dev/null
+++ b/drivers/mmc/host/sdhci-stm.c
@@ -0,0 +1,184 @@
+/* linux/drivers/mmc/host/sdhci-stm.c
+ *
+ * Copyright (C) 2010 STMicroelectronics Ltd
+ * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
+ *
+ * SDHCI support for STM platforms
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mmc/host.h>
+#include <linux/io.h>
+
+#include <linux/mmc/sdhci-stm.h>
+
+#include "sdhci.h"
+
+static struct sdhci_ops sdhci_pltfm_ops = {
+	/* Nothing to do for now. */
+};
+
+struct sdhci_stm {
+	struct sdhci_host *host;
+	struct platform_device *pdev;
+	struct resource *ioarea;
+	struct sdhci_platform_data *pdata;
+};
+
+static int __devinit sdhci_probe(struct platform_device *pdev)
+{
+	struct sdhci_platform_data *pdata;
+	struct device *dev = &pdev->dev;
+	struct sdhci_host *host;
+	struct sdhci_stm *sc;
+	struct resource *res;
+	int ret, irq;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "no memory specified\n");
+		return -ENOENT;
+	}
+
+	irq = platform_get_irq_byname(pdev, "mmcirq");
+	if (irq < 0) {
+		dev_err(dev, "no irq specified\n");
+		return irq;
+	}
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(dev, "no device data specified\n");
+		return -ENOENT;
+	}
+
+	host = sdhci_alloc_host(&pdev->dev, 0);
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
+		dev_dbg(&pdev->dev, "error allocating host\n");
+		return PTR_ERR(host);
+	}
+
+	sc = sdhci_priv(host);
+	sc->host = host;
+	sc->pdev = pdev;
+	sc->pdata = pdata;
+
+	platform_set_drvdata(pdev, host);
+
+	sc->ioarea = request_mem_region(res->start, resource_size(res),
+					pdev->name);
+	if (!sc->ioarea) {
+		dev_err(dev, "failed to reserve register area\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	ret = sdhci_claim_resource(pdev);
+	if (ret < 0)
+		goto out;
+
+	host->hw_name = "sdhci-stm";
+	host->ops = &sdhci_pltfm_ops;
+	host->irq = irq;
+	host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
+
+	host->ioaddr = ioremap(res->start, resource_size(res));
+	if (!host->ioaddr) {
+		dev_err(dev, "failed to map registers\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_dbg(&pdev->dev, "error adding host\n");
+		goto out;
+	}
+
+	return 0;
+
+out:
+	if (host->ioaddr)
+		iounmap(host->ioaddr);
+
+	if (sc->ioarea) {
+		release_resource(sc->ioarea);
+		kfree(sc->ioarea);
+	}
+
+	sdhci_free_host(host);
+
+	return ret;
+}
+
+static int __devexit sdhci_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_stm *sc = sdhci_priv(host);
+
+	sdhci_remove_host(host, 1);
+
+	iounmap(host->ioaddr);
+	release_resource(sc->ioarea);
+	kfree(sc->ioarea);
+
+	sdhci_free_host(host);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sdhci_stm_suspend(struct platform_device *dev, pm_message_t pm)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+
+	sdhci_suspend_host(host, pm);
+	return 0;
+}
+
+static int sdhci_stm_resume(struct platform_device *dev)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+
+	sdhci_resume_host(host);
+	return 0;
+}
+#endif
+
+static struct platform_driver sdhci_driver = {
+	.driver = {
+		   .name = "sdhci-stm",
+		   .owner = THIS_MODULE,
+		   },
+	.probe = sdhci_probe,
+	.remove = __devexit_p(sdhci_remove),
+#ifdef CONFIG_PM
+	.suspend = sdhci_stm_suspend,
+	.resume = sdhci_stm_resume,
+#endif
+};
+
+static int __init sdhci_stm_init(void)
+{
+	return platform_driver_register(&sdhci_driver);
+}
+
+module_init(sdhci_stm_init);
+
+static void __exit sdhci_stm_exit(void)
+{
+	platform_driver_unregister(&sdhci_driver);
+}
+
+module_exit(sdhci_stm_exit);
+
+MODULE_DESCRIPTION("STM Secure Digital Host Controller Interface driver");
+MODULE_AUTHOR("Giuseppe Cavallaro <peppe.cavallaro@st.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mmc/sdhci-stm.h b/include/linux/mmc/sdhci-stm.h
new file mode 100644
index 0000000..4e6ad14
--- /dev/null
+++ b/include/linux/mmc/sdhci-stm.h
@@ -0,0 +1,40 @@
+/*
+ * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
+ *
+ * include/linux/mmc/sdhci-stm.h
+ *
+ * platform data for the sdhci stm driver.
+ *
+ * Copyright (C) 2010  STMicroelectronics Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ */
+
+#ifndef __SDHCI_STM_PLAT_H__
+#define __SDHCI_STM_PLAT_H__
+
+#include <linux/stm/platform.h>
+#include <linux/stm/pad.h>
+
+struct sdhci_platform_data {
+	struct stm_pad_config *pad_config;
+};
+
+/* SDHCI_STM Resource configuration */
+static inline int sdhci_claim_resource(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct sdhci_platform_data *plat_dat = pdev->dev.platform_data;
+
+	/* Pad routing setup required on STM platforms */
+	if (!devm_stm_pad_claim(&pdev->dev, plat_dat->pad_config,
+				dev_name(&pdev->dev))) {
+		pr_err("%s: Failed to request pads!\n", __func__);
+		ret = -ENODEV;
+	}
+	return ret;
+}
+#endif /* __SDHCI_STM_PLAT_H__ */
-- 
1.5.5.6

