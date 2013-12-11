From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Wed, 11 Dec 2013 22:02:20 +0800
Message-ID: <1386770541-15056-3-git-send-email-zhangfei.gao@linaro.org>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:45193 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab3LKODI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 09:03:08 -0500
Received: by mail-we0-f180.google.com with SMTP id t61so6402111wes.25
        for <linux-mmc@vger.kernel.org>; Wed, 11 Dec 2013 06:03:07 -0800 (PST)
In-Reply-To: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Add dw_mmc-k3.c for k3v2, support sd/emmc

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Zhigang Wang <brooke.wangzhigang@huawei.com>
---
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   51 ++++++++
 drivers/mmc/host/Kconfig                           |   10 ++
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  136 ++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
new file mode 100644
index 000000000000..d816b89c386a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
@@ -0,0 +1,51 @@
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
+* clk-table-num: should be number of clks in clk-table required by each mmc timing
+* clk-table: should clock list required by each mmc timing
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
+		clk-table-num = <8>;
+		clk-table =
+		<13000000 50000000 0 0 13000000 50000000 0 100000000>;
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
index 000000000000..08fd7d7bbb23
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -0,0 +1,136 @@
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
+
+	clk_set_rate(host->ciu_clk, priv->clk_table[ios->timing]);
+}
+
+static int dw_mci_k3_parse_dt(struct dw_mci *host)
+{
+	struct dw_mci_k3_priv_data *priv;
+	int ret = 0, num = 0;
+
+	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(host->dev, "mem alloc failed for private data\n");
+		return -ENOMEM;
+	}
+	host->priv = priv;
+
+	ret = of_property_read_u32(host->dev->of_node, "clk-table-num", &num);
+	if (ret < 0) {
+		dev_err(host->dev, "not found clk-table-num\n");
+		return ret;
+	}
+	if (num > MAX_NUMS) {
+		dev_err(host->dev, "clk-table-num too big\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(host->dev->of_node, "clk-table",
+			priv->clk_table, num);
+	if (ret) {
+		dev_err(host->dev, "not found clk-table\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static unsigned long k3_dwmmc_caps[4] = {
+	MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED,
+	MMC_CAP_8_BIT_DATA | MMC_CAP_MMC_HIGHSPEED,
+	0,
+	0,
+};
+
+static const struct dw_mci_drv_data k3_drv_data = {
+	.caps			= k3_dwmmc_caps,
+	.set_ios		= dw_mci_k3_set_ios,
+	.parse_dt		= dw_mci_k3_parse_dt,
+};
+
+static const struct of_device_id dw_mci_k3_match[] = {
+	{ .compatible = "hisilicon,hi4511-dw-mshc",
+			.data = &k3_drv_data, },
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
+
+	if (!IS_ERR(host->ciu_clk))
+		clk_disable_unprepare(host->ciu_clk);
+
+	return dw_mci_suspend(host);
+}
+
+static int dw_mci_k3_resume(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+	int ret = 0;
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

