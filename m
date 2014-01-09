From: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Thu,  9 Jan 2014 22:35:11 +0800
Message-ID: <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389278112-7099-1-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zhigang Wang <brooke.wangzhigang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add dw_mmc-k3.c for k3v2, support sd/emmc

Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Zhigang Wang <brooke.wangzhigang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   60 +++++++++
 drivers/mmc/host/Kconfig                           |   10 ++
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  132 ++++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
new file mode 100644
index 000000000000..d7e2d7f159bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
@@ -0,0 +1,60 @@
+* Hisilicon specific extensions to the Synopsys Designware Mobile
+  Storage Host Controller
+
+Read synopsys-dw-mshc.txt for more details
+
+The Synopsys designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core Synopsys dw mshc controller properties described
+by synopsys-dw-mshc.txt and the properties used by the Hisilicon specific
+extensions to the Synopsys Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be one of the following.
+  - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extentions.
+
+* clock-freq-table: should be the frequency (in Hz) array of the ciu clock
+	in each	supported mode.
+	0. CIU clock rate in Hz for DS mode
+	1. CIU clock rate in Hz for MMC HS mode
+	2. CIU clock rate in Hz for SD HS mode
+	3. CIU clock rate in Hz for SDR12 mode
+	4. CIU clock rate in Hz for SDR25 mode
+	5. CIU clock rate in Hz for SDR50 mode
+	6. CIU clock rate in Hz for SDR104 mode
+	7. CIU clock rate in Hz for DDR50 mode
+	8. CIU clock rate in Hz for HS200 mode
+
+Example:
+
+	/* for Hi3620 */
+
+	/* SoC portion */
+	dwmmc_0: dwmmc0@fcd03000 {
+		compatible = "hisilicon,hi4511-dw-mshc";
+		reg = <0xfcd03000 0x1000>;
+		interrupts = <0 16 4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&mmc_clock HI3620_SD_CIUCLK>, <&clock HI3620_DDRC_PER_CLK>;
+		clock-names = "ciu", "biu";
+		clock-freq-table =
+		<25000000 0 50000000 25000000 50000000 100000000 0 50000000>;
+	};
+
+	/* Board portion */
+	dwmmc0@fcd03000 {
+		num-slots = <1>;
+		vmmc-supply = <&ldo12>;
+		fifo-depth = <0x100>;
+		supports-highspeed;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
+		slot@0 {
+			reg = <0>;
+			bus-width = <4>;
+			disable-wp;
+			cd-gpios = <&gpio10 3 0>;
+		};
+	};
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099e44b2..45aaa2de0f58 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -575,6 +575,16 @@ config MMC_DW_SOCFPGA
 	  This selects support for Altera SoCFPGA specific extensions to the
 	  Synopsys DesignWare Memory Card Interface driver.
 
+config MMC_DW_K3
+	tristate "K3 specific extensions for Synopsys DW Memory Card Interface"
+	depends on MMC_DW
+	select MMC_DW_PLTFM
+	select MMC_DW_IDMAC
+	help
+	  This selects support for Hisilicon K3 SoC specific extensions to the
+	  Synopsys DesignWare Memory Card Interface driver. Select this option
+	  for platforms based on Hisilicon K3 SoC's.
+
 config MMC_DW_PCI
 	tristate "Synopsys Designware MCI support on PCI bus"
 	depends on MMC_DW && PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index c41d0c364509..64f5f8d35839 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_MMC_DW)		+= dw_mmc.o
 obj-$(CONFIG_MMC_DW_PLTFM)	+= dw_mmc-pltfm.o
 obj-$(CONFIG_MMC_DW_EXYNOS)	+= dw_mmc-exynos.o
 obj-$(CONFIG_MMC_DW_SOCFPGA)	+= dw_mmc-socfpga.o
+obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
 obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
new file mode 100644
index 000000000000..68e5e428e8f6
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2013 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/dw_mmc.h>
+#include <linux/of_address.h>
+
+#include "dw_mmc.h"
+#include "dw_mmc-pltfm.h"
+
+#define MAX_NUMS	10
+struct dw_mci_k3_priv_data {
+	u32	clk_table[MAX_NUMS];
+};
+
+static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+{
+	struct dw_mci_k3_priv_data *priv = host->priv;
+	u32 rate = priv->clk_table[ios->timing];
+	int ret;
+
+	if (!rate) {
+		dev_warn(host->dev,
+			"no specified rate in timing %u\n", ios->timing);
+		return;
+	}
+
+	ret = clk_set_rate(host->ciu_clk, rate);
+	if (ret)
+		dev_warn(host->dev, "failed to set clock rate %uHz\n", rate);
+
+	host->bus_hz = clk_get_rate(host->ciu_clk);
+}
+
+static int dw_mci_k3_parse_dt(struct dw_mci *host)
+{
+	struct dw_mci_k3_priv_data *priv;
+	struct device_node *node = host->dev->of_node;
+	struct property *prop;
+	const __be32 *cur;
+	u32 val, num = 0;
+
+	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(host->dev, "mem alloc failed for private data\n");
+		return -ENOMEM;
+	}
+	host->priv = priv;
+
+	of_property_for_each_u32(node, "clock-freq-table", prop, cur, val) {
+		if (num >= MAX_NUMS)
+			break;
+		priv->clk_table[num++] = val;
+	}
+	return 0;
+}
+
+static const struct dw_mci_drv_data k3_drv_data = {
+	.set_ios		= dw_mci_k3_set_ios,
+	.parse_dt		= dw_mci_k3_parse_dt,
+};
+
+static const struct of_device_id dw_mci_k3_match[] = {
+	{ .compatible = "hisilicon,hi4511-dw-mshc", .data = &k3_drv_data, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_mci_k3_match);
+
+static int dw_mci_k3_probe(struct platform_device *pdev)
+{
+	const struct dw_mci_drv_data *drv_data;
+	const struct of_device_id *match;
+
+	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
+	drv_data = match->data;
+
+	return dw_mci_pltfm_register(pdev, drv_data);
+}
+
+static int dw_mci_k3_suspend(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+	int ret;
+
+	ret = dw_mci_suspend(host);
+	if (!ret)
+		clk_disable_unprepare(host->ciu_clk);
+
+	return ret;
+}
+
+static int dw_mci_k3_resume(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(host->ciu_clk);
+	if (ret) {
+		dev_err(host->dev, "failed to enable ciu clock\n");
+		return ret;
+	}
+
+	return dw_mci_resume(host);
+}
+
+SIMPLE_DEV_PM_OPS(dw_mci_k3_pmops, dw_mci_k3_suspend, dw_mci_k3_resume);
+
+static struct platform_driver dw_mci_k3_pltfm_driver = {
+	.probe		= dw_mci_k3_probe,
+	.remove		= dw_mci_pltfm_remove,
+	.driver		= {
+		.name		= "dwmmc_k3",
+		.of_match_table	= dw_mci_k3_match,
+		.pm		= &dw_mci_k3_pmops,
+	},
+};
+
+module_platform_driver(dw_mci_k3_pltfm_driver);
+
+MODULE_DESCRIPTION("K3 Specific DW-MSHC Driver Extension");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dwmmc-k3");
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
