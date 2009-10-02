From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/07] mfd: Add SuperH Mobile SDHI platform driver
Date: Fri, 02 Oct 2009 11:22:09 +0900
Message-ID: <20091002022209.8215.81916.sendpatchset@rxone.opensource.se>
References: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:61326 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513AbZJBC0o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 22:26:44 -0400
In-Reply-To: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, g.liakhovetski@gmx.de

From: Magnus Damm <damm@opensource.se>

This patch adds an MFD driver for the SuperH Mobile SDHI
hardware block. At this point the driver simply wraps the
tmio-mmc driver with some clock code. In the future this
driver is the place to put SDHI specific hotplug code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mfd/Kconfig          |    8 ++
 drivers/mfd/Makefile         |    1 
 drivers/mfd/sh_mobile_sdhi.c |  145 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)

--- 0001/drivers/mfd/Kconfig
+++ work/drivers/mfd/Kconfig	2009-10-01 11:22:18.000000000 +0900
@@ -35,6 +35,14 @@ config MFD_ASIC3
 	  This driver supports the ASIC3 multifunction chip found on many
 	  PDAs (mainly iPAQ and HTC based ones)
 
+config MFD_SH_MOBILE_SDHI
+	bool "Support for SuperH Mobile SDHI"
+	depends on SUPERH
+	select MFD_CORE
+	 ---help---
+	  This driver supports the SDHI hardware block found in many
+	  SuperH Mobile SoC:s.
+
 config MFD_DM355EVM_MSP
 	bool "DaVinci DM355 EVM microcontroller"
 	depends on I2C && MACH_DAVINCI_DM355_EVM
--- 0002/drivers/mfd/Makefile
+++ work/drivers/mfd/Makefile	2009-10-01 10:58:05.000000000 +0900
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_MFD_ASIC3)		+= asic3.o
+obj-$(CONFIG_MFD_SH_MOBILE_SDHI)		+= sh_mobile_sdhi.o
 
 obj-$(CONFIG_HTC_EGPIO)		+= htc-egpio.o
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
--- /dev/null
+++ work/drivers/mfd/sh_mobile_sdhi.c	2009-10-01 12:07:48.000000000 +0900
@@ -0,0 +1,145 @@
+/*
+ * SuperH Mobile SDHI
+ *
+ * Copyright (C) 2009 Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Based on "Compaq ASIC3 support":
+ *
+ * Copyright 2001 Compaq Computer Corporation.
+ * Copyright 2004-2005 Phil Blundell
+ * Copyright 2007-2008 OpenedHand Ltd.
+ *
+ * Authors: Phil Blundell <pb@handhelds.org>,
+ *	    Samuel Ortiz <sameo@openedhand.com>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/core.h>
+#include <linux/mfd/tmio.h>
+
+struct sh_mobile_sdhi {
+	struct clk *clk;
+	struct tmio_mmc_data mmc_data;
+	struct mfd_cell cell_mmc;
+};
+
+static struct resource sh_mobile_sdhi_resources[] = {
+	{
+		.start = 0x000,
+		.end   = 0x1ff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = 0,
+		.end   = 0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct mfd_cell sh_mobile_sdhi_cell = {
+	.name          = "tmio-mmc",
+	.num_resources = ARRAY_SIZE(sh_mobile_sdhi_resources),
+	.resources     = sh_mobile_sdhi_resources,
+};
+
+static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
+{
+	struct sh_mobile_sdhi *priv;
+	struct resource *mem;
+	char clk_name[8];
+	int ret, irq;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		dev_err(&pdev->dev, "missing MEM resource\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		dev_err(&pdev->dev, "missing IRQ resource\n");
+
+	if (!mem || (irq < 0))
+		return -EINVAL;
+
+	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
+	if (priv == NULL) {
+		dev_err(&pdev->dev, "kzalloc failed\n");
+		return -ENOMEM;
+	}
+
+	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
+	priv->clk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		ret = PTR_ERR(priv->clk);
+		kfree(priv);
+		return ret;
+	}
+
+	clk_enable(priv->clk);
+
+	/* FIXME: silly const unsigned int hclk */
+	*(unsigned int *)&priv->mmc_data.hclk = clk_get_rate(priv->clk);
+
+	memcpy(&priv->cell_mmc, &sh_mobile_sdhi_cell, sizeof(priv->cell_mmc));
+	priv->cell_mmc.driver_data = &priv->mmc_data;
+	priv->cell_mmc.platform_data = &priv->cell_mmc;
+	priv->cell_mmc.data_size = sizeof(priv->cell_mmc);
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = mfd_add_devices(&pdev->dev, pdev->id,
+			      &priv->cell_mmc, 1, mem, irq);
+	if (ret) {
+		clk_disable(priv->clk);
+		clk_put(priv->clk);
+		kfree(priv);
+	}
+
+	return ret;
+}
+
+static int sh_mobile_sdhi_remove(struct platform_device *pdev)
+{
+	struct sh_mobile_sdhi *priv = platform_get_drvdata(pdev);
+
+	mfd_remove_devices(&pdev->dev);
+	clk_disable(priv->clk);
+	clk_put(priv->clk);
+	kfree(priv);
+
+	return 0;
+}
+
+static struct platform_driver sh_mobile_sdhi_driver = {
+	.driver		= {
+		.name	= "sh_mobile_sdhi",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sh_mobile_sdhi_probe,
+	.remove		= __devexit_p(sh_mobile_sdhi_remove),
+};
+
+static int __init sh_mobile_sdhi_init(void)
+{
+	return platform_driver_register(&sh_mobile_sdhi_driver);
+}
+
+static void __exit sh_mobile_sdhi_exit(void)
+{
+	platform_driver_unregister(&sh_mobile_sdhi_driver);
+}
+
+module_init(sh_mobile_sdhi_init);
+module_exit(sh_mobile_sdhi_exit);
+
+MODULE_DESCRIPTION("SuperH Mobile SDHI driver");
+MODULE_AUTHOR("Magnus Damm");
+MODULE_LICENSE("GPL v2");
