From: akpm@linux-foundation.org
Subject: + sdhci-spear-st-spear-based-sdhci-controller-glue.patch added to -mm tree
Date: Wed, 19 May 2010 14:10:22 -0700
Message-ID: <201005192110.o4JLAMqH006279@imap1.linux-foundation.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49077 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353Ab0ESVLF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 May 2010 17:11:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: mm-commits@vger.kernel.org
Cc: viresh.kumar@st.com, linus.ml.walleij@gmail.com, linux-mmc@vger.kernel.org, rmk@arm.linux.org.uk, shiraz.hashim@st.com


The patch titled
     sdhci-spear: ST SPEAr based SDHCI controller glue
has been added to the -mm tree.  Its filename is
     sdhci-spear-st-spear-based-sdhci-controller-glue.patch

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/SubmitChecklist when testing your code ***

See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
out what to do about this

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
Subject: sdhci-spear: ST SPEAr based SDHCI controller glue
From: Viresh KUMAR <viresh.kumar@st.com>

Add a glue layer to support the sdhci driver on the ST SPEAr platform.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Cc: <shiraz.hashim@st.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 MAINTAINERS                     |    6 
 drivers/mmc/host/Kconfig        |   12 +
 drivers/mmc/host/Makefile       |    1 
 drivers/mmc/host/sdhci-spear.c  |  300 ++++++++++++++++++++++++++++++
 include/linux/mmc/sdhci-spear.h |   42 ++++
 5 files changed, 361 insertions(+)

diff -puN MAINTAINERS~sdhci-spear-st-spear-based-sdhci-controller-glue MAINTAINERS
--- a/MAINTAINERS~sdhci-spear-st-spear-based-sdhci-controller-glue
+++ a/MAINTAINERS
@@ -5001,6 +5001,12 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-s3c.c
 
+SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) ST SPEAR DRIVER
+M:	Viresh Kumar <viresh.kumar@st.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/sdhci-spear.c
+
 SECURITY SUBSYSTEM
 M:	James Morris <jmorris@namei.org>
 L:	linux-security-module@vger.kernel.org (suggested Cc:)
diff -puN drivers/mmc/host/Kconfig~sdhci-spear-st-spear-based-sdhci-controller-glue drivers/mmc/host/Kconfig
--- a/drivers/mmc/host/Kconfig~sdhci-spear-st-spear-based-sdhci-controller-glue
+++ a/drivers/mmc/host/Kconfig
@@ -136,6 +136,18 @@ config MMC_SDHCI_S3C
 
 	  If unsure, say N.
 
+config MMC_SDHCI_SPEAR
+	tristate "SDHCI support on ST SPEAr platform"
+	depends on MMC_SDHCI && PLAT_SPEAR
+	help
+	  This selects the Secure Digital Host Controller Interface (SDHCI)
+	  often referrered to as the HSMMC block in some of the ST SPEAR range
+	  of SoC
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_S3C_DMA
 	bool "DMA support on S3C SDHCI"
 	depends on MMC_SDHCI_S3C && EXPERIMENTAL
