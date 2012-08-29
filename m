From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v5 9/9] mmc: dw_mmc: add support for exynos specific
 implementation of dw-mshc
Date: Wed, 29 Aug 2012 16:18:15 +0530
Message-ID: <1346237295-7116-10-git-send-email-thomas.abraham@linaro.org>
References: <1346237295-7116-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:8427 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab2H2Ka5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Aug 2012 06:30:57 -0400
In-reply-to: <1346237295-7116-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org

Samsung Exynos SoC's extend the dw-mshc controller for additional clock and bus
control. Add support for these extensions and include provide device tree based
discovery suppory as well.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Will Newton <will.newton@imgtec.com>
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   85 +++++++
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-exynos.c                   |  243 ++++++++++++++++++++
 4 files changed, 338 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-exynos.c

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
new file mode 100644
index 0000000..cc82e11
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -0,0 +1,85 @@
+* Samsung Exynos specific extensions to the Synopsis Designware Mobile
+  Storage Host Controller
+
+The Synopsis designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core Synopsis dw mshc controller properties described
+by synposis-dw-mshc.txt and the properties used by the Samsung Exynos specific
+extensions to the Synopsis Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be
+	- "samsung,exynos4210-dw-mshc": for controllers with Samsung Exynos4210
+	  specific extentions.
+	- "samsung,exynos4412-dw-mshc": for controllers with Samsung Exynos4412
+	  specific extentions.
+	- "samsung,exynos5250-dw-mshc": for controllers with Samsung Exynos5250
+	  specific extentions.
+
+* samsung,dw-mshc-sdr-timing: Specifies the value of CUI clock divider, CIU
+  clock phase shift value in transmit mode and CIU clock phase shift value in
+  receive mode for single data rate mode operation. Refer notes of the valid
+  values below.
+
+* samsung,dw-mshc-ddr-timing: Specifies the value of CUI clock divider, CIU
+  clock phase shift value in transmit mode and CIU clock phase shift value in
+  receive mode for double data rate mode operation. Refer notes of the valid
+  values below. The order of the cells should be
+
+    - First Cell: 	CIU clock divider value (applicable only for Exynos5
+			SoC's, should be zero for Exynos4 SoC's)
+    - Second Cell:	CIU clock phase shift value for tx mode.
+    - Third Cell:	CIU clock phase shift value for rx mode.
+
+  Valid values for SDR and DDR CIU clock timing for Exynos5250:
+
+    - valid values for CIU clock divider, tx phase shift and rx phase shift
+      is 0 to 7.
+
+    - When CIU clock divider value is set to 3, all possible 8 phase shift
+      values can be used.
+
+    - If CIU clock divider value is 0 (that is divide by 1), both tx and rx
+      phase shift clocks should be 0.
+
+Required properties for a slot:
+
+* gpios: specifies a list of gpios used for command, clock and data bus. The
+  first gpio is the command line and the second gpio is the clock line. The
+  rest of the gpios (depending on the bus-width property) are the data lines in
+  no particular order. The format of the gpio specifier depends on the gpio
+  controller.
+
+Example:
+
+  The MSHC controller node can be split into two portions, SoC specific and
+  board specific portions as listed below.
+
+	dwmmc0@12200000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		reg = <0x12200000 0x1000>;
+		interrupts = <0 75 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	dwmmc0@12200000 {
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
+
+		slot@0 {
+			reg = <0>;
+			bus-width = <8>;
+			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
+				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
+				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
+				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
+				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
+		};
+	};
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index aa131b3..9bf10e7 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -540,6 +540,15 @@ config MMC_DW_PLTFM
 
 	  If unsure, say Y.
 
+config MMC_DW_EXYNOS
+	tristate "Exynos specific extentions for Synopsys DW Memory Card Interface"
+	depends on MMC_DW
+	select MMC_DW_PLTFM
+	help
+	  This selects support for Samsung Exynos SoC specific extensions to the
+	  Synopsys DesignWare Memory Card Interface driver. Select this option
+	  for platforms based on Exynos4 and Exynos5 SoC's.
+
 config MMC_DW_PCI
 	tristate "Synopsys Designware MCI support on PCI bus"
 	depends on MMC_DW && PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 8922b06..17ad0a7 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
 obj-$(CONFIG_MMC_DW)		+= dw_mmc.o
 obj-$(CONFIG_MMC_DW_PLTFM)	+= dw_mmc-pltfm.o
