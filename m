From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [RFC PATCH v2 4/6] mmc: sdhci: host: add new f_sdh30
Date: Thu, 26 Jun 2014 14:23:30 +0800
Message-ID: <1403763812-5495-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36359 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbaFZGXx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jun 2014 02:23:53 -0400
In-Reply-To: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, patches@linaro.org, andy.green@linaro.org, jaswinder.singh@linaro.org, Vincent.Yang@tw.fujitsu.com

This patch adds new host controller driver for
Fujitsu SDHCI controller f_sdh30.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  35 +++
 drivers/mmc/host/Kconfig                           |   7 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   | 346 +++++++++++++++++++++
 drivers/mmc/host/sdhci_f_sdh30.h                   |  40 +++
 5 files changed, 429 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
new file mode 100644
index 0000000..40add438
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
@@ -0,0 +1,35 @@
+* Fujitsu SDHCI controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci_f_sdh30 driver.
+
+Required properties:
+- compatible: "fujitsu,f_sdh30"
+- voltage-ranges : two cells are required, first cell specifies minimum
+  slot voltage (mV), second cell specifies maximum slot voltage (mV).
+  Several ranges could be specified.
+
+Optional properties:
+- gpios: This is one optional gpio for controlling a power mux which
+  switches between two power supplies. 3.3V is selected when gpio is high,
+  and 1.8V is selected when gpio is low. This voltage is used for signal
+  level.
+- clocks: Must contain an entry for each entry in clock-names. It is a
+  list of phandles and clock-specifier pairs.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Should contain the following two entries:
+	"sd_sd4clk" - clock primarily used for tuning process
+	"sd_bclk"   - base clock for sdhci controller
+
+Example:
+
+	sdhci1: sdio@36600000 {
+		compatible = "fujitsu,f_sdh30";
+		reg = <0 0x36600000 0x1000>;
+		interrupts = <0 172 0x4>,
+			     <0 173 0x4>;
+		voltage-ranges = <1800 1800 3300 3300>;
+		gpios = <&gpio0 7 0>;
+		clocks = <&clk_hdmi_2_0>, <&clk_hdmi_3_0>;
+		clock-names = "sd_sd4clk", "sd_bclk";
+	};
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fee224..a1f3207 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -281,6 +281,13 @@ config MMC_SDHCI_BCM2835
 	  This selects the BCM2835 SD/MMC controller. If you have a BCM2835
 	  platform with SD or MMC devices, say Y or M here.
 
+config MMC_SDHCI_F_SDH30
+	tristate "SDHCI support for Fujitsu Semiconductor F_SDH30"
+	depends on MMC_SDHCI && (ARCH_MB8AC0300 || ARCH_MB86S70)
+	help
+	  This selects the Secure Digital Host Controller Interface (SDHCI)
+	  Needed by some Fujitsu SoC for MMC / SD / SDIO support.
+	  If you have a controller with this interface, say Y or M here.
 	  If unsure, say N.
 
 config MMC_MOXART
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 7f81ddf..a4c89e5 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
 obj-$(CONFIG_MMC_SDHCI_PXAV2)	+= sdhci-pxav2.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SIRF)   	+= sdhci-sirf.o
