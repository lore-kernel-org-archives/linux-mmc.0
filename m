From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V2 3/3] mmc: sdhci-brcmstb: Add sdhci driver for Broadcom BRCMSTB/BMIPS SOCs
Date: Fri, 6 Nov 2015 13:56:04 -0500
Message-ID: <1446836164-16259-4-git-send-email-alcooperx@gmail.com>
References: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:31448 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbbKFS4q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 13:56:46 -0500
In-Reply-To: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../devicetree/bindings/mmc/sdhci-brcmstb.txt      |  36 +++++
 drivers/mmc/host/Kconfig                           |  12 ++
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-brcmstb.c                   | 158 +++++++++++++++++++++
 4 files changed, 207 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
 create mode 100644 drivers/mmc/host/sdhci-brcmstb.c

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt b/Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
new file mode 100644
index 0000000..50375a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
@@ -0,0 +1,36 @@
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
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index af71de5..d99f84a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -784,3 +784,15 @@ config MMC_MTK
 	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.
 	  This is needed if support for any SD/SDIO/MMC devices is required.
 	  If unsure, say N.
+
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
index 3595f83..e3e163f 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= sdhci-bcm2835.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
 obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
+obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
new file mode 100644
index 0000000..617cd6e
--- /dev/null
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -0,0 +1,158 @@
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
+static int sdhci_brcmstb_enable_dma(struct sdhci_host *host)
+{
+	if (host->flags & SDHCI_USE_64_BIT_DMA)
+		if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
+			host->flags &= ~SDHCI_USE_64_BIT_DMA;
+	return 0;
+}
+
+static void brcmstb_of_parse(struct platform_device *pdev,
+			struct sdhci_host *host)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	if (!of_get_property(np, "broken-sdr50", NULL))
+		return;
+	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
+	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50);
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
+	.enable_dma = sdhci_brcmstb_enable_dma,
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

