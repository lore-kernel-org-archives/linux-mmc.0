From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/6] mmc: tmio: convert the SDHI MMC driver from MFD to a
 standard platform driver
Date: Fri, 11 Mar 2011 08:52:06 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103110846000.23675@axis700.grange>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62656 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab1CKHwM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2011 02:52:12 -0500
In-Reply-To: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On sh-mobile platforms the SDHI driver was using the tmio_mmc SD/SDIO
MFD cell driver. Now that the tmio_mmc driver has been split into a
core and a separate MFD glue, we can support SDHI natively without the
need to emulate an MFD controller. This also allows to support systems
with an on-SoC SDHI controller and a separate MFD with a TMIO core.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mfd/Kconfig                |   14 ---
 drivers/mfd/Makefile               |    1 -
 drivers/mfd/sh_mobile_sdhi.c       |  200 ------------------------------------
 drivers/mmc/host/Kconfig           |    9 ++-
 drivers/mmc/host/Makefile          |    7 +-
 drivers/mmc/host/sh_mobile_sdhi.c  |  171 ++++++++++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h        |    4 +-
 include/linux/mfd/sh_mobile_sdhi.h |   19 +---
 include/linux/mmc/sh_mobile_sdhi.h |   16 +++
 9 files changed, 207 insertions(+), 234 deletions(-)
 delete mode 100644 drivers/mfd/sh_mobile_sdhi.c
 create mode 100644 drivers/mmc/host/sh_mobile_sdhi.c
 create mode 100644 include/linux/mmc/sh_mobile_sdhi.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 7509858..1928ed3 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -60,15 +60,6 @@ config MFD_ASIC3
 	  This driver supports the ASIC3 multifunction chip found on many
 	  PDAs (mainly iPAQ and HTC based ones)
 
-config MFD_SH_MOBILE_SDHI
-	bool "Support for SuperH Mobile SDHI"
-	depends on SUPERH || ARCH_SHMOBILE
-	select MFD_CORE
-	select TMIO_MMC_DMA
-	 ---help---
-	  This driver supports the SDHI hardware block found in many
-	  SuperH Mobile SoCs.
-
 config MFD_DAVINCI_VOICECODEC
 	tristate
 	select MFD_CORE
@@ -243,11 +234,6 @@ config MFD_TMIO
 	bool
 	default n
 
-config TMIO_MMC_DMA
-	bool
-	select DMA_ENGINE
-	select DMADEVICES
-
 config MFD_T7L66XB
 	bool "Support Toshiba T7L66XB"
 	depends on ARM && HAVE_CLK
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b51d353..b755293 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -6,7 +6,6 @@
 obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