+obj-$(CONFIG_MMC_SDHCI_F_SDH30)	+= sdhci_f_sdh30.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
new file mode 100644
index 0000000..6fae509
--- /dev/null
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -0,0 +1,346 @@
+/*
+ * linux/drivers/mmc/host/sdhci_f_sdh30.c
+ *
+ * Copyright (C) 2013 - 2014 Fujitsu Semiconductor, Ltd
+ *              Vincent Yang <vincent.yang@tw.fujitsu.com>
+ * Copyright (C) 2014 Linaro Ltd  Andy Green <andy.green@linaro.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/mmc/sd.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/suspend.h>
+
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+#include "sdhci_f_sdh30.h"
+#include "../core/core.h"
+
+#define DRIVER_NAME "f_sdh30"
+
+
+struct f_sdhost_priv {
+	struct clk *clk_sd4;
+	struct clk *clk_b;
+	int gpio_select_1v8;
+	u32 vendor_hs200;
+	struct device *dev;
+};
+
+void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
+{
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+	u32 ctrl = 0;
+
+	usleep_range(2500, 3000);
+	ctrl = sdhci_readl(host, F_SDH30_IO_CONTROL2);
+	ctrl |= F_SDH30_CRES_O_DN;
+	sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
+	ctrl |= F_SDH30_MSEL_O_1_8;
+	sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
+
+	if (gpio_is_valid(priv->gpio_select_1v8)) {
+		dev_info(priv->dev, "%s: setting gpio\n", __func__);
+		gpio_direction_output(priv->gpio_select_1v8, 0);
+	}
+
+	ctrl &= ~F_SDH30_CRES_O_DN;
+	sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
+	usleep_range(2500, 3000);
+
+	if (priv->vendor_hs200) {
+		dev_info(priv->dev, "%s: setting hs200\n", __func__);
+		ctrl = sdhci_readl(host, F_SDH30_ESD_CONTROL);
+		ctrl |= priv->vendor_hs200;
+		sdhci_writel(host, ctrl, F_SDH30_ESD_CONTROL);
+	}
+
+	ctrl = sdhci_readl(host, F_SDH30_TUNING_SETTING);
+	ctrl |= F_SDH30_CMD_CHK_DIS;
+	sdhci_writel(host, ctrl, F_SDH30_TUNING_SETTING);
+}
+
+unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
+{
+	return F_SDH30_MIN_CLOCK;
+}
+
+void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
+{
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+
+	if (gpio_is_valid(priv->gpio_select_1v8))
+		gpio_direction_output(priv->gpio_select_1v8, 1);
+
+	if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0) {
+		sdhci_writew(host, 0xBC01, SDHCI_CLOCK_CONTROL);
+		mmiowb();
+	}
+
+	sdhci_reset(host, mask);
+}
+
+static const struct sdhci_ops sdhci_f_sdh30_ops = {
+	.voltage_switch = sdhci_f_sdh30_soft_voltage_switch,
+	.get_min_clock = sdhci_f_sdh30_get_min_clock,
+	.reset = sdhci_f_sdh30_reset,
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
+static int sdhci_f_sdh30_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	struct device *dev = &pdev->dev;
+	int irq, ctrl = 0, ret = 0;
+	struct f_sdhost_priv *priv;
+	u32 reg = 0, bus_width;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "%s: no irq specified\n", __func__);
+		ret = irq;
+		goto err;
+	}
+
+	host = sdhci_alloc_host(dev, sizeof(struct sdhci_host) +
+						sizeof(struct f_sdhost_priv));
+	if (IS_ERR(host)) {
+		dev_err(dev, "%s: host allocate error\n", __func__);
+		ret = -ENOMEM;
+		goto err;
+	}
+	priv = sdhci_priv(host);
+	priv->dev = dev;
+
+	host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+		       SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
+	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
+			SDHCI_QUIRK2_VOLTAGE_SWITCH |
+			SDHCI_QUIRK2_TUNING_WORK_AROUND;
+
+	if (!of_property_read_u32(pdev->dev.of_node, "vendor-hs200",
+				  &priv->vendor_hs200))
+		dev_info(dev, "Applying vendor-hs200 setting\n");
+	else
+		priv->vendor_hs200 = 0;
+
+	if (!of_property_read_u32(pdev->dev.of_node, "bus-width", &bus_width)) {
+		if (bus_width == 8) {
+			dev_info(dev, "Applying 8 bit bus width\n");
+			host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+		}
+	}
+
+	ret = mmc_of_parse_voltage(pdev->dev.of_node, &host->ocr_mask);
+	if (ret) {
+		dev_err(dev, "%s: parse voltage error\n", __func__);
+		goto err_voltage;
+	}
+
+	host->hw_name = DRIVER_NAME;
+	host->ops = &sdhci_f_sdh30_ops;
+	host->irq = irq;
+
+	host->ioaddr = of_iomap(pdev->dev.of_node, 0);
+	if (!host->ioaddr) {
+		dev_err(dev, "%s: failed to remap registers\n", __func__);
+		ret = -ENXIO;
+		goto err_remap;
+	}
+
+	priv->clk_sd4 = of_clk_get(pdev->dev.of_node, 0);
+	if (!IS_ERR(priv->clk_sd4)) {
+		ret = clk_prepare_enable(priv->clk_sd4);
+		if (ret < 0) {
+			dev_err(dev, "Failed to enable sd4 clock: %d\n", ret);
+			goto err_clk1;
+		}
+	}
+	priv->clk_b = of_clk_get(pdev->dev.of_node, 1);
+	if (!IS_ERR(priv->clk_b)) {
+		ret = clk_prepare_enable(priv->clk_b);
+		if (ret < 0) {
+			dev_err(dev, "Failed to enable clk_b clock: %d\n", ret);
+			goto err_clk2;
+		}
+	}
+
+	/* optional */
+	priv->gpio_select_1v8 = of_get_gpio(pdev->dev.of_node, 0);
+	if (gpio_is_valid(priv->gpio_select_1v8)) {
+		ret = gpio_request(priv->gpio_select_1v8, "sdhci");
+		if (unlikely(ret)) {
+			dev_err(dev, " gpio %d request failed ",
+				priv->gpio_select_1v8);
+			goto err_gpio;
+		}
+		/* initially 3.3V */
+		ret = gpio_direction_output(priv->gpio_select_1v8, 1);
+		if (unlikely(ret)) {
+			dev_err(dev, "failed to set phy_enable gpio\n");
+			goto err_gpio;
+		}
+	}
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_err(dev, "%s: host add error\n", __func__);
+		goto err_add_host;
+	}
+
+	platform_set_drvdata(pdev, host);
+
+#ifdef CONFIG_PM_RUNTIME
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		dev_err(dev, "Failed to pm_runtime_get_sync: %d\n", ret);
+#endif
+
+	/* init vendor specific regs */
+	ctrl = sdhci_readw(host, F_SDH30_AHB_CONFIG);
+	ctrl |= F_SDH30_SIN | F_SDH30_AHB_INCR_16 | F_SDH30_AHB_INCR_8 |
+		F_SDH30_AHB_INCR_4;
+	ctrl &= ~(F_SDH30_AHB_BIGED | F_SDH30_BUSLOCK_EN);
+	sdhci_writew(host, ctrl, F_SDH30_AHB_CONFIG);
+	mmiowb();
+
+	reg = sdhci_readl(host, F_SDH30_ESD_CONTROL);
+	sdhci_writel(host, reg & ~F_SDH30_EMMC_RST, F_SDH30_ESD_CONTROL);
+	msleep(20);
+	sdhci_writel(host, reg | F_SDH30_EMMC_RST, F_SDH30_ESD_CONTROL);
+	mmiowb();
+
+	return 0;
+
+err_add_host:
+	if (gpio_is_valid(priv->gpio_select_1v8)) {
+		gpio_direction_output(priv->gpio_select_1v8, 1);
+		gpio_free(priv->gpio_select_1v8);
+	}
+err_gpio:
+	clk_put(priv->clk_b);
+err_clk2:
+	clk_put(priv->clk_sd4);
+err_clk1:
+	iounmap(host->ioaddr);
+err_remap:
+err_voltage:
+	sdhci_free_host(host);
+err:
+	return ret;
+}
+
+static int sdhci_f_sdh30_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
+			  0xffffffff);
+	iounmap(host->ioaddr);
+	release_mem_region(iomem->start, resource_size(iomem));
+
+	clk_disable_unprepare(priv->clk_sd4);
+	clk_disable_unprepare(priv->clk_b);
+
+	clk_put(priv->clk_b);
+	clk_put(priv->clk_sd4);
+
+	if (gpio_is_valid(priv->gpio_select_1v8)) {
+		gpio_direction_output(priv->gpio_select_1v8, 1);
+		gpio_free(priv->gpio_select_1v8);
+	}
+
+	sdhci_free_host(host);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_f_sdh30_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	return sdhci_suspend_host(host);
+}
+
+static int sdhci_f_sdh30_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	return sdhci_resume_host(host);
+}
+#endif
+
+#ifdef CONFIG_PM_RUNTIME
+static int sdhci_f_sdh30_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	return sdhci_runtime_suspend_host(host);
+}
+
+static int sdhci_f_sdh30_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	return sdhci_runtime_resume_host(host);
+}
+#endif
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops sdhci_f_sdh30_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_f_sdh30_suspend, sdhci_f_sdh30_resume)
+	SET_RUNTIME_PM_OPS(sdhci_f_sdh30_runtime_suspend,
+			   sdhci_f_sdh30_runtime_resume, NULL)
+};
+
+#define SDHCI_F_SDH30_PMOPS (&sdhci_f_sdh30_pmops)
+
+#else
+#define SDHCI_F_SDH30_PMOPS NULL
+#endif
+
+static const struct of_device_id f_sdh30_dt_ids[] = {
+	{ .compatible = "fujitsu,f_sdh30" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, f_sdh30_dt_ids);
+
+static struct platform_driver sdhci_f_sdh30_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = f_sdh30_dt_ids,
+#ifdef CONFIG_PM_SLEEP
+		.pm	= SDHCI_F_SDH30_PMOPS,
+#endif
+	},
+	.probe	= sdhci_f_sdh30_probe,
+	.remove	= sdhci_f_sdh30_remove,
+};
+
+module_platform_driver(sdhci_f_sdh30_driver);
+
+MODULE_DESCRIPTION("F_SDH30 SD Card Controller driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD.");
+MODULE_ALIAS("platform: " DRIVER_NAME);
diff --git a/drivers/mmc/host/sdhci_f_sdh30.h b/drivers/mmc/host/sdhci_f_sdh30.h
new file mode 100644
index 0000000..50c51c9
--- /dev/null
+++ b/drivers/mmc/host/sdhci_f_sdh30.h
@@ -0,0 +1,40 @@
+/*
+ * linux/drivers/mmc/host/sdhci_f_sdh30.h
+ *
+ * Copyright (C) 2013 - 2014 Fujitsu Semiconductor, Ltd
+ *              Vincent Yang <vincent.yang@tw.fujitsu.com>
+ * Copyright (C) 2014 Linaro Ltd  Andy Green <andy.green@linaro.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+
+#ifndef F_SDH30_H
+#define F_SDH30_H
+
+/* F_SDH30 extended Controller registers */
+#define F_SDH30_AHB_CONFIG		0x100
+#define  F_SDH30_AHB_BIGED		0x00000040
+#define  F_SDH30_BUSLOCK_DMA		0x00000020
+#define  F_SDH30_BUSLOCK_EN		0x00000010
+#define  F_SDH30_SIN			0x00000008
+#define  F_SDH30_AHB_INCR_16		0x00000004
+#define  F_SDH30_AHB_INCR_8		0x00000002
+#define  F_SDH30_AHB_INCR_4		0x00000001
+
+#define F_SDH30_TUNING_SETTING		0x108
+#define  F_SDH30_CMD_CHK_DIS		0x00010000
+
+#define F_SDH30_IO_CONTROL2		0x114
+#define  F_SDH30_CRES_O_DN		0x00080000
+#define  F_SDH30_MSEL_O_1_8		0x00040000
+
+#define F_SDH30_ESD_CONTROL		0x124
+#define  F_SDH30_EMMC_RST		0x00000002
+
+#define F_SDH30_CMD_DAT_DELAY		0x200
+
+#define F_SDH30_MIN_CLOCK		400000
+
+#endif
-- 
1.9.0

