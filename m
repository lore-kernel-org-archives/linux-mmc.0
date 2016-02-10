From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 2/2] mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs
Date: Wed, 10 Feb 2016 15:25:40 -0500
Message-ID: <1455135940-29758-3-git-send-email-alcooperx@gmail.com>
References: <1455135940-29758-1-git-send-email-alcooperx@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:58704
	"EHLO mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753667AbcBJUaf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2016 15:30:35 -0500
In-Reply-To: <1455135940-29758-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../devicetree/bindings/mmc/sdhci-brcmstb.txt      |  40 ++++++
 MAINTAINERS                                        |   7 +
 drivers/mmc/host/Kconfig                           |  11 ++
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-brcmstb.c                   | 154 +++++++++++++++++++++
 5 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
 create mode 100644 drivers/mmc/host/sdhci-brcmstb.c

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt b/Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
new file mode 100644
index 0000000..f8dd6a9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
@@ -0,0 +1,40 @@
+* BROADCOM BRCMSTB/BMIPS SDHCI Controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-brcmstb driver.
+
+Required properties:
+- compatible: "brcm,sdhci-brcmstb"
+
+Optional properties:
+- broken-sdr50: The Host Controller's SDR50 mode is broken.
+- broken-ddr50: The Host Controller's DDR50 mode is broken.
+- broken-64-bit-dma: 64 BIT DMA mode is broken, use 32 BIT DMA.
+- broken-timeout-value: The Host Controller CAPABILITY timeout value is incorrrect, use the maximum timeout.
+
+
+Example:
+
+	sdhci@f03e0100 {
+		compatible = "brcm,sdhci-brcmstb";
+		reg = <0xf03e0000 0x100>;
+		interrupts = <0x0 0x26 0x0>;
+		interrupt-names = "sdio0_0";
+		sdhci,auto-cmd12;
+		clocks = <0x13>;
+		clock-names = "sw_sdio";
+		broken-sdr50;
+	};
+
+	sdhci@f03e0300 {
+		no-1-8-v;
+		non-removable;
+		bus-width = <0x8>;
+		compatible = "brcm,sdhci-brcmstb";
+		reg = <0xf03e0200 0x100>;
+		interrupts = <0x0 0x27 0x0>;
+		interrupt-names = "sdio1_0";
+		sdhci,auto-cmd12;
+		clocks = <0x13>;
+		clock-names = "sw_sdio";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 30aca4a..2d9c90c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9724,6 +9724,13 @@ F:	tools/testing/selftests/seccomp/*
 K:	\bsecure_computing
 K:	\bTIF_SECCOMP\b
 
+SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) Broadcom BRCMSTB DRIVER
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-mmc@vger.kernel.org
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	drivers/mmc/host/sdhci-brcmstb*
+
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
 M:	Ben Dooks <ben-linux@fluff.org>
 M:	Jaehoon Chung <jh80.chung@samsung.com>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 4a35ebf..85bf266 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -797,3 +797,14 @@ config MMC_SDHCI_MICROCHIP_PIC32
           If you have a controller with this interface, say Y or M here.
 
           If unsure, say N.
+config MMC_SDHCI_BRCMSTB
+	tristate "Broadcom SDIO/SD/MMC support"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on MMC_SDHCI_PLTFM
+	default y
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects support for the SDIO/SD/MMC Host Controller on
+	  Broadcom STB SoCs.
+
+	  If unsure, say Y.
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index af918d2..2075c11 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
 obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
 obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
+obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
new file mode 100644
index 0000000..0e6cca6
--- /dev/null
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -0,0 +1,154 @@
+/*
+ * sdhci-brcmstb.c Support for SDHCI on Broadcom BRCMSTB SoC's
+ *
+ * Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/mmc/host.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "sdhci-pltfm.h"
+
+static void brcmstb_of_parse(struct platform_device *pdev,
+			struct sdhci_host *host)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
+	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	if (of_get_property(np, "broken-sdr50", NULL))
+		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50);
+	if (of_find_property(np, "broken-ddr50", NULL))
+		host->caps1 &= ~SDHCI_SUPPORT_DDR50;
+	if (of_get_property(np, "broken-64-bit-dma", NULL))
+		host->caps &= ~SDHCI_CAN_64BIT;
+	if (of_get_property(np, "broken-timeout-value", NULL))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+}
+
+
+#ifdef CONFIG_PM_SLEEP
+
+static int sdhci_brcmstb_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int res;
+
+	res = sdhci_suspend_host(host);
+	if (res)
+		return res;
+	clk_disable(pltfm_host->clk);
+	return res;
+}
+
+static int sdhci_brcmstb_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int err;
+
+	err = clk_enable(pltfm_host->clk);
+	if (err)
+		return err;
+	return sdhci_resume_host(host);
+}
+
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(sdhci_brcmstb_pmops, sdhci_brcmstb_suspend,
+			sdhci_brcmstb_resume);
+
+static const struct sdhci_ops sdhci_brcmstb_ops = {
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
+static struct sdhci_pltfm_data sdhci_brcmstb_pdata = {
+	.ops = &sdhci_brcmstb_ops,
+};
+
+static int sdhci_brcmstb_probe(struct platform_device *pdev)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct sdhci_host *host;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct clk *clk;
+	int res;
+
+	clk = of_clk_get_by_name(dn, "sw_sdio");
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "Clock not found in Device Tree\n");
+		clk = NULL;
+	}
+	res = clk_prepare_enable(clk);
+	if (res)
+		goto undo_clk_get;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_brcmstb_pdata, 0);
+	if (IS_ERR(host)) {
+		res = PTR_ERR(host);
+		goto undo_clk_prep;
+	}
+
+	/* Enable MMC_CAP2_HC_ERASE_SZ for better max discard calculations */
+	host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
+
+	sdhci_get_of_property(pdev);
+	mmc_of_parse(host->mmc);
+	brcmstb_of_parse(pdev, host);
+
+	res = sdhci_add_host(host);
+	if (res)
+		goto undo_pltfm_init;
+
+	pltfm_host = sdhci_priv(host);
+	pltfm_host->clk = clk;
+	return res;
+
+undo_pltfm_init:
+	sdhci_pltfm_free(pdev);
+undo_clk_prep:
+	clk_disable_unprepare(clk);
+undo_clk_get:
+	clk_put(clk);
+	return res;
+}
+
+static const struct of_device_id sdhci_brcm_of_match[] = {
+	{ .compatible = "brcm,sdhci-brcmstb" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
+
+static struct platform_driver sdhci_brcmstb_driver = {
+	.driver		= {
+		.name	= "sdhci-brcmstb",
+		.owner	= THIS_MODULE,
+		.pm	= &sdhci_brcmstb_pmops,
+		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
+	},
+	.probe		= sdhci_brcmstb_probe,
+	.remove		= sdhci_pltfm_unregister,
+};
+
+module_platform_driver(sdhci_brcmstb_driver);
+
+MODULE_DESCRIPTION("SDHCI driver for Broadcom BRCMSTB SoCs");
+MODULE_AUTHOR("Broadcom");
+MODULE_LICENSE("GPL v2");
-- 
1.9.0.138.g2de3478