+obj-$(CONFIG_MMC_DW_EXYNOS)	+= dw_mmc-exynos.o
 obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
new file mode 100644
index 0000000..cb8a196
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -0,0 +1,243 @@
+/*
+ * Exynos Specific Extensions for Synopsys DW Multimedia Card Interface driver
+ *
+ * Copyright (C) 2012, Samsung Electronics Co., Ltd.
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
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+
+#include "dw_mmc.h"
+#include "dw_mmc-pltfm.h"
+
+#define NUM_PINS(x)			(x + 2)
+
+#define SDMMC_CLKSEL			0x09C
+#define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
+#define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
+#define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
+#define SDMMC_CLKSEL_GET_DIVRATIO(x)	((((x) >> 24) & 0x7) + 1)
+#define SDMMC_CLKSEL_GET_DRV_WD2(x)	(((x) >> 16) & 0x3)
+#define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
+#define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
+					SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
+					SDMMC_CLKSEL_CCLK_DIVIDER(z))
+
+#define SDMMC_CMD_USE_HOLD_REG		BIT(29)
+
+#define EXYNOS4210_FIXED_CIU_CLK_DIV	2
+#define EXYNOS4412_FIXED_CIU_CLK_DIV	4
+
+/* Variations in Exynos specific dw-mshc controller */
+enum dw_mci_exynos_type {
+	DW_MCI_TYPE_EXYNOS4210,
+	DW_MCI_TYPE_EXYNOS4412,
+	DW_MCI_TYPE_EXYNOS5250,
+};
+
+/* Exynos implementation specific driver private data */
+struct dw_mci_exynos_priv_data {
+	enum dw_mci_exynos_type		ctrl_type;
+	u32				sdr_timing;
+	u32				ddr_timing;
+};
+
+static struct dw_mci_exynos_compatible {
+	char				*compatible;
+	enum dw_mci_exynos_type		ctrl_type;
+} exynos_compat[] = {
+	{
+		.compatible	= "samsung,exynos4210-dw-mshc",
+		.ctrl_type	= DW_MCI_TYPE_EXYNOS4210,
+	}, {
+		.compatible	= "samsung,exynos4412-dw-mshc",
+		.ctrl_type	= DW_MCI_TYPE_EXYNOS4412,
+	}, {
+		.compatible	= "samsung,exynos5250-dw-mshc",
+		.ctrl_type	= DW_MCI_TYPE_EXYNOS5250,
+	},
+};
+
+static int dw_mci_exynos_priv_init(struct dw_mci *host)
+{
+	struct dw_mci_exynos_priv_data *priv;
+	int idx;
+
+	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(host->dev, "mem alloc failed for private data\n");
+		return -ENOMEM;
+	}
+
+	for (idx = 0; idx < ARRAY_SIZE(exynos_compat); idx++) {
+		if (of_device_is_compatible(host->dev->of_node,
+					exynos_compat[idx].compatible))
+			priv->ctrl_type = exynos_compat[idx].ctrl_type;
+	}
+
+	host->priv = priv;
+	return 0;
+}
+
+static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
+{
+	/*
+	 * Exynos4412 and Exynos5250 extends the use of CMD register with the
+	 * use of bit 29 (which is reserved on standard MSHC controllers) for
+	 * optionally bypassing the HOLD register for command and data. The
+	 * HOLD register should be bypassed in case there is no phase shift
+	 * applied on CMD/DATA that is sent to the card.
+	 */
+	if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL)))
+		*cmdr |= SDMMC_CMD_USE_HOLD_REG;
+}
+
+static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+{
+	struct dw_mci_exynos_priv_data *priv = host->priv;
+
+	if (ios->timing == MMC_TIMING_UHS_DDR50)
+		mci_writel(host, CLKSEL, priv->ddr_timing);
+	else
+		mci_writel(host, CLKSEL, priv->sdr_timing);
+
+	host->bus_hz = clk_get_rate(host->ciu_clk);
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250)
+		host->bus_hz /= SDMMC_CLKSEL_GET_DIVRATIO(
+					mci_readl(host, CLKSEL));
+	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
+		host->bus_hz /= EXYNOS4412_FIXED_CIU_CLK_DIV;
+	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
+		host->bus_hz /= EXYNOS4210_FIXED_CIU_CLK_DIV;
+}
+
+static int dw_mci_exynos_parse_dt(struct dw_mci *host)
+{
+	struct dw_mci_exynos_priv_data *priv = host->priv;
+	u32 timing[3];
+	int ret;
+
+	ret = of_property_read_u32_array(host->dev->of_node,
+			"samsung,dw-mshc-sdr-timing", timing, 3);
+	if (ret)
+		return ret;
+
+	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], timing[2]);
+
+	ret = of_property_read_u32_array(host->dev->of_node,
+			"samsung,dw-mshc-ddr-timing", timing, 3);
+	if (ret)
+		return ret;
+
+	priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], timing[2]);
+	return 0;
+}
+
+static int dw_mci_exynos_setup_bus(struct dw_mci *host,
+				struct device_node *slot_np, u8 bus_width)
+{
+	int idx, gpio, ret;
+
+	if (!slot_np)
+		return -EINVAL;
+
+	/* cmd + clock + bus-width pins */
+	for (idx = 0; idx < NUM_PINS(bus_width); idx++) {
+		gpio = of_get_gpio(slot_np, idx);
+		if (!gpio_is_valid(gpio)) {
+			dev_err(host->dev, "invalid gpio: %d\n", gpio);
+			return -EINVAL;
+		}
+
+		ret = devm_gpio_request(host->dev, gpio, "dw-mci-bus");
+		if (ret) {
+			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
+			return -EBUSY;
+		}
+	}
+
+	gpio = of_get_named_gpio(slot_np, "wp-gpios", 0);
+	if (gpio_is_valid(gpio)) {
+		if (devm_gpio_request(host->dev, gpio, "dw-mci-wp"))
+			dev_info(host->dev, "gpio [%d] request failed\n",
+						gpio);
+	} else {
+		dev_info(host->dev, "wp gpio not available");
+		host->pdata->quirks |= DW_MCI_QUIRK_NO_WRITE_PROTECT;
+	}
+
+	if (host->pdata->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
+		return 0;
+
+	gpio = of_get_named_gpio(slot_np, "samsung,cd-pinmux-gpio", 0);
+	if (gpio_is_valid(gpio)) {
+		if (devm_gpio_request(host->dev, gpio, "dw-mci-cd"))
+			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
+	} else {
+		dev_info(host->dev, "cd gpio not available");
+	}
+
+	return 0;
+}
+
+/* Exynos5250 controller specific capabilities */
+static unsigned long exynos5250_dwmmc_caps[4] = {
+	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
+		MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+};
+
+static struct dw_mci_drv_data exynos5250_drv_data = {
+	.caps			= exynos5250_dwmmc_caps,
+	.init			= dw_mci_exynos_priv_init,
+	.prepare_command	= dw_mci_exynos_prepare_command,
+	.set_ios		= dw_mci_exynos_set_ios,
+	.parse_dt		= dw_mci_exynos_parse_dt,
+	.setup_bus		= dw_mci_exynos_setup_bus,
+};
+
+static const struct of_device_id dw_mci_exynos_match[] = {
+	{ .compatible = "samsung,exynos5250-dw-mshc",
+			.data = (void *)&exynos5250_drv_data, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
+
+int dw_mci_exynos_probe(struct platform_device *pdev)
+{
+	struct dw_mci_drv_data *drv_data;
+	const struct of_device_id *match;
+
+	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
+	drv_data = match->data;
+	return dw_mci_pltfm_register(pdev, drv_data);
+}
+
+static struct platform_driver dw_mci_exynos_pltfm_driver = {
+	.probe		= dw_mci_exynos_probe,
+	.remove		= __exit_p(dw_mci_pltfm_remove),
+	.driver		= {
+		.name		= "dwmmc_exynos",
+		.of_match_table	= of_match_ptr(dw_mci_exynos_match),
+		.pm		= &dw_mci_pltfm_pmops,
+	},
+};
+
+module_platform_driver(dw_mci_exynos_pltfm_driver);
+
+MODULE_DESCRIPTION("Samsung Specific DW-MSHC Driver Extension");
+MODULE_AUTHOR("Thomas Abraham <thomas.ab@samsung.com");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dwmmc-exynos");
-- 
1.6.6.rc2