-obj-$(CONFIG_MFD_SH_MOBILE_SDHI)		+= sh_mobile_sdhi.o
 
 obj-$(CONFIG_HTC_EGPIO)		+= htc-egpio.o
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
deleted file mode 100644
index 53a6302..0000000
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ /dev/null
@@ -1,200 +0,0 @@
-/*
- * SuperH Mobile SDHI
- *
- * Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Based on "Compaq ASIC3 support":
- *
- * Copyright 2001 Compaq Computer Corporation.
- * Copyright 2004-2005 Phil Blundell
- * Copyright 2007-2008 OpenedHand Ltd.
- *
- * Authors: Phil Blundell <pb@handhelds.org>,
- *	    Samuel Ortiz <sameo@openedhand.com>
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/slab.h>
-#include <linux/platform_device.h>
-#include <linux/mmc/host.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/tmio.h>
-#include <linux/mfd/sh_mobile_sdhi.h>
-#include <linux/sh_dma.h>
-
-struct sh_mobile_sdhi {
-	struct clk *clk;
-	struct tmio_mmc_data mmc_data;
-	struct mfd_cell cell_mmc;
-	struct sh_dmae_slave param_tx;
-	struct sh_dmae_slave param_rx;
-	struct tmio_mmc_dma dma_priv;
-};
-
-static struct resource sh_mobile_sdhi_resources[] = {
-	{
-		.start = 0x000,
-		.end   = 0x1ff,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = 0,
-		.end   = 0,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct mfd_cell sh_mobile_sdhi_cell = {
-	.name          = "tmio-mmc",
-	.num_resources = ARRAY_SIZE(sh_mobile_sdhi_resources),
-	.resources     = sh_mobile_sdhi_resources,
-};
-
-static void sh_mobile_sdhi_set_pwr(struct platform_device *tmio, int state)
-{
-	struct platform_device *pdev = to_platform_device(tmio->dev.parent);
-	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
-
-	if (p && p->set_pwr)
-		p->set_pwr(pdev, state);
-}
-
-static int sh_mobile_sdhi_get_cd(struct platform_device *tmio)
-{
-	struct platform_device *pdev = to_platform_device(tmio->dev.parent);
-	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
-
-	if (p && p->get_cd)
-		return p->get_cd(pdev);
-	else
-		return -ENOSYS;
-}
-
-static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
-{
-	struct sh_mobile_sdhi *priv;
-	struct tmio_mmc_data *mmc_data;
-	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
-	struct resource *mem;
-	char clk_name[8];
-	int ret, irq;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		dev_err(&pdev->dev, "missing MEM resource\n");
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		dev_err(&pdev->dev, "missing IRQ resource\n");
-
-	if (!mem || (irq < 0))
-		return -EINVAL;
-
-	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
-	if (priv == NULL) {
-		dev_err(&pdev->dev, "kzalloc failed\n");
-		return -ENOMEM;
-	}
-
-	mmc_data = &priv->mmc_data;
-
-	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
-	priv->clk = clk_get(&pdev->dev, clk_name);
-	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
-		ret = PTR_ERR(priv->clk);
-		kfree(priv);
-		return ret;
-	}
-
-	clk_enable(priv->clk);
-
-	mmc_data->hclk = clk_get_rate(priv->clk);
-	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
-	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
-	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
-	if (p) {
-		mmc_data->flags = p->tmio_flags;
-		mmc_data->ocr_mask = p->tmio_ocr_mask;
-		mmc_data->capabilities |= p->tmio_caps;
-	}
-
-	/*
-	 * All SDHI blocks support 2-byte and larger block sizes in 4-bit
-	 * bus width mode.
-	 */
-	mmc_data->flags |= TMIO_MMC_BLKSZ_2BYTES;
-
-	/*
-	 * All SDHI blocks support SDIO IRQ signalling.
-	 */
-	mmc_data->flags |= TMIO_MMC_SDIO_IRQ;
-
-	if (p && p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
-		priv->param_tx.slave_id = p->dma_slave_tx;
-		priv->param_rx.slave_id = p->dma_slave_rx;
-		priv->dma_priv.chan_priv_tx = &priv->param_tx;
-		priv->dma_priv.chan_priv_rx = &priv->param_rx;
-		priv->dma_priv.alignment_shift = 1; /* 2-byte alignment */
-		mmc_data->dma = &priv->dma_priv;
-	}
-
-	memcpy(&priv->cell_mmc, &sh_mobile_sdhi_cell, sizeof(priv->cell_mmc));
-	priv->cell_mmc.mfd_data = mmc_data;
-
-	platform_set_drvdata(pdev, priv);
-
-	ret = mfd_add_devices(&pdev->dev, pdev->id,
-			      &priv->cell_mmc, 1, mem, irq);
-	if (ret) {
-		clk_disable(priv->clk);
-		clk_put(priv->clk);
-		kfree(priv);
-	}
-
-	return ret;
-}
-
-static int sh_mobile_sdhi_remove(struct platform_device *pdev)
-{
-	struct sh_mobile_sdhi *priv = platform_get_drvdata(pdev);
-
-	mfd_remove_devices(&pdev->dev);
-	clk_disable(priv->clk);
-	clk_put(priv->clk);
-	kfree(priv);
-
-	return 0;
-}
-
-static struct platform_driver sh_mobile_sdhi_driver = {
-	.driver		= {
-		.name	= "sh_mobile_sdhi",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= sh_mobile_sdhi_probe,
-	.remove		= __devexit_p(sh_mobile_sdhi_remove),
-};
-
-static int __init sh_mobile_sdhi_init(void)
-{
-	return platform_driver_register(&sh_mobile_sdhi_driver);
-}
-
-static void __exit sh_mobile_sdhi_exit(void)
-{
-	platform_driver_unregister(&sh_mobile_sdhi_driver);
-}
-
-module_init(sh_mobile_sdhi_init);
-module_exit(sh_mobile_sdhi_exit);
-
-MODULE_DESCRIPTION("SuperH Mobile SDHI driver");
-MODULE_AUTHOR("Magnus Damm");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 4d16166..0b03cee 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -444,12 +444,19 @@ config MMC_TMIO_CORE
 
 config MMC_TMIO
 	tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
-	depends on MFD_TMIO || MFD_ASIC3 || MFD_SH_MOBILE_SDHI
+	depends on MFD_TMIO || MFD_ASIC3
 	select MMC_TMIO_CORE
 	help
 	  This provides support for the SD/MMC cell found in TC6393XB,
 	  T7L66XB and also HTC ASIC3
 
+config MMC_SDHI
+	tristate "SH-Mobile SDHI SD/SDIO controller support"
+	select MMC_TMIO_CORE
+	help
+	  This provides support for the SDHI SD/SDIO controller found in
+	  SuperH and ARM SH-Mobile SoCs
+
 config MMC_CB710
 	tristate "ENE CB710 MMC/SD Interface support"
 	depends on PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 79c42dd..4f1df0a 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -31,8 +31,11 @@ obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 tmio_mmc_core-y			:= tmio_mmc_pio.o
-tmio_mmc_core-$(CONFIG_TMIO_MMC_DMA)	+= tmio_mmc_dma.o
-obj-$(CONFIG_MMC_CB710)	+= cb710-mmc.o
+ifneq ($(CONFIG_MMC_SDHI),n)
+tmio_mmc_core-y			+= tmio_mmc_dma.o
+endif
+obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o
+obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
 obj-$(CONFIG_MMC_DW)		+= dw_mmc.o
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
new file mode 100644
index 0000000..cc70123
--- /dev/null
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -0,0 +1,171 @@
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
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/mfd/tmio.h>
+#include <linux/sh_dma.h>
+
+#include "tmio_mmc.h"
+
+struct sh_mobile_sdhi {
+	struct clk *clk;
+	struct tmio_mmc_data mmc_data;
+	struct sh_dmae_slave param_tx;
+	struct sh_dmae_slave param_rx;
+	struct tmio_mmc_dma dma_priv;
+};
+
+static void sh_mobile_sdhi_set_pwr(struct platform_device *pdev, int state)
+{
+	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
+
+	if (p && p->set_pwr)
+		p->set_pwr(pdev, state);
+}
+
+static int sh_mobile_sdhi_get_cd(struct platform_device *pdev)
+{
+	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
+
+	if (p && p->get_cd)
+		return p->get_cd(pdev);
+	else
+		return -ENOSYS;
+}
+
+static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
+{
+	struct sh_mobile_sdhi *priv;
+	struct tmio_mmc_data *mmc_data;
+	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
+	struct tmio_mmc_host *host;
+	char clk_name[8];
+	int ret;
+
+	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
+	if (priv == NULL) {
+		dev_err(&pdev->dev, "kzalloc failed\n");
+		return -ENOMEM;
+	}
+
+	mmc_data = &priv->mmc_data;
+
+	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
+	priv->clk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		ret = PTR_ERR(priv->clk);
+		goto eclkget;
+	}
+
+	clk_enable(priv->clk);
+
+	mmc_data->hclk = clk_get_rate(priv->clk);
+	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
+	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
+	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
+	if (p) {
+		mmc_data->flags = p->tmio_flags;
+		mmc_data->ocr_mask = p->tmio_ocr_mask;
+		mmc_data->capabilities |= p->tmio_caps;
+
+		if (p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
+			priv->param_tx.slave_id = p->dma_slave_tx;
+			priv->param_rx.slave_id = p->dma_slave_rx;
+			priv->dma_priv.chan_priv_tx = &priv->param_tx;
+			priv->dma_priv.chan_priv_rx = &priv->param_rx;
+			priv->dma_priv.alignment_shift = 1; /* 2-byte alignment */
+			mmc_data->dma = &priv->dma_priv;
+		}
+	}
+
+	/*
+	 * All SDHI blocks support 2-byte and larger block sizes in 4-bit
+	 * bus width mode.
+	 */
+	mmc_data->flags |= TMIO_MMC_BLKSZ_2BYTES;
+
+	/*
+	 * All SDHI blocks support SDIO IRQ signalling.
+	 */
+	mmc_data->flags |= TMIO_MMC_SDIO_IRQ;
+
+	ret = tmio_mmc_host_probe(&host, pdev, mmc_data);
+	if (ret < 0)
+		goto eprobe;
+
+	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
+		(unsigned long)host->ctl, host->irq);
+
+	return ret;
+
+eprobe:
+	clk_disable(priv->clk);
+	clk_put(priv->clk);
+eclkget:
+	kfree(priv);
+	return ret;
+}
+
+static int sh_mobile_sdhi_remove(struct platform_device *pdev)
+{
+	struct mmc_host *mmc = platform_get_drvdata(pdev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+
+	tmio_mmc_host_remove(host);
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
+MODULE_ALIAS("platform:sh_mobile_sdhi");
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 8ae936b..677e2a5 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -92,7 +92,7 @@ struct tmio_mmc_host {
 	struct tasklet_struct	dma_complete;
 	struct tasklet_struct	dma_issue;
 	struct scatterlist	bounce_sg;
-#ifdef CONFIG_TMIO_MMC_DMA
+#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 	u8			bounce_buf[PAGE_CACHE_SIZE] __attribute__((aligned(TMIO_MAX_ALIGN)));
 #else
 	u8			bounce_buf[1];	/* A dummy in no-DMA case */
@@ -127,7 +127,7 @@ static inline void tmio_mmc_kunmap_atomic(struct scatterlist *sg,
 	local_irq_restore(*flags);
 }
 
-#ifdef CONFIG_TMIO_MMC_DMA
+#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 void tmio_mmc_start_dma(struct tmio_mmc_host *host, struct mmc_data *data);
 void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata);
 void tmio_mmc_release_dma(struct tmio_mmc_host *host);
diff --git a/include/linux/mfd/sh_mobile_sdhi.h b/include/linux/mfd/sh_mobile_sdhi.h
index c981b95..10af7f9 100644
--- a/include/linux/mfd/sh_mobile_sdhi.h
+++ b/include/linux/mfd/sh_mobile_sdhi.h
@@ -1,16 +1,7 @@
-#ifndef __SH_MOBILE_SDHI_H__
-#define __SH_MOBILE_SDHI_H__
+#ifndef MFD_SH_MOBILE_SDHI_H
+#define MFD_SH_MOBILE_SDHI_H
 
-#include <linux/types.h>
+/* Compatibility header - will disappear once all platforms are converted */
+#include <linux/mmc/sh_mobile_sdhi.h>
 
-struct sh_mobile_sdhi_info {
-	int dma_slave_tx;
-	int dma_slave_rx;
-	unsigned long tmio_flags;
-	unsigned long tmio_caps;
-	u32 tmio_ocr_mask;	/* available MMC voltages */
-	void (*set_pwr)(struct platform_device *pdev, int state);
-	int (*get_cd)(struct platform_device *pdev);
-};
-
-#endif /* __SH_MOBILE_SDHI_H__ */
+#endif /* MFD_SH_MOBILE_SDHI_H */
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
new file mode 100644
index 0000000..c981b95
--- /dev/null
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -0,0 +1,16 @@
+#ifndef __SH_MOBILE_SDHI_H__
+#define __SH_MOBILE_SDHI_H__
+
+#include <linux/types.h>
+
+struct sh_mobile_sdhi_info {
+	int dma_slave_tx;
+	int dma_slave_rx;
+	unsigned long tmio_flags;
+	unsigned long tmio_caps;
+	u32 tmio_ocr_mask;	/* available MMC voltages */
+	void (*set_pwr)(struct platform_device *pdev, int state);
+	int (*get_cd)(struct platform_device *pdev);
+};
+
+#endif /* __SH_MOBILE_SDHI_H__ */
-- 
1.7.2.3