diff -puN drivers/mmc/host/Makefile~sdhci-spear-st-spear-based-sdhci-controller-glue drivers/mmc/host/Makefile
--- a/drivers/mmc/host/Makefile~sdhci-spear-st-spear-based-sdhci-controller-glue
+++ a/drivers/mmc/host/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(CONFIG_MMC_SDHCI_PLTFM)	+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
+obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
diff -puN /dev/null drivers/mmc/host/sdhci-spear.c
--- /dev/null
+++ a/drivers/mmc/host/sdhci-spear.c
@@ -0,0 +1,300 @@
+/*
+ * drivers/mmc/host/sdhci-spear.c
+ *
+ * Support of SDHCI platform devices for spear soc family
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * Inspired by sdhci-pltfm.c
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/highmem.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdhci-spear.h>
+#include <linux/io.h>
+#include "sdhci.h"
+
+struct spear_sdhci {
+	struct clk *clk;
+	struct sdhci_plat_data *data;
+};
+
+/* sdhci ops */
+static struct sdhci_ops sdhci_pltfm_ops = {
+	/* Nothing to do for now. */
+};
+
+/* gpio card detection interrupt handler */
+static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct spear_sdhci *sdhci =
+		(struct spear_sdhci *)(pdev->dev.platform_data);
+	unsigned long gpio_irq_type;
+	int val;
+
+	val = gpio_get_value(sdhci->data->card_int_gpio);
+
+	/* val == 1 -> card removed, val == 0 -> card inserted */
+	/* if card removed - set irq for low level, else vice versa */
+	gpio_irq_type = val ? IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
+	set_irq_type(irq, gpio_irq_type);
+
+	if (sdhci->data->card_power_gpio >= 0) {
+		if (!sdhci->data->power_always_enb) {
+			/* if card inserted, give power, otherwise remove it */
+			val = sdhci->data->power_active_high ? !val : val ;
+			gpio_set_value(sdhci->data->card_power_gpio, val);
+		}
+	}
+
+	/* inform sdhci driver about card insertion/removal */
+	tasklet_schedule(&host->card_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit sdhci_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	struct resource *iomem;
+	struct spear_sdhci *sdhci;
+	int ret;
+
+	BUG_ON(pdev == NULL);
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iomem) {
+		ret = -ENOMEM;
+		dev_dbg(&pdev->dev, "memory resource not defined\n");
+		goto err;
+	}
+
+	if (!request_mem_region(iomem->start, resource_size(iomem),
+				"spear-sdhci")) {
+		ret = -EBUSY;
+		dev_dbg(&pdev->dev, "cannot request region\n");
+		goto err;
+	}
+
+	sdhci = kzalloc(sizeof(*sdhci), GFP_KERNEL);
+	if (!sdhci) {
+		ret = -ENOMEM;
+		dev_dbg(&pdev->dev, "cannot allocate memory for sdhci\n");
+		goto err_kzalloc;
+	}
+
+	/* clk enable */
+	sdhci->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sdhci->clk)) {
+		ret = PTR_ERR(sdhci->clk);
+		dev_dbg(&pdev->dev, "Error getting clock\n");
+		goto err_clk_get;
+	}
+
+	ret = clk_enable(sdhci->clk);
+	if (ret) {
+		dev_dbg(&pdev->dev, "Error enabling clock\n");
+		goto err_clk_enb;
+	}
+
+	/* overwrite platform_data */
+	sdhci->data = (struct sdhci_plat_data *)(pdev->dev.platform_data);
+	pdev->dev.platform_data = sdhci;
+
+	if (pdev->dev.parent)
+		host = sdhci_alloc_host(pdev->dev.parent, 0);
+	else
+		host = sdhci_alloc_host(&pdev->dev, 0);
+
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
+		dev_dbg(&pdev->dev, "error allocating host\n");
+		goto err_alloc_host;
+	}
+
+	host->hw_name = "sdhci";
+	host->ops = &sdhci_pltfm_ops;
+	host->irq = platform_get_irq(pdev, 0);
+	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
+
+	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
+	if (!host->ioaddr) {
+		ret = -ENOMEM;
+		dev_dbg(&pdev->dev, "failed to remap registers\n");
+		goto err_ioremap;
+	}
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_dbg(&pdev->dev, "error adding host\n");
+		goto err_add_host;
+	}
+
+	platform_set_drvdata(pdev, host);
+
+	/*
+	 * It is optional to use GPIOs for sdhci Power control & sdhci card
+	 * interrupt detection. If sdhci->data is NULL, then use original sdhci
+	 * lines otherwise GPIO lines.
+	 * If GPIO is selected for power control, then power should be disabled
+	 * after card removal and should be enabled when card insertion
+	 * interrupt occurs
+	 */
+	if (!sdhci->data)
+		return 0;
+
+	if (sdhci->data->card_power_gpio >= 0) {
+		int val = 0;
+
+		ret = gpio_request(sdhci->data->card_power_gpio, "sdhci");
+		if (ret < 0) {
+			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
+					sdhci->data->card_power_gpio);
+			goto err_pgpio_request;
+		}
+
+		if (sdhci->data->power_always_enb)
+			val = sdhci->data->power_active_high;
+		else
+			val = !sdhci->data->power_active_high;
+
+		ret = gpio_direction_output(sdhci->data->card_power_gpio, val);
+		if (ret) {
+			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
+					sdhci->data->card_power_gpio);
+			goto err_pgpio_direction;
+		}
+
+		gpio_set_value(sdhci->data->card_power_gpio, 1);
+	}
+
+	if (sdhci->data->card_int_gpio >= 0) {
+		ret = gpio_request(sdhci->data->card_int_gpio, "sdhci");
+		if (ret < 0) {
+			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
+					sdhci->data->card_int_gpio);
+			goto err_igpio_request;
+		}
+
+		ret = gpio_direction_input(sdhci->data->card_int_gpio);
+		if (ret) {
+			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
+					sdhci->data->card_int_gpio);
+			goto err_igpio_direction;
+		}
+		ret = request_irq(gpio_to_irq(sdhci->data->card_int_gpio),
+				sdhci_gpio_irq, IRQF_TRIGGER_LOW,
+				mmc_hostname(host->mmc), pdev);
+		if (ret) {
+			dev_dbg(&pdev->dev, "gpio request irq fail: %d\n",
+					sdhci->data->card_int_gpio);
+			goto err_igpio_request_irq;
+		}
+
+	}
+
+	return 0;
+
+err_igpio_request_irq:
+err_igpio_direction:
+	if (sdhci->data->card_int_gpio >= 0)
+		gpio_free(sdhci->data->card_int_gpio);
+err_igpio_request:
+err_pgpio_direction:
+	if (sdhci->data->card_power_gpio >= 0)
+		gpio_free(sdhci->data->card_power_gpio);
+err_pgpio_request:
+	platform_set_drvdata(pdev, NULL);
+	sdhci_remove_host(host, 1);
+err_add_host:
+	iounmap(host->ioaddr);
+err_ioremap:
+	sdhci_free_host(host);
+err_alloc_host:
+	clk_disable(sdhci->clk);
+err_clk_enb:
+	clk_put(sdhci->clk);
+err_clk_get:
+	kfree(sdhci);
+err_kzalloc:
+	release_mem_region(iomem->start, resource_size(iomem));
+err:
+	dev_err(&pdev->dev, "spear-sdhci probe failed: %d\n", ret);
+	return ret;
+}
+
+static int __devexit sdhci_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct spear_sdhci *sdhci =
+		(struct spear_sdhci *)(pdev->dev.platform_data);
+	int dead;
+	u32 scratch;
+
+	if (sdhci->data) {
+		if (sdhci->data->card_int_gpio >= 0) {
+			free_irq(gpio_to_irq(sdhci->data->card_int_gpio), pdev);
+			gpio_free(sdhci->data->card_int_gpio);
+		}
+
+		if (sdhci->data->card_power_gpio >= 0)
+			gpio_free(sdhci->data->card_power_gpio);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	dead = 0;
+	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
+	if (scratch == (u32)-1)
+		dead = 1;
+
+	sdhci_remove_host(host, dead);
+	iounmap(host->ioaddr);
+	sdhci_free_host(host);
+	clk_disable(sdhci->clk);
+	clk_put(sdhci->clk);
+	kfree(sdhci);
+	if (iomem)
+		release_mem_region(iomem->start, resource_size(iomem));
+
+	return 0;
+}
+
+static struct platform_driver sdhci_driver = {
+	.driver = {
+		.name	= "sdhci",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_probe,
+	.remove		= __devexit_p(sdhci_remove),
+};
+
+static int __init sdhci_init(void)
+{
+	return platform_driver_register(&sdhci_driver);
+}
+module_init(sdhci_init);
+
+static void __exit sdhci_exit(void)
+{
+	platform_driver_unregister(&sdhci_driver);
+}
+module_exit(sdhci_exit);
+
+MODULE_DESCRIPTION("SPEAr Secure Digital Host Controller Interface driver");
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@st.com>");
+MODULE_LICENSE("GPL v2");
diff -puN /dev/null include/linux/mmc/sdhci-spear.h
--- /dev/null
+++ a/include/linux/mmc/sdhci-spear.h
@@ -0,0 +1,42 @@
+/*
+ * include/linux/mmc/sdhci-spear.h
+ *
+ * SDHCI declarations specific to ST SPEAr platform
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef MMC_SDHCI_SPEAR_H
+#define MMC_SDHCI_SPEAR_H
+
+#include <linux/platform_device.h>
+/*
+ * struct sdhci_plat_data: spear sdhci platform data structure
+ *
+ * @card_power_gpio: gpio pin for enabling/disabling power to sdhci socket
+ * @power_active_high: if set, enable power to sdhci socket by setting
+ *			card_power_gpio
+ * @power_always_enb: If set, then enable power on probe, otherwise enable only
+ *			on card insertion and disable on card removal.
+ * card_int_gpio: gpio pin used for card detection
+ */
+struct sdhci_plat_data {
+	int card_power_gpio;
+	int power_active_high;
+	int power_always_enb;
+	int card_int_gpio;
+};
+
+/* This function is used to set platform_data field of pdev->dev */
+static inline void
+sdhci_set_plat_data(struct platform_device *pdev, struct sdhci_plat_data *data)
+{
+	pdev->dev.platform_data = data;
+}
+
+#endif /* MMC_SDHCI_SPEAR_H */
_

Patches currently in -mm which might be from viresh.kumar@st.com are

linux-next.patch
sdhci-spear-st-spear-based-sdhci-controller-glue.patch

