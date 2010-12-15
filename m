From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Tue, 14 Dec 2010 22:49:36 -0600
Message-ID: <1292388576-25600-5-git-send-email-olof@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:38598 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755584Ab0LOE5b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Dec 2010 23:57:31 -0500
In-Reply-To: <1292388576-25600-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Olof Johansson <olof@lixom.net>, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>

SDHCI driver for Tegra. Pretty straight forward, a few pieces of
functionality left to fill in but nothing that stops it from going
upstream. Board enablement submitted separately.

This driver is based on an original one from:

Signed-off-by: Yvonne Yip <y@palm.com>

Misc fixes and suspend/resume by:

Signed-off-by: Gary King <gking@nvidia.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>

GPIO write protect plumbing:

Signed-off-by: Rhyland Klein <rklein@nvidia.com>

Quirk rework and cleanups before submission:

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/include/mach/sdhci.h |   28 +++
 drivers/mmc/host/Kconfig                 |   10 +
 drivers/mmc/host/Makefile                |    1 +
 drivers/mmc/host/sdhci-tegra.c           |  267 ++++++++++++++++++++++++++++++
 4 files changed, 306 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/sdhci.h
 create mode 100644 drivers/mmc/host/sdhci-tegra.c

diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h b/arch/arm/mach-tegra/include/mach/sdhci.h
new file mode 100644
index 0000000..8ca9539
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/sdhci.h
@@ -0,0 +1,28 @@
+/*
+ * include/asm-arm/arch-tegra/include/mach/sdhci.h
+ *
+ * Copyright (C) 2009 Palm, Inc.
+ * Author: Yvonne Yip <y@palm.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef __ASM_ARM_ARCH_TEGRA_SDHCI_H
+#define __ASM_ARM_ARCH_TEGRA_SDHCI_H
+
+#include <linux/mmc/host.h>
+
+struct tegra_sdhci_platform_data {
+	int cd_gpio;
+	int wp_gpio;
+	int power_gpio;
+};
+
+#endif
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d618e86..bd69bf9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -189,6 +189,16 @@ config MMC_SDHCI_S3C_DMA
 
 	  YMMV.
 
+config MMC_SDHCI_TEGRA
+	tristate "Tegra SD/MMC Controller Support"
+	depends on ARCH_TEGRA && MMC_SDHCI
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Tegra SD/MMC controller. If you have a Tegra
+	  platform with SD or MMC devices, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_OMAP
 	tristate "TI OMAP Multimedia Card Interface support"
 	depends on ARCH_OMAP
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 7b645ff..a096f7f 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(CONFIG_MMC_SDHCI_PXA)	+= sdhci-pxa.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
+obj-$(CONFIG_MMC_SDHCI_TEGRA)	+= sdhci-tegra.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
new file mode 100644
index 0000000..eb6b952
--- /dev/null
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -0,0 +1,267 @@
+/*
+ * drivers/mmc/host/sdhci-tegra.c
+ *
+ * Copyright (C) 2009 Palm, Inc.
+ * Author: Yvonne Yip <y@palm.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/mmc/card.h>
+
+#include <mach/sdhci.h>
+
+#include "sdhci.h"
+
+#define DRIVER_NAME    "sdhci-tegra"
+
+struct tegra_sdhci_host {
+	struct sdhci_host *sdhci;
+	struct clk *clk;
+	int wp_gpio;
+};
+
+
+static u32 tegra_sdhci_readl(struct sdhci_host *host, int reg)
+{
+	u32 val;
+
+	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
+		/* Use wp_gpio here instead? */
+		val = readl(host->ioaddr + reg);
+		return val | SDHCI_WRITE_PROTECT;
+	}
+
+	return readl(host->ioaddr + reg);
+}
+
+static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
+{
+	if (unlikely(reg == SDHCI_HOST_VERSION)) {
+		/* Erratum: Version register is invalid in HW. */
+		return SDHCI_SPEC_200;
+	}
+
+	return readw(host->ioaddr + reg);
+}
+
+static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	writel(val, host->ioaddr + reg);
+	if (unlikely(reg == SDHCI_INT_ENABLE)) {
+		/* Erratum: Must enable block gap interrupt detection */
+		u8 gap_ctrl = readb(host->ioaddr + SDHCI_BLOCK_GAP_CONTROL);
+		if (val & SDHCI_INT_CARD_INT)
+			gap_ctrl |= 0x8;
+		else
+			gap_ctrl &= ~0x8;
+		writeb(gap_ctrl, host->ioaddr + SDHCI_BLOCK_GAP_CONTROL);
+	}
+}
+
+static unsigned int tegra_sdhci_get_ro(struct sdhci_host *sdhci)
+{
+	struct tegra_sdhci_host *host = sdhci_priv(sdhci);
+
+	if (host->wp_gpio != -1)
+		return gpio_get_value(host->wp_gpio);
+
+	return -1;
+}
+
+static irqreturn_t carddetect_irq(int irq, void *data)
+{
+	struct sdhci_host *sdhost = (struct sdhci_host *)data;
+
+	tasklet_schedule(&sdhost->card_tasklet);
+	return IRQ_HANDLED;
+};
+
+static int tegra_sdhci_enable_dma(struct sdhci_host *host)
+{
+	return 0;
+}
+
+static struct sdhci_ops tegra_sdhci_ops = {
+	.enable_dma = tegra_sdhci_enable_dma,
+	.get_ro     = tegra_sdhci_get_ro,
+	.read_l     = tegra_sdhci_readl,
+	.read_w     = tegra_sdhci_readw,
+	.write_l    = tegra_sdhci_writel,
+};
+
+static int __devinit tegra_sdhci_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct tegra_sdhci_platform_data *plat;
+	struct sdhci_host *sdhci;
+	struct tegra_sdhci_host *host;
+	struct resource *res;
+	int irq;
+	void __iomem *ioaddr;
+
+	plat = pdev->dev.platform_data;
+	if (plat == NULL)
+		return -ENXIO;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res == NULL)
+		return -ENODEV;
+
+	irq = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL)
+		return -ENODEV;
+
+	ioaddr = ioremap(res->start, res->end - res->start);
+
+	sdhci = sdhci_alloc_host(&pdev->dev, sizeof(struct tegra_sdhci_host));
+	if (IS_ERR(sdhci)) {
+		rc = PTR_ERR(sdhci);
+		goto err_unmap;
+	}
+
+	host = sdhci_priv(sdhci);
+	host->sdhci = sdhci;
+
+	host->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(host->clk)) {
+		rc = PTR_ERR(host->clk);
+		goto err_free_host;
+	}
+
+	rc = clk_enable(host->clk);
+	if (rc != 0)
+		goto err_clkput;
+
+	host->wp_gpio = plat->wp_gpio;
+
+	sdhci->hw_name = "tegra";
+	sdhci->ops = &tegra_sdhci_ops;
+	sdhci->irq = irq;
+	sdhci->ioaddr = ioaddr;
+	sdhci->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+			SDHCI_QUIRK_SINGLE_POWER_WRITE |
+			SDHCI_QUIRK_NO_HISPD_BIT |
+			SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+			SDHCI_QUIRK_NO_SDIO_IRQ;
+
+	rc = sdhci_add_host(sdhci);
+	if (rc)
+		goto err_clk_disable;
+
+	platform_set_drvdata(pdev, host);
+
+	if (plat->cd_gpio != -1) {
+		rc = request_irq(gpio_to_irq(plat->cd_gpio), carddetect_irq,
+			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+			mmc_hostname(sdhci->mmc), sdhci);
+
+		if (rc)
+			goto err_remove_host;
+	}
+
+	printk(KERN_INFO "sdhci%d: initialized irq %d ioaddr %p\n", pdev->id,
+			sdhci->irq, sdhci->ioaddr);
+
+	return 0;
+
+err_remove_host:
+	sdhci_remove_host(sdhci, 1);
+err_clk_disable:
+	clk_disable(host->clk);
+err_clkput:
+	clk_put(host->clk);
+err_free_host:
+	if (sdhci)
+		sdhci_free_host(sdhci);
+err_unmap:
+	iounmap(sdhci->ioaddr);
+
+	return rc;
+}
+
+static int tegra_sdhci_remove(struct platform_device *pdev)
+{
+	struct tegra_sdhci_host *host = platform_get_drvdata(pdev);
+	if (host) {
+		struct tegra_sdhci_platform_data *plat;
+		plat = pdev->dev.platform_data;
+
+		sdhci_remove_host(host->sdhci, 0);
+		sdhci_free_host(host->sdhci);
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tegra_sdhci_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct tegra_sdhci_host *host = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = sdhci_suspend_host(host->sdhci, state);
+	if (ret)
+		pr_err("%s: failed, error = %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int tegra_sdhci_resume(struct platform_device *pdev)
+{
+	struct tegra_sdhci_host *host = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = sdhci_resume_host(host->sdhci);
+	if (ret)
+		pr_err("%s: failed, error = %d\n", __func__, ret);
+
+	return ret;
+}
+#else
+#define tegra_sdhci_suspend    NULL
+#define tegra_sdhci_resume     NULL
+#endif
+
+static struct platform_driver tegra_sdhci_driver = {
+	.probe = tegra_sdhci_probe,
+	.remove = tegra_sdhci_remove,
+	.suspend = tegra_sdhci_suspend,
+	.resume = tegra_sdhci_resume,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init tegra_sdhci_init(void)
+{
+	return platform_driver_register(&tegra_sdhci_driver);
+}
+
+static void __exit tegra_sdhci_exit(void)
+{
+	platform_driver_unregister(&tegra_sdhci_driver);
+}
+
+module_init(tegra_sdhci_init);
+module_exit(tegra_sdhci_exit);
+
+MODULE_DESCRIPTION("Tegra SDHCI controller driver");
+MODULE_LICENSE("GPL");
-- 
1.7.3.GIT

